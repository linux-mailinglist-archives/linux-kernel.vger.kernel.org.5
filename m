Return-Path: <linux-kernel+bounces-1939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB65815620
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946C11F25961
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03ED1C38;
	Sat, 16 Dec 2023 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="HVsiTsi4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8471363;
	Sat, 16 Dec 2023 01:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702691774; x=1703296574; i=w_armin@gmx.de;
	bh=iRRAKbmAPwXhvUW4GeDAtHUeGHCa7UwO3y4IzMhZosU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=HVsiTsi4E/5xdpDXVtctRIpM2N23LOMCPUHwodHrmknycMsDGuJbRO96zdF4U0SH
	 bjkGyFYIoCaDuckpwtR2jYWvyVF3FtRDM1b/mSVAuS3O4liD20rmhUNAk2hsjuy1R
	 os7TlUFnATc3eYlSNH5D0APJgk38ZI0Wra1NjYNW5qXiNORVR522LHtevLTUxArqX
	 sH9Y53KDZiAr9uNeap08HjigS3h40dFahdEcgbfQs/ODwzWWgjgXyHnY2tVT0QOGY
	 DewFqBZHNoiL1X+PZOfCxDtedI2mRqH6gTE8WQeBVBUdarPUJ+AYRjopM6wkMj3Ub
	 unktvxa+B4vUh5Hisw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M59GA-1rDDys1NuW-001CoP; Sat, 16 Dec 2023 02:56:14 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] platform/x86: wmi: Remove unused variable in address space handler
Date: Sat, 16 Dec 2023 02:55:56 +0100
Message-Id: <20231216015601.395118-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231216015601.395118-1-W_Armin@gmx.de>
References: <20231216015601.395118-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MOirfnZjqqSa7HKQZpaCjRHQzbSnjM/WT0d9T5Iambpw8kD6B9y
 28m2Aow+fBqN0ma3ceR3fbZCEW/VusvoVPjx/Z61DKdNH24CTDtgsibYLUp7dQUY/fJL+Pj
 fyTXopPyGIIbgliOO8KCsKMzSgdfqBEOSn5PypGzVIUz0pok/I3OSZ0aM8LpldoR2rUUjqy
 uMR1DIPkjCn739AF6FK7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g6TJpMyVtzg=;8NJD8ZkcZbvWcPGjTdnCYAfn48e
 rS/yojc3meuqmvJ5oso+pp5CEd9xvsTzahRVyRzmg949loKL46jyAcNCZI5ImHrGZKmXUswtv
 BwY23woQqcu1Uqm87Pzi8gfgrqdymGcCdNudKJxPW/+tKW02ZgfJOaFJxxCvr/ueTZuLoiKug
 /vuc8B7amK/VtZngUoqt+TmBDPbQ4MDc4DdsiYe2vT3oLWhJHgSCtJ176knmVXVF5kI5t75xp
 DGsOWLfA9XH5uDqIxO3UvN9k132jmxzQ/ZzQPwIxfPxIK18SyvCMDcle4fExUCdws3hQNY7Ze
 RM1+m3PLYeLm8ma7XGzx6DDcUR3XayOmfnkUIjNHU/WD00JKI7SJ3bfmypl2vST4bXYtIRd2V
 8wZ+yaRLUNrMD61NIFenRs1KPdNEOxGmn+zFnvWLOYn2LAwIj9mz4u1lKHdQHfP03uE3KUbiS
 WyV51xWuM0POH4BOpsBcmPA2C7mzgp21VPf2NnN6cQwwK3CqSDru291Zz2qJycLe7JkLLiiiG
 V/LcFOZYgNLi11OPsIZ6o1+aJRPfOqkY5iGgtusibw/VmKKsJuisg8hJGAM8P9Xzso1sgdNMR
 BqRRuRGPE725kooFahxDm8nHFXKWkojFYTq5fGsrk4I5bvX0mzE7Cdm1/WFUYNNv+3YWObtLk
 T/NdslgPL8YNrH5e0s8CrIikPzu5CSj1w6yrBCOvrZpnz6nFwRdLi/Q0rSKrJ9KywJRe/5PWA
 Mxb3jVHaK/v8xVGN+zePFUsR8VMZ3ZZUBkO2FoOi01JbHcVEvKWM9av+63+MEI+2rJLjj179M
 A16yZHI969PbnXwd7DZXHVnhwACLNnCaqW5yG7/SQop7IXrouOltIQJVty4fxzYnzupUlsGJJ
 EFY0JmZ4OLy02346Xbz8yPUXGnPwifm3f+QAAPIslQr21+Dd1B74cTVAYJmoXxkAdB+luyOV3
 Q8aXwqqSRlozaFZ4MPrQ5WXHpN8=

The variable "i" is always zero and only used in shift operations.
Remove it to make the code more readable.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7303702290e5..906d3a2831ae 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1144,7 +1144,7 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physica=
l_address address,
 			  u32 bits, u64 *value,
 			  void *handler_context, void *region_context)
 {
-	int result =3D 0, i =3D 0;
+	int result =3D 0;
 	u8 temp =3D 0;

 	if ((address > 0xFF) || !value)
@@ -1158,9 +1158,9 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physica=
l_address address,

 	if (function =3D=3D ACPI_READ) {
 		result =3D ec_read(address, &temp);
-		(*value) |=3D ((u64)temp) << i;
+		*value =3D temp;
 	} else {
-		temp =3D 0xff & ((*value) >> i);
+		temp =3D 0xff & *value;
 		result =3D ec_write(address, temp);
 	}

=2D-
2.39.2


