Return-Path: <linux-kernel+bounces-51749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E6848EDD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB771F21729
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDF022EE3;
	Sun,  4 Feb 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="CUu05J9q"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B892263E;
	Sun,  4 Feb 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707059966; cv=none; b=Ip6igXO++qJXEk1RAebjTeutuWI0COyrOZokAQGALZegbWGblWlg9QhTMoapAXvAnKd83yCoR4ID8IoYUK8/+sY7YOx2H7pfoRwKA5ExzAZu6Zh03JCqx4t9q+hEsQ/tRRc736nIQ3dt0dhqeDeAiMsR/AuwjK/P98ZcYRDIpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707059966; c=relaxed/simple;
	bh=kXqxW888mDY6atIFh8PWhcVqmeXWk4ylA40FHZPc6Ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fEc4RRCCdKlKcLr/g3/NymTGJiwB33VznsQR3wsCVhTmHxqoPvA1DT4d+2PfBIBqsqNODjh94uLOuVAMZ5cfx8f+BmIzgFwg5LbikNLh4p9HACl8JkaxrGkDC0kRiQKqX0Cq4RsdE9Lx8wd/lPsAHtyxYUqFCvj1wjnSLQ/g0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=CUu05J9q reason="key not found in DNS"; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59a910a1265so2038758eaf.1;
        Sun, 04 Feb 2024 07:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707059964; x=1707664764;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTczlgkPDCS3gsgmbWxuEHVzbxy7MJkJFjIF9xap5j8=;
        b=rTVO1WM543bhXs7OPnSbhnq9l3hj/QU/cjiPpiLfb47IK5Pg/cFOLbBCFdwZnc6nzG
         c/AnVU7Gvp96cKtrfO3+8FOxqy/YnMFd3iKStFTDWytUptIfqQhufRwYP3iWyHA2FtEW
         FjV4ASN/z+WKpRBxUe2JLmwkdZDBhaHtLAfd9Mw940EY08VDLB/svKz4CzxitnVUbL6k
         Tn87DoO1wXIPRPQObWTUZSMP+WhPE5wYroO80qDHCKhUIVLs3NFRRUXTemNBdWQsnBhT
         gNe2HjUmSi+oQFZaXAbNRjmj70+8A5iuKQjltOgNQfzi6QaKbM0mHPHzIDaUff9Yt3Oo
         QJgA==
X-Gm-Message-State: AOJu0YzgA/QXKqlob6mngz5cEawWu5Uk8tuCVhziGpnoyQJ/Y+Ux5Iul
	qoHRm1Rgj06SmdqVELlmSmIprfPY+t7PQRc3dMxmAmxPs5LM/9r3Le9N93FutirQRw==
X-Google-Smtp-Source: AGHT+IFNDd3CQv0ou990HD+NCrLXVhuxDaw3NRhwqfyR4DMqz89AJfK4F0bJQSq0d5cWBg+HTHE3vg==
X-Received: by 2002:a05:6358:6a56:b0:176:cf6d:20a6 with SMTP id c22-20020a0563586a5600b00176cf6d20a6mr14273249rwh.19.1707059964012;
        Sun, 04 Feb 2024 07:19:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUGv17skPp2sQefcrlYr/SUwOAWKT83026nuhOF86F/YFkQfFNqZ3z118EaeueUgo8pGViCLGK2HYkJ1rYKRI/4AbzQj++uvxUSTKGFYJUZYkIw1wNPNlt1ZZUmKkb/fBAeL96B9JFreQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id 34-20020a630f62000000b005d8e30897e4sm5130948pgp.69.2024.02.04.07.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 07:19:23 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707059962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MTczlgkPDCS3gsgmbWxuEHVzbxy7MJkJFjIF9xap5j8=;
	b=CUu05J9qEfPCiXmGUfyehfgrgbiy9VwKij3DMyuYt0b0WDKeKtH6mF8ul6Z+d6or2bPy6t
	Yumx7MnZI9KEd/qzKRebRoxHPOs5EkN32CHQTwx86ZadrRdzFrRcvQEK6ZnIbupq8NUnrL
	V/Ve0Tfb78b+/qrAE5Mu83d/7eHJa8Hh0ApFnJ1UDobbIeuDGkKb0GivvmmaN7NIrT3k7K
	6V4WREeSkcvuFeaHgQS/NnDbGFSXyekvfC4upsjrbENbvRuQbRkH5uagjXddqADw8ewL01
	CIxkRGzTq3wB0dT5FBLASIU1ZgctUQY1RWSfvmA5nyjJQowEHPWTP1guIT1fHg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 12:19:50 -0300
Subject: [PATCH] sparc: vio: make vio_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-sparc-v1-1-4ca7fe8de5f7@marliere.net>
X-B4-Tracking: v=1; b=H4sIABWrv2UC/x3MQQqAIBBA0avErBNMDLSrRITZWANh4lAE4d2Tl
 m/x/wuMmZBhaF7IeBPTGSu6tgG/u7ihoLUalFRaKqnFcvHsD3TxSoKTy17Y3nTOLsZgsFC7lDH
 Q8z/HqZQPI/EDZmMAAAA=
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=kXqxW888mDY6atIFh8PWhcVqmeXWk4ylA40FHZPc6Ec=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv6sZCAiEkiJR21xfqSd0MdfRuWAesIUruCuzr
 kg/6f/iq1KJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+rGQAKCRDJC4p8Y4ZY
 pvQLEACbYtscBd8GmNiYZutEkHUVOjWiGZgz9D7McwiWXgNN+deVcH9S3fkaU8+vEqcnEcSSrOo
 7MlZyGZAdKVXzJru4ak/wGaspqFSY7P6+/ZuBqrnrpTyqR3JaKlM04FnnoeV8rfl64KC3ijRfjJ
 XKieL14x+jAHjdKpL9949knKSSv3ssXzqIaCFMMsjEufV8l2LY1yPeKBUsLGdJk/g1BVBA5dRqy
 MNkxFGfaKs8XrMf5tHDb31pfedGjR4MBF2ctrAWa7NfRdJOBtdQvQAvwyCUwP/4zDPAY3I+7aJy
 mlFIVaCJBqvqSWX0nPwZsfs7w9vMaRO+Tp/SqDkB7CuVhBALJy/SWUtvnfOW2w/mE42oBBeh5kh
 yOm/SXd/moVYEJZJoTiIyWoupVF1h43measeDdxgoxPEvWn8uLBwOKwXsUQYzJZ7K/XJ+MaPAsH
 cHDNQCEETnBn5i9BFpzPVtiraRsRk7c5svk1dRoupkTmar3z8zPlg3f2ER66HX114s3nk9LQswo
 Za/oRmbXMGW/Rb8AIrerXno5XEeFsk/uUa2F7eFM5BmoAJVnBS81AODGoq70AydriILlLHcso9w
 27bpnzzupwdOlhG+xoC52VHllsSYF2WFPCLlBEpm6CloFXcbjkKZirtawYbFVE3isqJO5jJKxj3
 Z/MgbVf7TJnE34g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the vio_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/sparc/kernel/vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 4f57056ed463..5cad16d81e3f 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -151,7 +151,7 @@ static struct attribute *vio_dev_attrs[] = {
  };
 ATTRIBUTE_GROUPS(vio_dev);
 
-static struct bus_type vio_bus_type = {
+static const struct bus_type vio_bus_type = {
 	.name		= "vio",
 	.dev_groups	= vio_dev_groups,
 	.uevent         = vio_hotplug,

---
base-commit: 2d2b17d08bfc3d98cf93622e8c6543eaaf02dabe
change-id: 20240204-bus_cleanup-sparc-9581a9b88ef9

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


