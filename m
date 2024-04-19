Return-Path: <linux-kernel+bounces-151196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464CA8AAB04
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04247281E77
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB5757F6;
	Fri, 19 Apr 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlUUOVdk"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F58657AC;
	Fri, 19 Apr 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713517128; cv=none; b=piKXBKVbpsKrIqRmj3sA2q1ZCakqfDKonPRdERF+5yIrHk/sra1/5GUDhi5nvcIRuuwoQjwf1Os1MmUaqJA6vsuz67rAGFPnPYeb19bCLjHrUzc3XdTOCOGqPWYLy4ypMFHF01tJvTR8rrTma5+rDjz1T3NPSM6q94dIRh+IPjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713517128; c=relaxed/simple;
	bh=jgbeBRVzeXMYSheG4ZQAneV/ODr+RugakD1+LtLxDCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2Rbmu/pHaB3Rh//wbeS7euiNnIAVS+CfjlF8PyG3Bo0p9uBQLcg28ViDxX1nX0rS+v3A9kNlBFu/2svYZiRBJiLkr5cDMwp29eWqrhle0GLJ4DGBrhc6wnTMtlu1kEYBnxIi2HbAXVlOPKPxAAVaErkdJ1JlP+9mDhvsP1UCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlUUOVdk; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso1707268e87.1;
        Fri, 19 Apr 2024 01:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713517125; x=1714121925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkPkWZD+fDDhemy2LIDiT55F/PO/TI//Q041lLZQk+c=;
        b=VlUUOVdkGDjDSlaheHjEvYtT9PgAiEzhYjH4GRFhjGbLGzJu4JLsfb7cuiWuuKhHh3
         DUSEGZ2pJuwISj9BuDk6K/CgYFiAxqycU6QbdfWRSXXUw/l1zJifxFZmt3X8tvCg9v0i
         SHGhjcU4FAWUSpBRVjgPQxeHFeuGwzdywtalpQLopRTGbm/iOxeoi1qdPhzOUj2HaHZI
         6bBKQgX8Oww42vMqIJ7JigZv/C7Phjywk/NmuurdiJSVbprR30oeLyQp/Sf3JiNWmSr/
         E94VGoIGKMNzmzaBwIdDDhcAwAFENGeFqCicuEnZLmy4uRIOhZgjde1SmjyGr0U5xdtW
         sdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713517125; x=1714121925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkPkWZD+fDDhemy2LIDiT55F/PO/TI//Q041lLZQk+c=;
        b=Eb0tNEUaU2OQEH5MwQcCRrPjvjWozracPrGYGfo1N4UR8lXCOOb+e3lrzJVIHzJOzD
         JK4MUF68aodXZPN6U/o1ofQSVHgzOLw+o56Hw/BrpQ5wmDWyjmaPAB8020JtaAnNOVP7
         4a429FGxPpthJ9kZ0BUynYoibPNRjmHnyVd4FWHh6KXVLTTETc5JOBrYTiXeYBgC1GF0
         3/aRduWtXgI2QgA4eYLwtYNd1lAsRhW7t9uM6htLwyKq4wqpjX2flnt6zd++rQBwZhhj
         QIoReU28r5dpoe8HLqIwPnzocvOJfWwFfQ8ytMk8S6pbGNiAV/x/F+tEzxX0H003csi5
         h1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWDP+9MYmhOrk98A3uoPxq8hF2G27VuH1xojmyjUeda99Hm31CUOMmlMVmMera04AsJBI50sGyCF76N7JSQ4+qJK8l5/ae05zfcyGYTiFmaqRe7Cp5rXeD7LsY0xtsxAd/NnaVa
X-Gm-Message-State: AOJu0YzfPc474Pz0XibsrWJ8LFJ1isvOcpgqJTCer4z+AIkwLUDF8sXC
	uWAw3EsYjcdbv/tnLXvH4kvgUNnF5kSmdEylUrU9YcGSLSVrDNWf
X-Google-Smtp-Source: AGHT+IG9jaQLQRx7GI8egozbRcyQnR4eJjjPqvTksThvItCQ/0Y3ypRISV37b291kfO+3oDXaYzPfw==
X-Received: by 2002:a19:6442:0:b0:51a:ae0a:26dd with SMTP id b2-20020a196442000000b0051aae0a26ddmr786111lfj.28.1713517124659;
        Fri, 19 Apr 2024 01:58:44 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id m24-20020a056512359800b0051950b8252asm606303lfr.240.2024.04.19.01.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:58:44 -0700 (PDT)
Date: Fri, 19 Apr 2024 11:58:42 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Yanteng Si <siyanteng@loongson.cn>, 
	Romain Gantois <romain.gantois@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Simon Horman <horms@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: Fix MAC-capabilities
 procedure
Message-ID: <axq6v6ya7nuov6x6vdjlp45i7bjdo2tkmmiuytye456fszycal@bkixd6ruplr7>
References: <20240417140013.12575-1-fancer.lancer@gmail.com>
 <20240418185328.79c38358@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418185328.79c38358@kernel.org>

On Thu, Apr 18, 2024 at 06:53:28PM -0700, Jakub Kicinski wrote:
> On Wed, 17 Apr 2024 17:00:06 +0300 Serge Semin wrote:
> > The series got born as a result of the discussions around the recent
> > Yanteng' series adding the Loongson LS7A1000, LS2K1000, LS7A2000, LS2K2000
> > MACs support:
> > Link: https://lore.kernel.org/netdev/fu3f6uoakylnb6eijllakeu5i4okcyqq7sfafhp5efaocbsrwe@w74xe7gb6x7p
> > 
> > In particular the Yanteng' patchset needed to implement the Loongson
> > MAC-specific constraints applied to the link speed and link duplex mode.
> > As a result of the discussion with Russel the next preliminary patch was
> > born:
> > Link: https://lore.kernel.org/netdev/df31e8bcf74b3b4ddb7ddf5a1c371390f16a2ad5.1712917541.git.siyanteng@loongson.cn
> > 
> > The patch above was a temporal solution utilized by Yanteng for further
> > developments and to move on with the on-going review. This patchset is a
> > refactored version of that single patch with formatting required for the
> > fixes patches.
> > 
> > The main part of the series has already been merged in on v1 stage. The
> > leftover is the cleanup patches which rename
> > stmmac_ops::phylink_get_caps() callback to stmmac_ops::update_caps() and
> > move the MAC-capabilities init/re-init to the phylink MAC-capabilities
> > getter.
> 

> According to the build bot it didn't apply at the time of posting :S

Most likely it happened because the first three patches
https://lore.kernel.org/netdev/20240412180340.7965-1-fancer.lancer@gmail.com/
hadn't been merged in yet back then. They are now.

> It does apply now but the bot doesn't have a "retry now" button.
> Could you repost?

Sure. I'll do that in an instant.

-Serge(y)

> -- 
> pw-bot: cr

