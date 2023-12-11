Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F3580D983
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344963AbjLKSyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLKSyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:54:16 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02A8B4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:54:22 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3333b0e0e02so535936f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702320861; x=1702925661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJ/uO2ze7N5KlFGwgc99whbyaD3GgIFDlJtONkS1JrM=;
        b=KgYYrwy0WSgrETCgMfRpiriIozQ8TxGdA2V1zpfdalzGrsIrj4f7OC59wxJK2eMnVm
         JrF86Fovh5nN07TBRAWFmh6kBovLP6R5mHK24Up6p9WvDImC0JC9Nua8RrEwYD9jJjd7
         +wgiH5LtVZPTs9vcN1KDejlXZieqLHEZNWI2lQoY2VEHPD0s0VyjYeXJI7XX9B9LYkj+
         6faCFZkCdxc+F1itO5u/39/LnRwAdntu0I+J0AvaRp5D0N5NW18H99dr+pKQUu8HinXw
         /K9dpCVXcEGRAoFKP4zaivBiKi3Aekqh8QEpYuxPczzy4MJ5jJVvJS91U0NakZPo96U8
         btoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702320861; x=1702925661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ/uO2ze7N5KlFGwgc99whbyaD3GgIFDlJtONkS1JrM=;
        b=G4GozDmPN3UdKN8M+BJ9bmoq0FmjWF8VIIw51feX+I0hB6nqwRsPG/1LCKGlJJgMxC
         hACZkY4EnCTBvXPVrQYCbzWm4FTVUU/0dvjuZlW7c6Pny/aIKOurf8PfkoVU6JmUeQ++
         inhKL6kQJYB8VdRt0v7Q5H2Si89jhHkspx2R67+iVq2iNOUWhfgCF/bL6Mku6lQGCwC+
         HiSAAE741LN/q0GEf7pJIQzt0JnqMbkwzMN/pU8WkmhtPRq0wcM7aG5tskrNBn7uL9U4
         I2pvjvSGAA/is4IyySCyNkTkovgcWPAzVhoqOFU63fKa9RgIe3jKAixMJJDioSXAHXmj
         sA8Q==
X-Gm-Message-State: AOJu0YzVcOPHfrCfD3KjNFCuNPrFirA4Gl0DwnWyNjKlBmG9CSwxZYrJ
        sdbkNPhRUhexTXWIFF6ZTFY=
X-Google-Smtp-Source: AGHT+IGpC+ooNOm4AcPs5iF1+NNGads2qfhDQV60CIdpKmXVYBHLVWemKinat1QVkjV7SsNPrXa6FA==
X-Received: by 2002:a05:6000:154f:b0:333:538a:aedc with SMTP id 15-20020a056000154f00b00333538aaedcmr6697426wry.2.1702320860941;
        Mon, 11 Dec 2023 10:54:20 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d46cc000000b003335c061a2asm9192828wrs.33.2023.12.11.10.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 10:54:20 -0800 (PST)
Message-ID: <b7a9bc86-68aa-4054-88cf-95c3da693db0@gmail.com>
Date:   Mon, 11 Dec 2023 19:54:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] [Series 1] rename variable HTIOTActDetermineRaFunc
 and (4) other
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231211001335.26169-1-garyrookard@fastmail.org>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231211001335.26169-1-garyrookard@fastmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 01:13, Gary Rookard wrote:
> Hi,
> 
> This patch series renames (5) different variables with
> the checkpatch coding style issue, Avoid CamelCase.
> 
> Patch 1/5) rename variable HTIOTActDetermineRaFunc
> Patch 2/5) rename variable HTResetIOTSetting
> Patch 3/5) rename variable HTConstructCapabilityElement
> Patch 4/5) rename variable HTConstructRT2RTAggElement
> Patch 5/5) rename variable HT_PickMCSRate
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> 
> Gary Rookard (5):
>    staging: rtl8192e: rename variable HTIOTActDetermineRaFunc
>    staging: rtl8192e: rename variable HTResetIOTSetting
>    staging: rtl8192e: rename variable HTConstructCapabilityElement
>    staging: rtl8192e: rename variable HTConstructRT2RTAggElement
>    staging: rtl8192e: rename variable HT_PickMCSRate
> 
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 14 +++++++-------
>   drivers/staging/rtl8192e/rtllib.h         |  6 +++---
>   drivers/staging/rtl8192e/rtllib_softmac.c |  6 +++---
>   3 files changed, 13 insertions(+), 13 deletions(-)
> 

Compiled and tested on hardware -> OK

