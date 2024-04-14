Return-Path: <linux-kernel+bounces-144072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633FE8A4184
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B372814BA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C247022F1C;
	Sun, 14 Apr 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sIo/CsoA"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A815E9B;
	Sun, 14 Apr 2024 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713086589; cv=none; b=QhuyZIOSDiIUs2QTvupaNXp96pzbKpQHpY+TqFCJ8MzZwPIWNPpZnUovB2f7b9jOoupXFe6C9/xOK3raI3wgPEDdHFhtv6nLSoDpiUJq4praZRg3zVbp8YiSY33jdWdUyUNwnrUdcXOYrjsv7sMpEzM3tchviHLV1xtGYt4C/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713086589; c=relaxed/simple;
	bh=CZbU5y5aS7bsN4EzHQELiX8tMKw5daTd36n4GBNvk8A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Y0o/fN4nCQaCG2AfnhaA10UgHsEMSt0GxWeP+EvLcpKNeOClzAdpL6T/ZG6q6d690ThD2zH5Qy8GEs/VQyx7j/OhWzmqA1nuWSDrv2vlDny5/2eyQeRHDUsyo+F+CKfoZy3cL8NZyj+LKrcrZHVOHxbTNcgfuhlHPHWv9HQpPug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sIo/CsoA; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713086579; x=1713691379; i=markus.elfring@web.de;
	bh=s5ltjkK1gwJpndCII1TvY/cIdzI9eB2EsZ3Lgn3ig3E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sIo/CsoAdjQQW0jx9crXA5pN3OhvhfLJLyeJE59/lMnfMf2gWaFYmmMqCt3aaXdR
	 c7SRfHGlSdN9SDlsxp2W0hqwmovU8CVNmKBm1+Knacpa31AxHAJR5LFl3vcdlLLh7
	 P662qXPDnvbzxVgWq3O1Fe0XQTaU7c1fq7z7L+DHmYpxARpkFFuLhDK4XByUBTUF+
	 RCfA6M3Sq7au+e1O3c4bfdu8Ery5ocUP/PDkpGk3nGv7DXgteQg9QlYeO5pxU07Y8
	 G2YNkvBzy5cG5ZEzvIdjrYXyPIr+hBxwHCVGM04UK4NhBRrEfdmladuBkS4D62Z/m
	 r598WQUQvqLAkwJbnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidDR-1sQqUJ45dn-00fQIp; Sun, 14
 Apr 2024 11:16:49 +0200
Message-ID: <22f324ce-552a-4f6a-b4e5-2d84a00010aa@web.de>
Date: Sun, 14 Apr 2024 11:16:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Nan <linan122@huawei.com>, linux-mtd@lists.infradead.org,
 kernel-janitors@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Hou Tao <houtao1@huawei.com>,
 Yang Erkun <yangerkun@huawei.com>, Yu Kuai <yukuai3@huawei.com>,
 Zhang Yi <yi.zhang@huawei.com>
References: <20231208074629.1656356-1-linan666@huaweicloud.com>
Subject: Re: [PATCH v2] ubi: block: fix memleak in ubiblock_create()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231208074629.1656356-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:78p3dblrsqPURz0FRE4t9XDi/hn8Hkx9PEJPx94ac+U8J2gEHyd
 ATSHvvuSo0/6ZUrt4X79V1sVdDHxzZV0Fk6+QX6uvvcat67jFNb9mOdBPiUm9ZTf5/42ipC
 Iac82O8R4x7hKff4bxvwRukSDZSYCe5z5K42hTU7CBVN9OE5/DSMtHMxNUAmjsshKnCB8+3
 5jlJw7JL1UE6tfYrFbS/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:78U8V0f2Fdo=;LGe4/JopxlNNRAM6CgWWkpkSAWk
 3BCmW5wTgs7oumhZCoEm4Y1cojBqUQKuJI4dMvn+e/l45aHnnkquuCwjd1De05C1dPE/XFMsX
 XTqkYwNuGiO0XkJRKJaesoCF6tCpW6GKZfd5vChJi1nVpoO5QFQf3jek4qqhTySAjjA8Bk6Vm
 bSIqCc+Q9SJ4m0fXkcOFdmA6b105pbuKHJdoAzLO0LspYHeFebZPerPwI2/9PXVpsTiCUwnWH
 /+B4yn1M0HC5zDhFkC8OupQHU90jrQyDhlXKic64HZQUvI36dkVNlbw1z5S0vNWavZdtxk08U
 rThHeDXYEDFK6NGGIgbxk1xOMHCpSue+LEqtBfmjhqVKSuHJqV+5rENU8+vEntxg6XDdxzO0/
 HbkZn4RQo4zZq0vjzvWYaac6r0UEEEjqtxqPBfqJdAtVWXHWlntPS97h1xHchIct94poZpRt2
 8EtgDek1KDaB5bR5WXSRtGf/tbhz4AOMukxL3IqYlSX2tSCbnQre5qyGImR2IT9qc09S5p1M0
 pzq0yi/3N+nhBL/xaf9nEK7thqKQI6Na7fx9z2lvRWkbz/rNDm7ueKzB69vUBIzbtCtBQ41ec
 pHBnBNtv7LO4dMmiSwnTkPEerrnZEgR9BtQrXnde4MLLcJfcroxsmjdgoyFyUclZ9u+FGw6gj
 PeBrpFhdHIDCsF6yMmzjqEmtAYdb3fyTwXWY1/qx/tbZvL/jJQ4elVFMqymIM2Nc7o4UKEDHd
 4irKba+X9tEk1L6pLoV9jTiqYY140iQP0eYgSVIWIDkRigouuXUw+gSm25ib2NcUm3pTvSnfi
 V7nIUbVGbIwD2W0OSCIXIx0t1opC6iDl2qJ+5Vv81cZck=

Can it be nicer to use the term =E2=80=9Cmemory leak=E2=80=9D instead of =
=E2=80=9Cmemleak=E2=80=9D
in the patch subject?


=E2=80=A6
> 'gd' will not be put anymore. Fix it by putting 'gd' directly.

Would the following wording variant be more desirable?

   =E2=80=A6 anymore.
   Thus pass the variable =E2=80=9Cgd=E2=80=9D to a put_disk() call direct=
ly.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?

Regards,
Markus

