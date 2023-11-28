Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89D7FB3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbjK1IOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjK1IOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:14:04 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6B1B0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:14:11 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a0907896so6665630e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701159249; x=1701764049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SB88Phe8Cfzd+i16UVy0kM0pj0uuscbZuQ2NaLA0dCI=;
        b=S0EewmN0lw9il/QgSJrT8yQUZZg2cpWDqfkVCflTqIM08PeWWW74Vpk4hwdvyWBrVc
         4tItozDPMZHnzO0iamnAcIpxRSLt/rVOjBRZE2qzfbLD7aJp27RsWR8HR52JIvSGSITR
         m+63F8/JS1/7/enqF2PvBEzwKcz2pX5COlQ3RDoxTrdAE57kEGz4Yfr3pO3XmbOk5ZYZ
         AL+z4lKno4rIzXfZ7UEHC3nwSK+fA7ctiDoSmiBuVD7IciOY1tM5kiS4S07MhXaOlmtI
         VdwRLFkwFtFyFQiSwsdLStCDToeXfAgju/OqDtoY0O4SIH0gBGqfSQ1mHWkQEkkLXb31
         j3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701159249; x=1701764049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SB88Phe8Cfzd+i16UVy0kM0pj0uuscbZuQ2NaLA0dCI=;
        b=sV8pgUzEpGIdGZ/zRHH4uZmUjbXA4VSCZ/n61lXM/rEbelQ2FSOgPa34KqyA71qnzw
         orCUx4AjeRMKap/2I5Hc+ho40pfZ5OS+fj9aDErmrnfeF3ZJbTuJ+mgVavN7lYLUdHwI
         UKI1DQaMGBpgPwOnSLw1ny+2YsSGAPOhS9hOSF0eQcPo1SSVfzzSkw5OzLHAQWGtL7qe
         SFvNGzVsKhO7r0YRhEnrmrstIYw4OmDswSQAIyOpuf4z9w8zgFpkvkLxrF9DhatA3yuz
         MXX2wgVdAnLqMwF05APyTm9YpkErG8kqFVmTCxUE76PAQO+H926YILJgHfk7VX7BrTZl
         9FJQ==
X-Gm-Message-State: AOJu0YyuThq/DZGaolCYNSLXrSaKs2G/g7jsvk9Lg2aZB9f+rRy2vFq6
        enL7F9PR5IiERvq5n5l2tkMYqQ==
X-Google-Smtp-Source: AGHT+IH54uXWkp+cTxiraNfMZKe0PZ/sj6esGVZEivbZ9wC4TftDlJKcFMCOpGUyLXPhgNkrvGTE/A==
X-Received: by 2002:ac2:428a:0:b0:50b:aa88:c54e with SMTP id m10-20020ac2428a000000b0050baa88c54emr5531985lfh.16.1701159249425;
        Tue, 28 Nov 2023 00:14:09 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id ay12-20020a05600c1e0c00b0040588d85b3asm17299412wmb.15.2023.11.28.00.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 00:14:09 -0800 (PST)
Message-ID: <e9bbd6a7-3802-4236-9957-6147eb4fd644@linaro.org>
Date:   Tue, 28 Nov 2023 08:14:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: stop printing superfluous debug info
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     michael@walle.cc, jaimeliao.tw@gmail.com, jaimeliao@mxic.com.tw,
        pratyush@kernel.org, richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231127165908.1734951-1-tudor.ambarus@linaro.org>
 <20231127181514.19b99d2e@xps-13>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20231127181514.19b99d2e@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/23 17:15, Miquel Raynal wrote:
> Hi Tudor,
> 

Hi!

> tudor.ambarus@linaro.org wrote on Mon, 27 Nov 2023 16:59:08 +0000:
> 
>> The mtd data can be obtain with the mtd ioctls and the SPI NOR
>> flash name can be determined interrogating the sysfs entries.
>> Stop polluting the kernel log.
> 
> Actually I like these prints when developing/fixing stuff, it's a clear
> indication of what's been discovered that is available even if for some
> reason my rootfs is not available (which is common when the rootfs is
> on a spi-nor).
> 
> So I would not trash all these lines personally... I believe the

What do you find useful about these prints? Maybe you mean that you'd
like some indicator that the SPI NOR probed successfully? How abut
adding a debug message at the end of mtd_device_register(), or otherwise
after mtd_device_register() is called?

> dev_info can be lowered if you prefer, but dev_dbg is already meant for
> debugging purposes and will anyway be discarded by default.

Yes, if we're going to keep these sort of prints I think we should
definitely lower them from info to dbg. It will speed the boot time and
stop polluting the kernel log.

Cheers,
ta
