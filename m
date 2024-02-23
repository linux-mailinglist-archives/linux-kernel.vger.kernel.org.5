Return-Path: <linux-kernel+bounces-79320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 365308620BA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16E51F23FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A444114DFEB;
	Fri, 23 Feb 2024 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E3zsd4U6"
Received: from flow6-smtp.messagingengine.com (flow6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8A84FB3;
	Fri, 23 Feb 2024 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731820; cv=none; b=eN6czBg4aQAf924MvLxhCGB+V6Um1Ep8iBxHlVvITQO+NqLFC8IqXAL//h/P4pCgH0RXRlLpRAaLVOnL4hmAoI994hzT9+AAcdqyTWdrr+4rXhGflpP4w3Jz4qUw89AAFny7Y5R+3dLu5/z4vRGHJOw+Etveb8QiKXoNRf0LMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731820; c=relaxed/simple;
	bh=uc2tZGR4P0x+PoLZlQj6rY29hlVYa/H5ELy0Qw70NOE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FL0Bkiv+knp5Q+rGDHTUvgWgwt0JWZe/c+BHhgj3BQUWwtfi53Sbys8T7nPns90lmgE6abHnNbIhEq0xzGttQCqeotUuurGmqKmcxiJGi/+d9OoN00zLzwZCWLmAbn6apcdFx5OuwshnWGcXY9OUunWpTFhIEoydDvPI3Bp9lU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E3zsd4U6; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.nyi.internal (Postfix) with ESMTP id B67DF2000CD;
	Fri, 23 Feb 2024 18:43:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 23 Feb 2024 18:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708731816; x=1708739016; bh=liG+eRquBSeLX1xRKI6KGXUP1iEl
	r+oOxWU/4UKc9+A=; b=E3zsd4U6ySZdHjZ1ZcyNYUztkCoxVsEl2WezxqhTe6yh
	Mi6CiE828lh7V8bkEmLJbvkTZ+uiCzXg5I3iA5WEsdoVoIpH5g2if3uSg6FhAP8I
	ybmYhl+E/FAmIuvVF64qkGKZpUbtwGUcQcFf0IMOL8tDNyNFGZ3Di+IzxNxLEaxE
	O52NsXuaNXXIG0Ttm5NyvKHmkdfsto145HbmEzTXpD1CHTbsTpH412oEZra6Rv6G
	C22vgUIn3tcXtPIAlsGfeBdjBNlRYi7VeoDfbA5ihapHwd2mRHPrMdZYyFKsLmG8
	JWPY4WIOFcy0ZtjlDRpDoE4RQcjw3WCpLwvHSlDjxw==
X-ME-Sender: <xms:py3ZZVyNwA6UXfikG1XyRs4grz5pbKuBAyMdkBJzGUsBife0Kn231g>
    <xme:py3ZZVT0wqcs60QLfUhgPEaMTM91gE7oqkkV4YX0cjvNyZDUuowyDH4bLHELC6S7t
    IeWzsXWTjZnwis18Hw>
X-ME-Received: <xmr:py3ZZfXXVaLCQ2BmHeTtEH_h8Y2TUFVG9fEmrJMbpcdpI9EzJF6SV-vndkzhcAvZY9M_-TTAXxVeQWS9Pj2trioOS19s8xGKPxE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeejgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueeh
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:qC3ZZXh9Ug-46AOI2iv4wnkMfRWaLbOwulie6Y4fGTLOqfFSw_80yQ>
    <xmx:qC3ZZXAAvZkHz9Ovo_oSy3070rENDUMVEIvs8t9clnknU2HJi6cLUw>
    <xmx:qC3ZZQJsBEzjE1XHBfune7Fhfi8Xg10mcF5_YWIUMmSsUa72iVmg4A>
    <xmx:qC3ZZSVcZZUDWD79WogST1V2XxBr2UXci3SGkbs65vfCNWvLxYBRlV5IwFA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Feb 2024 18:43:32 -0500 (EST)
Date: Sat, 24 Feb 2024 10:44:12 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Justin Stitt <justinstitt@google.com>
cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
     Kashyap Desai <kashyap.desai@broadcom.com>,
     Sumit Saxena <sumit.saxena@broadcom.com>,
     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
     "James E.J. Bottomley" <jejb@linux.ibm.com>,
     "Martin K. Petersen" <martin.petersen@oracle.com>,
     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
     Ariel Elior <aelior@marvell.com>,
 Manish Chopra <manishc@marvell.com>,
     "David S. Miller" <davem@davemloft.net>,
     Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
     Paolo Abeni <pabeni@redhat.com>,
 Saurav Kashyap <skashyap@marvell.com>,
     Javed Hasan <jhasan@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com,
     Nilesh Javali <njavali@marvell.com>,
     Manish Rangankar <mrangankar@marvell.com>,
     Don Brace <don.brace@microchip.com>,
 mpi3mr-linuxdrv.pdl@broadcom.com,     linux-scsi@vger.kernel.org,
 linux-hardening@vger.kernel.org,     linux-kernel@vger.kernel.org,
 Kees Cook <keescook@chromium.org>,     MPT-FusionLinux.pdl@broadcom.com,
 netdev@vger.kernel.org,     storagedev@microchip.com
Subject: Re: [PATCH 7/7] scsi: wd33c93: replace deprecated strncpy with
 strscpy
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-7-9cd3882f0700@google.com>
Message-ID: <4a52a2ae-8abf-30e2-5c2a-d57280cb6028@linux-m68k.org>
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com> <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-7-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Fri, 23 Feb 2024, Justin Stitt wrote:

> @p1 is assigned to @setup_buffer and then we manually assign a NUL-byte
> at the first index. This renders the following strlen() call useless.
> Moreover, we don't need to reassign p1 to setup_buffer for any reason --
> neither do we need to manually set a NUL-byte at the end. strscpy()
> resolves all this code making it easier to read.
> 
> Even considering the path where @str is falsey, the manual NUL-byte
> assignment is useless 

And yet your patch would only remove one of those assignments...

> as setup_buffer is declared with static storage
> duration in the top-level scope which should NUL-initialize the whole
> buffer.
> 

So, in order to review this patch, to try to avoid regressions, I would 
have to check your assumption that setup_buffer cannot change after being 
statically initialized. (The author of this code apparently was not 
willing to make that assumption.) It seems that patch review would require 
exhaustively searching for functions using the buffer, and examining the 
call graphs involving those functions. Is it really worth the effort?

> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/scsi/wd33c93.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
> index e4fafc77bd20..a44b60c9004a 100644
> --- a/drivers/scsi/wd33c93.c
> +++ b/drivers/scsi/wd33c93.c
> @@ -1721,9 +1721,7 @@ wd33c93_setup(char *str)
>  	p1 = setup_buffer;
>  	*p1 = '\0';
>  	if (str)
> -		strncpy(p1, str, SETUP_BUFFER_SIZE - strlen(setup_buffer));
> -	setup_buffer[SETUP_BUFFER_SIZE - 1] = '\0';
> -	p1 = setup_buffer;
> +		strscpy(p1, str, SETUP_BUFFER_SIZE);
>  	i = 0;
>  	while (*p1 && (i < MAX_SETUP_ARGS)) {
>  		p2 = strchr(p1, ',');
> 
> 

