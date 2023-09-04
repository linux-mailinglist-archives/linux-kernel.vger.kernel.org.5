Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD93791EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbjIDVQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjIDVQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:16:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB5EAB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:16:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a42d06d02so1049266b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 14:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693862192; x=1694466992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8wgNVpTNDzCrao34l0u3J7l14QWnA5VC866xjk8bCs=;
        b=H76zgmQPrOaVCtuK3S6oQQc78+NVglHyXMblwT+Dyftj2yQYx2wO+pzq6ZoNT+JNhi
         qicKfRUomUHLCzEltre2YvfxsLYapFJV23h6gaPVg71NJ1MFDhxX801grWEqATLv8Ptt
         ZbcxZ+NPglmt99iqVDaB2Bhk7ECDFq0973W129rC9MsLNLjZLLLWkYSA1jzeVKHNGQWC
         pzEfnBapPX9HWtv+ilt7JuPM4BP1TyWlqQS5Zunr6p+J/I0UrmEF1CAq3uynj7NJcxH8
         OdFEZ2pob1tIJDXVDUtuiW+66H96ynyGfbkXk94FqiiI70oxks3kIZRkr06xNrUagmE7
         IuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693862192; x=1694466992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8wgNVpTNDzCrao34l0u3J7l14QWnA5VC866xjk8bCs=;
        b=G6klB7PcDjgN75VGqLjWq0d1BRTflghGmqsEkRwGlW8mYsnoLgyPcCoeB5RNrRPH8C
         OEvM6kzpm+7ETCvZwt7gBYLg99nkgFuxDOVVYIf6D6jad24mVAdpeF63i7WbNk7XOHGF
         TN8RsQQRNfzXvPgwCzNwxDrMg/eG8DgXOIyICHM+SXsJhgjBja9tdn25xXEoy9HHxGaJ
         LTjFKvqBwCl/9hFdVJkHT1kvoUujQmIbDa5jI0dQXkKmkPp62h8dLM2qfWz6KPKcoL2G
         5XsRhMeQw8U0JmVjQ6vCYdZ8Meb537mvoNdnQHSSPHK1yCVR5f/ZrSuinLrL7BK53WC3
         Bz9w==
X-Gm-Message-State: AOJu0YxU/WsJDgEjYBgI12NvvW2Z0tlCNZG+P2FO2Z6Pd9vxM3dxyDL6
        sL0+0MF9RkXCPVQ/HiYlUMwYRw==
X-Google-Smtp-Source: AGHT+IH7TUfPW532y/4a5gyD3Op0vnux/RtbP+cf8JnuHrM7jURUa8Odo5hrXciGhAVG/SaWM6u0qQ==
X-Received: by 2002:a05:6a00:2d94:b0:68a:457f:d3ee with SMTP id fb20-20020a056a002d9400b0068a457fd3eemr10323147pfb.28.1693862191905;
        Mon, 04 Sep 2023 14:16:31 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:4d17:cefe:4740:3fd1])
        by smtp.gmail.com with ESMTPSA id r9-20020a62e409000000b00682b299b6besm7719240pfh.70.2023.09.04.14.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 14:16:31 -0700 (PDT)
Date:   Mon, 4 Sep 2023 15:16:28 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>, linux-imx <linux-imx@nxp.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: Re: [PATCH 1/2] remoteproc: imx_dsp_rproc: add mandatory
 find_loaded_rsc_table op
Message-ID: <ZPZJLJpL+f9nB1cn@p14s>
References: <20230712224220.26430-1-iuliana.prodan@oss.nxp.com>
 <ZLV9gAmiDldlvIUR@p14s>
 <474c0241-a58e-b435-8ac1-82a5a458d79a@nxp.com>
 <ZLauY85b9SRC3z0x@p14s>
 <03d7c703-81cb-20f9-aaf8-2ab8ca3e7138@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03d7c703-81cb-20f9-aaf8-2ab8ca3e7138@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 06:40:53PM +0300, Iuliana Prodan wrote:
> 
> On 7/18/2023 6:23 PM, Mathieu Poirier wrote:
> > On Tue, Jul 18, 2023 at 11:25:03AM +0300, Iuliana Prodan wrote:
> > > On 7/17/2023 8:42 PM, Mathieu Poirier wrote:
> > > > On Thu, Jul 13, 2023 at 01:42:20AM +0300, Iuliana Prodan (OSS) wrote:
> > > > > From: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > > > 
> > > > > Add the .find_loaded_rsc_table operation for i.MX DSP.
> > > > > We need it for inter-process communication between DSP
> > > > > and main core.
> > > > > 
> > > > > This callback is used to find the resource table (defined
> > > > > in remote processor linker script) where the address of the
> > > > > vrings along with the other allocated resources (carveouts etc)
> > > > > are stored.
> > > > > If this is not found, the vrings are not allocated and
> > > > > the IPC between cores will not work.
> > > > Is there a constraint on the system memory the M4 can address?  If so there
> > > > will be a need to declare address ranges for vrings and buffers in reserved
> > > > memory in the DT.
> > > > 
> > > > Thanks,
> > > > Mathieu
> > > Hi Mathieu,
> > > 
> > > No, there is no constraint on memory.
> > > 
> > > We want the Cortex A core to communicate with the HiFi4 DSP.
> > > The Cortex A is in charge of starting the DSP and loading the firmware in
> > > HiFi4's memory.
> > > When using rpmsg for IPC, the Cortex A needs to find the resource table
> > > (defined in the DSP linker script) and this is done using
> > > .find_loaded_rsc_table callback.
> > > 
> > > For the DT, we are using a (not upstream) device tree where we have the
> > > reserved-memory for dsp_vdev0vring0, dsp_vdev0vring1 and dsp_vdev0buffer.
> > That is the part I'm interested in.  Don't we need the reserved-memory entries?
> > Otherwise the M4 may not be able to access the memory chosen by the application
> > processor, most likely leading to a crash.
> 
> This kernel module (imx_dsp_rproc) is used only for DSP.
> For M4 core we use imx_rproc.
>

The point here is that if I merge this patch and someone tries to load a
firmware image that has a resource table, the system will likely crash because
reserved memories haven't been specified in the DT.

Unless there is a very good reason not to, I would like to see the companion DT
changes submitted with this patch so that the feature is complete.

> Iulia
> 
> > > Iulia
> > > 
> > > 
> > > > > Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > > > ---
> > > > >    drivers/remoteproc/imx_dsp_rproc.c | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> > > > > index d95fa5586189..b5634507d953 100644
> > > > > --- a/drivers/remoteproc/imx_dsp_rproc.c
> > > > > +++ b/drivers/remoteproc/imx_dsp_rproc.c
> > > > > @@ -941,6 +941,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
> > > > >    	.kick		= imx_dsp_rproc_kick,
> > > > >    	.load		= imx_dsp_rproc_elf_load_segments,
> > > > >    	.parse_fw	= imx_dsp_rproc_parse_fw,
> > > > > +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> > > > >    	.sanity_check	= rproc_elf_sanity_check,
> > > > >    	.get_boot_addr	= rproc_elf_get_boot_addr,
> > > > >    };
> > > > > -- 
> > > > > 2.17.1
> > > > > 
