Return-Path: <linux-kernel+bounces-11658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED4C81E97E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FD8283450
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B96823C9;
	Tue, 26 Dec 2023 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fBOhzl+r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF6F5221;
	Tue, 26 Dec 2023 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703619819; x=1704224619; i=markus.elfring@web.de;
	bh=kfUrqzz13/SvRJXYn0ERTOI/fh6ulUnX5zFEb1O64Js=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=fBOhzl+rNglrGfAE5U6T/gr7Mcos5BQiia4AiECPLcFxE5boaMpuyvWYg3qXNQo/
	 adlFWcdh/FSb/vR2Lg86/GKHSvAeI0wB1SMZnRyzYwEjw8mm9+EF+uoYyCG5Lofj4
	 fSA+bPafsWBoR2IAZMCUkko4/1aIarO7bKMcqt0NauJmCDebcE2coRytaIVfESeG1
	 KIPMJ51KyTOtB+DUwHSoA5l1uFG/JQfX8Grt5PxKx6zmONmVYO5Bnlut13dYffHsC
	 f+syDNPaKXK/iMN/bEy473NZsaJXd12tdW08Ik3jwGaNLwkaRLg/4vf2qb49tq105
	 q5lVTJXlS4hLCVV/rw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhFlo-1qn1SL0xuM-00eWrU; Tue, 26
 Dec 2023 20:43:39 +0100
Message-ID: <5088a905-4f29-41d3-a96e-5b66aad551f1@web.de>
Date: Tue, 26 Dec 2023 20:43:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Henrik Rydberg <rydberg@bitmath.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] Input: MT - Return directly after a failed kzalloc() in
 input_mt_init_slots()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a8q13dW4fWVw2Hjfg84VQkwXU+SMTB/VfKaMZFUi+rSbfT92EII
 2KooLkW2Dt1N9cTE4m8DJ1HBbo4D5rqf0iDdRWR8KpJTnq59BWm8uAfCr2a/hZJHirCNjXJ
 4l9HsAHIOoSz2pE9twVSlBijktomx1LJ3hXmLqLS8OoA7gXYLMDQVJwWKL97573cEZNpkMW
 RxqfNn9aqV3fQjdpHC7Cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8pD2t0jv3V0=;6PXCgp1FFSxhp3Tffor/temmFSg
 895atRLT+C3nCeMjM3n1oRHwvgFOcktzBWruWZEu5ZsGaxTbuyYtv2rGGKUslWmPgpexSpWL+
 wXULaZMfngAAw6HlTtXgX2N5PgaFtL8hImDr+fnVQYlQ4bArZqprAJXtrpUs5COQSHWfqlIva
 WVUP2Hlo+soijfzzP4Hxi2N6rZXmYYzQIpcHjVSuKcb//ryfLvy2dFeibU1YzAIR6OdRMWVIw
 PScT4n1dy7v+uoIjO2a78SPpJoAkmvKE1JkEPkaqunOmP+PJ3N5SpicZt172/MbIArELY5MB3
 Fxffx5qL8ripKt3ZHJ0NuqUlUR59TnNpeHEwW/NBIK34glXJ0KrIYPCkaxt5uvf2L0ZQXsn5B
 Tis9pVoqRq2nCMZKCEf/zikkeGZEG5pVPgmAyel3u9zK5UTQJGzbTNqGaUM+2VrU8k5/QgAaK
 O1veTuapZJuIYZY/J7GM1Sy3jVVDjfpp9LX9/6w8KZsxuQqgH/aSDOIVh3feJqPcm2Jse6RxD
 hBaK3Y0igDbFy82DRMlqZ+4Bsm0Ky7c3aIQEsz9xfVnAjr1i1Xj0ZvmW21RVlExwVYfjteYln
 DmbvanRgUBMVtAllhsVg45iKkkZDMX4EOtGd2Y3IetOoGMxxuuG7xeMCNShOEd01tWQ85vmv7
 bWRPB9vH5o2o6rsp0q56uXa5kpUaYRPIa2HGQtR3x5Ak7M+thOfifL9PXQyhvh4OaGwh903wH
 ePem5rBifH6vYxAzwSljTbLR/EmbhLaBPmqqdS7EG796xRTBswHFa6B07v91Q5vScFOZpOS5c
 Efd7dLd25gd4f8vambmPhJEErXnP5NdACQ+/a9LO97qNdgNhXmmFXij6tTAuybNdxbNkIF/tM
 XmyBK/Oln1d3IMon2CHHb9avCOFZWG7dXOIArCyAhV2ZUFTDSVXVVgiGYTF1+6ldsB3Tz7C6i
 uPK6oA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 20:36:09 +0100

The kfree() function was called in one case by
the input_mt_init_slots() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/input/input-mt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index 14b53dac1253..24064447d600 100644
=2D-- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -49,7 +49,7 @@ int input_mt_init_slots(struct input_dev *dev, unsigned =
int num_slots,

 	mt =3D kzalloc(struct_size(mt, slots, num_slots), GFP_KERNEL);
 	if (!mt)
-		goto err_mem;
+		return -ENOMEM;

 	mt->num_slots =3D num_slots;
 	mt->flags =3D flags;
=2D-
2.43.0


