Return-Path: <linux-kernel+bounces-133783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 170FB89A89D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98681F21BC0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF661798F;
	Sat,  6 Apr 2024 03:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ooTiwkUK"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC775748A;
	Sat,  6 Apr 2024 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712373592; cv=none; b=og4LzN3w0u+Ydns6AjvBWQaIsI2uC7yHoYWZKAvJMP91rCUqjWombp02UQK4vLyoLHKWC5Q5JyYJiybdKrn0kZjGqtT6dKb7pUfJSYK8rZ6NLz4/9qS1UtbJFEJTALy11DcDMWbzFF4Q658cePrddWyEVlQ89zQT7C7ZE5/X1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712373592; c=relaxed/simple;
	bh=RuI4VwdgharvMxl9aFCQfXwEYjnfZ5btGReh837FzQY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hFRTYRRB1DPTHcaStiKG1sHas9A7hU6joGJH/vzjy5A7toVoi7IaeH8PkMBfU1+FPrz3YX88/1Us67Pz7dyEYLTFR8+jsFMZm96p5k7yuQ+8pX6ElE6od05W83kXw2uYvqAsMIonK7AMBHLKtkU3RQ7ptT+mZ9BpSS8+z2zwbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ooTiwkUK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id AB0F913800C6;
	Fri,  5 Apr 2024 23:19:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 05 Apr 2024 23:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712373588; x=1712459988; bh=9kul5wYSciMTZEU/ffUWZ8gwme9H
	jWu3Wnb8YIqDLsk=; b=ooTiwkUKPhqW9zfzDZVT3t/TwKbGTeukyQ4L0eHI7FMv
	fu2q2wSYhfbk2jjYyI79BJ9vJ5UB4/FWTSOjn12RWZ/kxPypStmk6egXL5gHeDok
	Iocho1g/7BznBTiKa5E4QQVq+pXilIyNR5+Ijbxp4QN0RAqt0E8sTNM23+ZSF7Ra
	ojM7WTN9HlJPvg01UFgme3wy3+WzWBYQXSOCuVBejHua7G9sefeUdklA9Dld3i9+
	7x4WzRhlxgXoysfUO+r2ms3FKpTumVIOY+eYv1ZvNnAxCuXE2ofJMCZNc6fwajWj
	CePqWoYYYT/OXE3GQI8GbkBa80qBAmFs0Hv6+M1Qfw==
X-ME-Sender: <xms:Ur8QZuD8CT1UgC2Ds_aeWUmZvG7k3rQ_eX6fvm6SCS3sviG2kXOL1Q>
    <xme:Ur8QZogH6Jyrkz30kjfkMt-_EmsjoqVYpN1lphw-cgCMiruvqWvzxtId2lyx6l8JU
    rpJCQKR6aVGCqvyrQI>
X-ME-Received: <xmr:Ur8QZhm9Tx7fRhWNb6GpVtDOu2okZdG2SZjuYn9I-NI03ZJvLu2MNDfLtmCvWzJKSlDgIoqFANhKgnoRh1rTREAmL4UVNJgj27w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeguddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:Ur8QZsxlx9GVIg02xww6XF9wTSF1HVYFdDDg3IL3dCX74TB4rf7cfw>
    <xmx:Ur8QZjRkr3MDJRNQqfySKoKF3SnOkXjUIMk2DyozNbelevevHUqjqQ>
    <xmx:Ur8QZnb-is7g2j0VuIVznGeNBrxJmDGGRbQUGGw_GUDkpPlCOhysHQ>
    <xmx:Ur8QZsTtMS3xpqUGF7dxI1A7sGSSaN1Rqs6qLMD9_kErmZGlU6GRuA>
    <xmx:VL8QZhBxeJD7YIEcwdZTCg1evymGUe6vlmyeyGzewfTlaE1QTvbhybbU>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Apr 2024 23:19:44 -0400 (EDT)
Date: Sat, 6 Apr 2024 14:21:33 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    linux-m68k@lists.linux-m68k.org, 
    Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
    Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] serial/pmac_zilog: Remove flawed mitigation for rx
 irq flood
In-Reply-To: <87v84w7be3.fsf@mail.lhotse>
Message-ID: <2cb53463-897b-8f3f-7238-9fe87622b54d@linux-m68k.org>
References: <0df45bedded1249f6c6ec2c2fb0d9879da1841b7.1712273040.git.fthain@linux-m68k.org> <87v84w7be3.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 5 Apr 2024, Michael Ellerman wrote:

> I assume you have tested this on an actual pmac, as well as qemu?
> 

I tested the patched driver and its console functionality using Zilog SCC 
hardware in a Mac IIci, as well as QEMU's q800 virtual machine.

That should suffice from a code coverage point-of-view, since 
pmz_receive_chars() is portable and independent of CONFIG_PPC_PMAC.

Moreover, I don't know how to get my PowerMac G3 to execute the kludge 
that's to be removed here. I can't prove it's impossible, though.

