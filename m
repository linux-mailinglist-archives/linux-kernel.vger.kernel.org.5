Return-Path: <linux-kernel+bounces-12433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7C481F4C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B741C217E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 05:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F03D23CC;
	Thu, 28 Dec 2023 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="juu8/ozp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B801FDD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 05:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbd453dfaeso58446b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703742397; x=1704347197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EQDr6Z7QmW8Ie5koy5Oa0ii9ZyG87dfdK/7a84RIhNw=;
        b=juu8/ozp7Kmwmfu086yRxn09J5achGFTxVbXLv0JU6i3p/tLbXYen9MDJTN0QhKQBb
         qu6CHQocJitV7p+aD+nkF41UwaxiVip/6R5NugjWx3y1Mpe8CGDrIzqRLRQ2Xv8b73g1
         8EiRJ2gTi07i3h3D9DZclbd1acAWnaTr71ub4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703742397; x=1704347197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQDr6Z7QmW8Ie5koy5Oa0ii9ZyG87dfdK/7a84RIhNw=;
        b=u8gSWwRCNTfQhJc0ipwI352B1f0xPTjfwNa+SRDj91oP/vac8LbcLjxD269DHz2zzx
         Z8N3pVhCSXIX+/Gis1KlPFeGRd2zfYTmnD6WTkeaCegUgsdc5Qk6RuVWd1u2sQ/FQQhV
         JNeaIixsPXy1dL/7KmPnlCbcWorfUIrp5ay4a0cp3RZ7b8+GMLytplBiFhGQ59NKynmU
         eeSYAF23fgA8UhTFZvVhm4zfrn3229XX1ye9vHig+gg8TgP0zqPsy3GpRfBzZW1jOcr4
         JVA4B2brMCQUZXII1GEiQXUwmmemrE4ba0I4vqd93t1s5PodXioZp0G9fUUhqBQtflUA
         Un5Q==
X-Gm-Message-State: AOJu0YwuNvzxlm98Ez+knCA5J1uKtBI8P9BsKo38HUa2cNiAwYz6UZzs
	yTKyS89qMQ4QWlSx9hqX/VHzXVoRo/h0
X-Google-Smtp-Source: AGHT+IGtb4PJPjrPu/b6afh8QGn62xF8h39xwqqmWOdmEZcp7X5gd0rz2kIYzeuI46Vv+KN/TtEoSA==
X-Received: by 2002:a05:6808:1a19:b0:3bb:8197:4fb with SMTP id bk25-20020a0568081a1900b003bb819704fbmr9634730oib.75.1703742396878;
        Wed, 27 Dec 2023 21:46:36 -0800 (PST)
Received: from basement.c.googlers.com.com (112.157.221.35.bc.googleusercontent.com. [35.221.157.112])
        by smtp.gmail.com with ESMTPSA id 6-20020aa79106000000b006d8fb8c3968sm12590663pfh.190.2023.12.27.21.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 21:46:36 -0800 (PST)
From: Tomasz Figa <tfiga@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesse Taube <Mr.Bossman075@gmail.com>,
	Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH] kconfig: menuconfig: Make hidden options show as dim
Date: Thu, 28 Dec 2023 14:46:30 +0900
Message-ID: <20231228054630.3595093-1-tfiga@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hidden options are toggled on (using 'z'), the number of options
on the screen can be overwhelming and may make it hard to distinguish
between available and hidden ones. Make them easier to distinguish by
displaying the hidden one as dim (using the A_DIM curses attribute).

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 scripts/kconfig/lxdialog/dialog.h  |  3 +++
 scripts/kconfig/lxdialog/menubox.c | 11 +++++++----
 scripts/kconfig/lxdialog/util.c    | 10 ++++++++++
 scripts/kconfig/mconf.c            | 18 ++++++++++++++++++
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index a501abf9fa31..d2ebdc6e2e28 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -128,6 +128,7 @@ void item_add_str(const char *fmt, ...);
 void item_set_tag(char tag);
 void item_set_data(void *p);
 void item_set_selected(int val);
+void item_set_hidden(int val);
 int item_activate_selected(void);
 void *item_data(void);
 char item_tag(void);
@@ -139,6 +140,7 @@ struct dialog_item {
 	char tag;
 	void *data;	/* pointer to menu item - used by menubox+checklist */
 	int selected;	/* Set to 1 by dialog_*() function if selected. */
+	int hidden;	/* Set to 1 if hidden. */
 };
 
 /* list of lialog_items */
@@ -157,6 +159,7 @@ int item_n(void);
 const char *item_str(void);
 int item_is_selected(void);
 int item_is_tag(char tag);
+int item_is_hidden(void);
 #define item_foreach() \
 	for (item_cur = item_head ? item_head: item_cur; \
 	     item_cur && (item_cur != &item_nil); item_cur = item_cur->next)
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index 0e333284e947..2cf1f24f67b6 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -51,9 +51,9 @@ static int menu_width, item_x;
  * Print menu item
  */
 static void do_print_item(WINDOW * win, const char *item, int line_y,
-			  int selected, int hotkey)
+			  int selected, int hotkey, int hidden)
 {
-	int j;
+	int j, attrs;
 	char *menu_item = malloc(menu_width + 1);
 
 	strncpy(menu_item, item, menu_width - item_x);
@@ -64,7 +64,10 @@ static void do_print_item(WINDOW * win, const char *item, int line_y,
 	wattrset(win, dlg.menubox.atr);
 	wmove(win, line_y, 0);
 	wclrtoeol(win);
-	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
+	attrs = selected ? dlg.item_selected.atr : dlg.item.atr;
+	if (hidden)
+		attrs |= A_DIM;
+	wattrset(win, attrs);
 	mvwaddstr(win, line_y, item_x, menu_item);
 	if (hotkey) {
 		wattrset(win, selected ? dlg.tag_key_selected.atr
@@ -81,7 +84,7 @@ static void do_print_item(WINDOW * win, const char *item, int line_y,
 #define print_item(index, choice, selected)				\
 do {									\
 	item_set(index);						\
-	do_print_item(menu, item_str(), choice, selected, !item_is_tag(':')); \
+	do_print_item(menu, item_str(), choice, selected, !item_is_tag(':'), item_is_hidden()); \
 } while (0)
 
 /*
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index 3f78fb265136..58d6ee96f7ec 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -635,6 +635,11 @@ void item_set_selected(int val)
 	item_cur->node.selected = val;
 }
 
+void item_set_hidden(int val)
+{
+	item_cur->node.hidden = val;
+}
+
 int item_activate_selected(void)
 {
 	item_foreach()
@@ -698,3 +703,8 @@ int item_is_tag(char tag)
 {
 	return (item_cur->node.tag == tag);
 }
+
+int item_is_hidden(void)
+{
+	return (item_cur->node.hidden != 0);
+}
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index eccc87a441e7..090121a1e5b6 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -539,6 +539,8 @@ static void build_conf(struct menu *menu)
 						  menu_is_empty(menu) ? "----" : "--->");
 				item_set_tag('m');
 				item_set_data(menu);
+				if (!visible)
+					item_set_hidden(TRUE);
 				if (single_menu_mode && menu->data)
 					goto conf_childs;
 				return;
@@ -548,6 +550,8 @@ static void build_conf(struct menu *menu)
 					item_make("   %*c*** %s ***", indent + 1, ' ', prompt);
 					item_set_tag(':');
 					item_set_data(menu);
+					if (!visible)
+						item_set_hidden(TRUE);
 				}
 				break;
 			default:
@@ -556,6 +560,8 @@ static void build_conf(struct menu *menu)
 					item_make("---%*c%s", indent + 1, ' ', prompt);
 					item_set_tag(':');
 					item_set_data(menu);
+					if (!visible)
+						item_set_hidden(TRUE);
 				}
 			}
 		} else
@@ -591,10 +597,14 @@ static void build_conf(struct menu *menu)
 			}
 			item_set_tag('t');
 			item_set_data(menu);
+			if (!visible)
+				item_set_hidden(TRUE);
 		} else {
 			item_make("   ");
 			item_set_tag(def_menu ? 't' : ':');
 			item_set_data(menu);
+			if (!visible)
+				item_set_hidden(TRUE);
 		}
 
 		item_add_str("%*c%s", indent + 1, ' ', menu_get_prompt(menu));
@@ -615,6 +625,8 @@ static void build_conf(struct menu *menu)
 			item_make("---%*c%s", indent + 1, ' ', menu_get_prompt(menu));
 			item_set_tag(':');
 			item_set_data(menu);
+			if (!visible)
+				item_set_hidden(TRUE);
 			goto conf_childs;
 		}
 		child_count++;
@@ -632,6 +644,8 @@ static void build_conf(struct menu *menu)
 					item_make("-%c-", val == no ? ' ' : '*');
 				item_set_tag('t');
 				item_set_data(menu);
+				if (!visible)
+					item_set_hidden(TRUE);
 				break;
 			case S_TRISTATE:
 				switch (val) {
@@ -648,6 +662,8 @@ static void build_conf(struct menu *menu)
 					item_make("-%c-", ch);
 				item_set_tag('t');
 				item_set_data(menu);
+				if (!visible)
+					item_set_hidden(TRUE);
 				break;
 			default:
 				tmp = 2 + strlen(sym_get_string_value(sym)); /* () = 2 */
@@ -660,6 +676,8 @@ static void build_conf(struct menu *menu)
 					     "" : " (NEW)");
 				item_set_tag('s');
 				item_set_data(menu);
+				if (!visible)
+					item_set_hidden(TRUE);
 				goto conf_childs;
 			}
 		}
-- 
2.43.0.472.g3155946c3a-goog


