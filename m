Return-Path: <linux-kernel+bounces-22137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CD98299D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37D31B27AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EDC47F6C;
	Wed, 10 Jan 2024 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JhZjCYhS"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3074747F40;
	Wed, 10 Jan 2024 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704887327; x=1705492127; i=markus.elfring@web.de;
	bh=LTkB4g/EgdPEET+xqwliNWj/wGfk6xQ9qpWM5jUj2tc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=JhZjCYhSzB5Non1e7VG+S9wpK2Ggk1YkD5CAWjhOgSu+L+CnupAZVW3P465sG5Rt
	 VCGQUs4q2+EnfC693AMDacbf0yZfoT/JrHCk4uOdD7BP9MX9uIzRvdOmBgfm8zdjf
	 MIlP0Y75D2kzXiT6jvlk2E6OnDCxkssUEdNsRFquOmEC4+e6GkLH3e71OCHF/j4OJ
	 7SfBWerQrp64098xO4m2SQzglS1vI1VASaH03Kay4nxQtqQZ3JmFzqJ7ERgsumKPk
	 GRL3FD6Nk/x3bPUMpa3WsKpJJzGLBevkjbguF+1AArqS2sisRwQ7eURHj37SSjudF
	 jw3zkM64d5dy0yeqcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mfc4g-1qhck32AZ6-00gBHR; Wed, 10
 Jan 2024 12:48:47 +0100
Message-ID: <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
Date: Wed, 10 Jan 2024 12:48:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ARM: Adjustments for init_atags_procfs()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Russell King <linux@armlinux.org.uk>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
In-Reply-To: <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fu16EWDvzTMZHLAc4WQ6rkStfY9mvBZxuOny3HBgTQQDY6Gw6uq
 JdJuHrBQm+zOJRxWN4gsCMiJhlj1jPrxu/qHhl2E1nYpT4OuhJhE61RcDTZ8+10PJ2N9jsZ
 dXr8wE62fo84k/VdDcoXljA1Vl4CTco4PBQWzvTfpR96W8xQp23yEI4aiEqiT9dJH8UNViS
 LmvoOj0AbxycHXmeFbpNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zSs1X3od1UM=;50UtiU5PEFqbpBp+t0vuIWXLgyW
 a3mMcTu2My+XaS28YjykZmKNbHVp24MtqrnNhK+ddJ2li1Q5KNEZyEFD6f2HPOfjb86p6FguU
 s8bo45HprpIpVyhCleOoyfsYLChl+XgSBu+3q9ZPlh9QeniUGCTGPDs0BOXx1O0PVfZEB6OWi
 vfB/4cTAImcQWXyiiK9vayKsgcUdwUfEgN6nV91AMyqkhAdNsQ2qwMfxq7RDsDCxWCwReJQw0
 Bed5p2d8EDWcWRvee7pxw0flHoEKcIBVd9x66ZPnO+oZK4IClEHEGHVuZ7/1LtUcnLtJp9lKS
 tFpGDpP+t2vRnmWaTbwu9eHnzuXYqhqeibVhnRSWli5zWKvPLI2hnk389roaSsesvscmi1s5F
 3KhmMY6IyOyD7fSNkt6LBNNyubEoBgf1f9AsGFhPqe1hW+plsQGjhE2W2fu2vTraW83iVg5gJ
 X1fmvC4TBsUHg1r8Bv2CkJKpQHwC00rgaSIFaVgDXd92CtFMsCpWpIS+cozdUzq5PYj2mLtCy
 nGjv60ijz0A7NoWo9lfaiO3tgJ3KV+9dxI9FovabRXf+Ryj/NOUFyC/E5PXxpCWwty4l1WLIR
 yavguvwZikEBC3kLONw6BXD38J2dGaHdbUh263/LnVLjL9XSpjdOvU1oLSd92C2ilqkj2b+q9
 2AMtItNL0DgJ4thBlvMZB2c8hgyPRfry4t7G4Hj4NVH/Ak372LCoo/9dQZkdP/nLdFtEHH9LE
 /c7yNQCF0h+aY5t0SyXt0G2Uw63/PbQ7QnHu2kTCMVja3DWy4QftPTIyl+TgANihsqex57wTX
 dsK27N34M+eMgIeIMFT/HpICkH5SBjJ53W7JM1MLDr56zn1o81WsJFYn3b3WiSCyrgmjTGpyW
 lxIfcGEQLeWuGjUbSKFYC5KUsSxKkfs8tzo/cTUIMGmlak0ZxF6nW2AXqIKPPHci5Cw0dukaG
 r+nIpQ==

> Date: Tue, 28 Mar 2023 19:06:32 +0200
>
> A few update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (2):
>   Delete an error message for a failed memory allocation
>   Return directly after a failed kmalloc()
>
>  arch/arm/kernel/atags_proc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/2258ce64-2a14-6778-8319-b342b06a1f33@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-04/msg00034.html

Regards,
Markus

