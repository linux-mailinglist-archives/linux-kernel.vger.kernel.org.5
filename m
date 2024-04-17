Return-Path: <linux-kernel+bounces-148470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63AB8A8308
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2167CB212EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFDB13D290;
	Wed, 17 Apr 2024 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="rYbxEK7A"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D60513CF8D;
	Wed, 17 Apr 2024 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356475; cv=none; b=ZL3BtcdChIz6Lzen45ScgFpR7Ny5M797r2LYZM+wTIuh5xp89IitUCev3dMjAwCb14r6rA7eYzRElGQLSM1ll8C/d5fbcjrrYSEauSkj82I+oK7PSSpp6nFRGaljvpUmg3Wa8dg3e/wPfyQfMyrMnxwzJprRL1UILzwFRaS/FoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356475; c=relaxed/simple;
	bh=I5J45peC89w2IYVjowKRnY9hie3m0Xx+tnMFU4dALms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRcLtEMY+ekbuIIb0orR0vGDztgV61rgsT28r7VAdGWeOrvAUkcZid5hYJoeqtmF4XUKb8FL5rcrBzeOCUP1hEGRnyQfTBTpZIMFPLXhMfybkSuEwv7Gh4S8FdWCeGlSUKeWV5wRZbbXfFccAtnIl+muU7wkQxdIpcIUgFuyRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=rYbxEK7A; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713356464; x=1713961264; i=parker@finest.io;
	bh=HYeCBqjK4Tty67Ut5ek/6W6RMOnoU012Tr72xRLWLUc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rYbxEK7A2icdPrE508mAQd32WToHFhFTNYBOle08ZzcPotwoArcW0mq3/1xQK57e
	 upMhL5EHF/gWXaDCIDuPjTlhp4vWBNTVY6+6RSOaN6AR4r8K+TKnA2IEwp0NH8muN
	 c/ywQ+DCzwXGNEPR616XzioRAuXRvgmzzVD4KI7s6WAFssRvk8E0iEcFWXYYzNnfe
	 Lhko2JQ9TmiD1ChTBhwdRtCNfdIa0K7zzd2Chn9g1G+L/6rac9FwKKGG5hcp4KsV1
	 CDfot/VlV00gVE/ZzFzRgd4v80RpGx5ylMSHl2ySoD1V5+GfO28MhHRB0e6rwRT75
	 5rKL1bzQx+Qae2JzAw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0Lg24j-1sXRQR0yBX-00fpJr; Wed, 17 Apr 2024 14:21:04 +0200
Date: Wed, 17 Apr 2024 08:21:03 -0400
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 3/8] serial: exar: added a exar_get_nr_ports function
Message-ID: <20240417082103.66400776@SWDEV2.connecttech.local>
In-Reply-To: <2024041708-flail-pester-d1fa@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
	<56bda5690e76a297bdec6768ea1f5d11c32e5eed.1713270624.git.pnewman@connecttech.com>
	<2024041708-flail-pester-d1fa@gregkh>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PhoE6PlsOTp9CeMzLcAhTiYfX0zORSbXCMBvjRmSidLCsa02w9M
 JP/5XyIipm6C12f+RJKkcjMb8svUKGYSOFMulMJhR1V8wAI/raeEk4U8fEzLLFrkF0h0i1F
 t0ReOJW4roodQ8c6MAHMin01k97f0moaDmKGhAzFoq6N7Aj9ndy58wmYFTxD3VEw8Hq3LVR
 U/bqEOTvzVieTZH/anmOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LYoAygteKWU=;DuUUftjbq3nUap5EnLLqc3AVpZo
 sMJ3AY587F6g4Qfd83Od+HyUfgTKxDwyQXEAHewwXOaC9JPyRy0tr7ZYosTED1/ANWVtcM4Qt
 aRg/QaRsrFb3MmxUgaBBgNPipAoNE7OkcbD4l1D5fVHPRClRdWXegGzCPL8G/iFXENQvNLTtj
 AaAMxsb+F7J6ovn8/V0/EVCiJix70HX2/AMlK4qAyA8/8AwsAwS9RPg0xF/Adi1IfSfNSlzfv
 lIFmIeJDY3NgmwwDNcqFBxVHQ8YDcb7QIROTu0Jgdwv4juftJx8KgjvGQp0+/FQ0de1PAofVo
 D3+w8zF+WzU+iJMC5KTYv2ephmPcL5AEbL3+MWmK2ymGJJMXcuWZ+Br4ZZ8Ezd1pDMIRom3PH
 XQOFN+Y1QtwepyKNTO3gSZdCc1QJw8hY17OeWufjOq+yGFnt46jnqAoLIMkFipr34m3REDvdF
 eucykmGguP9m7kLHoakEeJTqyt6dSjt4BzUqHa5SLKZibSQkcXbBiVp+bOX9+79F0U+J6fizK
 1kdbtO8mYqk3I4ZLtvmPFCawFyOfD1v8hzv6Rzsc9JB05SzOHpP3gDgHLqOl+IUPAvdDZX2GL
 kKEMFTmTaYnllgob9Z0UQlWlj/ShiLl+v5aZcLKnRHuo8GFIpsSXajDr2AaZ28Tx3myICaaPk
 ewBkF7DMAmzdhFTpHewMBUxoAZYSgvdkGfVG14iUlNB7+sGBHWdb1qFzmlN1u+wWNMxy/h9Lk
 jm8VcsyvkiwHfdunfrGcoISJT2uH0g0ASiTqy0LtcOF4cKM4M7aRy8=

On Wed, 17 Apr 2024 13:15:41 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Apr 16, 2024 at 08:55:30AM -0400, Parker Newman wrote:
> > From: Parker Newman <pnewman@connecttech.com>
> >
> > Moved code for getting number of ports from exar_pci_probe() to a
> > separate exar_get_nr_ports() function.
> >
> > Chnages in v3:
> > - Only moved existing code in this patch, will add CTI code in subsequ=
ent
> >   patch
>
> Nit, the "changes" need to go below the --- line, otherwise it shows up
> in the change logs.
>
> So when you resend this, can you put these below the --- line please?
>

Yes sorry see that note online now. Will do in next version.

Thanks,
Parker

> thanks,
>
> greg k-h


