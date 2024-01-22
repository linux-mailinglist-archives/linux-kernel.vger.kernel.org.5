Return-Path: <linux-kernel+bounces-32827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4BD83609B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AA21F21CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251463DBB9;
	Mon, 22 Jan 2024 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1zrR13O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD63AC1A;
	Mon, 22 Jan 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921478; cv=none; b=I0Q5OR/y4181qaZLq3fPNeHrItalWc7P/ZGwKpfrgiUYcAtAP7FIWHCHSYyNZeObzPqu5xgk1TBZdxOqOrmX6HyekZac5CXwmaNe7vd9eG6hg+VrFntSfFQ2PgF2ngoZSMwhz+s7u1zmikIS3lcBH+zZ80Nvl5ytIFKCBDnVxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921478; c=relaxed/simple;
	bh=pgGIPZEv6XKRoBjxEYNP5d5VFoktwTyHpvsavE6t6hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tjxqg2urpYjTPjJfVEdS+oamCP4Fh+5DWKWhdjlnDx1OZVtI4bxjKEGTJzXi8gBIu0fF2xheN8DLtwdQqtf2GJ1CDAfJQJ/y39i9SaehtfLU747dbcfJ9Bl0XiiKoESXCuZKzvVx/gi+dKSFSkQmLMRTLxjkvf8C3XBMoZo3mIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1zrR13O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2104C43394;
	Mon, 22 Jan 2024 11:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921478;
	bh=pgGIPZEv6XKRoBjxEYNP5d5VFoktwTyHpvsavE6t6hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1zrR13O7ksrcZuCBkqZLPcdSw9H+cLj4VTWU5aSVLChEmzGLcVN6Sun6vTSlr81P
	 AAkvzro622ADRqqZyGBH4qfpVz4zQqskmGwscb0W2pRFuD9zuZjCoRkyWYvW6GVEij
	 +A6FaVleDQEsO30v5NPLqije3P0YnmqLHIHXamRHN64Zkwz5L4bgcIjsOoMvb2VsjS
	 +exYCXRdiAA/vrypS0C1b55jxcCNK3+SNKgJ9ouClAKFPKk3401n0p/FWbEDmWmObC
	 r4Poprz367YnCfI24y19m8KaFSqrxVvt0KOFiZpnJ1hgTKuE1m9MTUZYtgzCrdbFM7
	 CLimfLD2VQwnA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 18/47] tty: vt: remove extern from functions in selection.h
Date: Mon, 22 Jan 2024 12:03:32 +0100
Message-ID: <20240122110401.7289-19-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unneeded 'extern' keyword from function prototypes in
selection.h. This makes it more readable as no more wrapping is needed
on many places.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/selection.h | 52 ++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/include/linux/selection.h b/include/linux/selection.h
index 533509f6ba4f..bab7d30d3446 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -14,15 +14,14 @@
 struct tty_struct;
 struct vc_data;
 
-extern void clear_selection(void);
-extern int set_selection_user(const struct tiocl_selection __user *sel,
-			      struct tty_struct *tty);
-extern int set_selection_kernel(struct tiocl_selection *v,
-				struct tty_struct *tty);
-extern int paste_selection(struct tty_struct *tty);
-extern int sel_loadlut(u32 __user *lut);
-extern int mouse_reporting(void);
-extern void mouse_report(struct tty_struct * tty, int butt, int mrx, int mry);
+void clear_selection(void);
+int set_selection_user(const struct tiocl_selection __user *sel,
+		       struct tty_struct *tty);
+int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty);
+int paste_selection(struct tty_struct *tty);
+int sel_loadlut(u32 __user *lut);
+int mouse_reporting(void);
+void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry);
 
 bool vc_is_sel(const struct vc_data *vc);
 
@@ -33,24 +32,21 @@ extern unsigned char default_red[];
 extern unsigned char default_grn[];
 extern unsigned char default_blu[];
 
-extern unsigned short *screen_pos(const struct vc_data *vc, int w_offset,
-		bool viewed);
-extern u16 screen_glyph(const struct vc_data *vc, int offset);
-extern u32 screen_glyph_unicode(const struct vc_data *vc, int offset);
-extern void complement_pos(struct vc_data *vc, int offset);
-extern void invert_screen(struct vc_data *vc, int offset, int count, bool viewed);
-
-extern void getconsxy(const struct vc_data *vc, unsigned char xy[static 2]);
-extern void putconsxy(struct vc_data *vc, unsigned char xy[static const 2]);
-
-extern u16 vcs_scr_readw(const struct vc_data *vc, const u16 *org);
-extern void vcs_scr_writew(struct vc_data *vc, u16 val, u16 *org);
-extern void vcs_scr_updated(struct vc_data *vc);
-
-extern int vc_uniscr_check(struct vc_data *vc);
-extern void vc_uniscr_copy_line(const struct vc_data *vc, void *dest,
-				bool viewed,
-				unsigned int row, unsigned int col,
-				unsigned int nr);
+unsigned short *screen_pos(const struct vc_data *vc, int w_offset, bool viewed);
+u16 screen_glyph(const struct vc_data *vc, int offset);
+u32 screen_glyph_unicode(const struct vc_data *vc, int offset);
+void complement_pos(struct vc_data *vc, int offset);
+void invert_screen(struct vc_data *vc, int offset, int count, bool viewed);
+
+void getconsxy(const struct vc_data *vc, unsigned char xy[static 2]);
+void putconsxy(struct vc_data *vc, unsigned char xy[static const 2]);
+
+u16 vcs_scr_readw(const struct vc_data *vc, const u16 *org);
+void vcs_scr_writew(struct vc_data *vc, u16 val, u16 *org);
+void vcs_scr_updated(struct vc_data *vc);
+
+int vc_uniscr_check(struct vc_data *vc);
+void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
+			 unsigned int row, unsigned int col, unsigned int nr);
 
 #endif
-- 
2.43.0


