Return-Path: <linux-kernel+bounces-6188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB2281959D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96AB28C46F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2419EBE64;
	Wed, 20 Dec 2023 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Fo/ku9Ia"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE8846B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d12ade25dso38257785e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1703032405; x=1703637205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZU+vKUedcxvlMvLQvRGcy4W/7LE9vhnsOAwLDimoXo=;
        b=Fo/ku9Ia5s/JCrg4/dAYOai0d7SUqif2MoA7isXysdX+hIYHjGWfmMrcFLgW3XyLA+
         pl1DRyvs3gOPqKFCU/7eeivWrFJN1ekfVL4G2MPZPJqY8zDdMV2dFpWvouAWtl64/3ZO
         sI0OwPnwjgr+Y3ZgzYl1Eg5p93V9VlrlL/LRf87sgmQ35M17r/xxdBiSA5oIKt1fJss3
         hklc/FjkfH+FD7N+eFPEHof2Bu6C+7Dlkqh6psLU/v7sutydiKoIQ3VsFobzy0w8NrXw
         3G4phh/3gyhJi1cWxdvzMD3LCshLsgz8sfPv6NTpfyYWckC6Z+lrPCF1qVtPV0yoFduJ
         9k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703032405; x=1703637205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZU+vKUedcxvlMvLQvRGcy4W/7LE9vhnsOAwLDimoXo=;
        b=YV5mc5iMvHNL56tL3Q2N5+8Nn48bCAzooAYpFiJ/1GsQdgn3dZ5s7Rx12jSWpzVbdd
         ScbKo4Ch7bZ0gMKu3zPofEw7RP8Ghp7f5hHxUGY/ksn4m3NiXW3XdY2gZHnW95EWyaJs
         2CvHtI8g1TaSHw7QMmjhjsL8Q922s7I1jOSWevavRWdWerQ3agjzbernAQzQ3cb+9WMC
         fzRzdoVqFr5IjDthh4j9fssCTB4CRQHkvBgxNHYEUScreOg2Va64t1hk+yaO9r6wQsqS
         LQdI7rGAuSvT+bSKS+BZgMrU4rk8TmDp2TgEtoTh93uuHQWwg6sgZJ8t6PML3bly2Mvn
         P5JA==
X-Gm-Message-State: AOJu0Yx3kNlaUlm4WDDSjpZZR436itkRnZ6gBno+WCZ29vy/A/bzujS6
	4kFW4E4tU5MYYMapCZzU3HYCow==
X-Google-Smtp-Source: AGHT+IFDsp4Fit6NQwqfzspnxFl5di5q7fJzYXKlPh0b18nTx/seRlZyhvAvWyP7REsUspaUN3uX8A==
X-Received: by 2002:a05:600c:4591:b0:40c:6c80:efa4 with SMTP id r17-20020a05600c459100b0040c6c80efa4mr4027621wmo.35.1703032404687;
        Tue, 19 Dec 2023 16:33:24 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w20-20020a05600c475400b0040b4fca8620sm5060620wmo.37.2023.12.19.16.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 16:33:23 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: Dmitry Safonov <dima@arista.com>,
	Baptiste Covolato <baptiste@arista.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Kevin Mitchell <kevmitch@arista.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH] gen_init_cpio: Apply mtime supplied by user to all file types
Date: Wed, 20 Dec 2023 00:33:15 +0000
Message-ID: <20231220-gen_init_cpio-reproducible-v1-1-d40da0b2c15c@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703032397; l=4390; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=WO4So3owkEgbDEJz508Jr0jtYldh4JAlQaVVz0idt6E=; b=QJo6MWRgcyZxxGf7vSu4xmF/4R01Xhsvf4ITaDjWlDexwqI14kpOIsX+CmK5JjU98BeNpYumO u3dgh/Gn/1wC60sm+cS3RCbmhEKP9eeCdw+MnlQp/krlQMvz1UEvGG3
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Currently gen_init_cpio -d <timestamp> is applied to symlinks,
directories and special files. These files are created by
gen_init_cpio from their description. Without <timestamp> option
current time(NULL) is used. And regular files that go in initramfs
are created before cpio generation, so their mtime(s) are preserved.

This is usually not an issue as reproducible builds should rebuild
everything in the distribution, including binaries, configs and whatever
other regular files may find their way into kernel's initramfs.

On the other hand, gen_initramfs.sh usage claims:
>	-d <date>      Use date for all file mtime values

Ar Arista initramfs files are managed with version control system
that preserves mtime. Those are configs, boot parameters, init scripts,
version files, platform-specific files, probably some others, too.

While it's certainly possible to work this around by copying the file
into temp directory and adjusting mtime prior to gen_init_cpio call,
I don't see why it needs workarounds.

The intended user of -d <date> option is the one that needs to create
a reproducible build, see commit a8b8017c34fe ("initramfs: Use
KBUILD_BUILD_TIMESTAMP for generated entries"). If a user wants
the build reproduction, they use -d <date>, which can be set on all
types of files, without surprising exceptions and workarounds.
Let's KISS here and just apply the time that user specified
with -d option.

Based-on-a-patch-by: Baptiste Covolato <baptiste@arista.com>
Link: https://lore.kernel.org/lkml/20181025215133.20138-1-baptiste@arista.com/
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 usr/gen_init_cpio.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 61230532fef1..edcdb8abfa31 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -27,6 +27,7 @@
 static unsigned int offset;
 static unsigned int ino = 721;
 static time_t default_mtime;
+static bool do_file_mtime;
 static bool do_csum = false;
 
 struct file_handler {
@@ -329,6 +330,7 @@ static int cpio_mkfile(const char *name, const char *location,
 	int file;
 	int retval;
 	int rc = -1;
+	time_t mtime;
 	int namesize;
 	unsigned int i;
 	uint32_t csum = 0;
@@ -347,16 +349,21 @@ static int cpio_mkfile(const char *name, const char *location,
 		goto error;
 	}
 
-	if (buf.st_mtime > 0xffffffff) {
-		fprintf(stderr, "%s: Timestamp exceeds maximum cpio timestamp, clipping.\n",
-			location);
-		buf.st_mtime = 0xffffffff;
-	}
+	if (do_file_mtime) {
+		mtime = default_mtime;
+	} else {
+		mtime = buf.st_mtime;
+		if (mtime > 0xffffffff) {
+			fprintf(stderr, "%s: Timestamp exceeds maximum cpio timestamp, clipping.\n",
+					location);
+			mtime = 0xffffffff;
+		}
 
-	if (buf.st_mtime < 0) {
-		fprintf(stderr, "%s: Timestamp negative, clipping.\n",
-			location);
-		buf.st_mtime = 0;
+		if (mtime < 0) {
+			fprintf(stderr, "%s: Timestamp negative, clipping.\n",
+					location);
+			mtime = 0;
+		}
 	}
 
 	if (buf.st_size > 0xffffffff) {
@@ -387,7 +394,7 @@ static int cpio_mkfile(const char *name, const char *location,
 			(long) uid,		/* uid */
 			(long) gid,		/* gid */
 			nlinks,			/* nlink */
-			(long) buf.st_mtime,	/* mtime */
+			(long) mtime,		/* mtime */
 			size,			/* filesize */
 			3,			/* major */
 			1,			/* minor */
@@ -536,8 +543,9 @@ static void usage(const char *prog)
 		"file /sbin/kinit /usr/src/klibc/kinit/kinit 0755 0 0\n"
 		"\n"
 		"<timestamp> is time in seconds since Epoch that will be used\n"
-		"as mtime for symlinks, special files and directories. The default\n"
-		"is to use the current time for these entries.\n"
+		"as mtime for symlinks, directories, regular and special files.\n"
+		"The default is to use the current time for all files, but\n"
+		"preserve modification time for regular files.\n"
 		"-c: calculate and store 32-bit checksums for file data.\n",
 		prog);
 }
@@ -594,6 +602,7 @@ int main (int argc, char *argv[])
 				usage(argv[0]);
 				exit(1);
 			}
+			do_file_mtime = true;
 			break;
 		case 'c':
 			do_csum = true;

---
base-commit: 55cb5f43689d7a9ea5bf35ef050f12334f197347
change-id: 20231219-gen_init_cpio-reproducible-99c707d8e66c

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


