Return-Path: <linux-kernel+bounces-79329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B9F8620D7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBDF287A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ECA14DFFD;
	Fri, 23 Feb 2024 23:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jglTGBrB"
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABDD14CAD0;
	Fri, 23 Feb 2024 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732651; cv=none; b=RjrzTcrArL4g7s5MUJ5h4pkbn6vMSIs09t7IMOa4P9/izsL/X32TU/uO33rlppe+WSV/zP3Fc5pJPu/jv4edqIDR4+d+usSQgqdCok6KHkzKYqQjy1mM93myIIBJKt1zY7blwokQt2OeZWsmDbIQ7td26dBGfXTXsa6FrVIe9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732651; c=relaxed/simple;
	bh=Mx11YUHiPniIQ7XaRG9QZQ+TYZuZMGMF5iEeDvUY/ng=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K6ZYSb6JaQR5wiPs8wccLn6YOuXeXgKGaAiNR8NOprG7dV7GtAkToCMyyrnDioVv0LnneeqBUtS/5DGoN8txAsAA5i1T9MK17Zk5wg3SrMh/6R+T3dN6xAHNFNppFRg2lHql+2mIsgncZtboeuB+GTf1FOTn9KEZMHTod0Dq0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jglTGBrB; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.nyi.internal (Postfix) with ESMTP id 0C30C200087;
	Fri, 23 Feb 2024 18:57:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 23 Feb 2024 18:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708732649; x=1708739849; bh=Vk5kCKlCgJ1haPDDrVmCMA1V3Pov
	TZFbWmjHD81lc5g=; b=jglTGBrBnIN7wWXQoHPP6k1vKcyDNRH8UzlfaP9t7hMP
	XKPoldxdahZ/Wtg+u3+NyHyS5yvuziNR9tHtADbelg5NIZFJOAC64SeTMiJD/5H1
	ZOWRfyCKTiCbGR1XWuBIovu0qZHGj+3jr/oShYXkmLDJaQQgeclyz1I9rfrXxpf1
	J6renLhWmUUDWU+eFENoHS5QuoUaJsr8OYCZndbLtVpZBXGlHsnEZWCxkIdBXTbo
	YWiLy3TT/6xAzHGyqiPz2dog6axt0g9tx/sI+TFmeDM292uE0bUarWH8oYNu5FIg
	t3OYMtYrXbcHBFI2CMxopehqBpTPA/FENmoDwlY98w==
X-ME-Sender: <xms:6DDZZUw3W47kX-_r7YLKwW8hMU53QvK9kvRL4sq6QhfsxABodVbbmQ>
    <xme:6DDZZYTvirqK7I-g8WiQmdJE5eJKiO7MpqzVMGv0kFYyuba94NLsswNQhKV-KgeBR
    2efi5jNGEvRof1i8Og>
X-ME-Received: <xmr:6DDZZWXraH0Ou-H7K70OpNnu5RmOxYGFcouRNjJGW3WWj4LZnXZzil9B_gHLMTrb3k-glocO4I7XuoEbdZGNRnP8aDAfUtMy-CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeejgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueeh
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:6DDZZShkKIUw_l5b6DGcCn9ZdnQNoKW2TKbfLBhu4DUfaXs6bhIwDA>
    <xmx:6DDZZWBZUj1ZEkB9BVWaXRf2VnPQ9vgX3AnFlJzhzyWofkvjO8RpUA>
    <xmx:6DDZZTLqwj1V8fNUKW6OWBYLI-f0x8trEXMBb4Ot9X8-mLsH2qDvxA>
    <xmx:6TDZZRXtyWQx27tIeSA_wiSoJcjGKquSvIXm1x_BJRDphHwEXOLeQDn8dEM>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Feb 2024 18:57:25 -0500 (EST)
Date: Sat, 24 Feb 2024 10:58:07 +1100 (AEDT)
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
Subject: Re: [PATCH 1/7] scsi: mpi3mr: replace deprecated strncpy with
 strscpy
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-1-9cd3882f0700@google.com>
Message-ID: <512c1700-b333-8aea-f19b-707523ac3a6e@linux-m68k.org>
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com> <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-1-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Fri, 23 Feb 2024, Justin Stitt wrote:

> Really, there's no bug with the current code. 

If (hypothetically) you needed to reduce stack size, just copy the char 
pointer instead of copying the chars onto the stack.

If (hypothetically) strncpy() was banned altogether (rather than merely 
deprecated) I would do the same -- but I'm not the maintainer.

