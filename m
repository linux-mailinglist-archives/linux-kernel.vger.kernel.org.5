Return-Path: <linux-kernel+bounces-18421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE52825D37
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D4EB233CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C02360BB;
	Fri,  5 Jan 2024 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvS+0SPl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97436091
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6da0d1d6674so116900b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 15:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704498283; x=1705103083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vOWF5W5ygeOU6ZVOJhzom/o70P/K+HdT9XioW9hRinY=;
        b=TvS+0SPl3m/sUCx+xSTK328O6Gcp2NbY5M+1xtfzWShLPR1KQnJpMVO0WxJUVpCRd3
         NAq2EEmmT5CcOeVwuPb8CKkij9MHvrUpMI5YWsq0yqqFLeNwB40267wLJaL5RwPKXCV2
         b0oFbFWvYKpH0d41aPLJUVe32mJ2blRwXyLdm7RRNVLv4dOFhh+ZoOM0Y4Txa59P7i65
         0roBK0OC+b/9+SglpiBBCVuNsFDpWg6gKcjMzhuZLImm73MxCARs/xZ3uKpass90qSUX
         d3eRufMbSzQ0uo5fH7xSBwfSkktIfMqB5PgPSajZ7qVGa4jUYjkbhpyvBd1iy8ngHJoS
         rDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704498283; x=1705103083;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOWF5W5ygeOU6ZVOJhzom/o70P/K+HdT9XioW9hRinY=;
        b=WEBqX5FjgBdzGtsCawbRS4nifoa4ULz90ix6oIOx6LVaNZJC8c5D2zuYMdE6T75w0A
         V8Y6f3fhZZQrkUIN+jyVeiE27UtmCOqKGBuRFU4D7sNAMURMNDudj2psFM0Gm6QUpxRD
         srU5d2jfGEFDxxQsJ9d0cuyFdvLCWzoR2Qx6tkZOLJlOlLYnROPDxSHn2gAS0uf89yRJ
         oD7h6cw2ukmEcTotOyjSr7vGjeGbzXrMHJAY9tDGIxObmC01sNW+M8TwLAGAnN3HP+dm
         0PQ8rhvp7XmEacCXfQuF2XE6FfEoZ1DRiasGizObKwMToscX3plkV2RgiWTHtW/No/QX
         U7Mg==
X-Gm-Message-State: AOJu0YzfBhYn+gUipU8VoFzVJgKLJb4mKBmOsHQmvrQR3c8Lll4GBPUL
	sv94sCGp62U3sAKEEzbzDPxPDLftuepqWeLeGhI=
X-Google-Smtp-Source: AGHT+IGzTdTEq/wmYGt3o26TCoi2ort/HBoKZjH8itjA7JR3vq5ikU+Oe60UsKCp+DpskRMtqZQA6yIwwtkA
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:6a00:80a:b0:6da:aec4:7370 with SMTP id
 m10-20020a056a00080a00b006daaec47370mr17163pfk.1.1704498283369; Fri, 05 Jan
 2024 15:44:43 -0800 (PST)
Date: Fri, 05 Jan 2024 23:44:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGGUmGUC/3WNQQ6CMBBFr0K6tqatbQiuvIdxMcwM0ASooaZqC
 He3sNJElu9n3ptZRJ48R3EuZjFx8tGHMcPpUAjsYGxZesosjDJWaeXkyE8ewPcSkSw4qkulSOT
 z+8SNf22p6y1z5+MjTO+tnPS6/okkLbVEy6oGgyVqfWlDaHs+YhjEWklmzzTZdGypYXIVcPVtH oo9A8qGGEBBTfjza1mWD1bWAnsNAQAA
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704498281; l=1266;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=hQhbYUZaKOHjatvhE+T9/u2qLZJty00SlBRZVAlzcM0=; b=XSUeX+7MW2gESeZHcefEu3/HgdIQTw9ikwKKEj1rLiT7iju0NoOjnXbFbNZdPsscMLYNXry/L
 oH9CLwPApjvCul0P72jqpRBW3GS8i9VbdlEmAZ4z1yIKqRtuKLE3+MI
X-Mailer: b4 0.12.4
Message-ID: <20240105-newemail-v3-1-3dc8ae035b54@google.com>
Subject: [PATCH v3] mailmap: Switch email for Tanzir Hasan
From: Tanzir Hasan <tanzirh@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>, 
	Tanzir Hasan <tanzhasanwork@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"

From: Tanzir Hasan <tanzhasanwork@gmail.com>

Access to the tanzirh@google.com email will be revoked upon the end of
the internship.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
Changes in v3:
- Used correct reviewed-by tag
- Link to v2: https://lore.kernel.org/r/20240105-newemail-v2-1-a7fdeaa0abdc@google.com

Changes in v2:
- Fixed alphabetical ordering
- Link to v1: https://lore.kernel.org/r/20240105-newemail-v1-1-c4e0ba2c7c11@google.com
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 9a9069235f0d..36d5bd3fdc8e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -578,6 +578,7 @@ Surabhi Vishnoi <quic_svishnoi@quicinc.com> <svishnoi@codeaurora.org>
 Takashi YOSHII <takashi.yoshii.zj@renesas.com>
 Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> <tamizhr@codeaurora.org>
 Taniya Das <quic_tdas@quicinc.com> <tdas@codeaurora.org>
+Tanzir Hasan <tanzhasanwork@gmail.com> <tanzirh@google.com>
 Tejun Heo <htejun@gmail.com>
 Tomeu Vizoso <tomeu@tomeuvizoso.net> <tomeu.vizoso@collabora.com>
 Thomas Graf <tgraf@suug.ch>

---
base-commit: ac865f00af293d081356bec56eea90815094a60e
change-id: 20240105-newemail-ccd4a5db700d

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


