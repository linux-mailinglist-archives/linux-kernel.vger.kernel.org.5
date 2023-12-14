Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516668130DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573226AbjLNNC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573218AbjLNNCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:02:40 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3523012E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:02:45 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bee606265so8646413e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702558963; x=1703163763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3YT1yTjiwZn9PyE86GiClk+IflwHY+oj6xB+7OwSYY=;
        b=qJ9uxFzyuFo+sa3gwD1mF9/laRcSoXDjEoIN7asUTxwpRlH9UH0y3VJR32Iqst8YwR
         iv57JpEg9rtuS/U9yoHLn2HCBp6RKmFOG05qCfjAYVuAkCbdXf6rWHsSv3EgUn4UrB4y
         DidaAmLKqsPac8kkOI2LxI/jDLFX8FeqVH0OvA46z6BnjvJeWLgQ2hngBX816LEFRodl
         a5NKWAMpaPag05WcOE1QmccMR4vwBPQGY34a6XOA/kigWa8qWlgfYYk6HX6BYOxFvjpF
         r2llRp148CIZrORXmJYBQCj3/qp+B0XLhTaqe3BjwJRbl1o0zVd3sWiuMFNPlZr/uPXd
         pzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702558963; x=1703163763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3YT1yTjiwZn9PyE86GiClk+IflwHY+oj6xB+7OwSYY=;
        b=mDCSwYaE4AESpIyXylFC04w51vbFQltfIdXnVKW5yV0dyHVx1mP0SMq9knjnpK3Kmh
         qIjiwCbDP6tdYXLLGojsN0EdDy+cYoMORj6c239U9JAIQmfYv11gmhzzeYmUA89q4Juv
         TCTQ3+PDwWZmonUNAxFE1ExZZrn3lSNdnoC4JmEgBaTeg7gJwH11v4otmXS3dHguxJ0H
         FFuHHQiMLSpDqI/TtONFsaaJWUMLceShqUP3Sv/BTUQ+PrVpNyzhz1Lf/j+yPOtH64LV
         xL+ijYpkZVg+wYhj8cHU0iPV5ZZrrzmlie3womEb0SEqGWpwh5oCy/1fvk2pm3cOI12b
         CBWQ==
X-Gm-Message-State: AOJu0Yy621XZY0BKO1drX6ksOm9eOoXEaZsbFym/NXx+/4YhzBE1TnWT
        4FBSPofk039L1fInZcmyhfltMA==
X-Google-Smtp-Source: AGHT+IET06hXUkHZ3o2VSFgzV83re6xx3zwbr4qD2pVZ8CgEao7/EwdKCX5DPKu81vAAgxXF2CFLuw==
X-Received: by 2002:a05:6512:3d07:b0:50b:e637:b315 with SMTP id d7-20020a0565123d0700b0050be637b315mr6385869lfv.79.1702558963314;
        Thu, 14 Dec 2023 05:02:43 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id uh17-20020a170906b39100b00a1d5063b01csm9321453ejc.190.2023.12.14.05.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 05:02:42 -0800 (PST)
Message-ID: <f4ef41cb-ca35-4af6-b3e3-0d2be97bf59b@tuxon.dev>
Date:   Thu, 14 Dec 2023 15:02:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: ravb: Check that GTI loading request is done
Content-Language: en-US
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        claudiu.beznea.uj@bp.renesas.com, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, geert+renesas@glider.be,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231214113137.2450292-1-claudiu.beznea.uj@bp.renesas.com>
 <20231214113137.2450292-3-claudiu.beznea.uj@bp.renesas.com>
 <20231214123315.GL1863068@ragnatech.se>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231214123315.GL1863068@ragnatech.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.12.2023 14:33, Niklas Söderlund wrote:
> Hi Claudiu,
> 
> Thanks for your work.
> 
> On 2023-12-14 13:31:37 +0200, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Hardware manual specifies the following for GCCR.LTI bit:
>> 0: Setting completed
>> 1: When written: Issue a configuration request.
>> When read: Completion of settings is pending
> 
> This is hard to parse at first glance, the last row have odd indentation 
> and the mixing of read and write info is odd. I know this reflects how 
> it's written in the datasheet, but at least there the indentation is 
> correct. Also missing here is the fact that only 1 can be written to the 
> bit.
> 
>>
>> Thus, check the completion status when setting 1 to GCCR.LTI.
> 
> Can you describe in the commit why this fix is needed. I agree it is, 
> but would be nice to record why. As this have a fixes tags have you hit 
> an issue? Or are you correcting the driver based on the datasheet?

Yes, this is a issue I faced while working on runtime PM support for this
driver.

> 
> Maybe a more informative commit message could be to describe the change 
> and why it's needed instead of the register layout?

ok

> 
>   The driver do not wait for the confirmation of the configuring request 
>   of the gPTP timer increment before moving on. Add a check to make sure 
>   the request completes successfully.
> 
>>
>> Fixes: 7e09a052dc4e ("ravb: Exclude gPTP feature support for RZ/G2L")
>> Fixes: 568b3ce7a8ef ("ravb: factor out register bit twiddling code")
>> Fixes: 0184165b2f42 ("ravb: add sleep PM suspend/resume support")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/net/ethernet/renesas/ravb_main.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index ce95eb5af354..1c253403a297 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -2819,6 +2819,10 @@ static int ravb_probe(struct platform_device *pdev)
>>  
>>  		/* Request GTI loading */
>>  		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
>> +		/* Check completion status. */
>> +		error = ravb_wait(ndev, GCCR, GCCR_LTI, 0);
>> +		if (error)
>> +			goto out_disable_refclk;
> 
> nit: Maybe create a helper for this so future fixes only need to be 
> addressed in one location?

The code intended for runtime PM support addresses this.

> 
>>  	}
>>  
>>  	if (info->internal_delay) {
>> @@ -3041,6 +3045,10 @@ static int __maybe_unused ravb_resume(struct device *dev)
>>  
>>  		/* Request GTI loading */
>>  		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
>> +		/* Check completion status. */
>> +		ret = ravb_wait(ndev, GCCR, GCCR_LTI, 0);
>> +		if (ret)
>> +			return ret;
>>  	}
>>  
>>  	if (info->internal_delay)
>> -- 
>> 2.39.2
>>
> 
