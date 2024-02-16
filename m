Return-Path: <linux-kernel+bounces-67943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0065D857362
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EA11C21998
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A305DDC5;
	Fri, 16 Feb 2024 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFrxFGqH"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA98F49;
	Fri, 16 Feb 2024 01:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046691; cv=none; b=iTJqhrX05kgkEII1aPu1Ux6g+E0I6j2PnEGLi+VgIRXdNuRSa0nBOcCgToc0PXI1YV0rNc9q0Zh9pjgUJmmwSTYJNxGnN9+Wuqir3jrG2HXxErJ0/Abxmie4XikpL+MvkhS9tU/TH4YK4IpIFdGuGWXw7CeqdlR/Zvy9vu5etC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046691; c=relaxed/simple;
	bh=4RHOaWM73Sbfn1xpDXxyaZo4TzXIOvxgW+QTbCR9sYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buaKa+Q2UKbtUj0HUUCu15EKHZCRNG8F1eA18ofgEYP1VIO+anad9IhWREpn4GfhzwqKZh3l0BoWhtMWhqBH0TvwFrYhlZ8ny2tTaN92DmnVR92lXxkXttka2fAzglTTdDvm1l8fyOpRfnawsDq/Fi26SzyPB5jE0D8MSV/YsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFrxFGqH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412255afa19so6888285e9.3;
        Thu, 15 Feb 2024 17:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708046688; x=1708651488; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oyqz5SQV7vsHMVsXkHmWHMS+rB/T1/CKYrZbsQOdOR8=;
        b=NFrxFGqHrrN7J2/liBo/c0bNGdIxKp5uVWsLBY6UMtnydgcjXK+tm89PiJt/4jrDBg
         9uL2QHaM5eRzXqZd6qFR48/KBotXRfGgE2JOPXtF+s1L38+pMx/4DZwYbtmquMRopWGg
         S9wXNxyrdVtD8CnIFuYWSG+IKT4xiXG5JAPwVv3B6jqZiudJuRJ2D2ZjmXGPAz8ML9Fo
         xhUSLx2Hc/rGRXig+SBXuU6vq9qJOcRnF4LXWZSyNuZFuUBdH5pMKLymYIAs3nuCTsSZ
         +xVMyvVp0SvwYkuJsnrA5ZwlJ6hUMbZv2llPb/pe6ysPc3gIROYDzcZD9Tec4e21BDqq
         iwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708046688; x=1708651488;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oyqz5SQV7vsHMVsXkHmWHMS+rB/T1/CKYrZbsQOdOR8=;
        b=OKVJZ4k3kNzaermc++luqVzFCz7Vqeb1KYNNsw4iFVeSaf00kobU5B3VFRdQMHrr6g
         fozN1JpxEwjtzBqgh6oVGklNYuIptb26irYbzyOHRhW2EXFb5GvBdrE76L5hG2WiN8TY
         JNdVYaJepvj2/vGzfA1b4cQnrFcQo9dPhE8SlaBEhooVp8jVj1vcYI4vzdxwnS0uW4J0
         bKB7dyCL4fw7FmgdOomMLpb3JyP8aVEa6zmAA6HX+qDIPwxvEffZN7I4A0TgMxOR4PaA
         hkMy+MhN/ke3jkUh3fybAWCaDN8p5d7FFwcf0aAbvddeNlj+0yc+/fvbj0NKZAVHAGCW
         pZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCXGwKFEIfrzp+G+0hhed79qqBgVE2Ix0/S54f576D8KiQc/AHJ4o5tlkEJ1qPp0flswPf9X4pRKmmjgxrbR/3lT0AbSIg0WEvPNZdePKAWlbJhXMiFLlu1qaN7/LfYXUHftHSyP
X-Gm-Message-State: AOJu0YxVipnnaSx/zPIXkfq7qxgg2tT3HBR4Q1tjxID7AtIL6U7THyAJ
	7jP/upN/fxbXTCafy/pTcXdb5tIgkhRR4y1pPYHy3Rarikg8jZ1K
X-Google-Smtp-Source: AGHT+IGBlunrq9zjEgxmNJ3CxTO0V4JQm3KyRRcIkUsnDoNn3Qeb0dixW54hlTXUhMgR3hYWRWylUw==
X-Received: by 2002:a5d:4104:0:b0:33b:636e:c967 with SMTP id l4-20020a5d4104000000b0033b636ec967mr2010965wrp.1.1708046688150;
        Thu, 15 Feb 2024 17:24:48 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id co3-20020a0560000a0300b0033cf9e35b13sm660331wrb.72.2024.02.15.17.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 17:24:47 -0800 (PST)
Date: Fri, 16 Feb 2024 03:24:45 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: arinc.unal@arinc9.com
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net RFC] net: dsa: mt7530: fix link-local frames that
 ingress vlan filtering ports
Message-ID: <20240216012445.em247rxfjnyufwm5@skbuf>
References: <65bbf40d.170a0220.a87f4.becdSMTPIN_ADDED_BROKEN@mx.google.com>
 <65bbf40d.170a0220.a87f4.becdSMTPIN_ADDED_BROKEN@mx.google.com>
 <20240201232619.nsmm7lvafuem2gou@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240201232619.nsmm7lvafuem2gou@skbuf>

On Fri, Feb 02, 2024 at 01:26:19AM +0200, Vladimir Oltean wrote:
> On Thu, Feb 01, 2024 at 10:13:39PM +0300, Arınç ÜNAL via B4 Relay wrote:
> > One remaining limitation is that the ingress port must have a PVID assigned
> > to it for the frame to be trapped to the CPU port. A PVID is set by default
> > on vlan aware and vlan unaware ports. However, when the network interface
> > that pertains to the ingress port is attached to a vlan_filtering enabled
> > bridge, the user can remove the PVID assignment from it which would prevent
> > the link-local frames from being trapped to the CPU port.
> > 
> > Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > ---
> > I couldn't figure out a way to bypass VLAN table lookup for link-local
> > frames to directly trap them to the CPU port. The CPU port is hardcoded for
> > MT7530. For MT7531 and the switch on the MT7988 SoC, it depends on the port
> > matrix to choose the CPU port to trap the frames to. Port matrix and VLAN
> > table seem to go hand in hand so I don't know if this would even be
> > possible.
> > 
> > If possible to implement, link-local frames must not be influenced by the
> > VLAN table. They must always be trapped to the CPU port, and trapped
> > untagged.
> 
> Isn't this, in effect, what the "Leaky VLAN Enable" bit does?

Hm? Any news on this? I suppose this was the reason for submitting the
otherwise ok patch as RFC?

