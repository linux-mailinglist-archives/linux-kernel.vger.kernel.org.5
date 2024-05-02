Return-Path: <linux-kernel+bounces-166738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34908B9EBB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B211F22566
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023561553BB;
	Thu,  2 May 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T64ldZ+R"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1065155350
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667872; cv=none; b=I5sDc15Yh+Kip8RX1V7i8m7Xsx4paKsRp4qPC3+srkyI8F7tWWqdrD4dczcPFYPX6qkbTU5HLOOY8j4WQOP/X502yEpui9CEIJtAZNS05ZSOZ1fV22XRbXZgQ4Gst/qXk5bxa86POj5yTssYznkwbZ9naD70mVdTPG+6R7f/RGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667872; c=relaxed/simple;
	bh=Aw2TZpFf5p2Lk0E/0yZahQlvESUj4IsJOQc9aJKNHXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr5Ea6EOBSgBCSqaui1mqDs0Tw1HSkncta+51FBkJS1hX4WBY2yHOMDZ0Eavh8ZeBAJg2GEdTGts/YG1OELjlEzyAjufL+I6UD81QgqrVD4FXfrZZjgbvcTOL/vhABRGXIq2RXqiorhIHwStVM1hpiC80PxAkaXZMl0+NA2JDxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T64ldZ+R; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43ca8e1f990so10774581cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714667870; x=1715272670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e05O22ZC/rIe8aqzeD563ZAugqnhUbzGJboIi69AQw=;
        b=T64ldZ+RQ5KqO0UvOloMfqw+rNHWIbIxfbJTbKz604mGWolyrXvO8cG4MPyWq7YYfE
         I73B9wEXLBkDLG5VYqRP0lcx43fprj60kJ94li9AVBh0NR+6C9dMod5uOoxvUi8ZFhfk
         vphH1YLotXrRM90Kxrj8OUpKIvXsWEsHR27f4HCT4AJDPTS1v29tCToJbfoCnt9GHclm
         D3bkqCK1C827iURjTXtxCURbKWkMx58neHg3NtEy2qcJQu1S93v9KLPkuvrvk13Yjytu
         2Jlzk/rz4847tCiUAsj+Dr9zsHjzWIkZwpLJC9UUEjdeKenJNjlyVizT9u0nr3Ki38L5
         xxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714667870; x=1715272670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e05O22ZC/rIe8aqzeD563ZAugqnhUbzGJboIi69AQw=;
        b=TffaOxKmAnM4o8Ihs0e2KZCeQFJpyy7AFk9Cu8aoRUWi09OaOBoqnakGUWikNxTiiC
         g3m1Q2EspDLqLN97Ktt/KCwkdIemhYGQwlp+Y6DFeG5fgrNHWredkPq5zQCV5kuIMDRs
         o/kyjCpZSycUfrGjdZ61Hhx29/8J5nUlxf3yZx/H7grf6AU8rqnle+UHx0qDwdbOHY0R
         DVwDEiAJWKK0reY1iSc55ktMRRZmNIrNJiHAIF19PaurS1+cwK1a0azhnP34Pqlhj26j
         8SQ1d6J64ARgdVCXqBIarEovMXRonWq6XT5/bRvhI5J0pqnAvJXtOxTSnuY4gU4S6k56
         0Alg==
X-Forwarded-Encrypted: i=1; AJvYcCU68aguryA6lLc3MR39kxlzRA5BGQdn33WxY+22AGiDzJyxudtkQgo90/NlybvcQ7+T/32UGXBFh9eIQTeIpbHE8YgmHU+82jzk4fjc
X-Gm-Message-State: AOJu0YzyUp4+11SwTcsexMoP4dXB2Yah6IoLZArxW7UVKVtRyaU1z1BO
	4Nb56XNxNoa3VWNrMA5sHvd6VAsV//KBTfvionK2HnvWVd2PLiZG
X-Google-Smtp-Source: AGHT+IE2Gd+gwfBv2+JIL+log/vXbc6WUJU5mPpYv2hMHuqgelHQHMOcA/Nj53eh3WGckyszHx6ZaA==
X-Received: by 2002:ac8:5f09:0:b0:43a:b8e2:5870 with SMTP id x9-20020ac85f09000000b0043ab8e25870mr539823qta.3.1714667869820;
        Thu, 02 May 2024 09:37:49 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id f8-20020ac840c8000000b00434c31fa60csm605386qtm.92.2024.05.02.09.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 09:37:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 8C8141200069;
	Thu,  2 May 2024 12:37:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 May 2024 12:37:48 -0400
X-ME-Sender: <xms:XMEzZtNGu0u9rSx19qgJPUPA8jD6Z2TZgwjiv8UByKzk0N7mwGpNPQ>
    <xme:XMEzZv_V2AzHjN8lxJ8hNI8stNWipOvAoqQKIuWZhBEqlgSvntXiArm0Yl-Z4QkIW
    2MNRK7Y8VDzEXI8fQ>
X-ME-Received: <xmr:XMEzZsSPCqldN77UbqfYU5WaLZvPdOhhQs8hJfftlspQcjGG6JX5lYYo70bMdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:XMEzZpu6PDzC3LWdViReGithYNMfvDPfeVqKVerOCrkhRfYHof5daA>
    <xmx:XMEzZld6quLYn6qo8vRrkq-ZMwlA6vWVBQ-nRZXGNfPskJARYOqMmg>
    <xmx:XMEzZl3dmmcRWJZBExCpgn_1XfTVZgs5GddFrsKtOBpD6cpodkQbXg>
    <xmx:XMEzZh9gK2qlnsMgnwtsQopQUOCFllIimftEoa-0QcvQrofGSwYRuA>
    <xmx:XMEzZg-UGLRepwS3szZsX28Q9SEFEdGrHFizzYeH9CfSK_H2QMmvJ3bb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 12:37:47 -0400 (EDT)
Date: Thu, 2 May 2024 09:37:17 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Elver <elver@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
Message-ID: <ZjPBPWSSdE_VcH_V@boqun-archlinux>
References: <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop>
 <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop>
 <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>
 <1c886023-ae61-46ba-bb3c-b460c30de937@paulmck-laptop>
 <b3b81374-a19d-4bf5-abb3-15e48c72f01a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b81374-a19d-4bf5-abb3-15e48c72f01a@paulmck-laptop>

On Wed, May 01, 2024 at 03:32:34PM -0700, Paul E. McKenney wrote:
> On Wed, May 01, 2024 at 02:49:17PM -0700, Paul E. McKenney wrote:
> > On Wed, May 01, 2024 at 02:20:35PM -0700, Linus Torvalds wrote:
> > > On Wed, 1 May 2024 at 14:06, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> 
> [ . . . ]
> 
> > > I'd love to see an extension where "const volatile" basically means
> > > exactly that: the volatile tells the compiler that it can't
> > > rematerialize by doing the load multiple times, but the "const" would
> > > say that if the compiler sees two or more accesses, it can still CSE
> > > them.
> 
> Except that "const volatile" already means "you cannot write to it,
> and reads will not be fused".  :-/
> 
> > No promises, other than that if we don't ask, they won't say "yes".
> > 
> > Let me see what can be done.
> 
> >From a semantics viewpoint __atomic_load_n(&x, __ATOMIC_RELAXED) would
> work for loading from x.  The compilers that I tried currently do not
> fuse loads, but they are allowed to do so.
> 

Yeah, I wonder the same, from what I read, "const volatile" seems to
be just a (non-volatile) relaxed atomic load.

Regards,
Boqun

> Or is there something I am missing that would make this not work?
> Aside from compilers not yet optimizing this case.
> 
> 							Thanx, Paul

