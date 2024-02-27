Return-Path: <linux-kernel+bounces-82994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C47868CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B02F283984
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10136137C2E;
	Tue, 27 Feb 2024 09:56:00 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C313699C;
	Tue, 27 Feb 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027759; cv=none; b=gGKALv32GWBb33rVUMLxjSKE7wWHkk6Aa5KAvoXqSDNKH9G2R1U59XUISaHa2jGyV00+smkJZWF82q/0zrJzwIxuvMxTxKT+JIQHCu9YfQTBMOv5hC8/TwqD6BzgnlLJAQtLsvoxdVryfpAc1ZWEQKSJQmzNUen4oLXAplI8sH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027759; c=relaxed/simple;
	bh=xq3qBvU4gk1ltWqMXc7Ql/8kJ/Mxz+rJm9geJy5TnhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1AgDgSOaG/iJx5l8qbaVSPvVtF/c6haCP4jPGs8RQEqB0o1yN8/s95P2TJ4A8MMiGT4Q0uMJLbVkw/H9Razt8p79xV4KnPhO29ePPgOz0svUNO5CX28pS3dz7Ky+Y8gilGj9JJw4v+yrwuUZcRksz3rlT6f9WbA2XP8gqm85Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3cf98a80e6454bb8b1d6f00fd9077175-20240227
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:162797f2-c538-442e-bc87-ce312ef5383f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:162797f2-c538-442e-bc87-ce312ef5383f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:d9de43ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:2402271312595MEHZP25,BulkQuantity:5,Recheck:0,SF:24|17|19|44|64|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 3cf98a80e6454bb8b1d6f00fd9077175-20240227
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 763447630; Tue, 27 Feb 2024 17:55:49 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 493D2E000EBC;
	Tue, 27 Feb 2024 17:55:49 +0800 (CST)
X-ns-mid: postfix-65DDB1A5-1319371114
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 6132CE000EBC;
	Tue, 27 Feb 2024 17:55:48 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: manivannan.sadhasivam@linaro.org
Cc: chentao@kylinos.cn,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH] bus: mhi: ep: Simplify the allocation of slab caches in mhi_ep_register_controller
Date: Tue, 27 Feb 2024 17:55:47 +0800
Message-Id: <20240227095547.160357-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227051236.GA2587@thinkpad>
References: <20240227051236.GA2587@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=8bit
Content-Transfer-Encoding: quoted-printable

Thanks for the reply.
> > On Wed, Feb 21, 2024 at 04:59:37PM +0800, Kunwu Chan wrote:
> > Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> > to simplify the creation of SLAB caches.
> >=20
>=20
> There are multiple instances of kmem_cache_create() in this driver. Cou=
ld you
> change them also?

Sure, I'll change all of them if possible in v2 patch.

>=20
> - Mani
>=20
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> > ---
> >  drivers/bus/mhi/ep/main.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> > index 65fc1d738bec..7b61d384b2b6 100644
> > --- a/drivers/bus/mhi/ep/main.c
> > +++ b/drivers/bus/mhi/ep/main.c
> > @@ -1493,9 +1493,7 @@ int mhi_ep_register_controller(struct mhi_ep_cn=
trl *mhi_cntrl,
> >  		goto err_destroy_ev_ring_el_cache;
> >  	}
> > =20
> > -	mhi_cntrl->ring_item_cache =3D kmem_cache_create("mhi_ep_ring_item"=
,
> > -							sizeof(struct mhi_ep_ring_item), 0,
> > -							0, NULL);
> > +	mhi_cntrl->ring_item_cache =3D KMEM_CACHE(mhi_ep_ring_item, 0);
> >  	if (!mhi_cntrl->ev_ring_el_cache) {
> >  		ret =3D -ENOMEM;
> >  		goto err_destroy_tre_buf_cache;
> > --=20
> > 2.39.2
> >=20
> >=20
>=20
> --=20
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
>=20
 Thanks,
	Kunwu.Chan

