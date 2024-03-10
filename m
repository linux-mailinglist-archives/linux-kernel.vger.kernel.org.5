Return-Path: <linux-kernel+bounces-98237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5E9877724
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DFFE1F21398
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E333CC4;
	Sun, 10 Mar 2024 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy82C4LC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085D2D60F;
	Sun, 10 Mar 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710077609; cv=none; b=OjMPl/9H0AopofizHx7zYbxIXqWR+h6X2klnj0AMv38cqKMPJ/v00o7jJEMcXvSulhcjw7n3g99Dh86YKyuG2wQxq1mQgWaodWWNenrQopqDt6Twxkvf/Z6TnHB7NpY8LUMoQ7aEa/5W4wECy8Yj8XNuMicNOCPAHwuBdsa8Txg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710077609; c=relaxed/simple;
	bh=adCC8oJqwX7Qy0rpAZbwP3ICARmDDN1OET3+D2SKn7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exRM3mb/sqQ0MIa7orCrB6eiIwUD6N1IQBnZza0NW9z4WKgZlZQ9r6bEjEjs5zP2bA/RlQcEGECvVGvX460AKbFIb7OmceLWGbLEZJEGWWW0MLPoDRbllg84OdCnLnOeM7GKVF3gZdyjXgdt2vd/iXC5b6avzdFUS9OOzfpKnjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy82C4LC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E393BC43390;
	Sun, 10 Mar 2024 13:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710077608;
	bh=adCC8oJqwX7Qy0rpAZbwP3ICARmDDN1OET3+D2SKn7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wy82C4LCHBMc6p8Xfu6+4TV0nma9vd9kT0UkVKNHn31srLZynKhtl9y34F8egpOK2
	 RotQRIuqQkrtOD4HF4e9obI5MmRrr2SXDm0h53hE45mIdG/jUFoJJsSKGFRzn7MDDp
	 KLJa02IcAJoU2t1SnmHGc8hlZt/JyGs4+USikbpElUvJvv+sH2vB5OUT/rGA2yCYsr
	 Q9bpDxXjXMrWjCj7yCQDHZFoVMRf4C5ego48DcaaQYA7Hj76V7v89QFOPaiu8lssAz
	 wfZbn1cVA6xgIaWs04AITHb9VZsP00roit8quvuWjN2a+Fv5YTihSvJh2ts//4sjQg
	 iKSY63GHlLM4A==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] kconfig: lxdialog: remove unused dialog colors
Date: Sun, 10 Mar 2024 22:32:58 +0900
Message-Id: <20240310133258.443787-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240310133258.443787-1-masahiroy@kernel.org>
References: <20240310133258.443787-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove inputbox_order, searchbox, searchbox_title, searchbox_border
because they are initialized, but not used anywhere.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lxdialog/dialog.h |  4 ----
 scripts/kconfig/lxdialog/util.c   | 18 ------------------
 2 files changed, 22 deletions(-)

diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index a501abf9fa31..2d15ba893fbf 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -91,10 +91,6 @@ struct dialog_info {
 	struct dialog_color button_label_active;
 	struct dialog_color button_label_inactive;
 	struct dialog_color inputbox;
-	struct dialog_color inputbox_border;
-	struct dialog_color searchbox;
-	struct dialog_color searchbox_title;
-	struct dialog_color searchbox_border;
 	struct dialog_color position_indicator;
 	struct dialog_color menubox;
 	struct dialog_color menubox_border;
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index d5315315b066..3fb7508b68a2 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -29,10 +29,6 @@ static void set_mono_theme(void)
 	dlg.button_label_active.atr = A_REVERSE;
 	dlg.button_label_inactive.atr = A_NORMAL;
 	dlg.inputbox.atr = A_NORMAL;
-	dlg.inputbox_border.atr = A_NORMAL;
-	dlg.searchbox.atr = A_NORMAL;
-	dlg.searchbox_title.atr = A_BOLD;
-	dlg.searchbox_border.atr = A_NORMAL;
 	dlg.position_indicator.atr = A_BOLD;
 	dlg.menubox.atr = A_NORMAL;
 	dlg.menubox_border.atr = A_NORMAL;
@@ -69,10 +65,6 @@ static void set_classic_theme(void)
 	DLG_COLOR(button_label_active,   COLOR_YELLOW, COLOR_BLUE,   true);
 	DLG_COLOR(button_label_inactive, COLOR_BLACK,  COLOR_WHITE,  true);
 	DLG_COLOR(inputbox,              COLOR_BLACK,  COLOR_WHITE,  false);
-	DLG_COLOR(inputbox_border,       COLOR_BLACK,  COLOR_WHITE,  false);
-	DLG_COLOR(searchbox,             COLOR_BLACK,  COLOR_WHITE,  false);
-	DLG_COLOR(searchbox_title,       COLOR_YELLOW, COLOR_WHITE,  true);
-	DLG_COLOR(searchbox_border,      COLOR_WHITE,  COLOR_WHITE,  true);
 	DLG_COLOR(position_indicator,    COLOR_YELLOW, COLOR_WHITE,  true);
 	DLG_COLOR(menubox,               COLOR_BLACK,  COLOR_WHITE,  false);
 	DLG_COLOR(menubox_border,        COLOR_WHITE,  COLOR_WHITE,  true);
@@ -104,11 +96,6 @@ static void set_blackbg_theme(void)
 	DLG_COLOR(button_label_inactive, COLOR_WHITE,  COLOR_BLACK, false);
 
 	DLG_COLOR(inputbox,         COLOR_YELLOW, COLOR_BLACK, false);
-	DLG_COLOR(inputbox_border,  COLOR_YELLOW, COLOR_BLACK, false);
-
-	DLG_COLOR(searchbox,        COLOR_YELLOW, COLOR_BLACK, false);
-	DLG_COLOR(searchbox_title,  COLOR_YELLOW, COLOR_BLACK, true);
-	DLG_COLOR(searchbox_border, COLOR_BLACK,  COLOR_BLACK, true);
 
 	DLG_COLOR(position_indicator, COLOR_RED, COLOR_BLACK,  false);
 
@@ -136,7 +123,6 @@ static void set_bluetitle_theme(void)
 	DLG_COLOR(title,               COLOR_BLUE,   COLOR_WHITE, true);
 	DLG_COLOR(button_key_active,   COLOR_YELLOW, COLOR_BLUE,  true);
 	DLG_COLOR(button_label_active, COLOR_WHITE,  COLOR_BLUE,  true);
-	DLG_COLOR(searchbox_title,     COLOR_BLUE,   COLOR_WHITE, true);
 	DLG_COLOR(position_indicator,  COLOR_BLUE,   COLOR_WHITE, true);
 	DLG_COLOR(tag,                 COLOR_BLUE,   COLOR_WHITE, true);
 	DLG_COLOR(tag_key,             COLOR_BLUE,   COLOR_WHITE, true);
@@ -189,10 +175,6 @@ static void init_dialog_colors(void)
 	init_one_color(&dlg.button_label_active);
 	init_one_color(&dlg.button_label_inactive);
 	init_one_color(&dlg.inputbox);
-	init_one_color(&dlg.inputbox_border);
-	init_one_color(&dlg.searchbox);
-	init_one_color(&dlg.searchbox_title);
-	init_one_color(&dlg.searchbox_border);
 	init_one_color(&dlg.position_indicator);
 	init_one_color(&dlg.menubox);
 	init_one_color(&dlg.menubox_border);
-- 
2.40.1


