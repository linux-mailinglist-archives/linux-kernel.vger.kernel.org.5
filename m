Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A917FAA94
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjK0Tta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjK0Tt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:49:28 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCC1D64
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:49:34 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b2e763b83so6055885e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701114573; x=1701719373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7y5gQC5hvIBvBFDJ+KIWxjtV9gEjJrCiDgYolpeuvA=;
        b=cUQAPE3v2pm5QYdkJUoYmOFDT/92XTYAvo1JMFTp2ZuW1ZvJGN1degqKzYDJDTuCxO
         +SuBpTYWmkalLlV3Q47EAJ32x0Cmkjk/fTcJHxaB+CfFPmWqlJ/MYWVcu+MbnnkdIIxR
         GFoGIfXJK5GJOgY0KiRdGX8wqwImB8N7GRoeTse9cnEAgPgYV1yq4cotbT8mYT8peAAz
         mLtmfOLmt3bavQCFEmT4TRxkaqIwIS08uRC0Ie7GbZp826FzwMC5kVXRBFu7fB7L+6Xj
         J5rUF7XnNv6nj9yKz+Q7QLcJmdPkjuPNM5o/cCT8vCgwS2x5+MZYC32ujWP58Uof3KeQ
         35+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701114573; x=1701719373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7y5gQC5hvIBvBFDJ+KIWxjtV9gEjJrCiDgYolpeuvA=;
        b=qznLhAdbZGCVrIBq+2g+my+e2X1pwYaqteN0weVj4qP8gWuxmKXkZtmSKfw3GTTVBq
         nNvr69I1ojXU6+cheWbyYR68Dx2iFfJcsM+cUidwVPoAx+dtRvjpUONdNfgZLsBF0Bk/
         dKqWQlMwZ1OPJpSaVBc89GC1ETg5JK7nI0AXsZ1/lWZnD38KRoJcVSMrhmXBBfKx495i
         3fHWotMQF+SOABSR0vln3sivKPtp6vKUW6YIlGj8ROxKA95aizpqdUxU6lggWxylfaVj
         wO6F8z9Ihm3AklmnZrJzhzkMX33whnjSmotuVLO0x/UdtdVx9YNMxzcYIAvC+SPTEwSa
         D1ag==
X-Gm-Message-State: AOJu0YxoXIBQ5Dp93cwFJqsBitL8xjUBHwA1jjlsgvOd8M7XbSWBSFN1
        7XkH1Bc2C5qYQsA/xFduWqQFQ+rOxpE=
X-Google-Smtp-Source: AGHT+IHFbu2EXNV30J7b0sqEBX6koH+mWUJRXjpUY+IfCwIsBE+KsG69ZPnEC5xWDO9coIa3UHLxcw==
X-Received: by 2002:a05:600c:257:b0:408:3836:525f with SMTP id 23-20020a05600c025700b004083836525fmr9048648wmj.1.1701114573090;
        Mon, 27 Nov 2023 11:49:33 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c4f9100b004090798d29csm14819478wmq.15.2023.11.27.11.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 11:49:32 -0800 (PST)
Message-ID: <91d11256-d855-4a80-9a8c-0c987b22aed9@gmail.com>
Date:   Mon, 27 Nov 2023 20:49:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Staging: rtl8192e: Rename CamelCase vars
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        anjan@momi.ca, gregkh@linuxfoundation.org,
        Gary Rookard <garyrookard@fastmail.org>
References: <20231127054305.148276-1-tdavies@darkphysics.net>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231127054305.148276-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 06:42, Tree Davies wrote:
> This Series renames 15 variables to fix checkpatch warnings.
> 
> Thank you in advance to reviewers
> ~Tree
> 
> Tree Davies (15):
>    Staging: rtl8192e: Rename variable pTxTs
>    Staging: rtl8192e: Rename variable BAReq
>    Staging: rtl8192e: Rename variable Delba
>    Staging: rtl8192e: Rename variable TSpec
>    Staging: rtl8192e: Rename variable TxAdmittedBARecord
>    Staging: rtl8192e: Rename variable TxPendingBARecord
>    Staging: rtl8192e: Rename variable pDialogToken
>    Staging: rtl8192e: Rename variable pTsCommonInfo
>    Staging: rtl8192e: Rename variable TxCurSeq
>    Staging: rtl8192e: Rename variable TsAddBaTimer
>    Staging: rtl8192e: Rename variable DelbaParamSet
>    Staging: rtl8192e: Rename variable pBaParamSet
>    Staging: rtl8192e: Rename variable pBaTimeoutVal
>    Staging: rtl8192e: Rename variable pAdmittedBA
>    Staging: rtl8192e: Rename variable TsCommonInfo
> 
>   drivers/staging/rtl8192e/rtl819x_BAProc.c | 178 +++++++++++-----------
>   drivers/staging/rtl8192e/rtl819x_TS.h     |  12 +-
>   drivers/staging/rtl8192e/rtl819x_TSProc.c |  56 +++----
>   drivers/staging/rtl8192e/rtllib.h         |   2 +-
>   drivers/staging/rtl8192e/rtllib_tx.c      |  22 +--
>   5 files changed, 135 insertions(+), 135 deletions(-)
> 

Hi Tree,

thanks for your patches, those work on hardware well.

I am about to delete the block acknowledgment (ba) from the driver. 
Reason is that ba is not properly working. The AP seems to try around 
before it gives up. This is slowing down the connection build up.

My issue is that I need to remove the following parts:

Function rtllib_process_action() that reacts when the AP sends packets 
with ba.

The following three timers are also part of this functionality
timer_setup(&pTxTS->ts_add_ba_timer, TsAddBaProcess, 0);
timer_setup(&pTxTS->tx_pending_ba_record.timer, rtllib_ba_setup_timeout, 0);
timer_setup(&pTxTS->tx_admitted_ba_record.timer, 
rtllib_tx_ba_inact_timeout, 0);

And I cannot really remove the ones without the others. So some kind of 
encirclement is happening.

Just wanted to inform you about what I plan to do.

Have a good day.

Bye Philipp










