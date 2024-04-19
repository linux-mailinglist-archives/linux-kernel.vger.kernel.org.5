Return-Path: <linux-kernel+bounces-151413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 820838AAE90
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224041F21E54
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF48563B;
	Fri, 19 Apr 2024 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IN+1b0Hq"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9852AF19;
	Fri, 19 Apr 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530082; cv=none; b=Kar7Bs5c4K7ywat2OoMu+C7cHo3+PhYh/nTSxVoTZw0sahb2Ncx2UO63GjDBRfZ47iRWkFsXvf1hyK8bKtWomdL9DQJTwmhSjhsL6krMwg4PtoZmhXCCzX6OM4ZTiE3uMib7FubuXFxgXxZsYeNnEK7ayzuai6io8ze/S6omCfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530082; c=relaxed/simple;
	bh=VIgd6FGeCZf9jaLppQkadGQw4jn79qXVK2vGUPmwF3M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uViH67sf0oYUB4G33J1iN9gg8MRb/rhlmcpe2WpocgAz9Vp1/i2/Yj9c3xBBFcbuWjCTaueKbBCENxD3X6t/KhNKHZXsDw3Q7IYeeC7MqcnA3piNVhSeaGx3hsbMfKzv5PSCtZGKTYwdHWRgHh0/T0gXcQm8d04vZBJRFweVei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IN+1b0Hq; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713530061; x=1714134861; i=markus.elfring@web.de;
	bh=Og1l6Un11iJf7svz+TfvdUtXC4tcEdS9sUDbHqFgGkY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IN+1b0Hq4uKA3+EVvUYwooAAiHoCEHYeqR4QpMoqk0TVE3A/Vvi/QKYpJVa5kabs
	 gqMj9Kl5Z2khW+cV3zAPcYk9lp6hBg4UMm9kmWujc/CqimyPnYgsV9xKHa3ypJEQH
	 xllfprFCYBXbA/KcjhLkqhtBnX37i1L3YlWr9a4Ukvp1Idc0/3JSWi597N59eYue4
	 uTfHfCm4Sci7pL995ibKyf481jyY/r6IZfbLF+k9ekQAKo4Vgz11j8BYTiSZJ4Ckl
	 DAqtEN7pR4Bte+UzS2o1+7jPGNC1h7ogaeeDcl4VY5IT7yuZ2s4qHDe22FMUfeXhh
	 j04wZa4s5x58ajDylA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdO9E-1sX8CD2R4i-00ZNUv; Fri, 19
 Apr 2024 14:34:21 +0200
Message-ID: <18be23bd-415e-4030-8035-d1f180cdca7a@web.de>
Date: Fri, 19 Apr 2024 14:34:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
 GR-QLogic-Storage-Upstream@marvell.com,
 "James E. J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] scsi: qla2xxx: Use -EIO in qla_get_tmf()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kns3lGbZIKumJguc13YnPSjPdkEeWOeszZgbLH6TiNspZodmKbf
 Xo2eWqi04JI76xeZ76x3LOBb+iXvMbanbL5kP35mAyiWDc/QNUMdAErqiIXfcqraXjzDLAe
 ALHSBfI6qdkMCSYPNt3pQ162ou2lQfQA4O3pI49T1wJhL2gUyQ+W2iBT08tqfEb8H2rcAf2
 E67YpTmKI6AFaA571LHLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SOYbDjhfgj0=;i8TJsSLu3aAwRHvKMPzm03CD5Q8
 LwOKr7LarTYucphEe4H4lDuP7j5qG344SciLPjBQ9i/K01jkhwpiYfQGsbmqOa69Av6UCvr5X
 kevciB7FgsBKZrzlPnnVR3boqnfxt4e16i883xtsJB8W+ebjP7zAK3M4JV0Uo2/k/pIbaweEz
 N7IDNL1cnvItXKUI81qEu2DwAe9WOdp5ZEaYU2Cj+hTc9xS65S+SIZRB1SulCzeVx3FLH1I12
 3ehshxp8yJb3hpONCKRp0HqoMx1Eq/xZJ3t0WdBLAEsCKZNeVVyyNa4f142fU01p4RPtM4vMf
 U2xT3mL8T1bj0yGGA6j3c5i2Qe4nysHiPrD9LsnnUxS0FCaWFUpJ3CuyUKMV1MRIxgMOamKvo
 eEsUn7CA07wxBDEdneeM5FgXmm78t2cchBisEjfgXzy2lOdW8inMcW8/sW7xLA1WyoUO1vti0
 0bkjnUM4MHhbtMvstLoUIfrhZ2MwhRh68txTiokoSeUPE16XmvH0G+KKgbldNO0wocEvjh9MX
 7IFxo0S1wjtaexBBBZGMt4JaPbMwZip6CJwojnpf1jn0HRSE0Jo0Fx+miGiz+ZUqkbOAKHnst
 JVpPtr2ET9iatxg3DxuLjmgwsQ9T8OBfCr/Svl3gqMC2/bbgDv2Ink3oJUhZjlvv+yu/Qs0ls
 3K5r999ju1wF1tfwCP8eOuFwrhpX3wLznWvq7nb6WTDfrM9l7ELMgOQMcObbHybcqp3qw7p7I
 B75nWogk88Kzq/bkTubecdbLg68MQq+8XyF0s8I1Qd+pj8knAXmYwtpu1fpOmQgj1G8b860NP
 dfiT7f6uNBdrzXSoZFNgoo9KuGeVwv/DiHY1LoKo1dBUc=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 19 Apr 2024 14:24:56 +0200

Add a minus sign before the error code =E2=80=9CEIO=E2=80=9D
so that a negative value will eventually be returned
as in another error case.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/scsi/qla2xxx/qla_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_in=
it.c
index 8377624d76c9..8d93d9631ba3 100644
=2D-- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2281,7 +2281,7 @@ int qla_get_tmf(struct tmf_arg *arg)
 		if (TMF_NOT_READY(fcport)) {
 			ql_log(ql_log_warn, vha, 0x802c,
 			    "Unable to acquire TM resource due to disruption.\n");
-			rc =3D EIO;
+			rc =3D -EIO;
 			break;
 		}
 		if (ha->active_tmf < MAX_ACTIVE_TMF &&
=2D-
2.44.0


