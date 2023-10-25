Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7C7D69CD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjJYLNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYLNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:13:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565BEAC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:13:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507b9408c61so7569696e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698232385; x=1698837185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+D+BeZsEPMEv5rNbntpopdiMR8fAehJzR7Avs9K/vA=;
        b=zici63CSFMLticfGJalIRUiCE5f4Sa5NTtBawr80aXm372zZQseCcpNJsNVyQzbd4t
         OAo8F0Wl/fo49QJbOsxRe4isv+xNdlcjZhsNiX4suPo/aHk4vCqLWQBriFVJttaRSWh5
         r0F8dhUGnF80ncglKqQd8YtipyCOhK7In2GNm8hCoGUi9/c8B0FKODkZc6ey4e1/V10C
         Y/ga/2wX5TKrnMfbGMTOIFvHkyP+rSCvwb1bBgOgAAfVO6B2Irq/DVBtBmXI9fnQFCha
         tD9iFw6kuUjc3dCgxZYTFdo+M8vVSKNmbCrA8+5N48RFCgWZh8DyR4M6JFlMP1QGTCOc
         uMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698232385; x=1698837185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+D+BeZsEPMEv5rNbntpopdiMR8fAehJzR7Avs9K/vA=;
        b=Jvoh4Nq2MAgrcYi+xdbxhtND4jAQ2Icl+o0a/huicd6STqQjfNarFjaNbCsWQpcNv9
         2uwlHw5KPBQR+SD40BkRCER/w3ieCwbMOCKAYEFL/p7ipC6xIxdx/USsZT12V2/g0p36
         y2khMjxLqSFe4jhKdtJT6lcC/Vuj6AQqUGXPyL3QC82FGqvA6e+fXUAAZfq48mo86SPM
         bB17dW6cYR+vluqhWm/S4fcMOyWdTMSS7mUHH2dHshyFPrNgx94aWjF3GRuIwtQ+nSiL
         bIf4zCUwfYCQIDoPMKwmLC03FfToztSPsDkYkGDyjvVNQy847iqNInU4DlphE9fgscA3
         O4Xg==
X-Gm-Message-State: AOJu0Yy3BImATm88hMmf7ZW7K73PtlGraCIOof9MdcE4HDe/IdTATjoR
        YD14I57aKGiLB453/eRqzGeGuQ==
X-Google-Smtp-Source: AGHT+IF6szpxVxi80L5DU+dz954HXLZrnokCw6BZ1SAPk+8FOozdTZyH6sWiSPC2QHqTXJPyIrNuqw==
X-Received: by 2002:a19:9115:0:b0:503:1722:bf3a with SMTP id t21-20020a199115000000b005031722bf3amr10959254lfd.1.1698232385526;
        Wed, 25 Oct 2023 04:13:05 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d6687000000b00327bf4f2f14sm11754326wru.88.2023.10.25.04.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:13:05 -0700 (PDT)
Date:   Wed, 25 Oct 2023 14:13:01 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Wiktor Grzywacz <wiktor.grzywacz@3mdeb.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Signed-off-by: Wiktor Grzywacz
 <wiktor.grzywacz@3mdeb.com>
Message-ID: <793abd56-abaa-4780-a6ae-a5ea2cc2b7bd@kadam.mountain>
References: <20231025102614.125291-1-wiktor.grzywacz@3mdeb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025102614.125291-1-wiktor.grzywacz@3mdeb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 12:24:20PM +0200, Wiktor Grzywacz wrote:
> staging: rtl8723bs: fix checkpatch space before tab warning
> ---
>  drivers/staging/rtl8723bs/hal/rtl8723b_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
> index 2028791988e7..8bdb685c10e7 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
> @@ -46,7 +46,7 @@ static void Init_ODM_ComInfo_8723b(struct adapter *Adapter)
>  	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_CUT_VER, cut_ver);
>  
>  	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_PATCH_ID, pHalData->CustomerID);
> -	/* 	ODM_CMNINFO_BINHCT_TEST only for MP Team */
> +	/*  ODM_CMNINFO_BINHCT_TEST only for MP Team */
>  	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_BWIFI_TEST, Adapter->registrypriv.wifi_spec);
>  
>  	pdmpriv->InitODMFlag = ODM_RF_CALIBRATION|ODM_RF_TX_PWR_TRACK;
> @@ -84,7 +84,7 @@ static void Update_ODM_ComInfo_8723b(struct adapter *Adapter)
>  	/*  Pointer reference */
>  	/*  */
>  	/* ODM_CMNINFO_MAC_PHY_MODE pHalData->MacPhyMode92D */
> -	/* 	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_MAC_PHY_MODE,&(pDM_Odm->u8_temp)); */
> +	/*  ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_MAC_PHY_MODE,&(pDM_Odm->u8_temp)); */

This looks weird now because of the extra space.  Also it's dead,
commented out code.  Just delete it.

regards,
dan carpenter

