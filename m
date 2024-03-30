Return-Path: <linux-kernel+bounces-125762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 460FC892BCF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41811F21CE1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133B538F84;
	Sat, 30 Mar 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OntbtAkJ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709DEBB;
	Sat, 30 Mar 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711812030; cv=none; b=i7/J4wglv1y7fiC8rf7Q5FmalV7MaoozLMGOA1zuh4Y9pXArSUmNoUbeK4fK2I77YC8PLRBge99yQNt8VxRzESEUxMyhf7v26NdZmJmv7sdXpXzCi3w8SkFTycI0xMntFxftdVLD2s3Ib7bZhAmTyRIxuDUcuYjZD3jwJ6+dK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711812030; c=relaxed/simple;
	bh=ZDhfm018vFSDBueWA5CDz9WphpZ9cc6YhQfGOzOtKsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubsPki+IOFW0QuJ89vr69afVUjlFSLMFtcJNZk8gH0Qn6FmX8x64PKmMMDK3qpHUaiyukq78/fwVvfBM2WlPbdlLFOmRqcD8+9nfnAhsWZ+Q6twGwXk1v3n9BBNo8HPMWE9SnG+I87hO1P6amMn+/RuFBVj1g/ETKIobZl/KEiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OntbtAkJ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d6a1ad08b8so27825871fa.1;
        Sat, 30 Mar 2024 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711812026; x=1712416826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TkI73TeGKWiCOeoizdJ5ne1BtmQ7mP66j97GuGKs6xU=;
        b=OntbtAkJf5HA6zlRpo2NPS9h9MCd7jpqrdnvrFOJdEzVt8/EjVEpIz8mClWwpMRKMC
         GdPdoRDE9R7jbn6ajuzu6ZnGcBybqSJgEvtjnAAj2Aygf+nCFgC/3aRi8rMTooZuqnTX
         1A/hxKGAvQ7jvl14xiYNsZT9bGzHjKsIUBUi+NtUSfPH2lk9I1mcxMOM/4/ZcKfAVU+U
         iE8ic1PUbP/LhR6AV5g/pAZNxQ1R8Yy4Wwov9KBThhhLb6DEEncv6knKHyAufoGGIisM
         9KoQE5rj7OULlu9/p3gL7YrXT7LX2lLBNXk1cGQH3dqqmp2bLrcNBjTnnnQNmb/jyORq
         U/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711812026; x=1712416826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkI73TeGKWiCOeoizdJ5ne1BtmQ7mP66j97GuGKs6xU=;
        b=YxYOoc24LdYaXSwQDbxlVnwrDXxCxvTk2NfsN07Wh+BN9Ng10TBe74aMYaM0q/otjZ
         99A6mqUjuUzj6z5NvY4Ti8KHQbEdvSAmstiCBrxOAJtRDjXbX4rE8Znh1PrizvhRplCj
         eBqBuNHj16r/mhXkivj620uGW2herDs0itFJcOfkUY1PoMeXxh6vpPm0+UYXCHAoRIZ5
         twWqzXqhkclGYC6kEnlEAO3hde7ltSawoBMlGkZ+JW4SeUC4pSOrbzQYx4uO0UQyMebS
         qf6qd5FTMrWNh63Hab2jNW5q5rCoBl3cBY/X7U11hahBZBP50IMtN22IAKEPDIndayLz
         x6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXk8U4hzgxLE9aU/6ySrvfFN9x7ypMqNJLV553z6LNYDc+QxlQICuuGyH3FABdgCW+SxKE+mw6cQ/0fhxgZPvof1/bGwbU/Up3IfPle
X-Gm-Message-State: AOJu0Yzh0/w0ThLSQi/daACvttu4LG/g3ULGq1P89WiI5FwP/Nh/0VoE
	xXEsnlPGNaSifBlcGQ1N2JEhjr0rpeoOEnE29PCtzLY3uayxO0rV
X-Google-Smtp-Source: AGHT+IEe3ngo3E5WRUbfz7Pyww4/Y1Pd9MCNaQ9smTiCu2RaQ2jSLxde2Y20V+Xx0O1NHcV8LtkIRg==
X-Received: by 2002:a05:651c:4d2:b0:2d6:aff5:1e65 with SMTP id e18-20020a05651c04d200b002d6aff51e65mr4613284lji.16.1711812025981;
        Sat, 30 Mar 2024 08:20:25 -0700 (PDT)
Received: from gentoo.. (213-65-159-17-no600.tbcn.telia.com. [213.65.159.17])
        by smtp.gmail.com with ESMTPSA id h7-20020a0564020e0700b00568e3d3337bsm3290714edh.18.2024.03.30.08.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 08:20:25 -0700 (PDT)
From: Isak Ellmer <isak01@gmail.com>
To: masahiroy@kernel.org
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Isak Ellmer <isak01@gmail.com>
Subject: [PATCH] kconfig: Fix typo HEIGTH to HEIGHT
Date: Sat, 30 Mar 2024 16:19:45 +0100
Message-ID: <20240330151945.95875-1-isak01@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a typo in some variables where height was misspelled as heigth.

Signed-off-by: Isak Ellmer <isak01@gmail.com>
---
 scripts/kconfig/lxdialog/checklist.c |  2 +-
 scripts/kconfig/lxdialog/dialog.h    | 12 ++++++------
 scripts/kconfig/lxdialog/inputbox.c  |  2 +-
 scripts/kconfig/lxdialog/menubox.c   |  2 +-
 scripts/kconfig/lxdialog/textbox.c   |  2 +-
 scripts/kconfig/lxdialog/util.c      |  2 +-
 scripts/kconfig/lxdialog/yesno.c     |  2 +-
 scripts/kconfig/mconf.c              |  4 ++--
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index 31d0a89fbeb7..75493302fb85 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -119,7 +119,7 @@ int dialog_checklist(const char *title, const char *prompt, int height,
 	}
 
 do_resize:
-	if (getmaxy(stdscr) < (height + CHECKLIST_HEIGTH_MIN))
+	if (getmaxy(stdscr) < (height + CHECKLIST_HEIGHT_MIN))
 		return -ERRDISPLAYTOOSMALL;
 	if (getmaxx(stdscr) < (width + CHECKLIST_WIDTH_MIN))
 		return -ERRDISPLAYTOOSMALL;
diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index 2d15ba893fbf..f6c2ebe6d1f9 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -162,17 +162,17 @@ int on_key_esc(WINDOW *win);
 int on_key_resize(void);
 
 /* minimum (re)size values */
-#define CHECKLIST_HEIGTH_MIN 6	/* For dialog_checklist() */
+#define CHECKLIST_HEIGHT_MIN 6	/* For dialog_checklist() */
 #define CHECKLIST_WIDTH_MIN 6
-#define INPUTBOX_HEIGTH_MIN 2	/* For dialog_inputbox() */
+#define INPUTBOX_HEIGHT_MIN 2	/* For dialog_inputbox() */
 #define INPUTBOX_WIDTH_MIN 2
-#define MENUBOX_HEIGTH_MIN 15	/* For dialog_menu() */
+#define MENUBOX_HEIGHT_MIN 15	/* For dialog_menu() */
 #define MENUBOX_WIDTH_MIN 65
-#define TEXTBOX_HEIGTH_MIN 8	/* For dialog_textbox() */
+#define TEXTBOX_HEIGHT_MIN 8	/* For dialog_textbox() */
 #define TEXTBOX_WIDTH_MIN 8
-#define YESNO_HEIGTH_MIN 4	/* For dialog_yesno() */
+#define YESNO_HEIGHT_MIN 4	/* For dialog_yesno() */
 #define YESNO_WIDTH_MIN 4
-#define WINDOW_HEIGTH_MIN 19	/* For init_dialog() */
+#define WINDOW_HEIGHT_MIN 19	/* For init_dialog() */
 #define WINDOW_WIDTH_MIN 80
 
 int init_dialog(const char *backtitle);
diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index 1dcfb288ee63..3c6e24b20f5b 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -43,7 +43,7 @@ int dialog_inputbox(const char *title, const char *prompt, int height, int width
 		strcpy(instr, init);
 
 do_resize:
-	if (getmaxy(stdscr) <= (height - INPUTBOX_HEIGTH_MIN))
+	if (getmaxy(stdscr) <= (height - INPUTBOX_HEIGHT_MIN))
 		return -ERRDISPLAYTOOSMALL;
 	if (getmaxx(stdscr) <= (width - INPUTBOX_WIDTH_MIN))
 		return -ERRDISPLAYTOOSMALL;
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index 0e333284e947..6e6244df0c56 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -172,7 +172,7 @@ int dialog_menu(const char *title, const char *prompt,
 do_resize:
 	height = getmaxy(stdscr);
 	width = getmaxx(stdscr);
-	if (height < MENUBOX_HEIGTH_MIN || width < MENUBOX_WIDTH_MIN)
+	if (height < MENUBOX_HEIGHT_MIN || width < MENUBOX_WIDTH_MIN)
 		return -ERRDISPLAYTOOSMALL;
 
 	height -= 4;
diff --git a/scripts/kconfig/lxdialog/textbox.c b/scripts/kconfig/lxdialog/textbox.c
index 058ed0e5bbd5..0abaf635978f 100644
--- a/scripts/kconfig/lxdialog/textbox.c
+++ b/scripts/kconfig/lxdialog/textbox.c
@@ -175,7 +175,7 @@ int dialog_textbox(const char *title, const char *tbuf, int initial_height,
 
 do_resize:
 	getmaxyx(stdscr, height, width);
-	if (height < TEXTBOX_HEIGTH_MIN || width < TEXTBOX_WIDTH_MIN)
+	if (height < TEXTBOX_HEIGHT_MIN || width < TEXTBOX_WIDTH_MIN)
 		return -ERRDISPLAYTOOSMALL;
 	if (initial_height != 0)
 		height = initial_height;
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index 3fb7508b68a2..f18e2a89f613 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -291,7 +291,7 @@ int init_dialog(const char *backtitle)
 	getyx(stdscr, saved_y, saved_x);
 
 	getmaxyx(stdscr, height, width);
-	if (height < WINDOW_HEIGTH_MIN || width < WINDOW_WIDTH_MIN) {
+	if (height < WINDOW_HEIGHT_MIN || width < WINDOW_WIDTH_MIN) {
 		endwin();
 		return -ERRDISPLAYTOOSMALL;
 	}
diff --git a/scripts/kconfig/lxdialog/yesno.c b/scripts/kconfig/lxdialog/yesno.c
index bcaac9b7bab2..b57d25e1549f 100644
--- a/scripts/kconfig/lxdialog/yesno.c
+++ b/scripts/kconfig/lxdialog/yesno.c
@@ -32,7 +32,7 @@ int dialog_yesno(const char *title, const char *prompt, int height, int width)
 	WINDOW *dialog;
 
 do_resize:
-	if (getmaxy(stdscr) < (height + YESNO_HEIGTH_MIN))
+	if (getmaxy(stdscr) < (height + YESNO_HEIGHT_MIN))
 		return -ERRDISPLAYTOOSMALL;
 	if (getmaxx(stdscr) < (width + YESNO_WIDTH_MIN))
 		return -ERRDISPLAYTOOSMALL;
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index f4bb391d50cf..c0969097447d 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -659,9 +659,9 @@ static void conf_choice(struct menu *menu)
 		dialog_clear();
 		res = dialog_checklist(prompt ? prompt : "Main Menu",
 					radiolist_instructions,
-					MENUBOX_HEIGTH_MIN,
+					MENUBOX_HEIGHT_MIN,
 					MENUBOX_WIDTH_MIN,
-					CHECKLIST_HEIGTH_MIN);
+					CHECKLIST_HEIGHT_MIN);
 		selected = item_activate_selected();
 		switch (res) {
 		case 0:
-- 
2.43.2


