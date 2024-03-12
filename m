Return-Path: <linux-kernel+bounces-100929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D43F879FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3822128352A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDB047F5D;
	Tue, 12 Mar 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEJLD5bY"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855427456;
	Tue, 12 Mar 2024 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287304; cv=none; b=XWXr8k0ejoSt3A+c41d9Dh9A/llyiTm7bpbqcTMSxPtpYjAXluedBbQyxOxl6sBp5DQIW+SEo7Yeqt3g2t1hBogHMucDxqCYGa6JvpJEsVhvRc5KeY92ObIuUcKQ78q3HhTs0X5DwOh8nnwgIbLqF1hLrGgqAXUEckFg5JqMswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287304; c=relaxed/simple;
	bh=mFqngeDFdujHoCNS5OxiCIBb8sQL6MyLaTdipFn0kxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIILnU8ZJ/bbD6INYFD22UIiuCm6ORftC0dQFhbe/V0/LnCAWOoXWf5KZEzZYRO3ayeD7hZy2lYYhw/78hie2EU6Q2mRDh0GREHoSm7MWRy4Yd+g1qNl0WxdFbWFceovUkuJLDnA5UPRoxa1IzKGf+fB+R81Bx1Mr/xkwC+07ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEJLD5bY; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60a15449303so35507867b3.0;
        Tue, 12 Mar 2024 16:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710287301; x=1710892101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfLW9yYjxs0j0SPl+Eh0U8ksmTIet5mzavdLeQI0/cI=;
        b=OEJLD5bY+sUlN1TDjsBChlG4gAJKyJVXxcL3PBBQrhWILCkeBMnjBb2SxJ7I+Yonco
         NVerF6jPYSHC1xusPzoEIJdph7rQJia90GSosgrIXQI6VsemKqIFvvEJvbQyrUKZlR8U
         L5O2h3whrZymD3MiFUhxpisNBL+RIYQFTKBpQCoWCiXkWDh7xPKxvoA68YnFeLG++Q/l
         xbTRiRybhJ6dLdw+W9KgcFy/JYF8jzL763Z6QP4tzpyulzwfxlsDIzFH9WUIOozIKAjv
         27VwLjpPxGGl31FFcPYX7VT1HgktC6xel19St2QFtahDaOEMNeQ1ZXmBcDYh8KHGPIOs
         kHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710287301; x=1710892101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfLW9yYjxs0j0SPl+Eh0U8ksmTIet5mzavdLeQI0/cI=;
        b=Y7Txnr5P23DB03Mgc78z4HwhafpYJXrUYGqTwnN9vE4tf9kJ3ApYgCPpr0gDMn3HPo
         yYYNZtz3OxMK3FJth6FDT6zbhKiwXZKuilYgxxPl2MI5rCv2FJmrZFrbNSMZQL1QmqDX
         jN7WEubjrtbL3dD7e53a5z9wNvoXmOt5CWNiRrZr1W4fOZvEu6ZIqfTpFa073kn3D3PG
         EV2lcXoy8HZreUa+d1UQ3+hjdt7UseMvur13hq4hX4qMiqJ4mhaxzKIW57IT8LxkVaIe
         qtbmcRsMZYPMRjgTxiaGt1Ajm0+ASxwgQiPXX6tp2/2YggNy5xDmcjRpoIAbu/SAW2aU
         lUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHXM+nSceX4rcLLuqWd6/11zlKjEH82jbeAac/dnzjKzp9sin1QvejZop7xSp52OeYxNozsXcfaGaeHAsiTjKIK/Cj9BEo064QobxBjJ2ueyTA95kqRfNFX5b0nVzDq3ih
X-Gm-Message-State: AOJu0Yz3IpOanphnGC6y1gpXgiu49/VZIA0X2esFtkBJzopWmKLCnsji
	34TJKDB25BBRKw+naGHltXVIrrUOilhmU0CqdDYb/27PwhAtpAyj
X-Google-Smtp-Source: AGHT+IFVo+Wnio+Fy9gdu09sqmxUdejX4goakv5JZpr3o0mP/XGWs8DdbZY+/hAzXQNj8KEOxWgNmw==
X-Received: by 2002:a0d:dc01:0:b0:609:f1c8:a61 with SMTP id f1-20020a0ddc01000000b00609f1c80a61mr1012892ywe.33.1710287301384;
        Tue, 12 Mar 2024 16:48:21 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id q11-20020ac8450b000000b004308e46e815sm164553qtn.67.2024.03.12.16.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 16:48:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 3C69B1200043;
	Tue, 12 Mar 2024 19:48:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Mar 2024 19:48:20 -0400
X-ME-Sender: <xms:w-nwZUuQSxcZ2RTM8giog4fnQv_IfklticeuWZxrZsDpvCpPRB1HZg>
    <xme:w-nwZRfu6SVrbYUrIk1K7ycWrvI4DiOSIGhLbeYPX3ieDb1x4W5Y8quz7TNJRXJ6m
    DNVIjiA9RJF4aROaA>
X-ME-Received: <xmr:w-nwZfxhF7f_r0joMospCMk9fHg9AneIbGtRK5a8UepCP6CIMcK-LP9_kTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeggddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepffdtiefhieegtddvueeuffeiteevtdegjeeuhffhgfdugfefgefgfedtieeg
    hedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:w-nwZXOMMBiP8kE2uADe1M3bPfqUUVSlq6nEev5Q2aPPdVsA8uA8Dg>
    <xmx:w-nwZU_jIlu05-2jIDQ-DAHTKx735bdQe1WFGV736-JyvG_VRY2SoQ>
    <xmx:w-nwZfVezrVXJsJSOxBOm_kOu2GR8IGQkKTfx0-OdM5sfJk9w6jEtw>
    <xmx:w-nwZdcdqEQp2dFSJ-CyRyNWjOIwXa5JRncYoipqfTBoL-NfDShtNQ>
    <xmx:xOnwZfgzw0r228_RGQBLko4fD7rKD1c1Iu7jIXqc33py0zlqwYEkEiKvd9c>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 19:48:18 -0400 (EDT)
Date: Tue, 12 Mar 2024 16:48:05 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, paulmck@kernel.org, mingo@kernel.org,
	tglx@linutronix.de, rcu@vger.kernel.org, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, frederic@kernel.org,
	bigeasy@linutronix.de, anna-maria@linutronix.de,
	chenzhongjin@huawei.com, yangjihong1@huawei.com,
	rostedt@goodmis.org
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
Message-ID: <ZfDptafiK0jns050@boqun-archlinux>
References: <ZetHwrCb0KXE0xFI@tardis>
 <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux>
 <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>

On Tue, Mar 12, 2024 at 02:44:14PM -0700, Linus Torvalds wrote:
> On Tue, 12 Mar 2024 at 14:34, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > and here is a log where this fails:
> >
> > https://gist.github.com/ffainelli/ed08a2b3e853f59343786ebd20364fc8
> 
> You could try the 'initcall_debug' kernel command line.
> 

Right, that'll be helpful.

Besides I took a look at the config Florian shared, no TASKS_RCU,
RCU_LAZY or RCU nocb is enabled. So probably the only left changes in
the PR are around RCU expedited. Florian, could you see if you can build
and test with CONFIG_PROVE_RCU=y (you need to select
CONFIG_PROVE_LOCKING for that)? That'll call synchronize_rcu() +
synchronize_rcu_expedited() before and after we switch
rcu_scheduler_active, and it may provide more information. Thanks!

Regards,
Boqun

> It will make the above *much* noisier, but it might - thanks to all
> the new noise - show exactly *what* is being crazy slow to initialize.
> 
> Because right now it's just radio silence in between those
> 
>   [    1.926435] bcmgenet f0480000.ethernet: GENET 5.0 EPHY: 0x0000
>   [  162.148135] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
> 
> things, and that's presumably because some random initcall there just
> takes forever to time out.
> 
>              Linus

