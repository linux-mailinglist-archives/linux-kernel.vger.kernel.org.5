Return-Path: <linux-kernel+bounces-68276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1384A857819
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F25B2170C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5BA1A58E;
	Fri, 16 Feb 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="VSUNIuQt"
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5B18645
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073604; cv=none; b=L07XyXUEJZMgicK7Ky+Ag3ugnCR0564+Ts+eN96hvuYT58oGLpiriBqnA/7WjdZS4kdckpPw9kbkt5SCu+Ly2Fxki5TVGYorJTKqSyJCi/MFGy6Xq34ZqxKLuEZuX8cnJC80VcNopB+8WFTpY79uBAHDlKBnma3RaHN/PBkevVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073604; c=relaxed/simple;
	bh=WE3KdkX5VByr254yAyjqsfNttYARg0lCDLNK9YrlFKs=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=NBKTpmSQm6ayrFpU/H0h7y0hRo6Kb8P11hsIt6qAppD27Hy36O/zYSLeQVzPgQMYLy0j4HvdHHeDm4CU9/OFbDrAMkqxB7eG5r2pJKlakXFCyoaYrX4jZWHUX8oybtBOXqphYVJEY4lX9yBA9UzNaXYZj8pbn08z59DPAJn69As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=VSUNIuQt; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 4C017A4D;
	Fri, 16 Feb 2024 09:47:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1708073254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=fR39o00YViWIydM7bubGunhhqgptLPWAjHHTwJdFOds=;
	b=VSUNIuQtKG5mBOy/qRCA0dUIHc+yENa/6AhSz6KczbjA+IAIr8wxm9EtcnDg61uHqiw3Uv
	HUNCPceY7/LpoSipR8VrFuXRWvpO63c8qVvyzOfpdOzSylOe689CU7zv7Hu4kVjZUFUys7
	+BrIhjVj0i1PmKpA2dOJZnJDEBbWwzEpsjH/02+kjsSDAukuUVKosJz++HBgC1Tx1heiWa
	tNSgrhyROhCR2VPj8/OtWgurmRB8IgsXI3EPVsi0utRjmoH+tkTT0suyJYuc37RvFGeJuU
	KrwWfXOtim4QYzTqP9eDT5t/mkIqnSMFyqXuDIVBIbjVfmCsQGzqPjYGf3COMA==
Content-Type: multipart/signed;
 boundary=52ba317e8c7c5ca537a8d63e6ea42f83f0a58640d2bb4d9412e895a495f2;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 16 Feb 2024 09:47:27 +0100
Message-Id: <CZ6DFL6061FS.2WMDPMSSBXX8S@walle.cc>
Cc: <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>
From: "Michael Walle" <michael@walle.cc>
To: "Marco Felsch" <m.felsch@pengutronix.de>,
 <srinivas.kandagatla@linaro.org>, <gregkh@linuxfoundation.org>,
 <miquel.raynal@bootlin.com>, <rafal@milecki.pl>
Subject: Re: [RFC PATCH] nvmem: core: add sysfs cell write support
X-Mailer: aerc 0.16.0
References: <20240215211401.1201004-1-m.felsch@pengutronix.de>
In-Reply-To: <20240215211401.1201004-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--52ba317e8c7c5ca537a8d63e6ea42f83f0a58640d2bb4d9412e895a495f2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Feb 15, 2024 at 10:14 PM CET, Marco Felsch wrote:
> @@ -432,6 +466,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_de=
vice *nvmem)
>  	struct bin_attribute **cells_attrs, *attrs;
>  	struct nvmem_cell_entry *entry;
>  	unsigned int ncells =3D 0, i =3D 0;
> +	umode_t mode;
>  	int ret =3D 0;
> =20
>  	mutex_lock(&nvmem_mutex);
> @@ -456,15 +491,18 @@ static int nvmem_populate_sysfs_cells(struct nvmem_=
device *nvmem)
>  		goto unlock_mutex;
>  	}
> =20
> +	mode =3D nvmem_bin_attr_get_umode(nvmem);
> +
>  	/* Initialize each attribute to take the name and size of the cell */
>  	list_for_each_entry(entry, &nvmem->cells, node) {
>  		sysfs_bin_attr_init(&attrs[i]);
>  		attrs[i].attr.name =3D devm_kasprintf(&nvmem->dev, GFP_KERNEL,
>  						    "%s@%x", entry->name,
>  						    entry->offset);
> -		attrs[i].attr.mode =3D 0444;

cells are not writable if there is a read post process hook, see
__nvmem_cell_entry_write().

if (entry->read_post_processing)
	mode &=3D ~0222;

-michael

--52ba317e8c7c5ca537a8d63e6ea42f83f0a58640d2bb4d9412e895a495f2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYIAC8WIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZc8hHxEcbWljaGFlbEB3
YWxsZS5jYwAKCRDNyh2jtWxG+8eBAQDGYo2DtOKLuL0CsiuJCDK03JOD16/qs+uF
gwFEDQ6wUQEA3o3jofN51UHHDYz/EMyPvP6IRxGvCx7djrUXzzdHGgk=
=dSaw
-----END PGP SIGNATURE-----

--52ba317e8c7c5ca537a8d63e6ea42f83f0a58640d2bb4d9412e895a495f2--

