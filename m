Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A564A7BD6F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345702AbjJIJ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345862AbjJIJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:26:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30993D7F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:25:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405361bba99so39253795e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696843542; x=1697448342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfQehytd154kLft/C6yCF4s9r73XIYt4SKOC9+YlYHc=;
        b=me4D9fpOnvg/FdEIxiR3mlEN7mDLOlqnbd/B1FKvBMfqiN2o7qLdp8kUvTcYyqKSFu
         2B5un7CywJkjneGpPUUxzIjnXlA63NZhINmuMi9Uzniu7WAi5hKmZypfWjddz1+Hcekj
         sBswRTwSwExpoK9yaZch/qfsmKGUGPvtdvJikYqG7HdWld8EcRdw+Ysp+xgkaexxSgiG
         5sMPSYdOaWlHvc3LHfmG+mA71+f29LeJ/6PlCheQxyNqpx8qEVBinUPVuKG0PPnSUud8
         iItx9BhwqMmaMyeC5Tl+3tCjUWlG392Mr6rhHLxlmk94rOvGsQT0c7tffDY1Ypcbs8SV
         ExGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696843542; x=1697448342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfQehytd154kLft/C6yCF4s9r73XIYt4SKOC9+YlYHc=;
        b=vS+yZvWb/xFjPeaURyDQVzV3SQDlYNNM4gJ4Y28O6euumQTbjnc3REKEsrXre9FrIq
         VuFFEljM2msgeRjQZ0CwOGG0CtwA+6c7vyWfM+7vgVEOldD1gwuqn7Tgw+3Owm6iJEQh
         rGAyCaV3LuzKchgCri2jbHNfgjwOfhAaJO/LyGqNIm7+Au4cl8WFY8Kw6EBUTL4B1O19
         ENXC0m+7QcxKhiSluRHWf/skMecvtVVbBRNGDRspO+MzwDLhJ966Bsp7k1jisCJN6lGB
         0YtNq+kwpg6JkKBHaoZwaKygDH5/G6m77r7IybUcLswRCL81BL6gsZhogXPPBa0OVzIx
         jsuA==
X-Gm-Message-State: AOJu0Yz0l5r0tVK1Ihj4ezF8F4DmyGL1EpIE2DhqWFJ9Ptw98vyLObHL
        1DBl2M1J0FMVNhCRMG8GGdBL0A==
X-Google-Smtp-Source: AGHT+IFlldmcM+fIiLceHqDyQnRJB9r7mDcTQpF5n0Z7h8ddwL3MgPBGAo6qS22nswBhPvB1bwB5PA==
X-Received: by 2002:a5d:484a:0:b0:320:1d1:71c4 with SMTP id n10-20020a5d484a000000b0032001d171c4mr13600684wrs.23.1696843542542;
        Mon, 09 Oct 2023 02:25:42 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id i17-20020adffdd1000000b00326c952716esm8979393wrs.61.2023.10.09.02.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:25:42 -0700 (PDT)
Message-ID: <3edb10ab-2c14-4750-962c-c0b874c34b88@linaro.org>
Date:   Mon, 9 Oct 2023 10:25:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the v4l-dvb-next tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231009110852.36b0bd42@canb.auug.org.au>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231009110852.36b0bd42@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 01:08, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the v4l-dvb-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/media/platform/qcom/camss/camss.c: In function 'camss_probe':
> drivers/media/platform/qcom/camss/camss.c:1634:17: error: label 'err_cleanup' used but not defined
>   1634 |                 goto err_cleanup;
>        |                 ^~~~
> 
> Caused by commits
> 
>    7405116519ad ("media: qcom: camss: Fix pm_domain_on sequence in probe")
>    b278080a89f4 ("media: qcom: camss: Fix V4L2 async notifier error path")
> 
> interacting with commit
> 
>    2c1bae27df78 ("media: qcom: camss: Fix pm_domain_on sequence in probe")
> 
> from the v4l-dvb tree.
> 
> I have applied the following merge resolution patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 9 Oct 2023 11:05:26 +1100
> Subject: [PATCH] v4l-dvb-next: fix up for bad automatic merge.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   drivers/media/platform/qcom/camss/camss.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 38d20b12cdd8..8e78dd8d5961 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -1628,12 +1628,6 @@ static int camss_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	ret = camss_configure_pd(camss);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to configure power domains: %d\n", ret);
> -		goto err_cleanup;
> -	}
> -
>   	ret = camss_init_subdevices(camss);
>   	if (ret < 0)
>   		goto err_genpd_cleanup;

commit: f69791c39745e ("media: qcom: camss: Fix genpd cleanup") already 
appears in linux-next/master @ next-20231009 which commit: 2c1bae27df78 
("media: qcom: camss: Fix pm_domain_on sequence in probe") depends on.

Already looks resolved.

---
bod


