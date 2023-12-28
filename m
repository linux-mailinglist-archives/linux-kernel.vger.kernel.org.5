Return-Path: <linux-kernel+bounces-12720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D139B81F94E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC841C2111B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E58D514;
	Thu, 28 Dec 2023 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cAc+P5Do"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7B8D2F5;
	Thu, 28 Dec 2023 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8C70640E01AC;
	Thu, 28 Dec 2023 15:00:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PxZX2y-fzCBl; Thu, 28 Dec 2023 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1703775611; bh=iCf2bVGTYJt2X/04rIA1mBGQdKeeLuRm/0eyYuGvT8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAc+P5DoPPIhu9aIIq7QBENuq7kcTN+QuxEJ8iw+bNlxdDLz1cTyoswJH++A9qxXB
	 ST5BlFiur7ISSB1GrFKmGBYtwDj9ZWIxUh78sFhYQpWCuZMSLoqD3I9j6JrBFNjBLn
	 uVl+dKIxYMPqz675k4abm+27WRPpcC+roRmNu2r66jkj/TGLOm6mNliGV4A3JTb4fQ
	 GKVn2+pkAJ4NXLwo0ba8VK6Bb59sonXYB0b0lIGWiBJjf/GAGQifuDJ1IHvm9Cdvec
	 YpEVH5LZLeBhN1PXVHyinjNpdJq30EVJvDgXClX0Rw5eXrgkhAeu6Wj7jQDHR/b3qN
	 clxp+GJtZG2AqklR6afVPecmKhHl0k/LqCGe9rjExBSFBh8wm83SLW0l52ecWjuGk3
	 ktogUJZQm+0uUwyD/IEPM4ho6BUhBpT6kHvIgPo2fcwWssujCVVj9xCRHifzwIyFFP
	 IaVaREC9+rM15SXZshTxNgW/LPm5jw5LmmbsdBnwlNVuIskBPEmQ2RHR7PChZvJpVk
	 CAUkwrRQSQhiSRqsS/AFWNpWMB8TcT9r6DcXjkbPEUWXOi40NMUSYTO/nHpu8PMVjI
	 okHeJL47yrcOOnxM/u+/P3HUPN4FdSM2M4hI8m/JvahfdmhynCaw1Z8TcJEUWQQqxk
	 5YjqJfOrgVPN/KbBTGEBjf18=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2537C40E00CB;
	Thu, 28 Dec 2023 15:00:04 +0000 (UTC)
Date: Thu, 28 Dec 2023 16:00:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC: constantify the struct bus_type usage
Message-ID: <20231228150003.GAZY2Nc38sAIa0bat/@fat_crate.local>
References: <2023121909-tribute-punctuate-4b22@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023121909-tribute-punctuate-4b22@gregkh>
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 02:13:10PM +0100, Greg Kroah-Hartman wrote:
> In many places in the edac code, struct bus_type pointers are passed
> around and then eventually sent to the driver core, which can handle a
> constant pointer.  So constantify all of the edac usage of these as wel=
l
> because the data in them is never modified by the edac code either.

"constantify", huh? Not enough words in the English language so let's do
new ones?

:-)

So what's the plan with this "constantification"?

Because:

drivers/edac/edac_module.c: In function =E2=80=98edac_subsys_init=E2=80=99=
:
drivers/edac/edac_module.c:80:38: warning: passing argument 1 of =E2=80=98=
subsys_system_register=E2=80=99 discards =E2=80=98const=E2=80=99 qualifie=
r from pointer target type [-Wdiscarded-qualifiers]
   80 |         err =3D subsys_system_register(&edac_subsys, NULL);
      |                                      ^~~~~~~~~~~~
In file included from ./include/linux/edac.h:16,
                 from drivers/edac/edac_module.c:13:
./include/linux/device.h:75:45: note: expected =E2=80=98struct bus_type *=
=E2=80=99 but argument is of type =E2=80=98const struct bus_type *=E2=80=99
   75 | int subsys_system_register(struct bus_type *subsys,
      |

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

