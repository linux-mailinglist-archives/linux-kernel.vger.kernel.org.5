Return-Path: <linux-kernel+bounces-45128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 911D9842C00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8D7B214B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC0878B68;
	Tue, 30 Jan 2024 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZnUm+cx"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D366378B5A;
	Tue, 30 Jan 2024 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640201; cv=none; b=d8evCdu0U/6Aytw7Q569TsrXvSXfE223Y3bn+mxlLpo2hNTCwMAiTqUCZV28yvyPj6TU0NAtJSb/ojQEDpzE/znDzEefhbAZCidjtVl3vBnjzAjokzs7SuIK+w3byeJvGjbnBsK/iI8Sv2Cr4zEAfJJOxJAwLd2EUs9yxaCdAj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640201; c=relaxed/simple;
	bh=LqSvJ7UGpq6hU47XuSN0B7qu7zyfXZR+0CJXRnVzil0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8a3KfC1BeLL/BWi9J9/F8/0RCsWJXNqE2qCZAIm340LH/Stfa7ux7FyIdc5uA8AA/A2Pz5ybpc38A1AnYWQqkFFhvx097jMTN9jGDuVZB1vaCjWgN/GZdEZEYaZyecyby/gtDiKaGtei1q+3y8kQ+Yt9MPYZGMpwQAli9V6m4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZnUm+cx; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3637e03eeccso7644935ab.1;
        Tue, 30 Jan 2024 10:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706640199; x=1707244999; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Iemjl7GM0JK88Oll/0/tLzsl8zt7JP8BV/mn7VXCSjw=;
        b=UZnUm+cxGmKVnkezkVSsa6tfX1QEV4FTAbYE02RH2x9g9jE4m1eMpTEd72W/EqdC4x
         JGPztL11Qxpp7p4WA2KsbxdEFQC15giY382prAJvTw1Uwv+qi45MH2h8UdGC4Dzfly3b
         zX73GU+DH8FLHiZZ48LCQSOBZDrFfS7azsfXxYTZbGfWyGuCsEUqB17GIuO78bJK0NIT
         pTaBNirsLA5UaRfbwl7kz6KBikd5j9+E2LTvnWJttaEm2hM80Ls986GwJU/E4s09IRMc
         X4rmw47faOmuZSTY/NAsRyFOK1zOw4BYM2f7NKJwbijpwpWMIy8gi3SJrwaGN1rrx29P
         Fj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706640199; x=1707244999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iemjl7GM0JK88Oll/0/tLzsl8zt7JP8BV/mn7VXCSjw=;
        b=nzTwv8BAcKxt1ZKPFecprk4EFi9l2fWJJKz38g5GaVUzFMxiYHKIm0M5qhtMzXv0Lv
         98c/dnCItk2mTbRqi207RUGNzZ2xEywdcNIJ5rO/QPrW5DbUtuU1y3qusiPwV5n4B3Wf
         FuuiQbnh8qXAe9Fo+VDg2wOGXMKZFbvtx5qP/Yh8/H52raXaLAbn7zLRsE1C/bJJVbph
         /6WZ04BElUkf1fxXB2FkyllvRNBrvcwGc3tLnzWzG2UzKaMTkJpB3e/y8ECrYEEDbwqt
         i4Y6MXYfrOudK326Th09nQ7B/jJ8qnH2Asc3UU+a3AZUW0C8UtZdbqMcEODJkQIeCUz9
         neeA==
X-Gm-Message-State: AOJu0Yws/NvQcrJE+kBUtSgpCJ549f7uAcG54SB4tSy1yWvlkLiC4noY
	ER0ZaBb9/HyWLvysB3Y2chSpyxCURYK75mzLUNi/s/U/OiJy8R8SwzLKGwNK
X-Google-Smtp-Source: AGHT+IEHKo/9qd5ZiP7fxzeO07u4dZhNUbxfCVoIlp1tDUbOnnjHBv7koGmaUJ52fRSblwRmsim0ZA==
X-Received: by 2002:a92:d284:0:b0:363:7eee:6e51 with SMTP id p4-20020a92d284000000b003637eee6e51mr6482075ilp.15.1706640198862;
        Tue, 30 Jan 2024 10:43:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWiAb3TDUmue3nbcv7qMZPKQCTiNMQXkwgiBjTa9bXNZk68FGlbfPNJtVk69b9A56eCNe7b7FETkopC4hxPTn0v5uChLVUg2ctW+khCdZpp/aAT4RyG9Qj+ttTM9pj8wvNzSKU8X3Q2YrFFJPL93BXRh37Vn1ja3tjm3P+dkUX5IdS6/kZe0FHStJUTVzK1mZamh7GD1aWlB22kp8VuAcKqaDAu6YroX9lB0XqlZcIhHkVtfYh2PPihXzqptTnduhUrnMY5Y9/igRKPsUVjuwtMvWU1vf3u/4vg0EHKFunuQ9Nex9ypvSkxoF+vV4bXq1DS0z/0khMq484yBKlbUSRoCDZMXTpA43DhkCSBP0MmQ9QNRFCpFkSWFQ==
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x13-20020a02970d000000b00470e96d4263sm98098jai.2.2024.01.30.10.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:43:18 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailauth.nyi.internal (Postfix) with ESMTP id 4DC5B27C0064;
	Tue, 30 Jan 2024 13:43:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 30 Jan 2024 13:43:17 -0500
X-ME-Sender: <xms:RUO5ZRtoTxGLtdN5ud_uMGq-pYVKYr3Pz5Ds1VPeehALvv0BwDsx1g>
    <xme:RUO5ZaexMWHTRAKFqC_konfFXvg-vA3iiD1zq4AAQKueeOzIeKiZKKGjVKuAc92d3
    S7cOQhmKsgMj0hYqA>
X-ME-Received: <xmr:RUO5ZUwGGZdD0WsCl0Zp7rJkoLyDss7MUrudFoeRIL9rBB7AEZoYfSaM14U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtjedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnheptdegheelveffudejffegvdelgffhhfelkeeiieefgeevteejvdegveeu
    ffeihefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:RUO5ZYNiQ8ylkAn7d7tJyyJ28sxfPGpfNr7aWY4sZ-oheJI05fwxgw>
    <xmx:RUO5ZR9oOioFOQtSX34BFpQF6RBAictkW9iM59Tqlay1TU2sxI1ugg>
    <xmx:RUO5ZYXL5NMel7nFD7R_zdgO0Ms3Bv1RGcwp_Ln-5iKP_DjhdhC3zg>
    <xmx:RUO5ZYXJiO0NHMPMtbGHW0mjpvZbl4TJeWPPB2yrUYyKRDxAMMktjQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 13:43:16 -0500 (EST)
Date: Tue, 30 Jan 2024 10:42:16 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 1/8] rcu/exp: Remove full barrier upon main thread wakeup
Message-ID: <ZblDCPrr9fPgEi2P@boqun-archlinux>
References: <20240129232349.3170819-1-boqun.feng@gmail.com>
 <20240129232349.3170819-2-boqun.feng@gmail.com>
 <ZbkaBO99-6ZuNCcR@localhost.localdomain>
 <ZbkaWbpufZ6q-jLZ@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbkaWbpufZ6q-jLZ@localhost.localdomain>

On Tue, Jan 30, 2024 at 04:48:41PM +0100, Frederic Weisbecker wrote:
> Le Tue, Jan 30, 2024 at 04:47:16PM +0100, Frederic Weisbecker a écrit :
> > Le Mon, Jan 29, 2024 at 03:23:39PM -0800, Boqun Feng a écrit :
> > > From: Frederic Weisbecker <frederic@kernel.org>
> > > 
> > > When an expedited grace period is ending, care must be taken so that all
> > > the quiescent states propagated up to the root are correctly ordered
> > > against the wake up of the main expedited grace period workqueue.
> > > 
> > > This ordering is already carried through the root rnp locking augmented
> > > by an smp_mb__after_unlock_lock() barrier.
> > > 
> > > Therefore the explicit smp_mb() placed before the wake up is not needed
> > > and can be removed.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > [Offlist]
> 
> And yes that was not offlist, my fingers betrayed me!
> 

Thanks for the reminder anyway ;-)

Regards,
Boqun

> > 
> > For further posting, don't forget to add your own SoB while posting patches :-)
> > 
> > Thanks!
> > 

