Return-Path: <linux-kernel+bounces-41393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073C83F005
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945DA1F22E07
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB548175AE;
	Sat, 27 Jan 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="T8q5Kipo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cufab6Lv"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4E14A9D;
	Sat, 27 Jan 2024 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706388300; cv=none; b=FqsodCCzV/BnmZ5f6z0r/Vp+mqn2TU5mRcZwqopl48SKfS7WJzZVZ5f3VrmD7c21syNQQ+AgK0BSl5sHqXNhIX0ifVmHl2q4mUZy7ohqL9hKDorjpKEBWt+KlvMYSX5R9xCBvfYNcnCKy4OEXQIq8kdymPbnPmAGP7eIjQIIovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706388300; c=relaxed/simple;
	bh=7fJpC/F/2yX3YmpRJYR6iszdXsodW2fvEPdYddjhJBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aofmZQjMrafK63J42jkSpquapmWE0HdC3yVolxQj6oMDBJ9NPFZfyEmSgvdqXR21iST3p6dV81ZYQBsesNPH+yHhAKglqCq9licbkx4SIG03us9R+Yi69ceFqUEwfU/643jcajH22D4QzoENPmxcaJ/UR7aN5V0MKESmQkiUzm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=T8q5Kipo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cufab6Lv; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id AB53E5C00EB;
	Sat, 27 Jan 2024 15:44:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sat, 27 Jan 2024 15:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706388296; x=1706474696; bh=zv9FvXgF0s
	l4GXfUior97oaoRJoStoToMU42/qGdfcY=; b=T8q5Kipozu4vD+SyMGC1ggnno5
	Zaap1Xql+FpwOSjeUsL8+LW2DVL3+gvdZd/aYp7ag5N92vW4GQghnkGBPC7OfZyn
	4WRoTi1pJTK1omu/cUL1K0N2kZbW4/MqhhwqaG5UKZuIm5kSUZkltPvIJX1g3xOI
	ZEDRwdFTDFbwszQ6eKyp8BEpdlTxPvv4mDLRHPxHahpHRdpegC9XJS4GW9LOXiiy
	SNLbws5K1equFNaE3A3poB71+s8xKveNF0Hdyb5q8QN0GqSc9fNshf5u+XbuDZyY
	NpK2QV5/OOgHBnrvgC8J7DgteAeIwz3/V+DHO4DBDOiambUPTxlCtlO9rsmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706388296; x=1706474696; bh=zv9FvXgF0sl4GXfUior97oaoRJoS
	toToMU42/qGdfcY=; b=cufab6LvNxm+Ie3yjKh/amW520gARxbxdpCy9jkXxPa3
	B/Df0WfAqWCBfbxO+NN6ZjXitW5JRcihpNzz3trYQaYAe2kafM/9xxjx9pktVNjH
	FxZqbVdhGMzmdX2VBq2Zt5G75i4V7CDW4N4shoaWZBUoHP2Hlzk7gwfl8ajrckTU
	AW5aRNA8DbhYy/1hTyyiSwcOOzGaCIfyLdmuRm89IHSGnvyJMVnVZ4UnUqk5D1pw
	LWMzQf01Mw2qeA6F+GbnrUHdzbROuywooCxAoG/7AUIbA+jFIvpgQJh4K6seUI4f
	TbKbwF5g3fyHRs7qagSgMJIhCUoXZPJ+p2FpqGTXqg==
X-ME-Sender: <xms:SGu1ZW-JV-V_zgdhaGOskrUQvBRshlTlm74tTHlZc0lpalGDCx8LSg>
    <xme:SGu1ZWtaCYijd7gCKV9BLfBqLM0LryIOWS_RG-UhTT5rAlb8lIxanmLsMI0U3hA3d
    UUAJ-lx7jsUrDnc3ZU>
X-ME-Received: <xmr:SGu1ZcD5O2-PdEdzv43myXDYHrJtz9Lwk2QnmQVGpAkLVVkcwKIn3-5C1X9gBNsU_LzPjGCOpN3NBbuA-Ov-XcZ8IL_X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelledgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteek
    lefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:SGu1ZedCz0CcBsPlgKWaSxqp57CjA4X6YYxVU0npL9o6cbeyvp05Nw>
    <xmx:SGu1ZbPKkgnzt9GfyuRvwU5JYuqqEPnaunxuNpgjAnxcFbP7oNvqJQ>
    <xmx:SGu1ZYm8h43IS-zc7nQO66D6H0i3ELVST2qdvXxCswc72FT9_blg4w>
    <xmx:SGu1ZW3vJvKeKN6ESERW9L_XPEyEW3evx7LYIVw8nC_usNAtXTHBFA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jan 2024 15:44:55 -0500 (EST)
Date: Sat, 27 Jan 2024 13:44:54 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <ZbVrRgIvudX242ZU@tycho.pizza>
References: <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127193127.GC13787@redhat.com>

On Sat, Jan 27, 2024 at 08:31:27PM +0100, Oleg Nesterov wrote:
> On 01/27, Tycho Andersen wrote:
> >
> > > > > exit_notify() is called after exit_files(). pidfd_getfd() returns
> > > > > ESRCH if the exiting thread completes release_task(), otherwise it
> > > > > returns EBADF because ->files == NULL. This too doesn't really
> > > > > depend on PIDFD_THREAD.
> > > >
> > > > Yup, understood. It just seems like an inconsistency we might want to
> > > > fix.
> > >
> > > Not sure this worth "fixing"...
> >
> > Yep, maybe not. Just wanted to point it out.
> 
> On the second thought I am starting to understand your concern...
> 
> Indeed, in this case -EBADF is technically correct but it can confuse
> the user which doesn't or can't know that this task/thread is exiting,
> because EBADF looks as if the "int fd" argument was wrong.
> 
> Sorry I missed your point before.

No worries. I realized it's not so hard to fix with your new
xxx_exited() helper from the PIDFD_THREAD patch, so maybe worth
cleaning up after all?

Tycho

