Return-Path: <linux-kernel+bounces-128842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF3896062
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B1E1C21D90
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ED01272AC;
	Tue,  2 Apr 2024 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YP2z9cle"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13568626A0;
	Tue,  2 Apr 2024 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101642; cv=none; b=TeLH6YOB0ie1X7bQ5Pe6xddmtJU3gy1UlK0ShKL0shOtwl/zrjVGeFl9MRRrcWmUOax8I3Lb7nNBQUHsfp5TFLY9myvlv2W8Ozyo9QB0QidvW6WAfStEJfeKHSCRM+iYuqLBFoUfCsvoVPr99bj/cYgUoOz0MCU2VuikGmIOn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101642; c=relaxed/simple;
	bh=inPONuplr7+QX+aR/j2SyIqrY1nOT60fhNr/9GgsCcI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CfPNQXSTr0hgRhtaslhpTR3F2jHTsiFl99AAC59vylJwzxF4K7rnIWeC9V1Szek2G0VbNH7U+uVVgIYeCm/z5c3WWGEFdKtZliE4FuRaLFeh5VJvSUXWduMp+t7EaKaMe8u+/XcIX2r1ICilb9niUv3sAjfzEqkmSDA4gd+93oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=YP2z9cle; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712101629;
	bh=O1LoqnEQMcpTdBwdEfgqlvn/fIUNF8+6dsCHnA8sUDY=;
	h=Date:From:To:Cc:Subject:From;
	b=YP2z9clebzpRta9TeoArx28YOxl7Zk8HUM2pUUwcs+eJYNXV+AuoyBfnGY2MNH4K8
	 30fXfu7UAqYqQvweszB5pk2QNAPzdFeaxqNhXP0yAPf8B8NxBm0V3wEYAlnzIt5cJX
	 3e4oA+NGk+/ftjINrI932Mx6FLyh+FuWzYa/2sIRdJtjs+wuY1UTxC8yZiUS5XuCCI
	 H3cJmEpGpiQf9knJ+ALHZxn4jO+qt7f4fVm6C+xhNUh+fdZou8Isvxcwp7xUK9feQz
	 2ctWCVlqUGLlTb0XQaZPhj+GqRbQcwDqe45Igm/P+WiEIMn4Z701ftSA3pF2sUASwb
	 UImA9jwfPBcOw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V8PgK05cdz4wcp;
	Wed,  3 Apr 2024 10:47:08 +1100 (AEDT)
Date: Wed, 3 Apr 2024 10:47:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20240403104705.2ea598ff@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=h/rHpjwY4cM717RH==vH..";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=h/rHpjwY4cM717RH==vH..
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build
(x86_64_allmodconfig) failed like this:

In file included from drivers/gpu/drm/panthor/panthor_fw.c:19:
drivers/gpu/drm/panthor/panthor_fw.c: In function 'panthor_job_irq_suspend':
drivers/gpu/drm/panthor/panthor_device.h:326:13: error: unused variable 'co=
okie' [-Werror=3Dunused-variable]
  326 |         int cookie;                                                =
                             \
      |             ^~~~~~
drivers/gpu/drm/panthor/panthor_fw.c:979:1: note: in expansion of macro 'PA=
NTHOR_IRQ_HANDLER'
  979 | PANTHOR_IRQ_HANDLER(job, JOB, panthor_job_irq_handler);
      | ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/panthor/panthor_fw.c: In function 'panthor_job_irq_resume':
drivers/gpu/drm/panthor/panthor_device.h:336:13: error: unused variable 'co=
okie' [-Werror=3Dunused-variable]
  336 |         int cookie;                                                =
                             \
      |             ^~~~~~
drivers/gpu/drm/panthor/panthor_fw.c:979:1: note: in expansion of macro 'PA=
NTHOR_IRQ_HANDLER'
  979 | PANTHOR_IRQ_HANDLER(job, JOB, panthor_job_irq_handler);
      | ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
In file included from drivers/gpu/drm/panthor/panthor_gpu.c:19:
drivers/gpu/drm/panthor/panthor_gpu.c: In function 'panthor_gpu_irq_suspend=
':
drivers/gpu/drm/panthor/panthor_device.h:326:13: error: unused variable 'co=
okie' [-Werror=3Dunused-variable]
  326 |         int cookie;                                                =
                             \
      |             ^~~~~~
drivers/gpu/drm/panthor/panthor_gpu.c:166:1: note: in expansion of macro 'P=
ANTHOR_IRQ_HANDLER'
  166 | PANTHOR_IRQ_HANDLER(gpu, GPU, panthor_gpu_irq_handler);
      | ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/panthor/panthor_gpu.c: In function 'panthor_gpu_irq_resume':
drivers/gpu/drm/panthor/panthor_device.h:336:13: error: unused variable 'co=
okie' [-Werror=3Dunused-variable]
  336 |         int cookie;                                                =
                             \
      |             ^~~~~~
drivers/gpu/drm/panthor/panthor_gpu.c:166:1: note: in expansion of macro 'P=
ANTHOR_IRQ_HANDLER'
  166 | PANTHOR_IRQ_HANDLER(gpu, GPU, panthor_gpu_irq_handler);
      | ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
In file included from drivers/gpu/drm/panthor/panthor_mmu.c:30:
drivers/gpu/drm/panthor/panthor_mmu.c: In function 'panthor_mmu_irq_suspend=
':
drivers/gpu/drm/panthor/panthor_device.h:326:13: error: unused variable 'co=
okie' [-Werror=3Dunused-variable]
  326 |         int cookie;                                                =
                             \
      |             ^~~~~~
drivers/gpu/drm/panthor/panthor_mmu.c:1689:1: note: in expansion of macro '=
PANTHOR_IRQ_HANDLER'
 1689 | PANTHOR_IRQ_HANDLER(mmu, MMU, panthor_mmu_irq_handler);
      | ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/panthor/panthor_mmu.c: In function 'panthor_mmu_irq_resume':
drivers/gpu/drm/panthor/panthor_device.h:336:13: error: unused variable 'co=
okie' [-Werror=3Dunused-variable]
  336 |         int cookie;                                                =
                             \
      |             ^~~~~~
drivers/gpu/drm/panthor/panthor_mmu.c:1689:1: note: in expansion of macro '=
PANTHOR_IRQ_HANDLER'
 1689 | PANTHOR_IRQ_HANDLER(mmu, MMU, panthor_mmu_irq_handler);
      | ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  962f88b9c916 ("drm/panthor: Drop the dev_enter/exit() sections in _irq_su=
spend/resume()")

I have used the drm-misc tree from next-20240402 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/=h/rHpjwY4cM717RH==vH..
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYMmPkACgkQAVBC80lX
0GxDKAf9G3v6j8SSmsO725iM40aC0aOWHSxf+5dri4sI6wjIhxTIJ7Iy9x6628/n
PErvIk03eZeJSF2AfQEtv2EZhdQLveic/2M0qhzoYe8g+XmPF9Ed64F0WBQNFO7i
/F1RJcTHXDHll83mJroO7yuVFvmidBRhHG7lGUXT9JvHxvImRQZjD4Nw7i4yRN6j
kPgUWf4wEEPVrthJVoRvo0AFI25aCb+d50yye0oBcXgAMMLlJfdCfysn1d6AcOH5
UfK9xzntnUkX9wp8ZONMbnnNsiHj7CiC/OuSndeTzAgZx3MIe7ujiFirRk25P+vp
+BVVTQP4xhDo87Z3k6EKBMvIi3c0ZQ==
=2cUO
-----END PGP SIGNATURE-----

--Sig_/=h/rHpjwY4cM717RH==vH..--

