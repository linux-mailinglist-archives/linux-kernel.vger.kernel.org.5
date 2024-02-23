Return-Path: <linux-kernel+bounces-79256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00357861FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937761F23F38
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB469153506;
	Fri, 23 Feb 2024 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oNUYL41P"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB21534F7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727004; cv=none; b=u4761jfRPzLWqcbTiJQ+v7ixgfB/Mh5PesD22MnrVs/etgQ9LwANUCFYxp/q+Nl06Ef/BvNBERFiO3q34lRf5x5FsCS0vGh0LkVZXnvYqdxWqlb1Jd0GXjOwmDvWXYyAYutLGjb4K3E99/89x9/73jD9Hk0qLXd2Nh6lHzTKKGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727004; c=relaxed/simple;
	bh=hOmGJZtlyDjZ1c+JZUoPsWCm3VDSV2Qxk9ojvhhQIl4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MMalhi/ZCpdkjcXWERONrXJNL9Qcn0g7QfAjIOnJD6FOwuywmHp1upbsToe9zEI5wygmD+5GNkwAdkM03zTLfNWMlOLv1dzVak6551Eg9BIjx90sBbMGKddNWYvTFjqgyQjmaKWWFjttAE+zRNuj5EBAyXkKOpDF1Y2Ye1wBlvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oNUYL41P; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608cf009bcfso3969257b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708727002; x=1709331802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B52RSzoPz0mGizyBlMM5klXSYnyjiEEzzlSO34AH8fk=;
        b=oNUYL41PMz/Q3IMd+NQzFxIaU8oPcYn4K9UNWRO9ksFioJo9tKHO3aPHrBu5wNwQ8m
         z+0tmPmOWmhZT2XfAb4UCogn0X1yDEFcWJ4FEHiSU3Ww4sRMK45GDzfm5A8ANISprR4a
         /y35W1qM0CJzNaB+hirJlFd+5haXCDa7Sv7fjB9fRXaDB6sR5d3923uKUR2wyaiOLag2
         jK1bLmNFbHU3Ey1hVDrkm1etHg6KckVA8Ntvx7DFn21lfbnDsk23gLWNRbrqKwd+ky84
         ooxHCDCMZIB53S40ZbvEem/xVUXPM3iYKc4zlpKZe9nEV796PELrkM6/7B1NngHOxqKv
         zTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708727002; x=1709331802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B52RSzoPz0mGizyBlMM5klXSYnyjiEEzzlSO34AH8fk=;
        b=URuv/eXME3xLnMtdM+UPcZXrJuYk/Wnly+rXCGG+KgCKxOq0+LlOMy5qWBaAKjY7OB
         7HKfWAvh2tcD/saQVp0Ka00R0nkQw8V1IJJ3qql4IGrORGwqQcyc7el+QR8FWFFSFTr7
         B9nqwBV8o320X0HrEszVrKgAcQelsyFqt+DS7WtQ3/73s2AWZcjnGSQxMVEnDWDoco18
         g9j4VpsQgE9d31PVOxGfGjB1K7L7iVkcfbPirYH6C890diY40yKMvHr83BpZf/kpcp1M
         0TmAD9u0Y6Cj6WSBsl+XuyarYtFWwZ1cwPReiFSTKnUL29Sm5SbEWOytqQf1qoXZyW1r
         o3uw==
X-Forwarded-Encrypted: i=1; AJvYcCWF2D0JdzQvAUufEMqeCU6Zs28ffGZbyAuZq6d1z4OlxtjrHjCu9UIxUc0A0vzSPgcj8gl7yrt4DCu7vCri2gXTsn1+iVVUvtRWS58t
X-Gm-Message-State: AOJu0Ywj8uwjoOgOVC+uDHSZ42TOeZtRGeaWg3aKfrsR4cYGT9b5uRh5
	FugZpM809pSJV5wvNIZTdyqHr0fyr3efmbgT25/kggEW02O0BceHjr3jqWnl9GeDI2/Q/pyRUQ6
	AvtoEQKFSMcrFZkXRqhCfiA==
X-Google-Smtp-Source: AGHT+IH8BvjewAAU/Jv7dArLAwd9BdZ/e/MwR4qJmFCTcWyLALkhZS5WODn66865ajzGJ9hhEHLQDedglmJ9E05N2Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:e693:0:b0:608:c8c3:ab83 with SMTP
 id p141-20020a0de693000000b00608c8c3ab83mr210681ywe.8.1708727002358; Fri, 23
 Feb 2024 14:23:22 -0800 (PST)
Date: Fri, 23 Feb 2024 22:23:12 +0000
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708726991; l=1256;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=hOmGJZtlyDjZ1c+JZUoPsWCm3VDSV2Qxk9ojvhhQIl4=; b=gkPicOXTAwPTmCTO1o4Csa4Ea/XzR3aEtcvkwKHYxFZjEsPcbRiLTwWkzG1rxvSX7nu/XoDOW
 Pwzi8N+lJSUCB95JSlYT2loyUZhhlTUZgecBJ0ACufjQ2+0aW7CJ2qX
X-Mailer: b4 0.12.3
Message-ID: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-7-9cd3882f0700@google.com>
Subject: [PATCH 7/7] scsi: wd33c93: replace deprecated strncpy with strscpy
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
2.44.0.rc0.258.g7320e95886-goog


