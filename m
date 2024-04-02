Return-Path: <linux-kernel+bounces-128802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B7E895FBE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71E91C22D3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9954758AA1;
	Tue,  2 Apr 2024 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="WaSfnbwK"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146757876
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097834; cv=none; b=SYxWLphLSRhMshyLmtsQt+EVxZSg60kGncz6eIGoEIprbCA6mb5UbUS3gUtf+D0PxNp6CKAwyvmYeJ8j4g6VmyHKQbNwQ2xL2ke54R33BbzizfvMlj+n/DYnxvb9qGD+h87TUOS2UdyfmG66MLd1G4roqI0GZRxoSl+DvVhqA+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097834; c=relaxed/simple;
	bh=2vj7L4SvO9kgXWMpNZi1sl6xySqYvZYHm1x8CzMj6no=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEfzwYOkpNl9rMUJWoWVzvKXT51tjvNLGjJI5j0XFof+PDqhQ3fDf2EgBsAXrx2g2+VP6Rpncbawcq2BpWvMbJ0tBP8mYxlZxNOAuZ3kJ7ZizUZ5p5ZYP/s15NhGnJ03u/HAUl2BIAZKSeZ169p8p6biPpZqJTHTHYoyFhMmgVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=WaSfnbwK; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1712097826; x=1712357026;
	bh=0FtEGd4MmokinMdwcnnrHLEq9ZEZJcFh+6iVS2zIfJU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WaSfnbwKIFhzpOw66WKqxu7gC/3rrd7iRVDvJGKLqKY7bVIiR8QJGS0fpy2fptwuu
	 pr1W5kFVCbEcVciqQVaR/L3V/qXE2jiFotdujciehOKyQlAdlzUIstDI1OzkiMsi1F
	 0NgxypKbrjykZlS7n18QQD3XEKFAgj2uDGk2gzvgYBvRJFXDi93L8ZmYw1uSEiRqRR
	 f8miPnzcJvhr3o3h/xTMa8BRkkpUjIVyVwJ6TSv9E1Op+4uFdXubrr4vOWo+9NH6mr
	 uA8vd6CycFyyDm1JQ4ZqkjmfeBpN44z5JWqEPlMqm2KnUFVsOvHK5AogArKrQRs7V8
	 Fo4bd5ARcaEHA==
Date: Tue, 02 Apr 2024 22:43:38 +0000
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Nicolas Devos <ndevos-dev@pm.me>
Cc: Nicolas Devos <ndevos-dev@pm.me>
Subject: [PATCH 2/4] gpu/drm: Remove unnecessary braces
Message-ID: <20240402224320.12146-3-ndevos-dev@pm.me>
In-Reply-To: <20240402224320.12146-1-ndevos-dev@pm.me>
References: <20240402224320.12146-1-ndevos-dev@pm.me>
Feedback-ID: 76711691:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This commit fixes following checkpatch warnings:
WARNING: braces {} are not necessary for single statement blocks
WARNING: braces {} are not necessary for any arm of this statement

Signed-off-by: Nicolas Devos <ndevos-dev@pm.me>
---
 drivers/gpu/drm/drm_connector.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connecto=
r.c
index 40350256b1f6..6d8f0fc905f3 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -314,9 +314,8 @@ static int __drm_connector_init(struct drm_device *dev,
 =09=09=09=09   config->tile_property,
 =09=09=09=09   0);
=20
-=09if (drm_core_check_feature(dev, DRIVER_ATOMIC)) {
+=09if (drm_core_check_feature(dev, DRIVER_ATOMIC))
 =09=09drm_object_attach_property(&connector->base, config->prop_crtc_id, 0=
);
-=09}
=20
 =09connector->debugfs_entry =3D NULL;
 out_put_type_id:
@@ -2818,9 +2817,9 @@ int drm_connector_set_obj_prop(struct drm_mode_object=
 *obj,
 =09struct drm_connector *connector =3D obj_to_connector(obj);
=20
 =09/* Do DPMS ourselves */
-=09if (property =3D=3D connector->dev->mode_config.dpms_property) {
+=09if (property =3D=3D connector->dev->mode_config.dpms_property)
 =09=09ret =3D (*connector->funcs->dpms)(connector, (int)value);
-=09} else if (connector->funcs->set_property)
+=09else if (connector->funcs->set_property)
 =09=09ret =3D connector->funcs->set_property(connector, property, value);
=20
 =09if (!ret)
--=20
2.42.0



