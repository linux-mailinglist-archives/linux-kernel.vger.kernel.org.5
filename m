Return-Path: <linux-kernel+bounces-4481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AA0817E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BBE2841A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80207691F;
	Mon, 18 Dec 2023 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="uBEDHZ4G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F2760AF;
	Mon, 18 Dec 2023 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702942018; x=1703546818; i=wahrenst@gmx.net;
	bh=rYispb63UqZXzgy62A/1FZAm7a2jT8FXIlaZMoImlD8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=uBEDHZ4GuwcRnxfRfgCQLm6rape1oB2acFX24XOrfWLYRgF7KmW2R2rOsIbI3/Il
	 KNoxyQRNk9riQc0r8kNKUbRTQfYAphQC4SMkDxSkWHWGj8S1tNf3M+lUKHPwgNP9d
	 6M0S1MuuO2oxao0yYjzD7TZ1hM4lHRsem+fP63O4g+dAdQMBgWrWlvfqqIJwphhD2
	 FlEc8OBu9bJ/6SMf7o5Ai64eUd9omOzHM2PurkYqvftaCti+08QBTp1V+qbzfZHcJ
	 Nmqsy80czTY+b6ycCoL4BRMV2TbDNr7KLDMKMQ/jlFDc4ZMUdS6B+EJpWK9uRBOZe
	 MSLwW7FqHH/FIC3rHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwfWa-1r4hzM2Jly-00y6OX; Tue, 19
 Dec 2023 00:26:58 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 04/12 net-next] qca_7k_common: Drop unnecessary function description
Date: Tue, 19 Dec 2023 00:26:31 +0100
Message-Id: <20231218232639.33327-5-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218232639.33327-1-wahrenst@gmx.net>
References: <20231218232639.33327-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D6RC2f/kUGVv9viHTbJoT47ji2//MytN2OKS75YmlCv1z3Q2VqE
 8ycIVaHgadBzdjOdEDlgG8p1y3X9evJiYcUWxo1k+wGh3D+JXb0MZQZp83aWY45K2alMOj1
 3OaYA2NS+QTHNiBFFsMxMkZcs7ROCKHx8ttQ3wzyM3QCJ+PruSgdRURduXUhYnYitikVTY6
 dp7kTXWyvovWXN/JSAp4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uiX2OlXHdEg=;mLMjz4C3bQ/63Hrk/6nfAhlmsUd
 8qtBB/j9vEFV6qUJCNRfcGA0MqydtyHQH5GcoajE7nbHNpF+B6qYh/rHQmI32/unKW1Bx1O/V
 FLKreI5wueHiBTQXMZXW5VKhqy1kCZ8CwBz6siNlYAT+IysJAlCF78bdw7y9Ky2sX+fjuTZ6N
 R9l6QSPuMMVO1FdKSkyvkHU314i9U7YjDXpWsSgLuybieC6quz+Fe1k6B1wxjmixAcnwwVv1M
 CqxiTU3kyzsfZZdPnc6mqa4rXkeqaOEzaWBU87EPb2vtHKFXBDD4u1XMyj6g0OcxOypYwAqrB
 nnEW1ACjIhgEblFkHy6fb6R/2qEHd7DIk5EAlybd5K5xgpAHLeRT5+I7rfNatR0Ksxk/R7DOc
 BeZEG3rvEm9YT1zz6NbmTK9f/IHX07xjaaU0TcV/LJHQlM621naH5Z1jB/3Rq14lRckqbacJX
 rMMPUvInltB9O/+6f0EMZaVsvd7PwoqQLALfMDRnaa6jOrCYB8c5pa94e4Ny9LkFkxKXt6w/O
 Vp4pj1xzDEUV5PaSINsstpY2+tAoa3vNphn8U0izW6R+DrhOsec3wXOwdXoFf4r97DacvD8xx
 A4UJMZeh6JXGrpeWSxT0NgOSdZ8sWpMClRUbpkF8nZYy/UawmJoLeWIlYSlXYGW4y4iv04dV5
 I2HavE8NGQw61U0jfEYHNp67e92CAH7kbCAjAk5j9MmS2jcOXirOhsEEJrBq5c4BECvSvyd5n
 OCFIdcUtQZZv2tY/1dz/vEDFmGGL+Ymh/A125F0q4+3dKGDCr0kAtNaAt57POFoC8K3USas6p
 ZpFBtx5O3GnZc23d6ue2RshNILGgX1T/4W0qIdgB33oo7A8SfesDclf1C58Lb7F5nqMFaJBDM
 lPr5PE34bIQmgw7bc3YhG+wfA2xEuPhm8pGfVqNZCl2I4A5JRtWNtVpAgpUMrriA36NvGi/cJ
 hme52g==

qcafrm_fsm_decode has the almost the same function description in
qca_7k_common.c. So drop the comment here.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.h b/drivers/net/e=
thernet/qualcomm/qca_7k_common.h
index 928554f11e35..71bdf5d9f8d7 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.h
@@ -128,17 +128,6 @@ static inline void qcafrm_fsm_init_uart(struct qcafrm=
_handle *handle)
 	handle->state =3D handle->init;
 }

-/*   Gather received bytes and try to extract a full Ethernet frame
- *   by following a simple state machine.
- *
- * Return:   QCAFRM_GATHER       No Ethernet frame fully received yet.
- *           QCAFRM_NOHEAD       Header expected but not found.
- *           QCAFRM_INVLEN       QCA7K frame length is invalid
- *           QCAFRM_NOTAIL       Footer expected but not found.
- *           > 0                 Number of byte in the fully received
- *                               Ethernet frame
- */
-
 s32 qcafrm_fsm_decode(struct qcafrm_handle *handle, u8 *buf, u16 buf_len,=
 u8 recv_byte);

 #endif /* _QCA_FRAMING_H */
=2D-
2.34.1


