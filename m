Return-Path: <linux-kernel+bounces-83501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 990F3869A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3881F24BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524E145343;
	Tue, 27 Feb 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=animalcreek.com header.i=@animalcreek.com header.b="g/OAwn8N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="auIvCa4B"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5E1468E3;
	Tue, 27 Feb 2024 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047516; cv=none; b=ac5JU3rSX/+bB5OdDuUzjpT6NejdVxejENVtjyxCDbxelFDtkN+yNVY2FIcGaBLzkuN4HUM/abG0JnJ1a8JPpMvUlDXbkGHsqSp8vw5SqYWTJ3P8jncRpxrpZoEzdE77wEPGbEwEye6ynOx5ElYb5CL5MhmasH4e5cNxjIq+KTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047516; c=relaxed/simple;
	bh=/0CX/GTDlI99GNqGRU+WOoXiS5slLjuQQEO7NtWVgFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYkfZWaTmzD5vkOlpiAM+AEU39c/zGYLgfMt70HbOIMI++j1IqcVHssB2S+mKbVrGxe+cHg1Q5Wr4hC97gmOlfX9CQ9ddFYmzey14BqY8BIYpQ/S83+xsGX7uehfqxT5KhRrBrYpBwBufN7iuQcfJ8369qFdD1mLBt499DXFbs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=animalcreek.com; spf=pass smtp.mailfrom=animalcreek.com; dkim=pass (2048-bit key) header.d=animalcreek.com header.i=@animalcreek.com header.b=g/OAwn8N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=auIvCa4B; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=animalcreek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=animalcreek.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EC67311400AB;
	Tue, 27 Feb 2024 10:25:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Feb 2024 10:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1709047513; x=
	1709133913; bh=vk7zMywue6u8Ewys2yjE1YQdG3Ysi/Bjgx+fg8Jugd8=; b=g
	/OAwn8Nnd5m2DeHCOg5TZK3ISBP+1I13sk4tur6CbpG6Zfo4jrTWcFTD287kNrM9
	/ImIlcYeneF5cktE0bVwndusGl0UKNDbQkHL8D3580oIe5JkQ5er/jJyODDWNU4E
	TJVzhKtyfxvhik86j2RGgD/RpPr661K4FfyXnFPs/jxrgLiRAv0deAGBAOPyz/TS
	5EwPR/Sji/TG8uaQ8qzS2GB0NXLKPgh6mhK22n73uRUFy6HS9L8n5tBxoYvd+SIz
	UPbj2DQMMn2LkK0vqJMSd0M5lkjb+LRfQlClFOdLJhQRurMPEkugnLuizbXXRbv6
	UcyA5htnWMvFRUxmUEGUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709047513; x=1709133913; bh=vk7zMywue6u8Ewys2yjE1YQdG3Ys
	i/Bjgx+fg8Jugd8=; b=auIvCa4Bew62NXoHyKzQ9QD86zcWg4W/ntUvHxa3VrLP
	swYPAQgJDNxhX57rC6LdlOFs2V/dfZDgruU526I144YNsOm3N/TlVNFKS/OYYuem
	De+QROOwIaN+UdDeyQXdAUQwM+A0ddkCs3c0lXBV5xRglUyJcAWl0uryg+03EcTS
	SofGAOpjCVpQiT/SP+V7TxKLJHJFo0GWxIgq6udPpsW8ezVOY/Tb+vZsB3enf/TY
	DPZCJu3eTjP+7HX0N+27ZL0mrFoJDRPT7EY6P6D+bXXrB+TDGopfp89LDDQDyQnN
	m+mj0bzwf3iwaUOUusFyqzw8BA+al/TSKQUi7bLPAQ==
X-ME-Sender: <xms:2f7dZUJAXZnYXvIvAF2-0j4e77H-W92fq7tchj4kgDUkR6qJmJFfkw>
    <xme:2f7dZULEPdV4H-hUqMxH8HXOwzwmxLOl_Uh7YQLP4JL8cgSUXCxPbcRP0jIoAyMhE
    aR0xqCNRDdKofdxzg>
X-ME-Received: <xmr:2f7dZUs02GkQ4DkmUxSU6tAkvA6nns-mWYm_v2FmV61osXXOTXaX0T4WzuNGQtWxJfQ8X8gZkLN6iQkgdhNLUNdQTvG0GdZzJ95q3O8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjohesthdtredttddtvdenucfhrhhomhepofgrrhhk
    ucfirhgvvghruceomhhgrhgvvghrsegrnhhimhgrlhgtrhgvvghkrdgtohhmqeenucggtf
    frrghtthgvrhhnpeeugfejtefgteegieffjeejtedtveefvefffeegkefhtdehtdfgfeev
    keegvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmghhrvggvrhesrghnihhmrghltghrvggvkhdrtghomh
X-ME-Proxy: <xmx:2f7dZRYSEdTKiw6R15rDIrPVYYebeNpstNURMPqaeJIp835TaHPDzA>
    <xmx:2f7dZbY7EJ45ERcoMfNheIhetD0dCO0groHy2l0absyxjoqR0MAqAw>
    <xmx:2f7dZdCMPUPcPY8MYFGAijD5ve1ergrRr_bjMufMdeqEoPOQ_2ZfYQ>
    <xmx:2f7dZXrm061gXS4OrDsnJsGaqWnOESVkr1RdXkH9YjzHhh50JUKT-A>
Feedback-ID: i9cc843c7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:25:12 -0500 (EST)
Received: by blue.animalcreek.com (Postfix, from userid 1000)
	id 9CF18521078; Tue, 27 Feb 2024 08:25:11 -0700 (MST)
Date: Tue, 27 Feb 2024 08:25:11 -0700
From: Mark Greer <mgreer@animalcreek.com>
To: Alex Elder <elder@ieee.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	Vaibhav Agarwal <vaibhav.sr@gmail.com>,
	Mark Greer <mgreer@animalcreek.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] greybus: audio: apbridgea: Remove flexible array from
 struct audio_apbridgea_hdr
Message-ID: <Zd3+1xJnl7d22xIb@animalcreek.com>
References: <20240217154758.7965-1-erick.archer@gmx.com>
 <02cf87a3-4e92-4f6d-98f6-dfc0e198d462@ieee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02cf87a3-4e92-4f6d-98f6-dfc0e198d462@ieee.org>
Organization: Animal Creek Technologies, Inc.

On Sat, Feb 17, 2024 at 03:18:59PM -0600, Alex Elder wrote:
> On 2/17/24 9:47 AM, Erick Archer wrote:
> > When a struct containing a flexible array is included in another struct,
> > and there is a member after the struct-with-flex-array, there is a
> > possibility of memory overlap. These cases must be audited [1]. See:
> > 
> > struct inner {
> > 	...
> > 	int flex[];
> > };
> > 
> > struct outer {
> > 	...
> > 	struct inner header;
> > 	int overlap;
> > 	...
> > };
> > 
> > This is the scenario for the "struct audio_apbridgea_hdr" structure
> > that is included in the following "struct audio_apbridgea_*_request"
> > structures:
> 
> Yeah this was not a very good way to define these header
> structures, but I'm glad to hear the flexible array at the
> end was never used.  I don't know why it was there; maybe
> it's an artifact from some other information that got removed.
> 
> If the code compiles with your change, it ought to be fine.
> (It compiles for me.)
> 
> It would be good for Vaibhav or Mark to comment though, maybe
> they can provide some context.

Sorry for the delay guys.

The way this was done comes from associated firmware that ran on the
APBridge. This goes back a while but I think the packet headers may have
been in flux at the time and this was a convenient way to change all of
the packets if & when it changed.  Anyway, it doesn't seem so convenient
now. :)

So, yeah, getting rid of it sounds like a good thing to do to me.

> I'd like to hear from these others, but otherwise this change
> looks good to me.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>


> > diff --git a/drivers/staging/greybus/audio_apbridgea.h b/drivers/staging/greybus/audio_apbridgea.h
> > index efec0f815efd..ab707d310129 100644
> > --- a/drivers/staging/greybus/audio_apbridgea.h
> > +++ b/drivers/staging/greybus/audio_apbridgea.h
> > @@ -65,7 +65,6 @@
> >   struct audio_apbridgea_hdr {
> >   	__u8	type;
> >   	__le16	i2s_port;
> > -	__u8	data[];
> >   } __packed;
> > 
> >   struct audio_apbridgea_set_config_request {
> > --
> > 2.25.1

Acked-by: Mark Greer <mgreer@animalcreek.com>

