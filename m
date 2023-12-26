Return-Path: <linux-kernel+bounces-11555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AD381E82A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3BEBB21F20
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2F44F5E6;
	Tue, 26 Dec 2023 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jyuaWvs7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A091B4F210;
	Tue, 26 Dec 2023 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703606055; x=1704210855; i=markus.elfring@web.de;
	bh=CqUJd5RIIJKCSzBgNfve9F6+tVJsVgjVa3IJQgjQIYk=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=jyuaWvs7kl/orRAaXmBavd7ZWEUjrUPiBzRAdNzOi5+kkIRPBXCzLa8TtpmuKqHW
	 pWSfHVy79UJzhdQKuo8i2By1NbjO5yzN23R6otgCU03zUqeH+0Ajlb6HTchMsLn6A
	 rNl46ekm1pQ/TX5oTQ4J8yHVn1swNC9pmZ2o5DJFyRIQnV2oULl8+QaTpYqQOzfB+
	 9nokJX6oGLny6FP4Ix7qhmffC6CA39oSX8+2NKVw02jjsd29Aw4lJvHidUF89/vkS
	 KDAsgZxkVXfZgdB+RRAp/knjAO2rR7qjmklOqF+8DnyZm0P9/aJAXrifYKpZvuB6A
	 RjyX5BjX7dFGrseejg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMGuC-1raEL32Nvi-00JQqP; Tue, 26
 Dec 2023 16:54:15 +0100
Message-ID: <12b3e9cb-3241-40cc-b7a4-43c45b9eedc9@web.de>
Date: Tue, 26 Dec 2023 16:54:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] drm/sched: Adjustments for drm_sched_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5jqictNmemXsoho2KQ9xaqACp/mEdtmanumDIspEEQZ3A8n+v6X
 7UCTt+Xz3y5vOIU1kzIsUBK/jllN/W6VuXUAcF9kZLoLBppfIM9hN4qtH9FbGaZovPePNt9
 SblB9leG8gRs1OhXqk/dtAClQz/8l2KRC8VpSnmC6YGaqL7DZsdtZctYFcRJyH9MgckFtcu
 udWUBOnzVHqdfhotq0xDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IyoyNYxZGRw=;EspgbdmU/SfrRwagWhiRYJrGEOv
 jf+aUEPc30EgVxnjKOYnLC1VUxI/IR1zGnvj5UsOs9NmpzfB6PUNiDniUDoLNDVbu1qovC7nm
 Ktr809LRCrOciwqQlOwnlvE78V57jA3a9lu0ilFXe9QZ0b1eeHQldfeBMaLiECmK9INVDQ1k8
 FRicbVKt/anbPfXglt68+XRDQ2eUVb7FwVqla1qcQY92bqGLRq2NfbzZxvnBF5O6uMeg5+T3V
 pvqg0vPF0g3p8wmmmLc3NDug7wDu3IisNr1FDqrkqI95gmyJNZoNQmyVxdhFqVgkTcreGRd9r
 cYpRy+DkAJ35lBHiCm0D0UQB9/d6pCll3VlGDLo/cyrSWaVZVWfUPS+3FbfiJra79t9yedgI5
 LfWNSePf5Yon8+3RyKCxOmzdoLP3IedxMlGsX2JVXk/7XkHl7534r3rMKi6brCB3OJgKt/Nft
 oOPA7UPCEc8pbf9zfztCovL1Pi/MPDs9IaWNvUEej8uez/yJQALMtSRutW8zUoy8RpXbCu2tS
 5QfxVB8VSfevn6Wtb38W03fgv6sXa/5WjgWKj7YUvUG1tEn19FVUjsi/gko1P5Bqtz+ogZ5cs
 3Gwlxp1KcbRpBR3dice4xC7TUchhcV6fbS/10SpIopOS9maKu5BhRS426wU4UaTbMecNPNzEE
 4C7kHLHx7SPt9lapNSA9pbqU6iRrNjpsZTvns0YTS5cWBDEyE3M2zU3jn6M+/OKrOmYX2l05N
 37EPeoTFJupAvk/bRIGWoqnt+KA1LmMOWIYownOadD/n9sfrcZUCFAX5uzhqTDuvD89RorQPn
 ksD1V5sYaqQfP2oHdZlz5Uf9Y9CwGiPmzSS3lqzRbiLMdq1Bt9RGQeYJ5PcLczbnx8XmcZbzg
 4mSOuiH3MNj2wcKWQjux7UkRdn5OmzrHcLHiiXCVjJ6DPE3aPmhDi4VJtX8srx97GqS4aicHr
 9o6rMA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 16:48:48 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  One function call less after error detection
  Return an error code only as a constant

 drivers/gpu/drm/scheduler/sched_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

=2D-
2.43.0


