Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DCA761FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGYRFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGYRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:05:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8211985;
        Tue, 25 Jul 2023 10:05:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso58359665e9.0;
        Tue, 25 Jul 2023 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690304738; x=1690909538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2YUR+1v8W/voZcNojBPaaUUVvQAZPetxDPBBz2RD/0k=;
        b=sOBtHCrgt0k5pmbqlkrW8pb55VVzKoYoLL3sk2y04bbxPHs61Cw1IF6RCGAGm/V1Xk
         TxcBND/FDqb5MOUP0gwEK35nnoZvlyJuB/mMAWOU+Ob9NbUbjBwENxs6LzlT8rydNGsK
         piIjq4sOavk3fyVyIzmbiI0VluAhLe4fzlgG/QwFRLKRg36EMP+wXq1Y32/fNZBQcF8w
         ybSVFjcV/UXoAjmnQntWjjnGhWF8sh4GszangyMoVM3ch2gjD6fcmXi3vT/cxWPyZLHV
         ieaslON89JBQbWSjL3RFLUnZ7Zip2WeewXM2IqWxFUUSFt+0z3JiMG3kKWA4EtQuOQ3A
         QEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690304738; x=1690909538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YUR+1v8W/voZcNojBPaaUUVvQAZPetxDPBBz2RD/0k=;
        b=dLw+7H62tBnroYO72HYGlLtftubzeufT9vMK0l27feUxq7WLyKqwm5VP7vxCIAG5GZ
         ZBLyqr/h/jNukfl4HWitdm/KqtwTPe3WTzeZrASYVCwIo5VYoYFDZ6P0U8MfEkeBicz1
         usah05OXUNbpzRgB6B7xK/vxajzCEKXDR5E/vc7KSiRuDyrcfgzyTg0GEL98NHhzXNah
         mSNbTw6qFLufdqoLbAFpVrvbN+yoWTvmRuxGGiplWVTKvTf2XKWMdB0NuY/h7u/dDhoB
         ylDZ1znwv7/IO+9V2pVhYZngYPR05ZimVsTn5E8cAzfqI23QmdLLNR9pDp3Ekew+WKzM
         z9tg==
X-Gm-Message-State: ABy/qLbsNBf4kClNSdbiVwy8q45Ey0R587LcW3vbm+uDoxj7reSmMMBT
        vF0hAn8jRtWbRjLvxdrZ2Sw=
X-Google-Smtp-Source: APBJJlEFgSWnRgXdmQ2o6ZO165MFWF2IIzaMFL2OnqpUcFLM56F3JlqVQWktiFO+/Ju2MIyFi3VYHw==
X-Received: by 2002:a5d:4b4e:0:b0:313:ef93:925a with SMTP id w14-20020a5d4b4e000000b00313ef93925amr10499644wrs.24.1690304737872;
        Tue, 25 Jul 2023 10:05:37 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d5492000000b003142e438e8csm16970811wrv.26.2023.07.25.10.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 10:05:37 -0700 (PDT)
Date:   Tue, 25 Jul 2023 20:05:35 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "open list:FREESCALE DSPI DRIVER" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PTP HARDWARE CLOCK SUPPORT" <netdev@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] spi: fsl-dspi: Use dev_err_probe() in
 dspi_request_dma()
Message-ID: <20230725170535.7eh7gciw4j33ds3p@skbuf>
References: <20230725035038.1702-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725035038.1702-1-duminjie@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:50:37AM +0800, Minjie Du wrote:
> It is possible for dma_request_chan() to return EPROBE_DEFER, which means
> dev is not ready yet.
> At this point dev_err() will have no output.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index ca41c8a8b..6aaa529b7 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -503,15 +503,14 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
>  
>  	dma->chan_rx = dma_request_chan(dev, "rx");
>  	if (IS_ERR(dma->chan_rx)) {
> -		dev_err(dev, "rx dma channel not available\n");
> -		ret = PTR_ERR(dma->chan_rx);
> -		return ret;
> +		return dev_err_probe(dev, PTR_ERR(dma->chan_rx),
> +			"rx dma channel not available\n");

This does not have correct alignment either. Tabs are supposed to be
rendered using 8 spaces.

>  	}
>  
>  	dma->chan_tx = dma_request_chan(dev, "tx");
>  	if (IS_ERR(dma->chan_tx)) {
> -		dev_err(dev, "tx dma channel not available\n");
>  		ret = PTR_ERR(dma->chan_tx);
> +		dev_err_probe(dev, ret, "tx dma channel not available\n");
>  		goto err_tx_channel;
>  	}
>  
> -- 
> 2.39.0
> 
