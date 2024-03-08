Return-Path: <linux-kernel+bounces-96769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDB687612F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE4628310C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3914535D9;
	Fri,  8 Mar 2024 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI3YoPx1"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527C535A2;
	Fri,  8 Mar 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891114; cv=none; b=sHb4X904xpZEuVg8tBEtsVPjp2uMgyWaGq3Y4b/EQ9QLwTZdalhNAji/BXa36m4x+GZ1zWLaJg9CXPg1PtmyYo12hyY6WlK8gauPyWHOOtOstfKhd1h2gC866Tj8z60OxSbvXhV0oZzDVoVEx/1D+vK6sz43BGDPmGvynIstVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891114; c=relaxed/simple;
	bh=/Lhwy+X9ULFVVfFyESIFQcsEbTbTUD/pnfSCBIEkS44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzNHptFHyZxbjJHRDLPbtc+4ae6b2n74R/8t3zpXwqVyPE9cOSeAZKejfs1DwomlAED43fjnXr4n4lHS2bIonKmZwSyyNRUX2g+pbTz+Etx+6eHmtha+0j/gDTW516Jc+dwgSzwzPPISbeRGPwK21wQ44BMoKm7FAZF1RIaEpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CI3YoPx1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a458eb7db13so273458466b.2;
        Fri, 08 Mar 2024 01:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709891111; x=1710495911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Md0nxRb1z8L2XHTAy0exP+QIBZlMMn1Du5z5th9g9iQ=;
        b=CI3YoPx1RoSfURe7D2tqK6bxIxcPE5+5YGMkn/IYtYS8OMCXvmDCkMhL+bJLn6isku
         4AnyBupn7VtiSd/a4geA+S97epgcdlcpxSRPCglDRK2nkz0F1iCR6hH7XBhSErwwzc2l
         WIemZ/NiYjrIBYjC3dx5OQUPe6/Yxkru3E0H4GlWAVUptvLmlbkElERanf6cGGZjg2RK
         w7AWYv466Y0AV/iqRKtew0yIDIW1DXQzBylp8d0Y3YzYZ4Fvns9yEQdPGCSBKGPVAhGP
         0GGeKPAa86rBYUI5D1HUZEEzvuKk6iRHUxMsT9EO41HhpgFWcSLqwDNMw4VXT2tRa2t0
         Jkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709891111; x=1710495911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md0nxRb1z8L2XHTAy0exP+QIBZlMMn1Du5z5th9g9iQ=;
        b=P/PivyENz2+wSdU79wqK7jYdFcuTp/S2CLeUF0R+am6BrTw4MbrmE0VuAQOapxpUSX
         0oQIGY4F+WoE78QKBAWK/4HSGH8I00GwWDwvayyrr/3d3HHGNO2pnxaXjyGbJ4clBFfB
         kG1BhPLb8wIFTORu81drI8IOpq8Y80tOWne7j4YTwH1ianvExadTdMuqjFcxiLego2GO
         cuXXSsI2x0wbhGpb4X47FL+M05MzLmzxy/TBSk+CDGyyiPKWKKxgQtX2jQRaW0qZjtuf
         tZL+MznuJS/F6KxhXB14xSVLUlF3k5HhFVxLPvpDsHvYgKqDMWS+3udy9Kg9wzYffiF9
         0i5A==
X-Forwarded-Encrypted: i=1; AJvYcCV8a+ZYpgdED/zJI/FvWmAVnGbzdK5QoGoGuV+xyz3fFgmiFKscENvMq8kQJts/eXnEY0fqJg5YkC+LXxV+bUnB+4TuJ72A+feWcOSJ
X-Gm-Message-State: AOJu0YxXvPviZu87zO4Rd76NcJb6Wy4KFOhOv0OAh1unkjX/F1SXJTj0
	5jbGgg2q93GKD0mRS5TZBnBHPf3XW6u2pI1Brh+NZvyiQMCWcEq1Hhs1aiWi9iU=
X-Google-Smtp-Source: AGHT+IHqMwAAT8S9tUvZY9s2vCkqoaScqOw14chReMUBWmrBit1xmm+OPkS3vTLE65lGBydV3d3eKw==
X-Received: by 2002:a17:906:bcef:b0:a40:18ad:3fcc with SMTP id op15-20020a170906bcef00b00a4018ad3fccmr13112761ejb.36.1709891110482;
        Fri, 08 Mar 2024 01:45:10 -0800 (PST)
Received: from skbuf ([2a02:2f04:d207:f600::b2c])
        by smtp.gmail.com with ESMTPSA id qw16-20020a1709066a1000b00a3edb758561sm9068086ejc.129.2024.03.08.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 01:45:10 -0800 (PST)
Date: Fri, 8 Mar 2024 11:45:07 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 12/16] net: dsa: vsc73xx: introduce tag 8021q
 for vsc73xx
Message-ID: <20240308094507.larnhixusidgqspm@skbuf>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-13-paweldembicki@gmail.com>
 <20240301221641.159542-13-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301221641.159542-13-paweldembicki@gmail.com>
 <20240301221641.159542-13-paweldembicki@gmail.com>

On Fri, Mar 01, 2024 at 11:16:34PM +0100, Pawel Dembicki wrote:
> This commit introduces a new tagger based on 802.1q tagging.
> It's designed for the vsc73xx driver. The VSC73xx family doesn't have
> any tag support for the RGMII port, but it could be based on VLANs.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

With Florian's feedback addressed:

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

