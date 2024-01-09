Return-Path: <linux-kernel+bounces-21196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A6828B9D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178141C22D2D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D273C08D;
	Tue,  9 Jan 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX6XZXx3"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43393BB4C;
	Tue,  9 Jan 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e43e48a16so28598095e9.2;
        Tue, 09 Jan 2024 09:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704823098; x=1705427898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jpUtuzXOnCEqHGuFl9LL4Al2mrUJlNSjgLnKSAf1Ws0=;
        b=AX6XZXx3cFGDVjyLiWXk8oT9oSecKCEIH3u3ZEdW/F6gQrooS/PFVRPByGOBSXR6Ry
         4ov2unT2T4jNQeX3pXVFPyYZ4Uij1n/iThTp5JoZgaaQo+PbhCf2nb1yo9T557rb0DPW
         2g/AMPjE4hITqzBbEVgxnWkFc+ndBieH9ZxK8EJs5cZHe0944FZwyCWuuDI9QMOXq541
         VCTvS8eM6gpsD5YV1Ei8woRvG4fzlgecAF2QOoTMC6MGdRj+JB/eJCQWP1aO8WsJfffo
         KalvAIZtihBVXQeRZI/id3759No19ifjsEBe9/oH1z7TjE0edyBf/bAeqGqn1j4CgFCc
         94PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704823098; x=1705427898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpUtuzXOnCEqHGuFl9LL4Al2mrUJlNSjgLnKSAf1Ws0=;
        b=Ti4O3tbL0WRecEkZ2g+dqm3Ri3wXfF080IFu8BilvyQKyfmiQXRI1FyvP0fWWO3JwT
         zlsI7kKSq23WG8cDbFzCidjVhT33TFI78j99hq/dsfYTEUtxZY9palRzzWs6OPdYhEOm
         aELtPwSsL2CfcCsbkCsZjExKllU4NV7ynidcf5tw+iCy8QhdcZP44mMxOZmHpL26jY9b
         fepkfoffZEmfzlaSVHB0VcGMvKzyE+FDwBC1v7sSk5Eoa0pytwIBJqoJHDgz1tVO5+kl
         /32inACeR76E1CtzrvJmz7kDCnrPkicO0oO1i4dBUwW7v7avudcDdDCVyjnF7eBtzMQk
         iVEA==
X-Gm-Message-State: AOJu0Yz8RVG40xJz8F5EpwiS8XkHVP1ZVJUVTgiZdRWtMH+EhZO8Adyc
	XXGgRqje0VZEqQK5aHojQBf9WbUtG5s=
X-Google-Smtp-Source: AGHT+IHKcG3xLgIZvkIf6WXKaw2viLsbGnjXdHGB+gUG0ScLL60G2Y8/mqRCqsevl+1FE7O5XIddlw==
X-Received: by 2002:a05:600c:a05:b0:40d:9237:dada with SMTP id z5-20020a05600c0a0500b0040d9237dadamr2958932wmp.103.1704823097807;
        Tue, 09 Jan 2024 09:58:17 -0800 (PST)
Received: from macminim1.retailmedia.com ([2a01:e0a:b14:c1f0:617b:c61e:d65f:861e])
        by smtp.googlemail.com with ESMTPSA id iv14-20020a05600c548e00b0040e3733a32bsm15777075wmb.41.2024.01.09.09.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:58:17 -0800 (PST)
From: Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
To: 
Cc: Erwan Velu <e.velu@criteo.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Huang Rui <ray.huang@amd.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/2] admin-guide: Fixing typos
Date: Tue,  9 Jan 2024 18:57:53 +0100
Message-ID: <20240109175801.447943-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes two typos in the admin-guide.

- a missing e in "reference_perf".
- the amd_pstate sysfs path uses a dash instead of an underscore.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 Documentation/admin-guide/acpi/cppc_sysfs.rst | 2 +-
 Documentation/admin-guide/pm/amd-pstate.rst   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/acpi/cppc_sysfs.rst b/Documentation/admin-guide/acpi/cppc_sysfs.rst
index e53d76365aa7..36981c667823 100644
--- a/Documentation/admin-guide/acpi/cppc_sysfs.rst
+++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
@@ -75,4 +75,4 @@ taking two different snapshots of feedback counters at time T1 and T2.
   delivered_counter_delta = fbc_t2[del] - fbc_t1[del]
   reference_counter_delta = fbc_t2[ref] - fbc_t1[ref]
 
-  delivered_perf = (refernce_perf x delivered_counter_delta) / reference_counter_delta
+  delivered_perf = (reference_perf x delivered_counter_delta) / reference_counter_delta
diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1cf40f69278c..9eb26014d34b 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -361,7 +361,7 @@ Global Attributes
 
 ``amd-pstate`` exposes several global attributes (files) in ``sysfs`` to
 control its functionality at the system level.  They are located in the
-``/sys/devices/system/cpu/amd-pstate/`` directory and affect all CPUs.
+``/sys/devices/system/cpu/amd_pstate/`` directory and affect all CPUs.
 
 ``status``
 	Operation mode of the driver: "active", "passive" or "disable".
-- 
2.43.0


