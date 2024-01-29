Return-Path: <linux-kernel+bounces-43146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C9C840C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7B7B280CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2CC15704E;
	Mon, 29 Jan 2024 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRiZnyb8"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC2154BF0;
	Mon, 29 Jan 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547128; cv=none; b=gSOUIoTWItJx4QnLb6gW9zikvbAeydwfbXchS6aWTmOmGUj0n5QF+oe1L/H6Fz2c6q0qKq713Wx2Ve3w/w360oACFR4pAwq4RhgjifLhe0Fhe+NUYq2Nrr1jgLk3s0j0PFMha7SCLsmYQnymhXJ9L3QqpLaIk43OIwfYxl9cbgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547128; c=relaxed/simple;
	bh=fy1/J0hdHEVA4AQbTV7W69Mw8iBZ4byDZkFdhjYIA1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTyklZuYplpyAeS+Oqac67ThqU/n3Igw9Ii5VZjpkcdvUC83M0uLrVb0oGqclMwpjItlyQNCjL2ga+lbiAEKqVNPMmVuIaXc/+8wjd4a4SHC5LcE9UshZIyF41E/x/rhSXfin63AzAvWA2E7fYiIKHegtHMvctOlix5vaihKxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRiZnyb8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a359446b57dso173334366b.3;
        Mon, 29 Jan 2024 08:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706547125; x=1707151925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zM4YB6LCgMy5ymqGCGttDra+rFM6PL6B99ciN1rAFa8=;
        b=HRiZnyb8Bvhd3CDdBu35JQbzYkvyx8uVW6X79XZeSVrlH+bymP8vCC5dNK8gZb5TQ5
         LFMKlBHz9tBXUtEQB7BdkvhtMfCQMKEXMAyXAcS2EaKWV28MvJAkzY9f06CJg3t/k6aY
         +14MOHePd54bdS6FZUAiEQ23VTr59Nq21ryNNdrkehxjuErfWEhoHd91WbJyJlB3v+Ak
         d32vKt7jrcj2J9qa8bkl/iFMBAuajgOuXjjXXGAcb8r3dQb+E9/3uDZei6Q4+fE0JuBg
         ik8LbIYtC/vNVHmm+cp/eCt5IsudBa0jtvJnU0/UBSkg5JCoLpYftghd4r/blOXmZ1wo
         tPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706547125; x=1707151925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zM4YB6LCgMy5ymqGCGttDra+rFM6PL6B99ciN1rAFa8=;
        b=vbOVvJijsoTxZyd3ZLo4mhdb1S/SZewg5aCNOEjF7WX09e5M8ba/xb0lo8sCVF3LK1
         sgYi4dyDQ10LdNXP2vQQJPqAuJw1T11AVyMbLozo4pS7W1Z+cGgdLNDNup+preYyqsy2
         GhnH1jQ8nDHY2HZ2dSZMe7zZfvfPiOt4CnX5B0ln2X2Ged4oLLO+7NZu2z39JwvIlGSr
         QbDKMfeJlFhbQsWuDHwGYVxPRHL9seXHewqR/xkKWOBopx+ft0qecZqZt7o953Z20WtK
         deMqjULyop+ddEE03A5iKy293NIF5K8rYaTCYBPL+RsO9vNbLCywI8ogVmIeZd4uHxo3
         gtNA==
X-Gm-Message-State: AOJu0Yzia9OLXh+8VK73kMIv2SUaaKgLV6Xik/wu8u8ORcn8T6LKpajV
	hxzdWIO1ZdFZfzvzAaypTh2MpjcK6C2khYvuT4aoKYNuTwVIBiZw
X-Google-Smtp-Source: AGHT+IGzq420DAFCukci9yVevy/O8K89kJMfsj41fc6AhgCNtdQXFjC0TQnH1aHeeatKT04gl1lHJw==
X-Received: by 2002:a17:906:b48:b0:a35:cd66:3e32 with SMTP id v8-20020a1709060b4800b00a35cd663e32mr1692079ejg.35.1706547124675;
        Mon, 29 Jan 2024 08:52:04 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id ld4-20020a1709079c0400b00a35a659cab5sm1616032ejc.179.2024.01.29.08.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:52:04 -0800 (PST)
Date: Mon, 29 Jan 2024 18:52:01 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 6/7] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
Message-ID: <20240129165201.s4oiuk3sxtk6zcsw@skbuf>
References: <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
 <20240122-for-netnext-mt7530-improvements-1-v3-6-042401f2b279@arinc9.com>
 <20240129125241.gu4srgufad6hpwor@skbuf>
 <431750cc-fb6b-4f7a-9123-b6986d359742@arinc9.com>
 <20240129083152.34d899cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129083152.34d899cd@kernel.org>

On Mon, Jan 29, 2024 at 08:31:52AM -0800, Jakub Kicinski wrote:
> On Mon, 29 Jan 2024 19:22:28 +0300 Arınç ÜNAL wrote:
> > > I hope this moves the patch set out of the 'deferred' state.
> > > 
> > > ---
> > > pw-bot: under-review  
> > 
> > I still see deferred. I guess I'll have to submit this again. :/
> 
> Took me an hour to fix the mailbot:
> https://github.com/kuba-moo/nipa/commit/6766e97e72ac91ffb42ed2259bc8e2ace446d0ef
> email is the most quirky thing ever.

Ah, so it was my neomutt encoding email as base64...

I see Arınç's series is now in the proper state, thanks!

