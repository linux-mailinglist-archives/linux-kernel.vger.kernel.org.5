Return-Path: <linux-kernel+bounces-31793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9B8833411
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67268B21DF5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E57E558;
	Sat, 20 Jan 2024 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="XT6kwkA0"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB913DF46;
	Sat, 20 Jan 2024 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705753357; cv=none; b=mqNVp4IMUpzWTK4bJnt0Fjz73tluf11JD0h7haHko92lPqwk0YRL0MwX4WrO+gqv/u6vmCifJoVse7+UXtnZyqIoYRRHyUSMr6R9unkIptC8awEfyBUny3PxOtuYClQ/cxvjYQfDrOI1BLfL+ktyuAyZXIrlU27LLZrv1eZL+X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705753357; c=relaxed/simple;
	bh=9YDEUzKhTgngX2Z0iAq+z3tHuTcCnH42aT3kTNk1/bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fO1hI04yXQM1iaEnxeaiDtf7vp7kFqOWTdjc0xy2QSIMDsuHJTpr3q3o2Y0Mxh6/PPB8VJ2N8DnP5tr0c9M1Lb77EIVBgmzMyxRx12D2seIio1Q9x0vs36h7hQvfrL+NLDsrtXeY0kMGeJjxyuS4v7DcIh0oSDLBLFpl1CuCwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=XT6kwkA0; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705753339; x=1706358139; i=erick.archer@gmx.com;
	bh=9YDEUzKhTgngX2Z0iAq+z3tHuTcCnH42aT3kTNk1/bc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=XT6kwkA0PE4Tpu0v0Vw04kApyR5BDjRJolmWh6T7rr0mY14wECU9CP3YnL0/jNy/
	 oOrpChMGpjlTsMFhxcilGJjhQUlS+Pm0TGj0kpWQh2QkVRvaKvMZLGh3qWJwW811l
	 Em2hNrJhjP2cmwhA9YGGFqyLnQlAmEFIYyYEYav/gBBf7IywS2vJWp+ipeQ9fjkEh
	 F4KKmaXw5s41KXkgwDBzMqKhBbhXftvtHXbc4L+PLY1Uoq0sWmSZyq9i+EGWkIV+u
	 O1S9vZjbx2CKgzldYG7GwyRe9xrCEQJh7pDTLftQOpiPdIa5k10DmKJtNbSNCF+Dz
	 57g7sHbY8VVWJY0VFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MA7GM-1rFZVB1eAc-00BdHt; Sat, 20 Jan 2024 13:22:19 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] docs/zh_CN/power: Use kcalloc() instead of kzalloc()
Date: Sat, 20 Jan 2024 13:22:04 +0100
Message-Id: <20240120122204.4287-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uvAMfo3WjxMA7hh2WCPD17d33xXJqS6azul4AHtLOu6zMVtuVZA
 7x60pap4O16Xd0QCb1NduUWtdD39wAv3pCFKatdFoSqj/SFR6S3vRVjrDGWYeloeWtqApR3
 PwPJ/Q1oqc0pTT4mAhoWP1Cc/sHEwpyFnKbU/LqNz864WLUnzTnQmB7MUkcZ+2kxuFISbPt
 anlLMtB8FGOoSnwxe5b8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h4GQL3qBzEs=;19EFmJ6zyvHSwjYb2PMIt9/mk0J
 BUUJ+byVWqUwvJAwrNp2wncC7pkWgOt+yXkiz8N4Ul9IhulpvN3eP8BEAHI86w3FuXo9f18d6
 wY6gcjRUTISNPgRYT2+22QRXkQZhMGtfEy57QkilIdikwnr8xVd9ZPGRZAy4UQ5XrhwaarOFe
 QZjzt5Doh7Zly1UZRCre/bDcAEAsalm5mmKT7uogzSwtxuUhzzdnlZ9Egc50RxeLqEQt/81Jc
 YohJYA0guKsWg1NJEZHv+EOneGb/s3oLjAFPVoPW77+7AG53OE17uWITTGQ6g+lz1FTl4r5Cn
 m/T/jGkjN+R2cV44LsmhsHDN1Tj++t6sZxvzFMSCS0kdlzG08IFpCS94V0y5MP/+1cEUm+Gc9
 UUDuc41siqt2NPHr8SB0rtGJtFdRZAR3/+1TcXKLQTNSsf5PKwmVm9Wr2GeOO8EZkGxf1qK9I
 xvD3FSJ9+ewZhxec7UjsuZbaDD4P5Aj/rVFbJYlPh/jALLM+ZpVIh/6TjeoomR+0wEz7hRJVL
 R6PhNvIYi+aDIyb335FBIA9rgi1Tq8d28BZRYNAVCmXRlX6E+iRGDocy4kJOxzOAwsL8wUGmd
 rQc99+DDOFnTUN7A8IoQ6Cpx9i/lpReH6/PikIzBcI8cz0qC1Z5Q9o8MKxkHzLIKZHNvdHUrt
 Ea1ZrBc6qrgFy0Hd4v45OUWMiAyZlECQOrNq/Uo9JmuN2i6ip98/kS/kIgHmaDoJf2ZcbUGge
 ZxXO7eIQslMkXwA0fydgEMJ1Hb1XL/mjPc1c5jxjyAWSrsldI5819eZCfUQaHdncLX3HiV4uv
 FVaZHykPmpGrVDErW1OrGX5/Metty6WrdKZJ0+N/COLekb6DhFDif8MMFMoHy/3++jE20xbQe
 GhPPainmvySlwSxFnU5LwTUzC7IXcsa+fmjP25hBo/VZvQv7Wc5lOkQ96dHW6Vjp6VKAQVn3F
 jj/a5EYl2w7XeKqCkzAZX8k5+m8=

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, in the example code use the purpose specific kcalloc() function
instead of the argument size * count in the kzalloc() function.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 Documentation/translations/zh_CN/power/opp.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/power/opp.rst b/Documentatio=
n/translations/zh_CN/power/opp.rst
index 8d6e3f6f6202..7470fa2d4c43 100644
=2D-- a/Documentation/translations/zh_CN/power/opp.rst
+++ b/Documentation/translations/zh_CN/power/opp.rst
@@ -274,7 +274,7 @@ dev_pm_opp_get_opp_count
 	 {
 		/* =E5=81=9A=E4=B8=80=E4=BA=9B=E4=BA=8B=E6=83=85 */
 		num_available =3D dev_pm_opp_get_opp_count(dev);
-		speeds =3D kzalloc(sizeof(u32) * num_available, GFP_KERNEL);
+		speeds =3D kcalloc(num_available, sizeof(u32), GFP_KERNEL);
 		/* =E6=8C=89=E5=8D=87=E5=BA=8F=E5=A1=AB=E5=85=85=E8=A1=A8 */
 		freq =3D 0;
 		while (!IS_ERR(opp =3D dev_pm_opp_find_freq_ceil(dev, &freq))) {
=2D-
2.25.1


