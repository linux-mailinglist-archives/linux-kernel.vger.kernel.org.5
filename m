Return-Path: <linux-kernel+bounces-29804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2A78313D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E75A1C220E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFB928E36;
	Thu, 18 Jan 2024 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPKaUkcf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A628E25;
	Thu, 18 Jan 2024 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564714; cv=none; b=i2ywWyT1ANk01dplGQ5nChLmRVzwXC18DIwkmKT11U6UAEmaxmvfygo7pNOHlQoL2IgCR9AQpUMuI3Vt2UgybTXDhQvn8Hx4GMaMW+ZmiGTj39FaaBhrapeAPA00HdC3FfRhg/dRADSHTuj22hsEsV4zDyOBS2jZaKE1HtjQT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564714; c=relaxed/simple;
	bh=pgGIPZEv6XKRoBjxEYNP5d5VFoktwTyHpvsavE6t6hw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=qLlXVsLdGFHbRrpTKk5jausoDSmzrzyYG/0h4VgBZA4kKs9A5x2H96EWBWS2vyflRyDoYXidBFH8RrnuLBVBJj6F5mdlk8+Tp92Ai87VlasbFYsTENvBArOF5cLiAUKbNjWuoD7Gi+dH6JHtA1MI9y7+KAtxMgxqUSSRH+SMc1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPKaUkcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DC7C433C7;
	Thu, 18 Jan 2024 07:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564713;
	bh=pgGIPZEv6XKRoBjxEYNP5d5VFoktwTyHpvsavE6t6hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPKaUkcfw6LypUl2/lKpHaTq1Z1YtNqbyudbrae5rfyAD9SvB3Uv5iX5i4y3cVPaA
	 Ivnj4GRSdRCbsBz6QURCpzkVHXRlSecKgkSrUfkGNOgHS1Vbbrbz7rkJhzszdXGoZf
	 8i+gJt7aF1QUBrGx4FnaDUmqDEq58+xyTgv2Pwx7kyj/HIeeYw8jFVrHwsIU0IhLQm
	 Lajyhnsk6FvAn5/Cj9IvwDBu8TXvxXKDFIi5E7Ekequ1zJx9s47byk5TqOZrJD9X7F
	 RpvZgBgXVDMTAIax0neR3Cd2VByG3oFaEwr6Mf499qg4jvqbncsBfUvAeP/WEbsNxL
	 hXDzk/P3NLh0w==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 17/45] tty: vt: remove extern from functions in selection.h
Date: Thu, 18 Jan 2024 08:57:28 +0100
Message-ID: <20240118075756.10541-18-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118075756.10541-1-jirislaby@kernel.org>
References: <20240118075756.10541-1-jirislaby@kernel.org>
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


