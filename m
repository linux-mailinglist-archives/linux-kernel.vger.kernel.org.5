Return-Path: <linux-kernel+bounces-132544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A1A89967C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E843F285DCF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0253D32C6C;
	Fri,  5 Apr 2024 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqNU42Cl"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3E339A8;
	Fri,  5 Apr 2024 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301821; cv=none; b=PUMiloMq5PVJx5MVN13eb40ZKaCtkG3kO07KxrUCcZ0L87oAknDZ4b4kbiofwCuNHM4YkYneXT8EcD5Em7088uDpPpvP29w5LSpAVoEKhjGOKRDs+xyPIQzegkRZ75mV6GjimLRvk5TMDmg1mV97mNMi7nygakWPbWalA0a45xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301821; c=relaxed/simple;
	bh=9Psm8kVfBEI7AmLYPbJAAhlV1Kf+ekU/JgcrW89HMH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIiux616R9zZmfrs6720W64G4TqP3Yfhf6wz777IHXUmHaqoldCUQog6p1wWwdQ7Rcggn9uB1DXlFEwnflC+eULuHUOwUudrTlJN5ux+2pwKx396hlXtdDte6mtdLQQk20zj0ub65GL2whJjG1+BJihMfQ31j8mSSQD42p29MaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqNU42Cl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0d82c529fso17557415ad.2;
        Fri, 05 Apr 2024 00:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712301819; x=1712906619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hIoGiu9ZtQIe724ASqROd3u0XmfszC++HoK35yFLoM=;
        b=dqNU42ClNSAtc6A9TldjQNMWMVvjF3KuwtRfZlrenLBUIfGNcxwLLS+4jZbFfa9+QK
         ER4KPYDqOXdiFjnnjfuMzdihj2wTIPw1jhVesl893s3m8oxVzUoi0oKXi58ki5+ZB0ZX
         dhFGfm7BHCA/Xde9jZKQzBYyWlV45Cazg+VQbmst/30LijRQwN0uMTwsWp1gmILaynoC
         s8830ub7DbkmcPjbHcnvE0mD8fIy7viO4NwOJtmnAEiD63426VbgffdHfdPEEhmZGYSD
         2YfwPw58CzuzbqlOGGKZZAbdJBUsBeyv3usINftJB3QvKZqtgXwNTvmoPFtY4IGNicdD
         BHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301819; x=1712906619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hIoGiu9ZtQIe724ASqROd3u0XmfszC++HoK35yFLoM=;
        b=ncc6TRDSzq8ZGsf9CnXJNfmmsedw4HKRCJbPZzdAbGVFDUojaC+wjteXrefKRF9UZS
         3VFNl0oLEDen31jU9za2yYB/xyfcCNiJT9i/rfQBmX/H10Ia5V2aYyFqdNlQ9chM6Nfh
         hEsEPGqJeq+XEQ1ZSe2pk4UaIGzdVwcTuWeJ480oOfjF3r9BZcSyQx7Dy/LPOlnhqKI7
         lGc00SjGBOSQqMnkYq8I4SYX7z4MhGh/YLHsSv2uYVlB4UI85QjIk7Dp8rYL7JVJENFT
         1ejmfbQArGkQJp4/Yeqzht3HBIvDmwiMDlP2V7QKTFfk/UJfTjP6q+ue4HMjRL6zuCGR
         1sMw==
X-Forwarded-Encrypted: i=1; AJvYcCUhCKCcVxbDrNIM4ZbxWhRqUwglWM8Ixp8TJOs1aAPr+yfS9kVpFu7Wgq4QYLwM0gvg2SuT3j8k7ubcb0bICy2dYqSWG1r6KUwDehGbqz4ihC08iV+Yu45i8Eb/pMOPHcd4E9EuKgoZY00=
X-Gm-Message-State: AOJu0Ywz1/xY4YJoeRS3kSncGGzTlVjq/sl9RmZp4tecR1OU1hXLAhei
	E8tbE8yBzK6W9kbzBVYHGg18DkR6H+FgDFfgohKDs7cKjwxNXPMF
X-Google-Smtp-Source: AGHT+IH/utFHO2Ot8ZuMpxluwLIO/bMKapqrDETHQbP0Fbo/VFvSmQaocmCwDCiXnBGI/QFo37oBoA==
X-Received: by 2002:a17:902:e5ce:b0:1e2:3e19:e571 with SMTP id u14-20020a170902e5ce00b001e23e19e571mr795044plf.35.1712301819167;
        Fri, 05 Apr 2024 00:23:39 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001e0b5fd3c95sm844201plh.259.2024.04.05.00.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:23:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id EE5B518483F5F; Fri,  5 Apr 2024 14:23:36 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux bcachefs <linux-bcachefs@vger.kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/2] Documentation: filesystems: Add bcachefs toctree
Date: Fri,  5 Apr 2024 14:23:18 +0700
Message-ID: <20240405072320.23416-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405072320.23416-1-bagasdotme@gmail.com>
References: <20240405072320.23416-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=bagasdotme@gmail.com; h=from:subject; bh=9Psm8kVfBEI7AmLYPbJAAhlV1Kf+ekU/JgcrW89HMH0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDGn8y3SmX/+252yf9erOkk+JpfzdR/+szRc453v9ZdjNV 9k6Jc7vOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRZcmMDG8sP/ofWhq3fuf0 fqe3qx38MqyYmJiZjt27trXQRpkx9AkjQ+//++U2wltV4jl/7TmY9ETvVMmMCeb2XHv3Tr2bu/h HAzMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit eb386617be4bdf ("bcachefs: Errcode tracepoint, documentation")
adds initial bcachefs documentation (private error codes) but without
any table of contents tree for the filesystem docs, hence Sphinx warns:

Documentation/filesystems/bcachefs/errorcodes.rst: WARNING: document isn't included in any toctree

Add bcachefs toctree to fix above warning.

Fixes: eb386617be4b ("bcachefs: Errcode tracepoint, documentation")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/bcachefs/index.rst | 11 +++++++++++
 Documentation/filesystems/index.rst          |  1 +
 2 files changed, 12 insertions(+)
 create mode 100644 Documentation/filesystems/bcachefs/index.rst

diff --git a/Documentation/filesystems/bcachefs/index.rst b/Documentation/filesystems/bcachefs/index.rst
new file mode 100644
index 00000000000000..e2bd61ccd96fff
--- /dev/null
+++ b/Documentation/filesystems/bcachefs/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+bcachefs Documentation
+======================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
+
+   errorcodes
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 0ea1e44fa02823..1f9b4c905a6a7c 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -69,6 +69,7 @@ Documentation for filesystem implementations.
    afs
    autofs
    autofs-mount-control
+   bcachefs/index
    befs
    bfs
    btrfs
-- 
An old man doll... just what I always wanted! - Clara


