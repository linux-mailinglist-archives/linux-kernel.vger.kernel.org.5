Return-Path: <linux-kernel+bounces-34068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F6A8372CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56911F27101
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDB0405E4;
	Mon, 22 Jan 2024 19:42:24 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551F3FE40;
	Mon, 22 Jan 2024 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952543; cv=none; b=B2JqZ3oAkcJLtCHg4drEJBnBBjV+jUVBQUvQ+dSVyQpueJpt4kizzefgJ65adVTmIBZ7YGL9Git0EyG62GvIIfhtS3KxzMpKOAG3cOccKXqky/82MndqNDBgOUx9bE3h44p8DKMY/TYSqmH3fndF7YSdpsashu21Uoxh1AJKb58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952543; c=relaxed/simple;
	bh=EBY71G+stKvdgAgfUQIAL6gxEux90BE6E+8pNd/KO6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVlkJt91y+qQfwzhZamgbTthlBBOSJv0mUfPCavTVq064QqHxs6tyrvfuxAq34Hw+BD9DdYrduNbNd+AQh0X1LVE7Q6YezNwJ5cFe8BUE9MRkAEgaqeLt2n1SYn6ZdYk5UekVlDUFzQlU6bWfBpbdmhlH8cEHVlSSaFuIWemuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so392888366b.2;
        Mon, 22 Jan 2024 11:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952540; x=1706557340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eLfl0HX6++Px3EAfYBIkTshUZGU3OZxAvTMxrDWMYE=;
        b=aJDbIQ8P/YRk5qmEAJ1tiq9eEfDezC9ks14jrnpIMbWLEjqRw9M3unlGmcwPqgT+VI
         yjsa7PNzW6fZ6IzztK35bRaRBqm3dcCb7nAHBoSNgvWnpvP4rWezB8QxTFB8nodu8YBn
         /pNdoI4kGyk/DrZcOhkPBAYnDa0fjl0XTSz6yr2VxzLWO3V80zlcYVrxD5lTFG1702gB
         Z7jl5RGDmCrw7mbnPURhJgwhAtoVVj9OSVDAC+E44EZdrifdlSNCw308tZ0E+O9pjVBx
         tQUJIauEnZL0cuV5TVWObSqVbhVcFEs6IWnHmt15U+3R0tFfpyxHolK8ibvunWRkV12m
         pr5g==
X-Gm-Message-State: AOJu0YxxtqALf2NSfote/1OV57st2zLE0aCxf1tIexplvh1qzIzra2i5
	J982RmGj+8KJtTyfUwWEPvb1/PKo9aOJYrcDxfuSYydXuNxVRSStfb3g7ry10UtqptqR
X-Google-Smtp-Source: AGHT+IGFDrIf8N972kKgxrVcyi7WYBgEj25uwIEFf8XU2BYN2taBe0GLDZSjKrdJLU5gOXmfwwOIMA==
X-Received: by 2002:a17:907:18cb:b0:a2f:ba78:2b3e with SMTP id lm11-20020a17090718cb00b00a2fba782b3emr1457199ejc.101.1705952540153;
        Mon, 22 Jan 2024 11:42:20 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id cu15-20020a170906ba8f00b00a2ec877d3a6sm6726116ejd.167.2024.01.22.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:42:19 -0800 (PST)
Date: Mon, 22 Jan 2024 11:42:17 -0800
From: Breno Leitao <leitao@debian.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: kuba@kernel.org, davem@davemloft.net, abeni@redhat.com,
	edumazet@google.com, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Alexander Couzens <lynxis@fe80.eu>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>, dsahern@kernel.org,
	weiwan@google.com,
	"open list:LYNX PCS MODULE" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next 03/22] net: fill in MODULE_DESCRIPTION()s for
 PCS Layer
Message-ID: <Za7FGS7xfBBq0Te+@gmail.com>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-4-leitao@debian.org>
 <Za7ChrR88vvqAJ5X@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za7ChrR88vvqAJ5X@makrotopia.org>

On Mon, Jan 22, 2024 at 07:31:18PM +0000, Daniel Golle wrote:
> Hi Breno,
> 
> On Mon, Jan 22, 2024 at 10:45:24AM -0800, Breno Leitao wrote:
> > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > Add descriptions to the LynxI PCS MediaTek's SoC.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/pcs/pcs-lynx.c      | 1 +
> >  drivers/net/pcs/pcs-mtk-lynxi.c | 1 +
> >  drivers/net/pcs/pcs-xpcs.c      | 1 +
> >  3 files changed, 3 insertions(+)
> > 
> > diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> > index dc3962b2aa6b..d51d09beaab3 100644
> > --- a/drivers/net/pcs/pcs-lynx.c
> > +++ b/drivers/net/pcs/pcs-lynx.c
> > @@ -398,4 +398,5 @@ void lynx_pcs_destroy(struct phylink_pcs *pcs)
> >  }
> >  EXPORT_SYMBOL(lynx_pcs_destroy);
> >  
> > +MODULE_DESCRIPTION("MediaTek SGMII library for Lynx PCS");
> 
> Nah, pcs-lynx.c is used by various SoC vendors **other than MediaTek**
> such as Freescale and STMicroelectronics.
> 
> Users of the pcs-lynx.c driver are
> ethernet/stmicro/stmmac/dwmac-socfpga.c
> ethernet/altera/altera_tse_main.c
> ethernet/freescale/dpaa2/dpaa2-mac.c
> ethernet/freescale/enetc/enetc_pf.c
> ethernet/freescale/fman/fman_memac.c
> dsa/ocelot/felix_vsc9959.c
> dsa/ocelot/seville_vsc9953.c

Thanks. What about something as?

MODULE_DESCRIPTION("Lynx PCS MDIO helpers");


