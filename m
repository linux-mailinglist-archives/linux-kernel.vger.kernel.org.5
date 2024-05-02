Return-Path: <linux-kernel+bounces-165883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136538B92EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40D1281D6A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA4B11718;
	Thu,  2 May 2024 00:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BBmNKNX0"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62168171AD;
	Thu,  2 May 2024 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714610826; cv=none; b=GgVSZBjDHxgNgRGTuwLlM952V7RzMBT/3JFzHd1+AzqowijAE1WHH38++v9wskelGims3qGXDpVrh4h4Sfbojynb/dOYIzWmk1xjrPMYBJWCt9YRk5NE0uq4tIqqXPZXurv1BNAjJwNiAKu6JegUAwOnjl0uT7tBPOykU/d1XbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714610826; c=relaxed/simple;
	bh=apm/m1mGLASExEwoGmuvs++Qafh2JxKXrQa8djaX1W0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fxi/ZQThWyaQ5upBVIhWHkzrVatD3qGZYbH/+v/0/Fk6ze8MqKiETJWRNxv2cKDt1adQ63kbgCXax6LWC3mRSXERBViTQpOckkvAHGYVzHtsu1zjt3jeP+aqS6iXW/vRIawW/LI7cA2t1yltENWsTRX4aREKApJOctPHhrDOAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BBmNKNX0; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3E9661140123;
	Wed,  1 May 2024 20:47:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 01 May 2024 20:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714610822; x=1714697222; bh=x7TQftPd3+u6tHbbTYbf5pRgfpco
	MKlpeUB0ct1nLso=; b=BBmNKNX0IEhR+r+O54bY3ciLilxdugPDOLZy5UkPNXzv
	y7+KYe1xp88Zr+rwbcnfA5Zv6BI0JI7X2xjkzOVf/n2pUqmI+xD8rADax7Pv0JB8
	UX6xh4nz/hSSoCIcY27eha27S8ek9SHOYlYW6wRko/TH1mSebV2gCP2/XMLsiGeq
	5Lc4voNmV0tRIEvHe8jEJPXAqGcwBhsgJCmhWt+V+iYkm7Te5Y3B5ti7yAoNFr+f
	lgNry8xOMNwXWydevSc/4iXmiQnZ2ntSn14tORnri35tGXpHTzaiQhOyYaSfdLF+
	QNMTJRk/cZU0FsctuPYXQw3D9Hf6x26/y87DmKZMkA==
X-ME-Sender: <xms:heIyZn9yYvYvKat7wcG-YANPVXk90XDa9c3iKH3qqSGjZmPU8ggR3A>
    <xme:heIyZjv20lEbL1fIa3WOpBRBh-cX76X5jSeY_2HlnFVd8b4g3QXpx4-6G7uwwoNK6
    fuHnNAnXhAZA2UfVvw>
X-ME-Received: <xmr:heIyZlAx0H9YdlsZnSNfhbL-OXypPgFRcU3zPVQNaP7BoO0VtaJlOr7J6ScW1i8rciSNzpAQN0k_VMDLGsP_NEG1iYMDQA2ms8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:heIyZjdLlpL2ZPXgDjrVAVbKLW4PTAnCYSTHU9Fe2GilxTW23Jc9jA>
    <xmx:heIyZsM0ibYWRmAmjuGc8SMeHDRCZbMzfXU2lM1TlYfhxOVI-1xEDg>
    <xmx:heIyZllFfTz1aY_OFN1Vi7fD_mFa_OVbRu8P6VdqXRe4TgT1M_UAiw>
    <xmx:heIyZmsOTtzs4H-vC73S9PNrGZWEFmaaSsUbX1EU6gaNr8SrcH5quA>
    <xmx:huIyZrqnwDYmXVMMlIqmX-xyeIoFC51ZqNoFqhtRpYCkcHdUDzMI629W>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 20:46:58 -0400 (EDT)
Date: Thu, 2 May 2024 10:47:21 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
cc: Kees Cook <keescook@chromium.org>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    Erick Archer <erick.archer@outlook.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Justin Stitt <justinstitt@google.com>, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-scsi@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] scsi: csiostor: Use kcalloc() instead of kzalloc()
In-Reply-To: <c358208c5d4c823e3373aca4fe42998a6edd12fb.camel@HansenPartnership.com>
Message-ID: <66bca69a-0036-4108-5963-002cce69376a@linux-m68k.org>
References: <AS8PR02MB7237BA2BBAA646DFDB21C63B8B392@AS8PR02MB7237.eurprd02.prod.outlook.com>  <202404291019.5AC903A@keescook> <yq17cgg58sp.fsf@ca-mkp.ca.oracle.com>  <202404291259.3A8EE11@keescook>
 <c358208c5d4c823e3373aca4fe42998a6edd12fb.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 May 2024, James Bottomley wrote:

> > The code itself is fine unless you have a 32-bit system with a 
> > malicious card, so yeah, near zero risk.
> 
> Well, no actually zero: we assume plugged in hardware to operate 
> correctly (had this argument in the driver hardening thread a while 
> ago), but in this particular case you'd have to have a card with a very 
> high number of ports, which would cause kernel allocations to fail long 
> before anything could introduce an overflow of sizeof(struct csio_lnode
> *) * hw->num_lns.
> 

Then it should be safe to add an equivalent assertion. E.g. 
BUG_ON(hw->num_lns > X) where X was derived either from knowledge of the 
hardware or from some known-safe kalloc() limit. Though I wonder whether 
BUG_ON() is the best way to encode preconditions for the benfit of static 
checkers...

