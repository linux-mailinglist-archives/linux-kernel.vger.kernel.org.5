Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE9975C1C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjGUIfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGUIe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:34:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAC7273E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:34:31 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36L7C3TY012776;
        Fri, 21 Jul 2023 03:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=4X5Vk5GzjGOeC6P
        vbgtdeu+U2bY+ZOvoDw8i1UzpoY4=; b=qdw/l4urdIy5Rc9CFCJL018s2IiY4lL
        E+lGszxaV51jy8xdOtJTAxswZupRQT1mornimEQZft28kr7bqqaGiJhEMhVTcVU3
        /QmT6J1zQox2THnOZiOLOGeoYnNMaVIqfFpK/hj89Hj3354JqjWegWjgzlhTLwb7
        Sw2eJSbqTNMtICQYSoRhE+DP5GJijsulZOlDiQdb+aJPna/wBjARAffzNsf3sztS
        FsFm87fWIppIJcjriMB/uqzeyRYmLN9gKX+wIekRbwYDlgukeDMlpX8F9FDKyxK+
        B3a1zUQNCTkRA+bfjV+Lf+8t5sTUj3Ap4Nt+cubOy1rTv9dvED+29Og==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3rus62xvn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 03:34:02 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 09:34:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Fri, 21 Jul 2023 09:34:00 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3E6143560;
        Fri, 21 Jul 2023 08:34:00 +0000 (UTC)
Date:   Fri, 21 Jul 2023 08:34:00 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8960: Add DAC filter characteristics selection
Message-ID: <20230721083400.GK103419@ediswmail.ad.cirrus.com>
References: <1689925948-21001-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1689925948-21001-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: KKA1_9swrhuJ-ghUBfoWBjL1c7-345QA
X-Proofpoint-ORIG-GUID: KKA1_9swrhuJ-ghUBfoWBjL1c7-345QA
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 03:52:28PM +0800, Shengjiu Wang wrote:
> Support DAC filter characteristics selection: Normal mode
> and Sloping stopband. Sloping stopband may have
> better frequency response.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/codecs/wm8960.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
> index 366f5d769d6d..ff1355306b43 100644
> --- a/sound/soc/codecs/wm8960.c
> +++ b/sound/soc/codecs/wm8960.c
> @@ -155,6 +155,7 @@ static const char *wm8960_adc_data_output_sel[] = {
>  	"Left Data = Right ADC; Right Data = Left ADC",
>  };
>  static const char *wm8960_dmonomix[] = {"Stereo", "Mono"};
> +static const char *wm8960_dacslope[] = {"Normal", "Sloping"};
>  
>  static const struct soc_enum wm8960_enum[] = {
>  	SOC_ENUM_SINGLE(WM8960_DACCTL1, 5, 4, wm8960_polarity),
> @@ -165,6 +166,7 @@ static const struct soc_enum wm8960_enum[] = {
>  	SOC_ENUM_SINGLE(WM8960_ALC3, 8, 2, wm8960_alcmode),
>  	SOC_ENUM_SINGLE(WM8960_ADDCTL1, 2, 4, wm8960_adc_data_output_sel),
>  	SOC_ENUM_SINGLE(WM8960_ADDCTL1, 4, 2, wm8960_dmonomix),
> +	SOC_ENUM_SINGLE(WM8960_DACCTL2, 1, 2, wm8960_dacslope),
>  };
>  
>  static const int deemph_settings[] = { 0, 32000, 44100, 48000 };
> @@ -307,6 +309,7 @@ SOC_SINGLE_TLV("Right Output Mixer RINPUT3 Volume",
>  
>  SOC_ENUM("ADC Data Output Select", wm8960_enum[6]),
>  SOC_ENUM("DAC Mono Mix", wm8960_enum[7]),
> +SOC_ENUM("DAC filter characteristics", wm8960_enum[8]),

Be nice to capitalise, to match the other controls but otherwise
looks good to me:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
