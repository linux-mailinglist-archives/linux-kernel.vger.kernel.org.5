Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF8A7580CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjGRPX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjGRPXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:23:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA99D1998
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:23:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666ecb21f86so5867727b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689693798; x=1692285798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWDtHVs3Urak5aG+ygvNpGbYkcumje8U+MVjSEamA3I=;
        b=OSgivM0r2+T7IwP3feiWb17Gir3+X4dfmryhv0WyyhJE/WNLA6uo1tuYEOKlXQyHtd
         4O9/SbOauZ+QT0d/k7oBpbld7JMsW2KxBLkVKAARv8SzkUM//5zbFMwHVbui5y4P0qQi
         kfFZMUdgnETrnYLtDqJ3U6V/W2egiA9BKth7tozj1pIWRYCXqQbP/KztX9S+jU9EY/uo
         UdiaNYu7I77BnmfAMPhy7FsxHCJVDZsIEdTXPsUhMo7u0pv0BxuEDkqfPXE7de9OxEV0
         fYty3cmjTv7Xk/QgNSOjfkVZB6mlBNJsoYGoqBDA5DQHAJnO49V2SAo94AByTKb4qwBF
         MSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689693798; x=1692285798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWDtHVs3Urak5aG+ygvNpGbYkcumje8U+MVjSEamA3I=;
        b=GMHNJi+tgAvRwvXod9uhMUFpGiiendoPM2wBXTiKOc1i12dHJb41KQNoOFDSbI3j5G
         I0vhmZmcFyaB0akZ8Z5+CluhyOQOOULFqG2TqrZdWVyCXPTY9Zs5uTIsLBIQJqNQzSmS
         ZYU4MluxxqEKw9+OknAftqd8o45iSlGYwiCGKHLe9TOPbr00ZD4lb+2is7UgJhe6V/aq
         RunN/PTbxRIUAb+Dr+SAlQ1q5be8rwNiJjyEVZ47jSVPtmaTcbDo7OtMQuqTCeuZ+6oj
         lY1TXeqbMg60Xs87lRWPMW2Mx9TFnMBZq+LD0iZv4wiDYakkFFtp617DVBxML96BjQay
         E00Q==
X-Gm-Message-State: ABy/qLapnHesJVCe+oti/Llj1PL6pwHV6QmZiU23OSyCRJDegYPIM0OD
        Ohi2yIoLRhUov48DzKOGaQjwMdNUviw3eVzPXKY=
X-Google-Smtp-Source: APBJJlE+sWd4ROQI9JcUy6oSHWAFtSVeK0lAHGj5ZqujU3RjIYVyIliD/z6LGdnmOnfT++85IjeDIQ==
X-Received: by 2002:a05:6a20:72a3:b0:133:96c9:fb3b with SMTP id o35-20020a056a2072a300b0013396c9fb3bmr16428354pzk.45.1689693798346;
        Tue, 18 Jul 2023 08:23:18 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:181:e3fe:53e1:920])
        by smtp.gmail.com with ESMTPSA id c14-20020aa78c0e000000b00654228f9e93sm1678412pfd.120.2023.07.18.08.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 08:23:17 -0700 (PDT)
Date:   Tue, 18 Jul 2023 09:23:15 -0600
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
Message-ID: <ZLauY85b9SRC3z0x@p14s>
References: <20230712224220.26430-1-iuliana.prodan@oss.nxp.com>
 <ZLV9gAmiDldlvIUR@p14s>
 <474c0241-a58e-b435-8ac1-82a5a458d79a@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474c0241-a58e-b435-8ac1-82a5a458d79a@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:25:03AM +0300, Iuliana Prodan wrote:
> On 7/17/2023 8:42 PM, Mathieu Poirier wrote:
> > On Thu, Jul 13, 2023 at 01:42:20AM +0300, Iuliana Prodan (OSS) wrote:
> > > From: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > 
> > > Add the .find_loaded_rsc_table operation for i.MX DSP.
> > > We need it for inter-process communication between DSP
> > > and main core.
> > > 
> > > This callback is used to find the resource table (defined
> > > in remote processor linker script) where the address of the
> > > vrings along with the other allocated resources (carveouts etc)
> > > are stored.
> > > If this is not found, the vrings are not allocated and
> > > the IPC between cores will not work.
> > Is there a constraint on the system memory the M4 can address?  If so there
> > will be a need to declare address ranges for vrings and buffers in reserved
> > memory in the DT.
> > 
> > Thanks,
> > Mathieu
> 
> Hi Mathieu,
> 
> No, there is no constraint on memory.
> 
> We want the Cortex A core to communicate with the HiFi4 DSP.
> The Cortex A is in charge of starting the DSP and loading the firmware in
> HiFi4's memory.
> When using rpmsg for IPC, the Cortex A needs to find the resource table
> (defined in the DSP linker script) and this is done using
> .find_loaded_rsc_table callback.
> 
> For the DT, we are using a (not upstream) device tree where we have the
> reserved-memory for dsp_vdev0vring0, dsp_vdev0vring1 and dsp_vdev0buffer.

That is the part I'm interested in.  Don't we need the reserved-memory entries?
Otherwise the M4 may not be able to access the memory chosen by the application
processor, most likely leading to a crash.

> 
> Iulia
> 
> 
> > > Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > ---
> > >   drivers/remoteproc/imx_dsp_rproc.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> > > index d95fa5586189..b5634507d953 100644
> > > --- a/drivers/remoteproc/imx_dsp_rproc.c
> > > +++ b/drivers/remoteproc/imx_dsp_rproc.c
> > > @@ -941,6 +941,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
> > >   	.kick		= imx_dsp_rproc_kick,
> > >   	.load		= imx_dsp_rproc_elf_load_segments,
> > >   	.parse_fw	= imx_dsp_rproc_parse_fw,
> > > +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> > >   	.sanity_check	= rproc_elf_sanity_check,
> > >   	.get_boot_addr	= rproc_elf_get_boot_addr,
> > >   };
> > > -- 
> > > 2.17.1
> > > 
