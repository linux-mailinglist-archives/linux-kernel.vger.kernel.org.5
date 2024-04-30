Return-Path: <linux-kernel+bounces-164345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2238B7C95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AEA2845A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1255177992;
	Tue, 30 Apr 2024 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="E9ffi5FO"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E4A171E67;
	Tue, 30 Apr 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493809; cv=none; b=hv7IFTXTDQhEi0onhk/Ck9uCHmeb9EXeND78k67dyuKF0A9sY0XP81Am3QvRn18/nh5MDTmb8Y+YqQQldmtqhtW7tGjKadXvP7bd/jhGWnor1lxgmC8jcZPIaABUJBzJaRlryxPh8JlGWyKzKg/F10ZdpPIuRJNdYs2504BM5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493809; c=relaxed/simple;
	bh=i2Z+ST1knfoR3VX2R+IERwe9mECMLFmQiRbESASYjUM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ugzKa32tZDSLYSFxDyS8sR5WqyWjBtEz0qbnLIXkTFI+KtGOT6E6OgR1DG9jDAxVicLf+hDKJYqaGK8pBRwfsyJwPjp8nn7Al/5fw3uYIP2ExQ5oKHR9PGz6HszIncLNLd1D6syHqp5BGpDEhE0FwVGuI7fzTGDbJ2+DVlyZU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=E9ffi5FO; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714493785; x=1715098585; i=markus.elfring@web.de;
	bh=qE8jfgGJPACGk2bLiMkTEZxoLNjXc46AGphYdfpzbtI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E9ffi5FO30x9+VdmiIQ1aFZYVxlWXvLdb8LM9/TLqy8tF9FgjIWWsSzuPlnccmqr
	 X/tWfZQVIiyjo/CvHcd8s6LTEMMsDlpy2B8HEJwEicaQcj7woiP6YpywjnBly4pd5
	 Mpq8MLbztdvjHEXnhwtCZAWi3QHMgL+zEUmRMjqP+EiCviUqe04a5PRqyyYhGA1PN
	 xQcdzv8LRoYAopIcQoSmizf4afbQoqf6o+qw3VXNtxXBP60MLBNUOUmPz9O2vR5PO
	 ytMRSiu/nKbsepUnHsHSOZAZZln3PameR8Usr95BVA3jN6typ/NK6wlkcYlSFh+Df
	 zd4iudOVXFKmLqxUYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrbz-1sBZS00e7J-00RyXm; Tue, 30
 Apr 2024 18:16:25 +0200
Message-ID: <11361de9-b145-41c0-8d5e-5312cd710124@web.de>
Date: Tue, 30 Apr 2024 18:16:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chun-Yi Lee <jlee@suse.com>, linux-block@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Justin Sanders <justin@coraid.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Chun-Yi Lee
 <joeyli.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jens Axboe <axboe@kernel.dk>, Kirill Korotaev <dev@openvz.org>,
 Nicolai Stange <nstange@suse.com>, Pavel Emelianov <xemul@openvz.org>
References: <20240410134858.6313-1-jlee@suse.com>
Subject: Re: [PATCH] aoe: fix the potential use-after-free problem in more
 places
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240410134858.6313-1-jlee@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H0Vj9avIGCf7BG5yW/lKI4cbc0H+0ovdz9Yr7i/Pe/RIWMLaCfF
 dwaaabigzg07eTFIqR2ZXzRwjCgaSiaSdGTJgEUCOznrV2Ihj6J2qTE4s3FdHRUjPv4+JX5
 NTjEFQtuHK0KREHk69QIm2xhyLzYUo7THWNuzF1fCE+0dgrxpmw5pC2NIR1wjZ+qg6qUcA1
 WSwSV+3mVSsr1E7R+bfMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5CnpBjEkO44=;NOUwE0wWY6C3XAs9dfdSuF3l0G1
 mye+FBFybE1Ez0Q9TLu/uQXgcvI2PDNfZf7NKbsOZu12tu91WxZ2qjJln4KMUsb/jxAGssclw
 6v47ZmgbrlDgoYgIEXCblrqbsyf6WupVaRZAevqZ5XqnxeUm6UvCMHn1KXatZJbDgcp3YY0J8
 VgYaSPcL0fhaja+Y4symZBTrceAzj9Wc9R7DCTOgtl60kS9ttpbP7/npEc0aJHQkOUNt9ssMr
 WrAnJePMfD8xYkxGt7L1z1U4QByMRvxAIMAPL0iFKBnmK79whELOzaUTBl2k7suNuWAh3VjjC
 ubJDVFZHjloQs5S5HQtZkGfWCHPH30ij6ErNiZXG4gTw1U3meJDFmrCM02k/9H/DpH7kgwe6y
 cj4xuqlFlUCjmE/vP1yBj3Q9XT8MQbJ16hkadIipoGVdkynj73rhwLVD3CZfdqtzyl3aRkvpX
 YLZFg9/LFa9qwu1bcUSlURfvzA5av0d568Gdz54P7HTSyLG8nsGB8OxS99c+gBeLKCU8vU2pP
 H8BBfsVQx1KI0W4E94q3zCHu3BXcXgdYsTNpswb50vtJMra2LK4k+fNCRZ6we7dGyi0+Qdtyp
 11JbDGn7FDoIrLm4UR3vXDJxfp5eli2He/8lMgC/EnFzdjzx2UI1xLY2WD0jNkrFK2LDOnF6M
 6nwoALaghu1cGMxT0bSFh+Gk8sDZx+n/5AmDDuqkg1w/9C9n6WXZDD+Kn22Cwn/GyxITFY2e1
 TgyOhbcBLHuKyvNZzetYN71oBHPJwzDLk1j4FVRkJGeduqomk59OJuUyXnuGXAxRswgSWariL
 6+/jgKFCPOQCJxBfLajxik3I1d5bfpGhYkINWVfngYfhg=

> For fixing CVE-2023-6270, f98364e92662 patch moved dev_put() from
=E2=80=A6

Please add a subject for the mentioned commit hash.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc6#n99


> This patch adds dev_hold() to those functions and also uses dev_put()
> when the skb_clone() returns NULL.

Please improve this change description with a corresponding imperative wor=
ding.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc6#n94


=E2=80=A6
> Fixes: f98364e92662 ("aoe: fix the potential use-after-free problem in
> aoecmd_cfg_pkts")

I suggest to omit a line break for this tag.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc6#n145


=E2=80=A6
> +++ b/drivers/block/aoe/aoecmd.c
=E2=80=A6
> @@ -401,7 +402,8 @@ aoecmd_ata_rw(struct aoedev *d)
>  		__skb_queue_head_init(&queue);
>  		__skb_queue_tail(&queue, skb);
>  		aoenet_xmit(&queue);
> -	}
> +	} else
> +		dev_put(f->t->ifp->nd);
>  	return 1;
>  }
>
=E2=80=A6
> @@ -617,7 +622,8 @@ probe(struct aoetgt *t)
>  		__skb_queue_head_init(&queue);
>  		__skb_queue_tail(&queue, skb);
>  		aoenet_xmit(&queue);
> -	}
> +	} else
> +		dev_put(f->t->ifp->nd);
>  }
>
>  static long
=E2=80=A6

Should curly brackets be used for both if branches in these function imple=
mentations?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.9-rc6#n213

Regards,
Markus

