Return-Path: <linux-kernel+bounces-4489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312DB817E22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53CE281ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB7A7EFAE;
	Mon, 18 Dec 2023 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="YK9vvx2O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5010768E5;
	Mon, 18 Dec 2023 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702942019; x=1703546819; i=wahrenst@gmx.net;
	bh=pMOm0QZ3NBUI5Myevq+RLLh5bsvVZgcSKMIaZJHXflY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=YK9vvx2Ooekz6IUX9Qyh3JQLgppfBNnB1lvACzVPehU3hS9VGVX6ToDxJ04yQ63T
	 kbmsGiwGt+huXuqFLIAQAhwF7IyVD2ge/Ytvb1Atv0BIiHcrS9TJ7F1Wjg/AJqILQ
	 J9ZAIGkS32qdT8pda7bSYEEsLLHZUY+rZKegpJ+Dbpu377bUdfogMP22VFut/ZrQU
	 9fpRCSCCqpktGJBiqo0JHdhcjcMN0oOnQFqomH6pqaMFlEtBKxSTx8VTjjvr6fofg
	 9CuMYIzm/5mLVc4K6VRhDMGYTUETXJ+bT7xk/gsgI9yLbK09qxHSvqabWdNeluxrM
	 4tSkmDj9FLqizE0bOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1qmcuI3gjY-00g1JT; Tue, 19
 Dec 2023 00:26:59 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 05/12 net-next] qca_7k_common: Drop unused len from qcafrm_handle
Date: Tue, 19 Dec 2023 00:26:32 +0100
Message-Id: <20231218232639.33327-6-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:XkLNZ/EhM3P0+pfDc1E+jDqkkHrWUpS8R/cnMD2uXSFhyl+XIsV
 bB22bq6x6DrwjKCYzlFgV0Sm+Fdsn2Q1QJN+kIy7kvKSOHcWA0Z3dXz+ZmCrshvfkx+DrZ8
 5Sx77+OFVKAp5ct35rHY6RVCvo8fqPkQvygqwcjjMMunuD+2CyXd03PBCPW+7oH+GOq4vRy
 PyrT9txMTKsyS1vi1Zmug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xdhFbJiAhNo=;fRP4e0dccJvn7fTRc9DZKT8R23M
 ig8T7wo99xZGmVV1yPRs3I6ROBOtpNbspQHB3uRHH74BODShqKQJab1q2jH2j3/lIcbZm1Uqk
 Dw0KZTDCHmMZA1kvFZKEkRGBc0YU8GX2pxY4/IoWAvO9WXfCSIxaDinuNHu9S6/QxicpEvOv+
 IIqeVK6ZMKVTChn7dd9lLjMmX52CVogjWX8eySJTx+IrP1H5y7wQHqCyPC59FiZw+1fryVbpu
 gVYbweHkhpvowUB+2b0L1KLSKf1e4A8Hy0oI/az0qPMkdixwtimMPN9uOzICe0EWJ50wTl9N4
 19hAEZry8rijTQeLoLC1rd+tW14T7/k8t2cXTZzI99qQvPq5+AUXebUpZ3xsl1ymHLgrhH4XI
 jwsON84HnRQAdy3+54e+1ESTOmSL04BQJf7FzIQGFfvw4l3ROE3QViRNc0p0qjsCGLYldBmIT
 CKgm3T9VsXCLThDydAV7E2kX3B3IOUG0SThTgwohttjvsrLoYBa2qhLrFvLYXkk3tNN/QNZAP
 d9P3VwsIQGL6Rhyja4fNTusrNPuw70tQOTIc9GRuz4+9zq2WdPfr5bPHoMr9mfCazSPiRXVpb
 M2Dquun7ezyL6PsVdLp0kLKfenpCvPzSOnrxM+cb6NuQvIDg10o3SObYBLN1TT1lqmxzZ6l4y
 WgrNIWbD+kIt6Qbr6YXyNDrFy3TTPJVi44vVyuRvatwRhj23jg/jnXHBPMo4IWGRFNZDAnUp9
 B2bgSYkBg93bxJKjGaeqriogVNoBucRUHe1b/08rymqQqzeV2KT4tDccwoY2j0xxQG6Y9r8Cp
 OdT6TkuJsFWlFOQigKqqkJAo29809th5deleILTlIqjwYyXME8+zSYKStbpIrcqe9aR5WxkAU
 VUkiFbxa+NgT6YLHPnnZbsJeEcCnF0OyMtoz0dJATrapEyQk5R+E2gUzTD2vgIwg1hDPVj/8g
 GgPOIEmTbHmUc5RbWrffEVwMcNM=

This member is never used. So drop it.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
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


