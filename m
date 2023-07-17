Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A1A756AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjGQRmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjGQRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:42:30 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FF11A8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:42:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8ad907ba4so26647275ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689615747; x=1692207747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2TPQLj+5bXU4oKqQgWi7jLjSmRDggaDn+c50v2mtwM=;
        b=kSMGYEW0Px1nJa3jtUFMmrwk2W5m3YtBYIr01lnHo7cnaCSGkqnhXm+LbF2t+noZ7q
         6dTfrYm1q/yMZ93vWgY5JVs4uCGo92vjVTxahjZeR19M2TzEhCROA8QIKq0cdX2EJ2P/
         dKw6FYSgTdjMHO2CeFvoCSqGRDOcJkJUU4K+Ady72ghThm/MNcuoR286/6qH4wF5KGMY
         4acG0oAg8zqfn2NMfptTG1IjSPufmceQwMTV9VvbtdNsei0Pn+BU36PQmbuiTkJSLg+w
         e+m1ptS7Qair7avArFw9qNHJaerAz++IJ1J9V0ycfawjfEQV5QbvVpSU8XYbwvoFHy4B
         NBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689615747; x=1692207747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2TPQLj+5bXU4oKqQgWi7jLjSmRDggaDn+c50v2mtwM=;
        b=gQpTxw1/Y58ZcAFXy2z1VGpQxpmn8ZcYXZa0HsdtlFv9fZeEdM2iH+rufMttPzHUlC
         zffnUo9S2p0KxPpxfPB9389ocauyDtdQCdzpXb+wlp8KSWElMt/E3j38RPeqQQiIYPq0
         B9/f46VE8N900ZsNbtTI4xXQaUvxhJbdlGbVYIIh5itfeHFgnaDAJ7lykCl+bzowJxIg
         so02kXC4AZ/LQuhRZZOHH/K+DuI+rIp8amBukHnzLGXH4NckWF2TkjHWqPUeekYrF9nA
         FKsdwChKhIfCCeQ0U2L99309m1zThEMm9cD0H5DcmUeQMLTHYZoNyHdY5AkmZe0opTnN
         e3Dg==
X-Gm-Message-State: ABy/qLYMdsOZfBIVhuQcgZmvWNg82hEuNepwstcbu3HMoIF+bDLKh+CF
        MTGXi6F18kakXMb2/s2l25sWLA==
X-Google-Smtp-Source: APBJJlHETE8kXHKsIMYEy9FiSPyIeEwDiD+zln4n72/wHDGQDtnej9rSPpnFbub+R2K6sLk8S4Wrkw==
X-Received: by 2002:a17:902:f688:b0:1b8:987f:3eaa with SMTP id l8-20020a170902f68800b001b8987f3eaamr12728016plg.58.1689615747151;
        Mon, 17 Jul 2023 10:42:27 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3328:146c:de53:b695])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b89a6164desm173607plg.118.2023.07.17.10.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 10:42:26 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:42:24 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: Re: [PATCH 1/2] remoteproc: imx_dsp_rproc: add mandatory
 find_loaded_rsc_table op
Message-ID: <ZLV9gAmiDldlvIUR@p14s>
References: <20230712224220.26430-1-iuliana.prodan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712224220.26430-1-iuliana.prodan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:42:20AM +0300, Iuliana Prodan (OSS) wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> Add the .find_loaded_rsc_table operation for i.MX DSP.
> We need it for inter-process communication between DSP
> and main core.
> 
> This callback is used to find the resource table (defined
> in remote processor linker script) where the address of the
> vrings along with the other allocated resources (carveouts etc)
> are stored.
> If this is not found, the vrings are not allocated and
> the IPC between cores will not work.

Is there a constraint on the system memory the M4 can address?  If so there
will be a need to declare address ranges for vrings and buffers in reserved
memory in the DT.

Thanks,
Mathieu

> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index d95fa5586189..b5634507d953 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -941,6 +941,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
>  	.kick		= imx_dsp_rproc_kick,
>  	.load		= imx_dsp_rproc_elf_load_segments,
>  	.parse_fw	= imx_dsp_rproc_parse_fw,
> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>  	.sanity_check	= rproc_elf_sanity_check,
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>  };
> -- 
> 2.17.1
> 
