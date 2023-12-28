Return-Path: <linux-kernel+bounces-12685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E32881F8DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E644D1F245CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0098820;
	Thu, 28 Dec 2023 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHxIKVTa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC1848D;
	Thu, 28 Dec 2023 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3e6c86868so47460265ad.1;
        Thu, 28 Dec 2023 05:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703770600; x=1704375400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SAwkVfYi710Nnw5LBAMKV15DX6mTtHBBaUhJfsCYgbU=;
        b=EHxIKVTaj9VTpd+Dl+A2qA1KsPe+fPxYbGEavTJermzVrmDKBls+D3LWIMm5lbEF3Z
         TIRt+q9B8MtdCfFiw9dSME29uIrnPAKS2laggb3fu8qRYMC5v+DEZ83cu9q+kmoZWmPn
         1WiAnvigKfH0sJWptDjGBKKVXoCnc71cejftUHi8Li0CgHSNeDLD+pxcWKavo9q6oK00
         6iCML6nF3OtQ/IrnascKKFnn+dMz23WL2EVb48aljSqEaSDj4ZFxysB/ukET7JRs90fp
         xZGDyJ2Og9tm/wPttH10qWNt+gTiGisz+b32OX7MplQRL23xl5/edBiupfG2OJZ7FWEC
         bWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703770600; x=1704375400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAwkVfYi710Nnw5LBAMKV15DX6mTtHBBaUhJfsCYgbU=;
        b=sIMpqpPjGmiSdCyI+1qXqxyTBhlEVOtaeFsEH+u+8v9odl3mossZoXENW0h7HZ6Qny
         9RkuIFEiAiPvW+sh5eZEveHyoKhRnP3yPlAq7JLxous9JKGjm+AiV83aegMYGHToJcqW
         Q6GZX0dpQHw0sO+nODXSyZpRp26CDnBHapqo/oLqutmd/Hw7Notg6oiXdx4DgE3+CycG
         74hLkrcEKcEzgHKomPQHRWQm+8bpcSwURIun6sfQ5yelXNCGl+VDEVS2JILYVrvah2Vx
         MlSIdrx4LbilGaf2N7R6d+tibsz8NkDLmq1qtEm1FKpOuR/34qiTtB72GYD+yDK/lcz4
         iRyg==
X-Gm-Message-State: AOJu0YwMimNxheHdo+RmUOf+95gwAlvJKhVNJOcMw7uEjIjivqkgS8zG
	Eh3qXF72+3zwqXs/Et/OV+o=
X-Google-Smtp-Source: AGHT+IEalSMo2J/vSjFgltbw/cKbNuTbIL9VxJn0WDGfFnu5vZkWmChKCs2Fpn19Wnx1WSwFiELgFw==
X-Received: by 2002:a17:902:c408:b0:1d4:3cd4:23d1 with SMTP id k8-20020a170902c40800b001d43cd423d1mr12629729plk.96.1703770599998;
        Thu, 28 Dec 2023 05:36:39 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001d496033787sm604848plt.11.2023.12.28.05.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 05:36:39 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 7D63F1033E0BF; Thu, 28 Dec 2023 20:36:34 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux CIFS <linux-cifs@vger.kernel.org>,
	samba-technical@lists.samba.org
Cc: Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] MAINTAINERS: Update Ronnie Sahlberg's address
Date: Thu, 28 Dec 2023 20:36:12 +0700
Message-ID: <20231228133611.8816-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1767; i=bagasdotme@gmail.com; h=from:subject; bh=nqlU6hrskpxEZ2QpVb1+Hcg1h5UX5JIrbT9uZ4c8XvA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKm9lcePZ/3ZZRBstPgme7rfyTLDp2+mHzWIn2J7J9D7/ IdtEi6aHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZhIrjQjw8/sm3vzfhz3P33R adHvi5zMiy0VjVQ6Ms8qhQYFKJVO+cTIcEd4rsXbh9yWvlPd9nvd2sbLG7hAz//CuxuJ7Av3G4Y y8QAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Emails to <lsahlber@redhat.com> bounce (address not found), since he
had left Red Hat some time ago.

Update his address to personal gmail one and add corresponding .mailmap
entry.

Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 19eb49e55836b0..76501bc09c8200 100644
--- a/.mailmap
+++ b/.mailmap
@@ -508,6 +508,7 @@ Rocky Liao <quic_rjliao@quicinc.com> <rjliao@codeaurora.org>
 Roman Gushchin <roman.gushchin@linux.dev> <guro@fb.com>
 Roman Gushchin <roman.gushchin@linux.dev> <guroan@gmail.com>
 Roman Gushchin <roman.gushchin@linux.dev> <klamm@yandex-team.ru>
+Ronnie Sahlberg <ronniesahlberg@gmail.com> <lsahlber@redhat.com>
 Muchun Song <muchun.song@linux.dev> <songmuchun@bytedance.com>
 Muchun Song <muchun.song@linux.dev> <smuchun@gmail.com>
 Ross Zwisler <zwisler@kernel.org> <ross.zwisler@linux.intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 4acc4a3d4fcd96..3ffc06c19aa2ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5191,7 +5191,7 @@ X:	drivers/clk/clkdev.c
 COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)
 M:	Steve French <sfrench@samba.org>
 R:	Paulo Alcantara <pc@manguebit.com> (DFS, global name space)
-R:	Ronnie Sahlberg <lsahlber@redhat.com> (directory leases, sparse files)
+R:	Ronnie Sahlberg <ronniesahlberg@gmail.com> (directory leases, sparse files)
 R:	Shyam Prasad N <sprasad@microsoft.com> (multichannel)
 R:	Tom Talpey <tom@talpey.com> (RDMA, smbdirect)
 L:	linux-cifs@vger.kernel.org

base-commit: 453e404bc3e7cc24a63433a6cdeed2e0830496c0
-- 
An old man doll... just what I always wanted! - Clara


