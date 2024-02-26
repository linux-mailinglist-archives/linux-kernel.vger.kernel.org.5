Return-Path: <linux-kernel+bounces-82297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE43386820A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6671F2313E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB39131746;
	Mon, 26 Feb 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="eJKJaNiO"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AD8199B8;
	Mon, 26 Feb 2024 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980148; cv=none; b=NPNg+zbXh5yKPiXRC9R2R73EgYuvQbKwe118oFEjxZ/HIU3yX1k6iyoHR2Cy7Z7Z8syaRx1yF00+hgnpcxKBVRAsVF0jUEMHq2QNk+HAAtNgviyZ3FMt2Z08S/q+wxaagOBtc5BWiGKGc6j9a6DjQhCNbi8CipHB8NzOwfU1RA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980148; c=relaxed/simple;
	bh=f2j+Sd5wJcy3Yy1n0NkWtL6bNbfHHQrqDFOhVY0x1k8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZbFTHKw1VTUJA+BYeYEbT4UDtIufw7Dky+MmgW4PA/c0JPMeDyr2owfDKvCdafOezTqkVSCh8ta1p8nOalCDy283yZdymqNMNDP/Ie1NTtmUCXfclMAhBhEf5WeK33DNi+u54Bk4qP3F0SzCtG8qr+HjAn/bjmmzlbtbDdUIXAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=eJKJaNiO; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4TkCGn1mkXzDqW9;
	Mon, 26 Feb 2024 20:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1708980145; bh=f2j+Sd5wJcy3Yy1n0NkWtL6bNbfHHQrqDFOhVY0x1k8=;
	h=From:Date:Subject:To:Cc:From;
	b=eJKJaNiOEN9yQrggyt8qHJPDQBSeGfSeu+XmODTsDxvhyE+cJeaJFHA6SBX99rUUp
	 SOGaGwDpB1o1yEQENJXM38tn5foDMlQy0cr3VJ5fCEtcwXnl/VzZCyrqOmY04xjCy6
	 FxNkvHjZ1QPrjIszOMkpTRGHaHRUMvAkcV4V8f/I=
X-Riseup-User-ID: 5C435D2CB39E271D201AEA1B972B596A08179232E5392308FFFB717330863423
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4TkCGh2RgTzJn68;
	Mon, 26 Feb 2024 20:42:19 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Mon, 26 Feb 2024 17:42:11 -0300
Subject: [PATCH] drm/vkms: Add information on how to benchmark
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-bench-vkms-v1-1-515ef91b11c8@riseup.net>
X-B4-Tracking: v=1; b=H4sIAKL33GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyMz3aTUvOQM3bLs3GJd0ySLJPPExCQjU9NUJaCGgqLUtMwKsGHRsbW
 1AGPd0U9cAAAA
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arthur Grillo <arthurgrillo@riseup.net>

Now that we have a defined benchmark for testing the driver, add
documentation on how to run it.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 Documentation/gpu/vkms.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index ba04ac7c2167..6d07f79f77ff 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -89,6 +89,12 @@ You can also run subtests if you do not want to run the entire test::
   sudo ./build/tests/kms_flip --run-subtest basic-plain-flip --device "sys:/sys/devices/platform/vkms"
   sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_flip --run-subtest basic-plain-flip
 
+If you are developing features that may affect performance, you can run the kms_fb_stress
+benchmark::
+
+  sudo ./build/benchmarks/kms_fb_stress --device "sys:/sys/devices/platform/vkms"
+  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/benchmarks/kms_fb_stress
+
 TODO
 ====
 

---
base-commit: eeb8e8d9f124f279e80ae679f4ba6e822ce4f95f
change-id: 20240226-bench-vkms-5b8b7aab255e

Best regards,
-- 
Arthur Grillo <arthurgrillo@riseup.net>


