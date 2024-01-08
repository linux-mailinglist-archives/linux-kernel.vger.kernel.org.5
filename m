Return-Path: <linux-kernel+bounces-19844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F354882752A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DE2281ECF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0085381D;
	Mon,  8 Jan 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONx6Cj3y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306CF46529
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78313803243so203897685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704731408; x=1705336208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1POvLeqUDu4gJT13ulQ2rf8/nBvbmNFthvIiVtWoKqg=;
        b=ONx6Cj3yJxvasBIdn3K5dJC68bc91Z6mh9+jjSTaJstkQGpf72DfiXle5xOYkMlrsu
         BWdNjNIrDecq4MlXejnzDkLXHXrI0doEkvbl2xnULnPw9sBiVHoh7t2Vs34ZiB2ii7WT
         7r8XTAvURt3crD+4KTKq74vmDRKsGpo3dQaYoh9nDcWU+/dnlW0z9aD7bULgrPa20FIK
         sn1N/UhiBAP09NCTWXp96aYtQQmSpvVfi5TzsoRoelgnn/sYU3sHcsZ/j3aHbkZNCO7/
         sb0hbT+R/4yymLTJnuqzndIkLFRJfGfKLXB5ma8fUO9upk3SKOi/yfa+5slLw4SxSPgq
         rLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704731408; x=1705336208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1POvLeqUDu4gJT13ulQ2rf8/nBvbmNFthvIiVtWoKqg=;
        b=uOYFqyFxcVipLkdF+WiW0t3XP+qFpIJDzsj/611YV5JILASKz9alAZ017KTaCJvMNY
         haOgoGpwBu+l/Tnwn/gK3+MgtZ/VKAyCdFhHDGX/kt65Sez0tURu9OT3jtIgwdR9XDvj
         0He+iSbdzu8CvRnDxz5Gar4q7+SfilgDpAFoMxJgD3WqhEVvqT/+EaEGLHEgFv4DWyOF
         pXIW3B/GyaXEDMsq6bvIVtDCgWrPWk2lPytPtWX6WqgCgFcti4pciZASVfQCYEgo6guy
         cRIWZUnF3FQYv14ZSqsIe4TkleG0//ozXEkPCJblHCZmh+P3ZPIgj1UuEDozUJydnyMW
         a2yw==
X-Gm-Message-State: AOJu0YxToag7wzYpeMLwIugqrxM3Nmtd0NzDdHT+VneqNZbTaP/ziZWz
	DR2La6G8tdjhNSobIK9Hg/zX4XB4t6E=
X-Google-Smtp-Source: AGHT+IGs0nHRYb1oZXKGRcimLyJoQDGEztHvAF8zqng0mnAPrgFWtGFzX2eO8Rp6ZkEtN3RBVRsk3A==
X-Received: by 2002:a05:620a:4088:b0:780:e6b9:621a with SMTP id f8-20020a05620a408800b00780e6b9621amr4987643qko.67.1704731407951;
        Mon, 08 Jan 2024 08:30:07 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a21c300b00783250c9638sm15028qka.53.2024.01.08.08.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 08:30:07 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 2AE0827C0060;
	Mon,  8 Jan 2024 11:30:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 08 Jan 2024 11:30:07 -0500
X-ME-Sender: <xms:DiOcZeJUIVeTF2DCVtWA9cRYczE4GAPIh2nnOXMvDvpc6AklMeHEHA>
    <xme:DiOcZWJMwo_TVB0o64635YSZsdV6INr8vs4BIy94yOBhZJDAqbHsGCsBKRJL7Tx49
    wncgSlJwZ4FSVsoig>
X-ME-Received: <xmr:DiOcZevpEiSRYkNbC5S4gELk_Qfe1F-hvcLaxd-tZw3vnnRmt7mC0aIxUoLYOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:DiOcZTYnvg0OHBnIX-c10KhL170-LWz3BSNgYRGMInbaNHDmbwcigg>
    <xmx:DiOcZVb6POcyb9ljR0P-a9fOK-UAziW5IA6UcH-u50d0yAqPsxULYQ>
    <xmx:DiOcZfB2Dhp-8EGITXQlJXb1xo-Y4_Pr6TRNPWiNsW0j37BUCs-IAw>
    <xmx:DyOcZTMjzKSSEmxQo9MGLGb6wGF3XliwjtHAijNBcjGY8Klb1q_bXQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 11:30:06 -0500 (EST)
Date: Mon, 8 Jan 2024 08:28:46 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, longman@redhat.com,
	ke.wang@unisoc.com, zhiguo.niu@unisoc.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock/lockdep: Add missing graph_unlock in validate_chain
Message-ID: <ZZwivt2C7-oxuMJS@boqun-archlinux>
References: <20240104054030.14733-1-xuewen.yan@unisoc.com>
 <ZZcJ-3MXF4BPqPtL@boqun-archlinux>
 <CAB8ipk9+BAFOa_4Dm2hs-bpfmMC_LHkaAb=JUVBq1CChX11wzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk9+BAFOa_4Dm2hs-bpfmMC_LHkaAb=JUVBq1CChX11wzA@mail.gmail.com>

On Fri, Jan 05, 2024 at 12:46:36PM +0800, Xuewen Yan wrote:
[...]
> >
> > Are you hitting a real issue or this is found by code reading?
> 
> Indeed, we hit a real issue:
> One cpu did not call graph_unlock, as a result, caused a deadlock with
> other cpus,
> because any cpu calling raw_spin_lock would get the graph_lock first.
> 

Could you share more details about the real issue you hit? For example,
serial log? I asked because although the graph_unlock() makes logical
sense, but that path should really not hit if lockdep works correctly.
Thanks!

Regards,
Boqun

> Thanks!

