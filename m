Return-Path: <linux-kernel+bounces-105377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBB187DD0E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 12:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695BE281617
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 11:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB891AACB;
	Sun, 17 Mar 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="QbQzEpSh"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B33C17BDC;
	Sun, 17 Mar 2024 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710675115; cv=none; b=Px1d19VNFWG0nyXZzWRpq9DWEIAAEDy2Z0ldtRfPDTsUDufokpWlFgHmfh3b2dQUWlwZP2XuWDeMRu03sIcZ93tMax1v0nwNxm6EtAVcTVJglbhMUHHUnIGVqD+XM4uOVY8zGhbZWoM4O9/2KRP9kfPzBG4XhHud3y52K8yLmZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710675115; c=relaxed/simple;
	bh=qrgeXJnBze0/NlThCnEWfbKJr4i8ti9uvqhuku1tviU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXIwUZ45yb7qMdpp7M21bPqh8gUwuTdpEZP7pFBhqXbZCxiHcxD+KSUSbYVIRN6cbW9qKQLXkvjq0488ZvOvt93DsU41NagJtZYZyVi1tow/lZdaR1vJYJNPJnU+I+uq+9f+TvFgX0qjwqIzDZT8xH2d4eISxSPBenVNRIl6ohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=QbQzEpSh; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1710675107; x=1711279907; i=ps.report@gmx.net;
	bh=thWe4OMhTAQiJNHJcIhgAzprazHbbDFO6O3nabVbkoQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=QbQzEpShu9aCF6eGud0wFqH5aBsS1yh2ZS8flEyhZMeElzpmMduWaCR60hC19sTS
	 hotihDgA9mMhZiZWtvBC+g0OiYtVoeWjM+vfHeMwTXM6dabohZjdC9yau65q4G0Yd
	 Ec38FDvENE8GCRmVWfVzP/fqDze6Hzc6N0vxZ2IEXPtURKsS9ScGUje+oWu8XniUL
	 xcaseaKYzvhWg2/8XIeyuY+9Hk67Gb+O/3u9Exmkqree/bL4TVYKfTLDITxwZM3LY
	 jstwdzLmM3v5XMxufZ043uvnH17YjzNFwfpVM8blGixII/n6VeW9KOfuuQjbcJx4Q
	 krid3VmkGFe9+AaoYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([212.114.183.180]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYbu-1r4Gyr1iX8-00m2bt; Sun, 17
 Mar 2024 12:31:47 +0100
Date: Sun, 17 Mar 2024 12:31:35 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Alejandro Colomar <alx@kernel.org>
Cc: Oliver Crumrine <ozlinuxc@gmail.com>, linux-kernel@vger.kernel.org,
 linux-man@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket
 options
Message-ID: <20240317123135.24993051@gmx.net>
In-Reply-To: <ZehrtwSDQV-X7BXV@debian>
References: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>
	<ZeXzuWVmC9AnsECt@debian>
	<7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>
	<ZehMWQ0LkemsTHAC@debian>
	<CAK1VsR0XZMgUW8qMQMcDPohD8-+OZsgW68sZegLbVy6cdoWucQ@mail.gmail.com>
	<ZehrtwSDQV-X7BXV@debian>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+EQe8vdWUodhPL4RH0qddhfdT6bV+qEix91lRkyb76oIOo+y33T
 hz/oYti00sb6w1koT3l74SUCK2sS9Cp0VwFPiuF5kOFcHybETlsRFTcsvHtglMTPbvIj3Mj
 LGuv9Di7Y+FP8RQ1RjWRLR4yjnai2aTGEih6aPD4fGCwuxL31StB6qMMH08EJwV7Aygg06o
 Rz8rhiW0JZ5uYwXgfbRuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CGV87Kpqmt8=;g84LAudjtX9P2NnR8jYlaozCDhO
 pT5A71DR3iMRoltgO7Ml7rWeCCuHPbA7+lsBqqBIW10fqazYGGdIuqT1qFtBWdeiAtx9aPWb2
 hPTBWYeukC4btBjvJBaKFRIKt7FFlGTj7bW3TRzZ9HlRljM14GurwvkBLo8cZGLRTv10rTRX5
 MvBrWPYBCMZG/KTepMCP5IYs95ePamPFvUCTi6RBSw0o3Avf3or/7vx1HFNGJ01PaNfIk70i5
 xvs5SJDFQc5VINngecz6nlCztgsJERoVm1vlSu0YHqGx9I27R7ZErpCjnD+9lrBIlEZalTCus
 ePFGteryWzDjwtuMGjpsrMenU42bE6Lw7AyanBdWkoFHZAVwtL7ndZAIlR0w5biU80a752EDw
 ubEeaXFKeBislvLD7VEhtuZ2y5cNWatJ6VJVJTmk61NZ3JAz7jAI8bX4F6biZtk1jrGez9bze
 5rhfLsVGhDn+xJs50lxR+Bv3x6APdVPgv8EJXkSbPEYIXLKSWsFaHWCTsBCNXWfvuI+2SYC0O
 OPHHCfftO4j/RxDlQlVeOiKqXQPL4KOp2pBWeGntSSUDEWkR0xCWucT2x1tud4UFIJAJa0Ky3
 n4TTBwqooQkIeBfUcjPGwn2EHH0jQRYys58jDpUahykIGSMpQhqes4CftvbQchggssmmiVazT
 19YwNRaCC/PN4otI/rk+kQRbnfAJpVOCO6jgGOm6n5thiI35E6uSsomokN3KNMY4W9gVSIiJO
 XGQbiSMUCBtSIm1KoHGfyJ9tLbE0sylBysc39sO2NoXVbj8SRKElmT+hb/E9+pcXIYfdpoo8u
 nBshFdrcSoxZzeS51cFv51E4nKAO6/fmCSODdmK5ZA/wc=

On Wed, 6 Mar 2024 14:12:23 +0100, Alejandro Colomar <alx@kernel.org> wrot=
e:

> On Wed, Mar 06, 2024 at 08:02:10AM -0500, Oliver Crumrine wrote:
> > Hi Alex,
>
> Hi Oliver,
>
> > Type into netcat, not the program I sent.
> > My program is the server and prints out whatever it recieves,
> > along with some other stuff that lets you know which options
> > are supported.
>
> Nothing either.
>
> $ date; nc localhost 8888 -u | ts
> Wed Mar  6 14:09:38 CET 2024
> foo
> $ echo $?
> 0

Same here, but with nc forced to IPv4

	$ nc localhost 8888  -u -4
	a

And in the other window:

	$ ./a.out
cmsg recieved
data read: a
byte =3D 02

Regards,
Peter

>
>
> $ cc testDgramSocketServer.c
> $ date; ./a.out | ts
> Wed Mar  6 14:09:05 CET 2024
> ^C
> $
>
>
> Have a lovely day!
> Alex
>


