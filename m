Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAC57D3D70
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjJWRYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJWRYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:24:34 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB73A2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:24:32 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5aa7fdd1420so1916175a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698081872; x=1698686672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BbbHD0YVJk9RufSxoYcq0y3n5cPhLMIwtkNHWUlAfWQ=;
        b=dSOslNcwyAix9UllTlLTRabeAZh85m57t8Mj7ws5bhMzQd+pUnOYxujudcsnJuhJzl
         KnsX1oxZ6VYQXsaBa2QcAW7/WhRFOGxo8nuY8LbAK4J0VFjI0AMHF6ZqwpzpXeDf4K5h
         SqT9kItDb82gSUU7CouIpZMMWrRsf5dwARIzd+7aZJyF6RIFgB0GPusNyPGcXTOpE1i+
         6Oownm+XphIZpUoZg96uZrgqh91bh17MVALhQvYDGrG95bXicAvhVqoe2v2TAqciL8xU
         69WIv2GOzKxPojIllusOYKRbt4DP8etEqczpOMGF5Ajxb/jR5UOk6mov+fsOPUM0mAdJ
         1FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698081872; x=1698686672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbbHD0YVJk9RufSxoYcq0y3n5cPhLMIwtkNHWUlAfWQ=;
        b=lWJoR2RfD6X71sV5f++3pRGTo19YQLlRMsU0B1hG2mEjl/wNW8dmR4lp3MVzfUEpYo
         iIufjruAmFhGdiRzEsXbv1XVDplZ484KmKjBw/Oqz9tPameDIi/3hQGub0xw6Gqi7Qed
         PIv2iK8NQtw3kKjgXIgyMGCnjdVSPmL8D4qlWKjMlIY9xw57pzc0z1fT9tXh4Pbh9jQX
         QbsdW6iLJDR8aTAFom834UkfSNmum32fdSW+th+z+kkv7gDcUmEs6n0gHpYEylqQQ4bW
         ZV1mXkKAWd3h9gHdgiYgzfyupk/VUZolU2GQvhyQsxloSKzOqGiaqqji5csY3jyZvvIt
         1a8A==
X-Gm-Message-State: AOJu0YziVNzgrktnahx/Z3WUpymOrZqYVdheUtbB+AWJOGxRac22x2bx
        1lxZPY/EaVnjtZ4JMuDzrImsHg==
X-Google-Smtp-Source: AGHT+IH5zn+p2FocGpHxAFS8gSDBMs+R8rkPa0KF41+FQfuasRuzkg4dmkOhZbI85fDx40K/Hlwn2w==
X-Received: by 2002:a05:6a21:498b:b0:17b:d39c:1d6 with SMTP id ax11-20020a056a21498b00b0017bd39c01d6mr239194pzc.30.1698081871694;
        Mon, 23 Oct 2023 10:24:31 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:85b7:8283:12b2:30f8])
        by smtp.gmail.com with ESMTPSA id cx3-20020a17090afd8300b0027d1366d113sm7419661pjb.43.2023.10.23.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:24:31 -0700 (PDT)
Date:   Mon, 23 Oct 2023 11:24:28 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        alexander.stein@ew.tq-group.com,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8mp: add reserve-memory nodes for
 DSP
Message-ID: <ZTasTEvw4//SEMlW@p14s>
References: <20231013152731.23471-1-iuliana.prodan@oss.nxp.com>
 <20231013152731.23471-3-iuliana.prodan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013152731.23471-3-iuliana.prodan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

On Fri, Oct 13, 2023 at 06:27:31PM +0300, Iuliana Prodan (OSS) wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> Add the reserve-memory nodes used by DSP when the rpmsg
> feature is enabled.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 22 ++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index fa37ce89f8d3..b677ad8ef042 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -125,6 +125,28 @@
>  		};
>  
>  	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		dsp_vdev0vring0: vdev0vring0@942f0000 {
> +			reg = <0 0x942f0000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		dsp_vdev0vring1: vdev0vring1@942f8000 {
> +			reg = <0 0x942f8000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		dsp_vdev0buffer: vdev0buffer@94300000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x94300000 0 0x100000>;
> +			no-map;
> +		};
> +	};

Alexander: Are you good with the refactoring?

Rob and Krzysztof: I'm not sure if you want to ack this patch but giving you the
benefit of the doubt.

Shawn and Sascha: Did you plan on picking up this patch or shoud I?

Thanks,
Mathieu

>  };
>  
>  &flexspi {
> -- 
> 2.17.1
> 
