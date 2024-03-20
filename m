Return-Path: <linux-kernel+bounces-109119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2B78814E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0978D1F21C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB63535C2;
	Wed, 20 Mar 2024 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jI/2aoqT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1453D4207B;
	Wed, 20 Mar 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949761; cv=none; b=FWs2leAOMjlweLoUzV/S0mP95aGJByhxRXt5nRniMDM01zCH1/2njJBsKAH22ildG33MnJjWmWQz7/sIRNeFhANbju2MQ0yiaeg+0cBiJmr+mit4vm2MgrQ7qlbHMZv3Kmq+PVOVdr7PYavUHWAWK/OloD5bGP+GPIsxSUaUlgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949761; c=relaxed/simple;
	bh=xcQAtsJlg/6AQJ48E0amQtY7Z3hqsM9mpclT5/9SuDg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=os5cTHbvhNhTm0xQaiHo2aOQPUAOzcYBIOoVpY4Ljg4heO5MEbCygfpyrDHAklvpRf4QMrq0ji/Iri/mLza5OgyP1RkuCtyEQniIKWnBPTn8+VwUBLD3s7lff5cNZDjvtJef9l28Gg+xuudaARzYaJ4Y6pxBGR2dG16bLlfpkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jI/2aoqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6A9C433F1;
	Wed, 20 Mar 2024 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1710949760;
	bh=xcQAtsJlg/6AQJ48E0amQtY7Z3hqsM9mpclT5/9SuDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jI/2aoqT/NM4PhQBSgnMksuVBN5TmmO56fJxz6vCsNKB18ODmv003QyOXH8SNMUJy
	 q0Npy88cO3ylVwE05OPq5Bly9SI+m2U7ars9yBevkXafVr5AVDUDZ7jW9VEyAmRCo2
	 qjJ3XLVzyHpDNB6skiTgS/iyqtO5iY+J5ollYWV8=
Date: Wed, 20 Mar 2024 08:49:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, corbet@lwn.net,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, Chris
 Zankel <chris@zankel.net>, Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu
 <herbert@gondor.apana.org.au>, Guenter Roeck <linux@roeck-us.net>, Max
 Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] Documentation: coding-style: ask function-like macros
 to evaluate parameters
Message-Id: <20240320084919.8e18adb418347feed6bfc8ae@linux-foundation.org>
In-Reply-To: <CAGsJ_4zpXwVEhsdffoZVBVWiwT4Lw2qEMrW-X92ib=kv=9Yx9g@mail.gmail.com>
References: <20240320001656.10075-1-21cnbao@gmail.com>
	<20240320124207.0c127947@canb.auug.org.au>
	<CAGsJ_4zpXwVEhsdffoZVBVWiwT4Lw2qEMrW-X92ib=kv=9Yx9g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 20 Mar 2024 16:24:30 +1300 Barry Song <21cnbao@gmail.com> wrote:

> Hi Stephen,
> Thanks for reviewing.
> 
> On Wed, Mar 20, 2024 at 2:42 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Barry,
> >
> > On Wed, 20 Mar 2024 13:16:56 +1300 Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > > index 9c7cf7347394..8065747fddff 100644
> > > --- a/Documentation/process/coding-style.rst
> > > +++ b/Documentation/process/coding-style.rst
> > > @@ -827,6 +827,13 @@ Macros with multiple statements should be enclosed in a do - while block:
> > >                               do_this(b, c);          \
> > >               } while (0)
> > >
> > > +Function-like macros should evaluate their parameters, for unused parameters,
> > > +cast them to void:
> > > +
> > > +.. code-block:: c
> > > +
> > > +     #define macrofun(a) do { (void) (a); } while (0)
> > > +
> >
> > Maybe add some comment about using a static inline function for these
> > simple versions instead, if at all possible, (it is suggested just
> > above this section) since that will still type check arguments.
> 
> right, what about adding the below section together with the above (void) cast?
> 
> +Another approach could involve utilizing a static inline function to replace
> +the macro.:
> +
> +.. code-block:: c
> +
> +       static inline void fun(struct foo *foo)
> +       {
> +       }
> +

Stronger than that please.  Just tell people not to use macros in such
situations.  Always code it in C.

