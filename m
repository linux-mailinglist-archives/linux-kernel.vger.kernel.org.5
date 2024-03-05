Return-Path: <linux-kernel+bounces-93112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1F8872B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7A01C2490B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DB0136649;
	Tue,  5 Mar 2024 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sk4+kK4O"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D333134738
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681691; cv=none; b=XB7cy/x/3HLj3iupxMO+Kzqsu9zxO04zUS5Qr3g6Mt1/HQGi/fKu3AJz2NzuWXMvBYuc2zxZtyGD6/0c8+8dQbD9WTc8+/+HVa6OIa3q0lTzgtKwjymNvFXH0XYezJi6JkJDuxg1krbs2tcKwEwlSdB/AwJ2GMyBTB40MjAYanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681691; c=relaxed/simple;
	bh=FcEcSMUZOi/4Oj8G2zljZCZLH3SJcgxPb0qa54lykhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dx0H5Pva1xb79TLf2I9RCdzUGcnLR5YjCy1LcjwzkdNzUp52nePhD18N7eVYaV8V132yM3y0ehXng6ZZ4YmZS+VaZ8XvL1SV+YjmPtWdIvhoL7/WSSTcTJE73IwDbyDcXVgFpD08SGEMF0in5Uxhupkh0WTuaenewm5olOgKfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sk4+kK4O; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so2175596276.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 15:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709681689; x=1710286489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsGEY9f3OqM6eFdMybydMZbUAGFeLoZyzbi8Mpvwi9w=;
        b=sk4+kK4OEtHjRB4RdWR/f4HFlTaYxrWMs3oYAilZqqqSTiLt3y0J6XN3zbILtB32+0
         /XZPJ/eaxgY8bDFtYRWdngUaVo7rE7llv13BWh3kgss2+6zKOrItFggOACk/UmZYatA+
         +At8Khwx+U56gUVqO8C8yBpbEzCnvU8V+JAlwtJHB0rYdqvpa9AAHRRPxBHEfEWtNrgn
         Gk5rVR9FiqpvwTNVy5ii7PNTvR8ftr4THmxH/dKM4cKydDHnvmD8ZspPuQ3r0DCrwQ+C
         Y5Uu0dJM8DgL6a5Qsn8qB9eBbnDpnHWbp9E/igbXcpKHk3Fm545P1XdND/poPQOL/0dP
         XgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681689; x=1710286489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsGEY9f3OqM6eFdMybydMZbUAGFeLoZyzbi8Mpvwi9w=;
        b=aaZxZV1Xc/9HqWJh9jRp1F45/wtT6MooaU15V1aEpfmR8rhensJJsFB2avD8u9AV2D
         GDxyWyY0sJFGwySQRlrnMxioxelFMt7nnKPlTGAmoLA/qewVXulhthHAWr3bp3MhfVyA
         6eNIxf9yGCFiq5foIRom6Q46xKTu0XOeUaAU1u13vdh1p65CRkQlBefgEJrVit328XIh
         L2jUEyeMq8sC/4ZOt4AoTW5mXYtfuZllKdYXAI9g90apSASzbFvSUGgpSfszJW1AB5v6
         5iVMeavL3xAXZOYE2AuyTDeiY70WwKsIo4RCXAG+SAODiY1z2raL4Hiz/1tRkI0dId+H
         wkeA==
X-Forwarded-Encrypted: i=1; AJvYcCUCQWSH1Gi/FnVfHUYUtyiaPZY5ngs2pqzlVkwwJWmS/HdgHXdbEw6XTKG5FhyyfhmO/SbO/24iHaI2e46LKL3v+qD6FbTBUQCReYk9
X-Gm-Message-State: AOJu0YxTYpEGZt5k1+v/1xj9GMcXpgMNchJSMXnQzqr3PWn7qNi04nOB
	YuI0dnPTNHre2jBB6ntdFgMoh6EWKJyLoQfJB9kjSsCNmZwtt9mre2J/I1/hJrScvC6wFN7CS/1
	zCQbsI4v31GPVlgBP9qy9NQ==
X-Google-Smtp-Source: AGHT+IFhY7mSFiskrXLQQcLXv+8xGkstxo5w0gS60+blMyypRYZeekyCqzmmOLRjPz0ivi7dNVpAi02DPBov+hPrzw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:210b:b0:dcc:50ca:e153 with
 SMTP id dk11-20020a056902210b00b00dcc50cae153mr3627471ybb.7.1709681689467;
 Tue, 05 Mar 2024 15:34:49 -0800 (PST)
Date: Tue, 05 Mar 2024 23:34:42 +0000
In-Reply-To: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709681680; l=1300;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=FcEcSMUZOi/4Oj8G2zljZCZLH3SJcgxPb0qa54lykhA=; b=rEqSK5v7RadAxWbNgUvH4x8qZTngDbd07BNkbZ1Pq1tjrnZ0h0MlU2EsBQmYekMKYg7eDKhfc
 Gc5GYce/HG/AVosyZo89GfoU8y1DHcrWZSkiwbH+zU8Q/7Cwo+zcboR
X-Mailer: b4 0.12.3
Message-ID: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-7-5b78a13ff984@google.com>
Subject: [PATCH v3 7/7] scsi: wd33c93: replace deprecated strncpy with strscpy
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

@p1 is assigned to @setup_buffer and then we manually assign a NUL-byte
at the first index. This renders the following strlen() call useless.
Moreover, we don't need to reassign p1 to setup_buffer for any reason --
neither do we need to manually set a NUL-byte at the end. strscpy()
resolves all this code making it easier to read.

Even considering the path where @str is falsey, the manual NUL-byte
assignment is useless as setup_buffer is declared with static storage
duration in the top-level scope which should NUL-initialize the whole
buffer.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/scsi/wd33c93.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index e4fafc77bd20..a44b60c9004a 100644
--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -1721,9 +1721,7 @@ wd33c93_setup(char *str)
 	p1 = setup_buffer;
 	*p1 = '\0';
 	if (str)
-		strncpy(p1, str, SETUP_BUFFER_SIZE - strlen(setup_buffer));
-	setup_buffer[SETUP_BUFFER_SIZE - 1] = '\0';
-	p1 = setup_buffer;
+		strscpy(p1, str, SETUP_BUFFER_SIZE);
 	i = 0;
 	while (*p1 && (i < MAX_SETUP_ARGS)) {
 		p2 = strchr(p1, ',');

-- 
2.44.0.278.ge034bb2e1d-goog


