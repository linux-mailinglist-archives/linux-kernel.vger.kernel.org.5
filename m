Return-Path: <linux-kernel+bounces-11564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0918581E83B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5A01F233C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD684F5F2;
	Tue, 26 Dec 2023 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FCGmIfEi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E94F210;
	Tue, 26 Dec 2023 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703606290; x=1704211090; i=markus.elfring@web.de;
	bh=UsBoPuZPdqnwWrn8IhaxnLaYVK5pnPZrOKNApu8djQA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=FCGmIfEiJPrC8OBQ9kHS5k/aWkC20OdHyG9Je0vmrj+6/Vtue12cVYPQSJYrewj6
	 uSNOaUtB31vmAU7i7pAcLxAWh9zSGBlhGsb+zeG4pZfmPbLkz8xLM79VdVZHU6Dfp
	 sVKvk3m56IRfESXcjbXjfwJ0hzQkwsl6Gnly8ZMT8hperGSwgyJnaHrtkvaZYjer0
	 tuyBYiiyrXxYi1lhE0UZ0a+VVCKycuUXJ2FnWEdVBMW+U2RxFe5FAsiFNGG0HOtSt
	 wOne3iDLl7oZd07khpKMvqJ2+rciTejn+J1SsuhW2mX445ElbY/pwHn02y05Eed10
	 QWfPPra8AeYbAnwjpw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Gga-1r8ZQh3d5e-0109x3; Tue, 26
 Dec 2023 16:58:09 +0100
Message-ID: <85f8004e-f0c9-42d9-8c59-30f1b4e0b89e@web.de>
Date: Tue, 26 Dec 2023 16:58:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] drm/sched: Return an error code only as a constant in
 drm_sched_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <12b3e9cb-3241-40cc-b7a4-43c45b9eedc9@web.de>
In-Reply-To: <12b3e9cb-3241-40cc-b7a4-43c45b9eedc9@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vj7nPubO/RtGZEW4DXmzQkH71f56f8vMzM5kuMez9/zuKsQ8EX4
 K02qYH4QSrdZS5YpEBjlzkaAL8PHX2R8OGLpKOdxwqXU02rFIWtgKSrsHhrIWCbWmX5OxWn
 zRinZwnnZ6PBinF6bxElAAgsaEk/jv7J5lcKGn+WjsPW8LsILG3Yu+opM3fcTVDUfPJCnI3
 r+eYb9cvQ5i04R94niE3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YyuitqbQW/U=;Kfwc98S8YFQzqqgDFSOv1ipPVfx
 2jb0vX4kV9xuSkxnHnDHhvmHuvwvJ5Uv7nPMH4SYE5edYIjosRAf2y+/a5Kdv5qbidquv8Mh6
 PCzTF2ONHNSh7jZTmpgAnsPfRhtv4YYZ1rVZzcrFr/HnMG43TUvVVFPeEeiHZ8v6h0N4hLoN3
 d5otP0tsJLWZmhQl5cNqoDp/0aAWU20oD1o8+xalenJhh7qbsKbbDFgtCKicoF4NLGRmQ88lf
 8Bb6SpyXpd0kN5he+3YO+YEnO8UV3dmz8VWv5SVQphn60jNLIDJS1u6iROic5GptURJyvRpw1
 VPKPbIdyArJvp+Q4jlUOzLIwnTZBJILQjlBP9xalU03XP0CKJxsRMZQRMd3Aq+v9zisDPCjDc
 FisV9VDss6bicviXTra0J+moNy5WO5iMOcd3s/fXcwThXknjb0GomztuZGZbDZFy4zf0Twyon
 5G3cQoCzKuOWeDJuR3Xt5329nYpb1xRDzUsJnJTQprtevTQJ/acvrcmshldKQ5dcHqM06gpEF
 0j+hXqe4rvheMpLOa+LWg6b2Q1vXQSZrm7GZ/BHN44FIvGC4V+SnkdkC8r8H0e9ER58oYb89Y
 s5dtUdavEcP1qCM0+63IqmHokE+SZBK6GQeOA7d/vj0Kg+ks929O2q7gpTIwp6gf1PkDoRF/r
 6Uor71voT+hNFQxF0RM2cMoNdu1u7Lp7imGzH7gaELzR3OGgjLx/xlpGC6EtMfTTEjKTrvPxf
 jorq+JCoOsYUG4Pt2X0uKyZvpzwCkKGLfd+Vuov5ZCd9SliTNF4NrjznvJrx+48nFlJbZYHkL
 CKKMU7o0i/JrKkvOdj4Y3y0AbT30FKXTbw6wOOP3VHs2hj5nhDb1QQefAMPByNqQ7LNddJVqt
 2tZTB70AfK7EbM645fu8ExaSby1N6q8m/xAAEQK7eMp2cpljuKL6IbAk2TqNJdC1ZcQ2e+DcR
 cUsKFw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 16:37:37 +0100

Return an error code without storing it in an intermediate variable.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/scheduler/sched_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sche=
duler/sched_main.c
index b99d4e9ff109..1abbcdf38430 100644
=2D-- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1249,7 +1249,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 		   long timeout, struct workqueue_struct *timeout_wq,
 		   atomic_t *score, const char *name, struct device *dev)
 {
-	int i, ret;
+	int i;

 	sched->ops =3D ops;
 	sched->credit_limit =3D credit_limit;
@@ -1285,7 +1285,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,

 		sched->own_submit_wq =3D true;
 	}
-	ret =3D -ENOMEM;
+
 	sched->sched_rq =3D kmalloc_array(num_rqs, sizeof(*sched->sched_rq),
 					GFP_KERNEL | __GFP_ZERO);
 	if (!sched->sched_rq)
@@ -1321,7 +1321,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	if (sched->own_submit_wq)
 		destroy_workqueue(sched->submit_wq);
 	drm_err(sched, "%s: Failed to setup GPU scheduler--out of memory\n", __f=
unc__);
-	return ret;
+	return -ENOMEM;
 }
 EXPORT_SYMBOL(drm_sched_init);

=2D-
2.43.0


