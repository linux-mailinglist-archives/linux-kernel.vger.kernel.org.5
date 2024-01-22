Return-Path: <linux-kernel+bounces-34076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0658372EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74D7289D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B2747F54;
	Mon, 22 Jan 2024 19:42:57 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F143F47A6C;
	Mon, 22 Jan 2024 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952577; cv=none; b=qGFkk8tDZKIB3lVGQvja4bUtQglsv8Ls3gRveL3U1tQO6vPuS35bc3zo0NyGwyPQmvV70l0dUUm7v5bupm9d+V0jtvSt2iYYz9P7V1PCICtXzmlDYhwkpMMUyotS/4AWl82OOAnM0Gvt52n+M9TDha5ZPgnux/2YgR4b9UcEikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952577; c=relaxed/simple;
	bh=tGx+wjv2kD7SWo6vWGqt+QOeT37RD+iUKyRyzGjc+4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOfx9W4I1ljcKI/AoQtPX1zw3LtvjibP8EPOPSZH6mrIFaU9jypL7MMP4Oi15YdoWGZq5RDYQKV0h0qRJkAtRN6Wi8P4WyO0n/0oEC711t2d4jiMHjs78Aua0Nv8ea9qWDfNZrKKqqf/O1MDnIQmFeHhKo3h7qRI6m2G2MWgPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so606916266b.1;
        Mon, 22 Jan 2024 11:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952574; x=1706557374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSz9MgcaBEj1PDlX4xVuO8K29ToCXliySSzjMUOEVTU=;
        b=I8BHz6QzUnpYT+f9W76zkVNvwtOKmnZ0Ppi4rEJ6enNdr7aefLS/G7izqmIPXZrAf/
         YOIWLZfIe912bnEVDZRKQVsuwXWr64tb/+6WV20b/EFjPi1udchWKd1gMx25tgjKcFqJ
         Tonm5KnGAa96dRrvqSfzzpRVhorrFo7oOhdjltViNZe79mUDpgzICjLIuuRmNloBeAuJ
         l8WOTR4k8NUtEFwt52Qps5eqJegIZZolWc7fF4eKBaj4mVL8GlXzMlqAHiDC0/tDr77+
         qJ4WLZ/2GLh3tPZCjgcEe8zckkXbEwfBx9pNBrosg4wiRb24FP2oRprBuP9lwwr1wftM
         AkIA==
X-Gm-Message-State: AOJu0YyBhea/wxspPhi4N9BXE5JsMzxZIqXv7eqKPQkTvB0E+x9wwpSi
	0lUVnWPdR2hJ7GLXM4hBXa4Gyyh3DMDsdBKPj+wEvQZNc8T7K4HY
X-Google-Smtp-Source: AGHT+IFQFCGpmLYtrnRwSCjHHeNf9K+eWlAMbY6MH7qysKYu0OOCBDzmRNRSH/REALQ1FNXviTDUFQ==
X-Received: by 2002:a17:906:3a92:b0:a29:32bf:9c8 with SMTP id y18-20020a1709063a9200b00a2932bf09c8mr4714272ejd.39.1705952574020;
        Mon, 22 Jan 2024 11:42:54 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-009.fbsv.net. [2a03:2880:31ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id ca23-20020a170906a3d700b00a2bd01c2349sm13594158ejb.169.2024.01.22.11.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:42:53 -0800 (PST)
Date: Mon, 22 Jan 2024 11:42:51 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: kuba@kernel.org, davem@davemloft.net, abeni@redhat.com,
	edumazet@google.com, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
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
Message-ID: <Za7FO7yBZ1a2KQ3B@gmail.com>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-4-leitao@debian.org>
 <52e39a1b-c551-4eea-9606-62be0cbad39f@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52e39a1b-c551-4eea-9606-62be0cbad39f@lunn.ch>

On Mon, Jan 22, 2024 at 08:33:31PM +0100, Andrew Lunn wrote:
> On Mon, Jan 22, 2024 at 10:45:24AM -0800, Breno Leitao wrote:
> > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > Add descriptions to the LynxI PCS MediaTek's SoC.
> 
> That patch now does more than that.
> 
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
> pcs-lynx is for NXP hardware, not MediaTek.

Thanks. I will update!

