Return-Path: <linux-kernel+bounces-38224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1665683BCBC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C381429109E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403471B96E;
	Thu, 25 Jan 2024 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmadJnP1"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037F1B94F;
	Thu, 25 Jan 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173253; cv=none; b=KzY8+dZAtuecX1spDjGokjhEIkwaA+KDtclRwBYYJiG0ZAnIHeFXBGEgL3vo9lYP71vMK2ioeECcFmoz2hwRApbYZ/AlceDWmPFbw+3nEGDzJpIUErYHIipjseGWSvGSReuu39ELxsewCniCRb4nM8Pr85bWQHlJb9oZxmC0b+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173253; c=relaxed/simple;
	bh=LoxX9dBFXRpqezdseXqTieo5vgHDE3MP1dCNWiKdj1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ds4/b4J27JhBoWGu27k8iMpC26r53v5lQnH+7bBdKz3ZFzU1YMHI9diwfXXrFPWSHmHFXrei4iqhOoofnNKI1b86Kbc+s9BLBbfFs7WybMo0j2E3X0rea+UCQ0rk1VJq3bSdecA6kX/4Y1s0BygA5ppYaE/JtMqTrMQpnNI17lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmadJnP1; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cd33336b32so86647331fa.0;
        Thu, 25 Jan 2024 01:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706173249; x=1706778049; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MOVBMzL6UNqR3dH+kMM9JTuFe/LvTcnh2ksCh4OpNI4=;
        b=ZmadJnP17HBHCqDQ9VD6hIdz4fO0nMZfPHXcFwznsiLJo4dlmxqX5O1Og6AycqNkkj
         w/1EDibcTD+WfYIMtueSvYlqlGYZb1/2AEkXY/dVGlb9+jTVQHNJkaYTf/UdfoBk3Gbt
         ZY1WN7dGb4pStVIAN9w/XOrfVZCp/wIgNs4jxP/vKnDHYrcBcAB5nMUPxjWcX8ek6pTI
         PcZMJrHgLzowAoGKrZwF9frktYD4RNiIjD8zATCWNgJOo0tp9Gng6KetHH/5frd6dl5T
         8dE1M3bRBg+aDckFXDlJ4W976lheg2ZkM9eUm/oj72hhh5/M2xcRfiJCvpUpu/lFdGpH
         KM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706173249; x=1706778049;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOVBMzL6UNqR3dH+kMM9JTuFe/LvTcnh2ksCh4OpNI4=;
        b=bF7YmQnR7hxkl04WHTi4EOIdSjrBTFGhTcLL0RaTNAbc8zPfHVw/s1t2pEhcy4IvQ5
         ZR8NazaubtcKsMgbCw7I95PVNg/QFrRSYgLzl7s++WKzDUx9x/zWllwooFadeSlQ/nF6
         oWzyL+omJFafg9TeteVI9+LoPwPL0kC7H7xwbO+j/4H7R9ULxUgX1fAJXdaeHCdf9Oqg
         a/WX2sHi5qXYSX+H1gJLaDkt5/VPX5nOrMhPddTNgKEaNVhkuaCmSPWtgLU5+4aPiJ21
         vF6pIkeHpkagyALjmvVsu7Zh85wKsbC9tISZfK38ewInA7w5lj7nB/PVfuJIQwdd02pO
         1LYA==
X-Gm-Message-State: AOJu0YxUtPbTb4l6NkWCcWBeljICblhRRYJ+tOZcnFb4NHk6OhORQQ8H
	Vd6FJdtvO/wBdKmnxNiQKL9ePcx4I1oEuxQb8vIOMcLL5gSPamCB
X-Google-Smtp-Source: AGHT+IFW7KOc59kAiJo0rL2JBDdWlpY0XQeY9OVlOIPhtZgE7XzytL23vqJ7or8rbMg6UXPpQkyxpA==
X-Received: by 2002:a2e:a271:0:b0:2cd:7830:5796 with SMTP id k17-20020a2ea271000000b002cd78305796mr357550ljm.5.1706173249070;
        Thu, 25 Jan 2024 01:00:49 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id u11-20020a056402110b00b00558aa40f914sm16938831edv.40.2024.01.25.01.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:00:48 -0800 (PST)
Date: Thu, 25 Jan 2024 11:00:46 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: remove OF-based MDIO bus registration
 from DSA core
Message-ID: <20240125090046.jyggdontwkhthqjh@skbuf>
References: <20240122053348.6589-1-arinc.unal@arinc9.com>
 <20240122053348.6589-1-arinc.unal@arinc9.com>
 <20240123154431.gwhufnatxjppnm64@skbuf>
 <d32d17ed-87b5-4032-b310-f387cea72837@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d32d17ed-87b5-4032-b310-f387cea72837@arinc9.com>

On Wed, Jan 24, 2024 at 08:30:11AM +0300, Arınç ÜNAL wrote:
> On 23.01.2024 18:44, Vladimir Oltean wrote:
> > On Mon, Jan 22, 2024 at 08:33:48AM +0300, Arınç ÜNAL wrote:
> > > These subdrivers which control switches [with MDIO bus] probed on OF, will
> > > lose the ability to register the MDIO bus OF-based:
> > > 
> > > drivers/net/dsa/b53/b53_common.c
> > > drivers/net/dsa/lan9303-core.c
> > > drivers/net/dsa/realtek/realtek-mdio.c
> > > drivers/net/dsa/vitesse-vsc73xx-core.c
> > > 
> > > These subdrivers let the DSA core driver register the bus:
> > > - ds->ops->phy_read() and ds->ops->phy_write() are present.
> > > - ds->user_mii_bus is not populated.
> > > 
> > > The commit fe7324b93222 ("net: dsa: OF-ware slave_mii_bus") which brought
> > > OF-based MDIO bus registration on the DSA core driver is reasonably recent
> > > and, in this time frame, there have been no device trees in the Linux
> > > repository that started describing the MDIO bus, or dt-bindings defining
> > > the MDIO bus for the switches these subdrivers control. So I don't expect
> > > any devices to be affected.
> > 
> > IIUC, Luiz made the original patch for the realtek switches. Shouldn't
> > we wait until realtek registers ds->user_mii_bus on its own, before
> > reverting? Otherwise, you're basically saying that Luiz made the DSA
> > core patch without needing it.
> 
> My findings point to that. Luiz made the patch to optionally register the
> MDIO bus of the MDIO controlled Realtek switches OF-based. So it's not
> necessary to wait.
> 
> Arınç

Well, Luiz is copied, he can ack or nack if so.

