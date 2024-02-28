Return-Path: <linux-kernel+bounces-85816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2476886BB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B051F293B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90077D06E;
	Wed, 28 Feb 2024 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vO1G+fJu"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460A72918
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161153; cv=none; b=lVGJUiz2JfVlCTLaQ9GIj4e+DvyyTZPndbvHwvXHm1fph0vU4I0jvKdnKQ8jJF2ounLBbVvLAcPKyerRQq4xutjFkXP1xqKO6mqbOdT/AwBWe3yiodybJ17UyLuLzMtJXunO6v3cff7tBrtyIIBEkoKWFFjrf5gsLS/uNn6lNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161153; c=relaxed/simple;
	bh=I3y6bw2LAb0IlKx+FDxow7f/ZEvtwZiT0GhDzrTym60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mV7MF+/Ht5ii1kws4me+LmAgebOBguT+vyGq3IhIfYPeUnVA+F8QhvO+INwIY7WqMiTAuCYpkIEIN/+BDbSg92eBTbKfXZk/jU/eS8nq88BS6y/qSdAwXSooQusIW6h2yTKK2EgAR+XGucFZQ3rBf+XERyB/l9xAanXu9bF3vXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vO1G+fJu; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7c78573f2d0so21755539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709161151; x=1709765951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl1dW8L3lDgmIQi+kWjnhkJ8hefGR0IxDu/wpRy1BWA=;
        b=vO1G+fJunlB1pJUEXlyCq74XoSc6qo+nBRTftSTMDmMp0yW+zdzufD+DsTNesl1yfK
         uwUpw7Hs5ybfmDHMJ/CRvOUyvpLgH6zhCwL6PLOC5HAwM6EdbsR2zxEl+TYu9G94bu4x
         EIG8kfDyuCR156K/of/wUGm7e58Pzc2YMU7cli6mYga6BbFJRfOzx9gUKcJOj6QyWZ+u
         h/is7CYlIs74LZbJOReS8BJxvBrWzyXZ+Pb8DlxCPjpRKWecF3H3Km94ZR/ZuQeTwhH9
         /dvqSxBh0r/HUUNrV7jRlmONxlivviYltDsFuHxkd9fsw8y7fsHGtLGOpWz8JsNsbiCV
         kgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161151; x=1709765951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl1dW8L3lDgmIQi+kWjnhkJ8hefGR0IxDu/wpRy1BWA=;
        b=MmX1lORL4OtHFD6JmdNruYTYkQFa4eeQMfMpP8/0428LD+4o4ySkoTGvL4PPMNajbm
         E/f2T0ho38sw/WYhE7JCNbfpQ7GHxtzZ/zlhhK21JA0Q2HlAE5/Q5GV2D2B0BTx4E0Ls
         9dXadxLLECk4zmvX7VR+TeaPp4OPxEbZl+rc0L6POjUttcMr9iB7pLeYFa/OhOLWfhJN
         PN/RWzcGbJIv3UOXaRZfhNP1wNBvMPuqNHYkuD4CGpLjHtwSoftYLOofGwEHjGBNogu8
         a8gQ7vTUI3GYSZg2PMCtyGINZT0RclFv/nQJ++RVs3PfWWq6fhV1WpJKLCg7uA+N6bAj
         rO4w==
X-Forwarded-Encrypted: i=1; AJvYcCVuwESYeWMKNdZ6MvAok6/bcC6jNeWu0QI4EVUE2aSKw4bZmrA57Yfw5yMwKOeu+ZoQKnyWLcAbtJXBbkFwVJpAT6Hx87WllIwDvAH0
X-Gm-Message-State: AOJu0YwdPYWhxyWOXVtOEEYydlSxHJd+bx65DqEC9PRTMibykRmC06nR
	gF/u2NjzaVHGohn/zGKhk5rDZ3HFpm6cFqlHy4+wS9ds6ImVn59MA6qT4ei4ys5ptgMTLZL0l8h
	t/rLzwMnH4vj8u7f8/aTSRA==
X-Google-Smtp-Source: AGHT+IEd5TqDpcDL/CecVQtIlol9AO/hwvYDfTD681/QxVlgloUGwWLrfutSShIUODQETh6ot+b26gv93gIpFIIyfQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:62a1:b0:474:b6fa:7034 with
 SMTP id fh33-20020a05663862a100b00474b6fa7034mr15140jab.1.1709161151340; Wed,
 28 Feb 2024 14:59:11 -0800 (PST)
Date: Wed, 28 Feb 2024 22:59:01 +0000
In-Reply-To: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709161149; l=2010;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=I3y6bw2LAb0IlKx+FDxow7f/ZEvtwZiT0GhDzrTym60=; b=0jfUcUruXPoEyglUKRSGG/j22pheWkJ/kShfxgCMAIYM00AkKvlXO/rOjvoieojTIF0janahM
 HdEeoTo59P7B86/+IKwv9cfg8SERVoihoa3caIiuFnNFgz59Q5zU78t
X-Mailer: b4 0.12.3
Message-ID: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-1-dacebd3fcfa0@google.com>
Subject: [PATCH v2 1/7] scsi: mpi3mr: replace deprecated strncpy with assignments
From: Justin Stitt <justinstitt@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Ariel Elior <aelior@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Don Brace <don.brace@microchip.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, MPT-FusionLinux.pdl@broadcom.com, 
	netdev@vger.kernel.org, storagedev@microchip.com, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Really, there's no bug with the current code. Let's just ditch strncpy()
all together.

We can just copy the const strings instead of reserving room on the
stack.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>

---
changes from v1->v2:
* use const char* assignments rather than strscpy (thanks Finn+Kees)
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 528f19f782f2..da0710cdac1d 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -3676,7 +3676,7 @@ static const struct {
  * mpi3mr_print_ioc_info - Display controller information
  * @mrioc: Adapter instance reference
  *
- * Display controller personalit, capability, supported
+ * Display controller personality, capability, supported
  * protocols etc.
  *
  * Return: Nothing
@@ -3685,20 +3685,20 @@ static void
 mpi3mr_print_ioc_info(struct mpi3mr_ioc *mrioc)
 {
 	int i = 0, bytes_written = 0;
-	char personality[16];
+	const char *personality;
 	char protocol[50] = {0};
 	char capabilities[100] = {0};
 	struct mpi3mr_compimg_ver *fwver = &mrioc->facts.fw_ver;
 
 	switch (mrioc->facts.personality) {
 	case MPI3_IOCFACTS_FLAGS_PERSONALITY_EHBA:
-		strncpy(personality, "Enhanced HBA", sizeof(personality));
+		personality = "Enhanced HBA";
 		break;
 	case MPI3_IOCFACTS_FLAGS_PERSONALITY_RAID_DDR:
-		strncpy(personality, "RAID", sizeof(personality));
+		personality = "RAID";
 		break;
 	default:
-		strncpy(personality, "Unknown", sizeof(personality));
+		personality = "Unknown";
 		break;
 	}
 

-- 
2.44.0.rc1.240.g4c46232300-goog


