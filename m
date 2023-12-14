Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D378813038
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573065AbjLNMdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573060AbjLNMdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:33:12 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41997116
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:33:18 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2cc3647bf06so22636551fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1702557196; x=1703161996; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qOKRvReK44WjC67PpboxcBAbWNfB0BRmMGzQVugpv1I=;
        b=rPQOtEhj7NoKrhnE41K6eNPo8ZJBU3/TvDfFUEnrxKTiSkQAlJc6LV3WJ6bdCndALU
         uGsNJ3/eq4/FKFLtMpsXuqgSTkw2SlDlowCmryhXChavD1qiznHXwl9jWU2Z1AipECNe
         /0aLh3iEnh9sQxgFOW4wM6C8K2dLKUz2dtQen4HjEp66bgrF8SCZNzaqzJbdrgWTAblx
         gLm1i108wVPQ/PQe9BiEMAH3FeegsjU4WhgSp6OSR6TUGXVEV95PGVbbou/5Bl5VuKPt
         swDVKTUVwhb6tUJ7Du814/QtX2pevkqp35gXRiYG3V+tote8utvZ8uwvp6ZrEnn718C1
         lxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557196; x=1703161996;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOKRvReK44WjC67PpboxcBAbWNfB0BRmMGzQVugpv1I=;
        b=D2P7Yyv3mEpxbuI+DQZ+oWNzeXj7PrZYdjNh42rqIRYIcDWZL6fmkl2JTWgzEKK2C3
         ZAp6u9nwx5rlOOe5PjytXmxylQs1iSS1LxJg/SO+dpY0Rv42F2DqO9ZIeJZS51JaMVP3
         Tk9jfEs4/XdvRPEZ5f1S6I7K1uu6s6vUJXWe/yKLiqlh81+jjkL8EEQKx86zNuPDS2CY
         JH30qm1xfMm+2xIf5jV9F8o1SFEdsmSllR7sDQzgKahHIoIG8ujUVaM02WVFyAOaEdNY
         i0g2SvDusYGtQvZXmSfhkfJShj47vw+wSOGxXb74HEfv9Vlqb7sN2Qf9eMDylL59agE2
         DmKg==
X-Gm-Message-State: AOJu0YzE9/Pp2Vz4xytnhSP4NS4Ln1kixKhMveo1JbMbORdMr0R3nvpY
        Du2bpY7Y0Ucsgv8kKDzm2DlBYUddMSUfIDXKQVk=
X-Google-Smtp-Source: AGHT+IH5NkhwO7Bck9gXySSKfyEWsZo7KqBsKJph/ZdaImpEC0ABrLLMoAFOIsAgX7Nrk1vij46ftA==
X-Received: by 2002:a2e:908d:0:b0:2c9:f864:9c7 with SMTP id l13-20020a2e908d000000b002c9f86409c7mr2982649ljg.55.1702557196324;
        Thu, 14 Dec 2023 04:33:16 -0800 (PST)
Received: from localhost (h-46-59-36-206.A463.priv.bahnhof.se. [46.59.36.206])
        by smtp.gmail.com with ESMTPSA id v18-20020a2e87d2000000b002ca013cb05csm2119750ljj.79.2023.12.14.04.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:33:15 -0800 (PST)
Date:   Thu, 14 Dec 2023 13:33:15 +0100
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        claudiu.beznea.uj@bp.renesas.com, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, geert+renesas@glider.be,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: ravb: Check that GTI loading request is done
Message-ID: <20231214123315.GL1863068@ragnatech.se>
References: <20231214113137.2450292-1-claudiu.beznea.uj@bp.renesas.com>
 <20231214113137.2450292-3-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231214113137.2450292-3-claudiu.beznea.uj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

Thanks for your work.

On 2023-12-14 13:31:37 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hardware manual specifies the following for GCCR.LTI bit:
> 0: Setting completed
> 1: When written: Issue a configuration request.
> When read: Completion of settings is pending

This is hard to parse at first glance, the last row have odd indentation 
and the mixing of read and write info is odd. I know this reflects how 
it's written in the datasheet, but at least there the indentation is 
correct. Also missing here is the fact that only 1 can be written to the 
bit.

> 
> Thus, check the completion status when setting 1 to GCCR.LTI.

Can you describe in the commit why this fix is needed. I agree it is, 
but would be nice to record why. As this have a fixes tags have you hit 
an issue? Or are you correcting the driver based on the datasheet?

Maybe a more informative commit message could be to describe the change 
and why it's needed instead of the register layout?

  The driver do not wait for the confirmation of the configuring request 
  of the gPTP timer increment before moving on. Add a check to make sure 
  the request completes successfully.

> 
> Fixes: 7e09a052dc4e ("ravb: Exclude gPTP feature support for RZ/G2L")
> Fixes: 568b3ce7a8ef ("ravb: factor out register bit twiddling code")
> Fixes: 0184165b2f42 ("ravb: add sleep PM suspend/resume support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index ce95eb5af354..1c253403a297 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2819,6 +2819,10 @@ static int ravb_probe(struct platform_device *pdev)
>  
>  		/* Request GTI loading */
>  		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
> +		/* Check completion status. */
> +		error = ravb_wait(ndev, GCCR, GCCR_LTI, 0);
> +		if (error)
> +			goto out_disable_refclk;

nit: Maybe create a helper for this so future fixes only need to be 
addressed in one location?

>  	}
>  
>  	if (info->internal_delay) {
> @@ -3041,6 +3045,10 @@ static int __maybe_unused ravb_resume(struct device *dev)
>  
>  		/* Request GTI loading */
>  		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
> +		/* Check completion status. */
> +		ret = ravb_wait(ndev, GCCR, GCCR_LTI, 0);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	if (info->internal_delay)
> -- 
> 2.39.2
> 

-- 
Kind Regards,
Niklas Söderlund
