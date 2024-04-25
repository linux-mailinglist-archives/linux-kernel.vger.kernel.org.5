Return-Path: <linux-kernel+bounces-158308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F428B1E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970FE1C214B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DAF126F0F;
	Thu, 25 Apr 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ysu7+YgJ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FF5126F06;
	Thu, 25 Apr 2024 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037692; cv=none; b=KOspLiokMDzkFsIuvrBS63QUD3vdIseAmHoSqKzHV3s3kToYn4LcpYtcnZCN4hHfSSW4qGGxXJrTzHTd6G3y5Op5nsX3/HHMg/httsP6vk9rU3BWiaP/ilFEVncED6ofpx7/Nuf2W3zOiiJWns3duMBWbp773iApZMVrMY/izlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037692; c=relaxed/simple;
	bh=O9wfJFdvuefwvtqzySphBgFrqWueWAbN+WGq++1wxKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJraLjgeO38MakcvBW0HRu8v3m+s5/78oVGNFtMXVophmGgNpwMroBkTfnuYOR75oxHlDluXOeAPS71pnNpFENa9oA+Q2hJjW6zR6KkNxzQYEXs2zUIRt3H34uj90OmNeXmE3SBl6IxGGvskvDWK7OIQyh5dpMCUWk45skm54/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ysu7+YgJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516ef30b16eso839775e87.3;
        Thu, 25 Apr 2024 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714037689; x=1714642489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnD0omPzrWfWLdKhFymv2hUrXX8nXsK7L5p1vlVD4ng=;
        b=Ysu7+YgJyheznGL9VA9kHXwMAOpGXa3zUkvNEH55VPpP6iV4kdR2ozMKoIE2Q8dpj2
         BydR+9FQTj6k7+3Qfsf9Slz4Tlgv2XwX8X2sd+JMywMGlx16pzLnnraolmTkj+Jt7rLe
         632SP9rK8u7XkqwVlc8oyjiczoqTrQt/9xxQzkn5S2c0zAuApHsSyChY7qjyLrOSGjEG
         r0LR7g7YI5JYxi6ImX2HkHGrg1YbeFi48UZlvhPVoTGAHTFmx2+UTCrsXWKat2G2uWAl
         VEi4ViFG86qKhjDO5PzgvX8LCqcsmUz1TgDQx1O6HOjcRwwU4kjxhRROepcq7X2sb29N
         ZDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714037689; x=1714642489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnD0omPzrWfWLdKhFymv2hUrXX8nXsK7L5p1vlVD4ng=;
        b=mBNjehkGZ9wv8d+RzA3NVCnCOa4BCVzwbVZ5pF+SJ/cnpcaOqLASbMUwjx9iz3CH4A
         nEOt1/immuW0GPVlBPXxnoiJPiismrlfTW4aKVo7fx2/oZG0ZRif3bhVxRi0vUpSTsyB
         1UFJObJTdPeG/NGobbXgRUz5UWVNdUTkfgvPXRQdp43QsdcjYWdZC95SQQI2/XTJuNpO
         KCefW8VATr6PGeshHAlmDu+cagqkJhrx5LFHkdEJ0A2yPuMFc2qCS473YYRlFr350+Zv
         dRjqsS8frtY/4P7z1IsAP+JegR/AjVBFIFfAI10nxpa2VZk4xfc515XDTA5n7lfBQJA6
         n0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOi5kVMhIOi7w5b3UGozehaBMcHF0FnVUGYD2qh6ilL0JNRTevd5UaLVwJsjZy7e1WAKIQGPkv1SxtMyII2T0i7GSym72u+SHuvBhxkDEToao4Rul0liVQ4aOPHQDZps5sXC1vKEqJhOmkWRuiXhnZevE3QVMOEI5fnc2hnkGRPFdjphlszFxvDxVaBqbiPLd2PkOb3epbnTBjbrGt25o6/OqK
X-Gm-Message-State: AOJu0YzIO0n3Lx5HW2aWKT2bRBIhXUl6b4koHbqaEjrsxzf+ATrlpNeA
	Yb/kEumS+CvFrVWCTCdQf7kSlD8+yuVWURE8Mii6GCUV1nErvOKT
X-Google-Smtp-Source: AGHT+IHYgtPbcyGjxp9azAySSkNvUGJnVnuEhRmauc3oUtMj9W3wY74hlU+ZsIlNOYoIINrtLKKkoA==
X-Received: by 2002:ac2:598f:0:b0:516:d0e3:9275 with SMTP id w15-20020ac2598f000000b00516d0e39275mr3345368lfn.11.1714037688538;
        Thu, 25 Apr 2024 02:34:48 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id fc21-20020a056512139500b0051b0703a923sm1545727lfb.131.2024.04.25.02.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 02:34:48 -0700 (PDT)
Date: Thu, 25 Apr 2024 12:34:45 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 2/5] net: stmmac: introduce pcs_init/pcs_exit
 stmmac operations
Message-ID: <a2ste62mw6nxfnaptv4gossylrrahplyh3e3bwsy7ayoohpts7@hdfrjctclbbm>
References: <20240424-rzn1-gmac1-v4-0-852a5f2ce0c0@bootlin.com>
 <20240424-rzn1-gmac1-v4-2-852a5f2ce0c0@bootlin.com>
 <qf637dtkakxbumefbei3qrhbpyxgerjwn72ixp5xh6mc6yjbda@6z6tm6hk7fki>
 <27279f1a-e718-a8cf-ecfc-40f45bf6c500@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27279f1a-e718-a8cf-ecfc-40f45bf6c500@bootlin.com>

On Wed, Apr 24, 2024 at 06:33:30PM +0200, Romain Gantois wrote:
> Hi Serge,
> 
> On Wed, 24 Apr 2024, Serge Semin wrote:
> 
> > Once again. There is a ready-to-use stmmac_xpcs_setup() method. Which
> > is currently intended for the XPCS setups. Let's collect all the
> > PCS-related stuff in a single place there. That will make code cleaner
> > and easier to read. This was discussed on v3:
> > 
> > https://lore.kernel.org/netdev/42chuecdt7dpgm6fcrtt2crifvv5hflmtnmdrw5fvk3r7pwjgu@hlcv56dbeosf/
> > 
> > You agreed to do that, but just ignored in result. I'll repeat what I
> > said in v3:
> 
> Yeah sorry I took a quick look at your merged patches and thought that 
> stmmac_xpcs_setup() had been repurposed in the meantime, but it seems like I was 
> just confused about that.
> 
> > It doesn't look as that much hard thing to do, but will cause having a
> > better readable code by providing a single coherent function for all
> > PCS'es.
> 
> Sure, I'll get to it in v5.

Awesome! Thanks.

-Serge(y)

> 
> Thanks,
> 
> -- 
> Romain Gantois, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

