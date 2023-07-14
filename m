Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EB175372C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjGNJzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjGNJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:55:52 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2006110
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:55:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6686ef86110so1117107b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689328550; x=1691920550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=M896ry3fyhi9hwSUZXOu6lPxw4QPrpANkfzDCXiBnJk=;
        b=NVJTju1eWiZsvap4AQk3W/iwAS3g+XrZbvgylmrhfSf2tu7pnFDzQm0xi6xOhNbpY4
         pDryYLRoqiiklTqwzUmPKWBh4mo73FvxPZvQ8bJkVXBPgUos2GJJuGTSWNwMaxOlSuSP
         Ov9yF/mXno7VHBb3HdwADAKlQte+urA6rSMsT/XAIQ3ro47gDr2JFZ7jjGOesNTfE9Sy
         iHbUugajheTLPzmbCJQkZtH6yr8xRcTOq7Wr7MCMV6EFF3iJ/D7HvuUUcJiXLrGqFiQz
         9i06atH+GeoVqUapcsjCH0NW67ogIfe3EYtUdZIGsWMdAYAOmtcU9CNjbitYKi61hjvU
         qYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328550; x=1691920550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M896ry3fyhi9hwSUZXOu6lPxw4QPrpANkfzDCXiBnJk=;
        b=lG/u3e93GoVxihatonxi2KDG0Yr94TmomBUk/dQc9SWOmmiEm44XuF3fupzIwtNLiA
         Q+uUi/Z0MDslG/9euOGgDgmUcOElJvCTC3+CILrkY3WCac6IRu6QDvfuRTsqtnN5VFW/
         NExZ+oS06N50sfJvy6EmXhfia48sIQEzNVkdlGp38MlWggB2ueg7ytNpiB/l07teMNaD
         jP+Xt3Ze2p2RfX79JvdklCM2pH1OjHc4fgLfINtP58/Q/QGeJ6guSOVie69dAF4WXNOp
         kkoKGQ2bMyNmufLfiRxPFwTVZ6/TeWbfUdVZloAGuoREpQYSFqDx7BrUXhHT0gefnhBN
         bRcw==
X-Gm-Message-State: ABy/qLZrnmWZml/CPSuhyi+OaeGT/XuiKQSUbVe3XKnuZmUoUY2Bmj5i
        ur5aTVw6k1pfysUETVADCyJmW+7H+/0=
X-Google-Smtp-Source: APBJJlHiPRaYUrwYlptQFw3wzb1V7nM6Pvd09MHDBTuv8G+ZT3XgHSjAUMWpFVp9qEr2R27cQ1ZSuQ==
X-Received: by 2002:a05:6a00:244d:b0:66e:fd84:c96d with SMTP id d13-20020a056a00244d00b0066efd84c96dmr4077580pfj.13.1689328550256;
        Fri, 14 Jul 2023 02:55:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r6-20020a62e406000000b006828a3c259fsm6810259pfh.104.2023.07.14.02.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 02:55:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f93d5d70-1b45-3504-c397-f985f018a8d1@roeck-us.net>
Date:   Fri, 14 Jul 2023 02:55:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] staging: mfd: eiois200-core: add eiois200 support
Content-Language: en-US
To:     "Wenkai.Chung" <Wenkai.Chung@advantech.com.tw>,
        "'lee@kernel.org'" <lee@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc:     "Susi.Driver" <Susi.Driver@advantech.com>
References: <20230713071420.67293-1-wenkai.chung@advantech.com.tw>
 <3886fffd54c245c6b49ae5d17717c72a@advantech.com.tw>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <3886fffd54c245c6b49ae5d17717c72a@advantech.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/23 00:18, Wenkai.Chung wrote:
> 
>      Add a mfd driver to support Advantech EIO-IS200 series EC.
> 
> Signed-off-by: wenkai.chung <wenkai.chung@advantech.com.tw>
> ---
>   drivers/mfd/eiois200.h          | 253 ++++++++
>   drivers/mfd/eiois200_core.c     | 913 +++++++++++++++++++++++++++++
>   drivers/watchdog/eiois200_wdt.c | 987 ++++++++++++++++++++++++++++++++
>   3 files changed, 2153 insertions(+)
>   create mode 100755 drivers/mfd/eiois200.h
>   create mode 100755 drivers/mfd/eiois200_core.c
>   create mode 100755 drivers/watchdog/eiois200_wdt.c

It is most definitely not acceptable to bundle a watchdog driver
into this submission.

Guenter

