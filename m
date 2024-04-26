Return-Path: <linux-kernel+bounces-160259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829068B3AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49901C24AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DCD15AAD0;
	Fri, 26 Apr 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="ABHvjftG"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14411148841;
	Fri, 26 Apr 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144412; cv=none; b=Iy7EU3SiYSm82Jfjfk7AfxJcF2ZlOJi+AtQ5eLA13yfPp6FsgCJxr1+IHWlhAi2PC8KpKe0JZrGS/BpUE/l/pc+QvvSobo+w3zMUiklh1KusY3mrZDktVGchMyhvJDsqhujPCgAGE0btv7/B6pJTozIjHPgNrXgW+PPK/NCll5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144412; c=relaxed/simple;
	bh=OVAcxKVWCr0cVxx6IPinXqZ82ZD2FZUL7lrWQzu5m3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4lJQiKzKKhxm2tPukZ6yEMbK4ripCO7FvJGLvAss+LB1xkDwKFrOqMbVtiFTsw4Ubd2Ov9pgXuVn99N+I2MorOWbHmvtF5h6e4vIX5K0ONA+P/ayOPB/q5qfVwn88P/9URHmFFEouv74mCe8RQp0wtZuUg7dG2NzGUQewUbPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=ABHvjftG; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1714144403; x=1714749203; i=christian@heusel.eu;
	bh=OVAcxKVWCr0cVxx6IPinXqZ82ZD2FZUL7lrWQzu5m3A=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ABHvjftGT0Nk3HBK1fiPfDov+IDVymBD7H7YU7emp8EJf43BI+/DVBuovADzBOQy
	 9E5D6DGsGbW9sSZwkRYZ+l6+u9+ZtfopSdi/q03blpgmHOQ/D8rDRXSnpC4ACIl/R
	 o/Dh4as+a9ZEYmCm9b+YpzVKA9G9cOzuZs9aJxDO1gnUKeWEsDR1ayilUwY7VkY3r
	 atlM687qTOxjmh4d2I0XP08IZaRZTMPpvPKTo7TbdHSLwWHyeP2FeHVHNM6+JRqYN
	 Hvgi99PhkmXK3q7y4Gc8nzazJYWXbS0EpJMEELjMleXcJEsKR3dsqaWi3lZIXYR7k
	 zcfFeqVUvJx7hqQ/Bw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.67.249]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MZTa2-1sE6gn1Mk2-00WUQI; Fri, 26 Apr 2024 17:07:31 +0200
Date: Fri, 26 Apr 2024 17:07:29 +0200
From: Christian Heusel <christian@heusel.eu>
To: lumingyindetect <lumingyindetect@126.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-serial@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] serial: 8250_lpss: Fix memory leak in lpss8250_probe()
Message-ID: <xoqjkheigkwozgpckrdpyrfwzw33gjs564plbhbujzfdqwhcti@bsvrni5a624e>
References: <20240426114716.1275085-1-lumingyindetect@126.com>
 <42c5d1f0-d16a-483b-8bb1-4c5768aa3a8c@web.de>
 <4e6966e0.a07e.18f1a7f7863.Coremail.lumingyindetect@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qlpmab66ws2khlm3"
Content-Disposition: inline
In-Reply-To: <4e6966e0.a07e.18f1a7f7863.Coremail.lumingyindetect@126.com>
X-Provags-ID: V03:K1:BJSzN70N91LqLh0w0cohyxHpkNGCi7Es93xSvdmob6OTS6JRc7N
 MrZOLp8DUt0HrkNl9f/Xy05GJi2sWIaO8IH7epsxbrri/Jqgn8XcT0e4usgLQTImX5HSYgD
 jlUpl2v9E1wJNSejsg/F1RKvL6rtiNFavCu/B8lVVLebP+eyuGPeSyoZN1WANsqR8rGENTt
 IH8gomiSalf5ki+mzCyng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h0eGSJvPrfo=;l9RT6DJoa/wuUZb+AfO1LhYfqsG
 8zK2nxNUJ7iTDdqdNlgO739LoW+B6kaMm9721WjnhF+TNhOYkVhppWGyCEgplLJyzc+vC/woY
 FjFdmjC7Ju9+sbKh+88Rx69Ec+BH6v0U2PXcEMMY8NxsEgHE+JEiqczKYCjyEyPPn0Tx5YMp9
 fgIlrIS+4wbFSEDawzCG1uur08+ofjTUSSt6bBCtEpqWVgCYeX5dpa/JMBdEU1AiCB2nNzdX5
 qouexPsDVbL+jLlF+SUoYGSj63Sg0GxbxguUOgI4wMnvArS1vrUApopNOgvJJiKe0WPPbtcdA
 DI+II290Levat0yfMCzmCjsdvF+gjFx+lqrkmkSpG1LjcC2rlPhM11z3XJLXr7GSj6r2aTfTR
 Qo1nD7sb7IZ62RqsQ/bIXBlvBXNugps7XQhRdTY/RJ1BSXsy7mLLlAvqFWvM3iNoVvf9iuiB8
 lfqVvlYDD0j7YoeQJ8YnUn+oh4l7/Z8UTlAJXfbWjyjabQBz+rpGOO0BYSK5majISxwxjQDQD
 JBHwfSdtuEYcjRAG2Af8kwvWRy0ubseGYVQ/uo/c6tgLY8ZYNb0b3fTDHyJIDwRF3IS/OXech
 NkuY7OyVKXEmsAKnn0H9Aoeo2ty3Qn/zDdQbskUorb/JMedb3a87oRe7shB2LVwOr8qhcchyx
 80SMKAqW8NOtCc2hNuJYIHq8b6/PjtTOLwMSSDqL9h4iCZwLmapP3N9CdbOZAW2yDlDUzryMO
 rtMEx6tWk1Fnya9EtYfGR5+lFBSAZWJsRDw8gCfoNy20aZQILHSkHY=


--qlpmab66ws2khlm3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 24/04/26 09:01PM, lumingyindetect wrote:
> Dear Markus,
>
> Thank you for your patient guidance and advice! This is my first time submitting a patch, and I haven't fully understood the meaning of "add a commit subject for this tag" yet. Could you please provide some examples or guidance on how to add it? I appreciate your help!
>
> Best regards,
> LuMingYin

Hey LuMingYin,

just for your information that while he means well the advice from
Markus is not always shared by other maintainers and their inablility to
adapt to such feedback got them banned for a while on lkml. See i.e.
https://lore.kernel.org/all/2024042547-shimmy-guileless-c7f2@gregkh/
for an instance where greg is sending a relevant reply to one of their
requested changes / feedback to patches.

So just evaluate for yourself whether the feedback makes sense and just
go along of the official documentation[0] and feedback you get from the
relevant subsystem maintainers.

Cheers,
chris

[0]: https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

--qlpmab66ws2khlm3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmYrwzAACgkQwEfU8yi1
JYVbMxAAvKybMp/z4Oapf3lItgsKsaqCqtaaeTpi3qPqwtX8ZUkbpJh2QxJ5dUph
YPJ+7HSMRtEY9S19Qt8d5GnTG2L/wXEPk5bMVIrizs/5tXfT5Gp05wfbKUKHZUqF
3m5n2Y1O9deSaFAKngJxwtM9qdRfRlF7Oef5+pX9IpooxNf1hgSwq9xlNryv0yhF
8wxT9e3e/4EdQcPeJl6S/lUr6KDH32+sotVipPEUevqNitr8h0MsP+H5CLj3B2Cr
9OxmbMTmuhla2dEzJuTFRJdrc424LaKml3qMARpGrsuLH8NbIQBGWmm2CeaCpQd3
5qYnlrsf/IFR2t2+dCc9TVbYdOHYFazcc6NVclNI5Eaifnsh1gGiDTxNGK7kChKU
1g6USkDOTicC9mLO/+hHDkoI4NzgulriDLHuZJF0mBzBlMXQm4H65TZ4ubIO0Vva
YFAKuGJ/D46gPuWGIKxSykZKMLOgn0hoIsvY3FPriUXTWEzsh0aQQafzZlO0aPHW
uk/Nz0yw4Ot5krRNltpAed4kuQd/24tQNrkEIwbkivzLIfd4MkFUD3q7DN2Bzkru
7mXcE6hUNDN+LSGd4mctl4xQe++mKbUw9N8OM9hliry8G7nS+pIpCZIvXlcoFEIO
yPRtXTgFGYZ32ctg/baGBtGgXxbC4qgo5j31wVZUFZuQuto692M=
=iecE
-----END PGP SIGNATURE-----

--qlpmab66ws2khlm3--

