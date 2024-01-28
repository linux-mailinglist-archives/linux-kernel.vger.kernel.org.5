Return-Path: <linux-kernel+bounces-41933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC8983F9BC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C78B1F21B8B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626145977;
	Sun, 28 Jan 2024 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="pLkrkDb8"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F23C699;
	Sun, 28 Jan 2024 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472697; cv=none; b=P6lFeD5g+e60jSkOpo0SBaK2cYQgrn5K6xTg99AEHDvLb5cGiyH5o0ExNv92JTa4Yg9gjWVTBujO38DjufDOXUux6Yb628AtXtVlVkDrYIZ2yix88aDTRyGLmG/DdWwXtufT6RJ46K3yYbvE/Nj4xs5JkurWLI93dtCjUhbIhd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472697; c=relaxed/simple;
	bh=s+C5yRBMXtAg248/XAUH77adEcGlMjvS8LegdnUr0Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dOm5hMuo+dm2I8Uq92uwNsfcCJCibyPvLwmE0KO+d1L2NNd19ZXfMz1FS2zwljN3fk6QUOWd/RQSngn6SAtIK2HwRPCM962aOjY7+B2Y7gVDLCxqoauc7Fc2DXnRB0ytwFK8ZRbtK2oh2fa8etsrsqkRpQpzFhex8hLPXAvA2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=pLkrkDb8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472681; x=1707077481; i=wahrenst@gmx.net;
	bh=s+C5yRBMXtAg248/XAUH77adEcGlMjvS8LegdnUr0Qo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=pLkrkDb8Jc0oAEY/WseIA4TLBNGf30xJw/u4CC+fRPlzt1/fJzD2c4y6+ZMplQ25
	 vBOUqsMtmlqBIcdMGU1y6SURcI5UjkS8BS2D442A0CKluurpfjQbmwxvrX91DDBm4
	 xjXV+YgNwQmJzsb1kZnZShoajGiBDSx1VdZQld9QB+t/ATDD6C/yadGZSVNanf9Gt
	 Jitwoo6HvNiye8+awaRen+bLnm88m/v49ex0We912fyhbyjirzJQaw3MO5Ou4vamu
	 xEVS6y2YIW3jvRzpq9LL991qDmBGhQfn0CjykBvk7pWD/oYGttDd5UXhpEbjinrXZ
	 dD6/+CFbMS0zTTxU+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwfWU-1r9lAZ2Vxa-00y9Dk; Sun, 28
 Jan 2024 21:11:21 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH V4 06/15 net-next] qca_7k_common: Drop unused len from qcafrm_handle
Date: Sun, 28 Jan 2024 21:10:50 +0100
Message-Id: <20240128201059.6259-7-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128201059.6259-1-wahrenst@gmx.net>
References: <20240128201059.6259-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E/sFtk9/uq2rtDnmVUG7YxQ1S/BpIZ31n091PvTo2DhEWfYuLie
 ThSN5Ix4JmtqDH9NtKKFZYeqY4ONhhmzWfT/C+XB1zmQsbXDlXRLRAQ6XoYi6PcMLO/vvXT
 EEG1wMdvopt3/z3l81wj7qqyf1Eeo6SqdIMCRgTCKFX2kv7iWB2IhPM1mIMdRd1Ya+cQ3a2
 mfW6J8YVhSSyO7mqQ+ihA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AWUveRcSymQ=;oKLwGwV5/z4+29d4ar82OFldb8K
 IalBExTsPAA7TFEwSPRWrTzUj8Gnqqbh5pt6eo+qh54LGKPCTg7VHte3/1Fo3ERH1faXjAxx6
 JVR5kiOsWxgiFEH28UitDjiC7UcbdSnfKVCwJswv53qw+oFJPekriRz4UJwxOJId8vXI6dtye
 OiBEkG5DgraAeMpCLkjMFdZq8JfQJBHP0U/cDCEGSNlt7prXU/5LTM2snLPrQ2KmUsOIl5NfN
 Sd2I9iVv5rUhVE1uIaGszPJk+gOxm/ojq+aq0OYta1uYZ8NIHmJfysBFLrhjf4q5rBNTRXgre
 SdviqLOBOi+oNiqAhsCZIAzqJccJBTL/HNiKvNCviZtuNbt7a6JpJRIn9D2vAHfhvMqhBS+oO
 WHvsjillpmt2n4DKjt8h/8xUVL1q4gDt6bqMg+Q/ovHkPu1zAosG4kwYEiJDEzIEjZ1ouZt2Q
 qAfv24zKxYUGVr3/dGdDgGffzXI3L/dSxHKS4V4iiO11e7+fXE3u3bu+TCMO2WKLbGC3ZWkRd
 c865q/yvk/iAn/xRTIrGUM26DSdV0VBvWgG9jVfbsZ5LIuwKqBHUrT4QUj19EkMRSNWuh2AkE
 1SyN+75YjdvNZYf9C0BGv/RKQAx4pJUWTTEe3JM7vfW7bjW6kuAESfeiJuv8eTRsp60L0Pgop
 t+lo7wFaz8qsFksY542Go48mfEbL2rFG573Xc2aOV3zJtKZtp8fkhk+iO6Pjti9HoQYTAtY44
 j5KvGO+7CHg0/Tn8G05P4Xd21imSxJDqSBot5ojMENZfRzSEa8cYBF47nECKFXBOsAiL3iCIK
 v3LeoNy5oFify3A1URfK8A43UXhIjQRVKyY3fX7Dcl6C8HDduU9tD0ud34hIhk9TmeEBflp43
 YH+u0mbNUZzOVpyQc1h8QS/aHPcPc/ThIkTxwrsaP58GPnes9v5t2qanXubWcE2JbIc2SwVB8
 hYlxVw==

This member is never used. So drop it.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.h b/drivers/net/e=
thernet/qualcomm/qca_7k_common.h
index 71bdf5d9f8d7..088cca7f61db 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.h
@@ -107,9 +107,6 @@ struct qcafrm_handle {

 	/* Offset in buffer (borrowed for length too) */
 	u16 offset;
-
-	/* Frame length as kept by this module */
-	u16 len;
 };

 u16 qcafrm_create_header(u8 *buf, u16 len);
=2D-
2.34.1


