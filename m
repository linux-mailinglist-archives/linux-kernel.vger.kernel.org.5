Return-Path: <linux-kernel+bounces-60623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B6B850781
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 01:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C236AB229C7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F011415A5;
	Sun, 11 Feb 2024 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lihGKL/Q"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB5A35;
	Sun, 11 Feb 2024 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707610092; cv=none; b=Q58Piy6A/eClVHeb26qz9yoWIhCMFhUOlR2iSWgKFP22lVMyngH8ubnKNfHDUplgS8LPYnWIhPiKeQG5vbPkx4gXw2894qQz7Za2S0xeBqbjNeKq6RWhj/CEwKiPCo+PTILAzrn4zMJYwqzdQV1JTT1jKZVI1OwjGickoEgzRPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707610092; c=relaxed/simple;
	bh=8SdHgzrqilgeg1RSLc8cDRbXG8jWn8PWpVMDFHwvVww=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NFzhwYUrOSwQfUc1Zm661z1fFgEF70dR+/M6f5N7/gqYhJiIEgnDv9bIhsqPZCzxGPU/jssfbdoPwlklNKFNaFME7hwmG0y8BPcOaO2QZ9jKBvbZDd91U2rAxatFMIUxrQ08GWab8g0XJdeYEFDBpRLG+hmvD8yL1UMbJoRz4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lihGKL/Q; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso16904145e9.0;
        Sat, 10 Feb 2024 16:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707610089; x=1708214889; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQk/Q4bki9VZhdmN8MGfnCe9kNGVsl6d50686N0rqPc=;
        b=lihGKL/QpO/u9xwElopSi7/cxuyJMfW4SUGrk+J6JLzFgPG6a0Jma2AiyXrj+jVQmi
         mHzsqiVjkU7p19Op3WK0u1yXh80tYUYi4dH5zN3Gvm1sxedNs1AEk09WK7nOmu7cNcrK
         tYhE8euQodZtg5RBnA6BDAPtbqg7NEVWt1kcowE0bE0AKyCWiPU2KBJ3+QHcdOEbNduq
         InSf8QALGWw990md/AknWuHi87bRDM7cvoiaWKRS8p7dJOw5fX9xE/lmcBlHRrAZ+PeH
         ZYzoGoDGvyvx+hwNOJ5bHBorxPDrla1/e2DfcjPGxV5I0q6M+RBEoBKS/QU5n0Hx7mAw
         eD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707610089; x=1708214889;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HQk/Q4bki9VZhdmN8MGfnCe9kNGVsl6d50686N0rqPc=;
        b=HToZp4vZ21yDkEzbxTD5Q2h9M+3O7t7Camg5VzExziUd24trWHBsBgaNAVh2gQqMIU
         h2pMSRtt5zyzHf74kFb9FRAKBja7YAPwzwpKYy9r9UWareCc09upe4eCcC4MrI8heSjX
         eU3A3xu9Fh2+vS2sFKVGldhgjnU2UjzMAYSmb0uxbJvZqPPErYSxRiQ0LF76jY+UnhNt
         ksOkUOyEC+Ncg9NBVW/SG6mXnME258e01QjnwjgDMtbrkku8kYcozLRx7smG1wVIC+aW
         ZZPFbBSGtiMhUg8z2EXVAhcRiX/5wC85glZoadrjHwcOreR8BKLFsPSW79oQB1Zd+EmU
         awrA==
X-Forwarded-Encrypted: i=1; AJvYcCVdvGLIBe4U0lpN7OEllsmHlLYqjFFsn2WqtlJwcW6s8OTAJSGvWUKxUMwK2CjdlXRWbAb0wg5dFF7hfoXMazbH393XVYIjYUaz6O51
X-Gm-Message-State: AOJu0YzKzueNvufSvk1/fwGu7+EFhKF7nZN5IwPUKlAf5EtNTnGTH7MG
	cRaca1Sh8iOgzonCMOWKBDHB2N313uyXh4u1obo9u6oHu411KEyk
X-Google-Smtp-Source: AGHT+IG5e6gY8Cxswk936R0eoC/RvnqHMggOaNqs5Vu4e6g1jz6NI/tBI/fbwpVbxkey1uUiSP0ldg==
X-Received: by 2002:a05:600c:1552:b0:410:7da8:53d5 with SMTP id f18-20020a05600c155200b004107da853d5mr2367538wmg.12.1707610088610;
        Sat, 10 Feb 2024 16:08:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnyGIEvAbdpHsAOqbuCZDREnm0705/fJ0KjCSHXVYADmqSCAKRJ5QhjRfwcXneFKtbKBB3F+Md/FqOcRIZeMTE9rfN7YqVIlM3BE5vWidZN2O4gRPqDfnZgOU87ZLtKQbhI7heswKlKq8eTlW7CffXF32CZPL1fBLLZWr1NJrR
Received: from ?IPV6:2a02:a03f:eb0f:3701:bc2b:7162:179e:ded8? ([2a02:a03f:eb0f:3701:bc2b:7162:179e:ded8])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0040fc26183e8sm4600010wmq.8.2024.02.10.16.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 16:08:08 -0800 (PST)
Message-ID: <52cf0eab-dbbd-4f12-b100-c7db1daea442@gmail.com>
Date: Sun, 11 Feb 2024 01:08:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 sviatoslav.harasymchuk@gmail.com
From: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>
Subject: [PATCH] Fix keyboard on ASUS EXPERTBOOK B2502FBA, see bug:217323
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

For: ASUS ExpertBook B2502FBA
Similar to patch:
https://lore.kernel.org/linux-acpi/20230411183144.6932-1-pmenzel@molgen.mpg.de/
For the bug:
https://bugzilla.kernel.org/show_bug.cgi?id=217323

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217323
Signed-off-by: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>
Tested-by: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>
---
  drivers/acpi/resource.c | 7 +++++++
  1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index dacad1d846c0..41fe6f2d4fa8 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -489,6 +489,13 @@ static const struct dmi_system_id 
irq1_level_low_skip_override[] = {
              DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
          },
      },
+    {
+        /* Asus ExpertBook B2502FBA */
+        .matches = {
+            DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+            DMI_MATCH(DMI_BOARD_NAME, "B2502FBA"),
+        },
+    },
      {
          /* Asus Vivobook E1504GA */
          .matches = {
--
2.34.1


