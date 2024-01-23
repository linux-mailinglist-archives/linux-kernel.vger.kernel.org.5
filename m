Return-Path: <linux-kernel+bounces-35580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC15839397
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387542949C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7986311F;
	Tue, 23 Jan 2024 15:42:21 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B2D5FDCC;
	Tue, 23 Jan 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024540; cv=none; b=fqRnqAOgaCKsFynLdbzfgDoMcRqyt4MLiZVyu/pnxGMpUtvrSlCAtMPaSQwZq7VjJYqGp4V13edpEksBpl3ooxCc47CVWRX+IRD88BGFggab4LjxwX1piTltBsAJevgpzivEgDuLUHxFY6PLTMSN75Vfsw96a/PzJsEVRr3PCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024540; c=relaxed/simple;
	bh=+UTa81YBW44P6//FAvDPxu5DehAqS8ZpjCgHujskPTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqRLiHJW6kkk11ZNo++A208OjMrVyCZ9jP/wUQyrd9ZAtj/z+om1ZTzcyqCaZeEDst5GMD+v3D0xDEfjm78K63XF0hHJAC/QYc4XV7osxWypZaw7KmR82yI0wSP2G50boGhfg0X6QU18zKqb8YkyyZIdDQHgcET53uHjw+0rCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a50649ff6so4858417a12.3;
        Tue, 23 Jan 2024 07:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024537; x=1706629337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2y5sNM/yucnPZoLAx7205huvZIvC+f7wQVXFZ6uwJs4=;
        b=bHEtgf4b/KpoejtTgT/6eZpPNau1GrTLkdITtx8PTsm01rkb9xyt2QO87bBBTY8W43
         N/TKXmL7QHTNpVqbnhtO675UfPnsGFRaUIICYXHyS39j85Zx539TxmVlQGaT+jRyTkIi
         9Q3Mh7nrkjpthDUBfdym0lgKCStgmSOLBhTfUZ+hYcNsQWgvdvZRSGgfKI0uGnlO6fLt
         M6PIeAJaNyFfLSfHeg3ZJL2sWV+BRIfdinBx2hRc2pp4QDfnKxPBWHG/bUrngNjseM3r
         ant1anMYKM/weihu6Cb8tySAGNXH6wIUaRstX+rre674Iiem3bM8O/FSIl6z8LNOfDsu
         Gmsg==
X-Gm-Message-State: AOJu0YzzHv/edPV31kzoDbW+SGVwjOdFZze+7W40BHeUF5Mp4mKhLFq3
	NbQX+EIFA0BYT1yV6hCa1S8eI81Vvbwv8GKGWwMYMJZsxLIq7OttYXRfaocDqEl4mw==
X-Google-Smtp-Source: AGHT+IFC6wAGsAj8uqnHsUUWEfLyGPf0JkShRDRdnJYHXY00IYEfnj8URw1o78onPzMjsyBmcGXT/Q==
X-Received: by 2002:a17:906:1391:b0:a28:d273:82b7 with SMTP id f17-20020a170906139100b00a28d27382b7mr43594ejc.41.1706024537177;
        Tue, 23 Jan 2024 07:42:17 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-009.fbsv.net. [2a03:2880:31ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id lb14-20020a170906adce00b00a2c869c2fe8sm14146661ejb.161.2024.01.23.07.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:42:16 -0800 (PST)
Date: Tue, 23 Jan 2024 07:42:14 -0800
From: Breno Leitao <leitao@debian.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: kuba@kernel.org, davem@davemloft.net, abeni@redhat.com,
	edumazet@google.com, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	UNGLinuxDriver@microchip.com, Paolo Abeni <pabeni@redhat.com>,
	dsahern@kernel.org, weiwan@google.com,
	"open list:OCELOT ETHERNET SWITCH DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 14/22] net: fill in MODULE_DESCRIPTION()s for
 ocelot
Message-ID: <Za/eVmcC9GS94Ivy@gmail.com>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-15-leitao@debian.org>
 <20240123074826330a374e@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123074826330a374e@mail.local>

On Tue, Jan 23, 2024 at 08:48:26AM +0100, Alexandre Belloni wrote:
> Hello,
> 
> On 22/01/2024 10:45:35-0800, Breno Leitao wrote:
> > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > Add descriptions to the Ocelot SoCs (VSC7514) helpers driver.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/ethernet/mscc/ocelot.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
> > index 56ccbd4c37fe..12999d9be3af 100644
> > --- a/drivers/net/ethernet/mscc/ocelot.c
> > +++ b/drivers/net/ethernet/mscc/ocelot.c
> > @@ -3078,4 +3078,5 @@ void ocelot_deinit_port(struct ocelot *ocelot, int port)
> >  }
> >  EXPORT_SYMBOL(ocelot_deinit_port);
> >  
> > +MODULE_DESCRIPTION("Ocelot SoCs (VSC7514) helpers");
> 
> Shouldn't that mention that this is related to the Ethernet switch?

sure. let me update it.

