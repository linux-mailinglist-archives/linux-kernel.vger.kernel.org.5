Return-Path: <linux-kernel+bounces-29830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB6831428
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711301C2284A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9282A35281;
	Thu, 18 Jan 2024 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7rsVnzZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA9034CF0;
	Thu, 18 Jan 2024 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564776; cv=none; b=Ag144STAzQfZ683rethtELFdx3Rvm/ZEyBtUbjcbZ1UtsPGPGJcPd4Dy3Yd+fnFAZnjaN9vXkPVM3YvxnQSqhzcqCxTzhnVRcyVkIFV+QQHvV/UMGMTm97TnJsmrKvynTxbNwPAqCKhCf11m3zjXcjxOUJXROR1gMNJeLwMP4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564776; c=relaxed/simple;
	bh=RPsg4+ITmM9gFoQ7ZYe+JsyD9TMljUbzbnXkyjAN+G4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=F9VL/bPndsbukQ8nWmKQVi+2HIfyVz8aC+F+AQLaO6sC3FPKKsWPJwz3A2DcIXoIBi9L9CukSbhVmuIqvE9B0pxEmqrO84TLYft87Dc6vVMwOWg3MPUoDWaOem/B/ABx3H0VlC+HdifkYdkPelDmlzT0Uj5BKU0tQR1l/rXLOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7rsVnzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C647C433C7;
	Thu, 18 Jan 2024 07:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564776;
	bh=RPsg4+ITmM9gFoQ7ZYe+JsyD9TMljUbzbnXkyjAN+G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7rsVnzZNRbj8c9PpNiRg7tMJRfqPL27CBgh/2BYLhy+qMnsqAZ1SI3yukubMY6Pi
	 AqeWgCRa9QCvNhT6DfZWACmnjtde1LUWdPnComt6Z0SC6DukGCv61sYaSpKPaMy5ED
	 Tb2lkZz+jCZfbSru5IjhAQ3R7UyRWHJRoG2Q2d+ed2IFfP3HbrOknGR74/DblxShz3
	 HfDdHL6wK5w6kd2sjsm4mOfCT2YWLVhkmgSkGHrsJul0PrUtSR7Pu2lWRfyXHB0YpQ
	 PxZjwhTXiv4YCQpcKbcz+qchBV/Gz6yINg7rEhGp0Z6vJJzYvYlsq9D0uJWB+wPLr8
	 ILHwZO3irzVsQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 43/45] tty: vt: document the rest of struct consw
Date: Thu, 18 Jan 2024 08:57:54 +0100
Message-ID: <20240118075756.10541-44-jirislaby@kernel.org>
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

There are still members of struct consw which are not documented yet.
Fix that up, so we can generate kernel-doc for that struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/console.h | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 698a2f7576b0..e0d5d84e918a 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -45,8 +45,11 @@ enum vc_intensity;
 /**
  * struct consw - callbacks for consoles
  *
+ * @owner:      the module to get references of when this console is used
+ * @con_startup: set up the console and return its name (like VGA, EGA, ...)
  * @con_init:   initialize the console on @vc. @init is true for the very first
  *		call on this @vc.
+ * @con_deinit: deinitialize the console from @vc.
  * @con_clear:  erase @count characters at [@x, @y] on @vc. @count >= 1.
  * @con_putc:   emit one character with attributes @ca to [@x, @y] on @vc.
  *		(optional -- @con_putcs would be called instead)
@@ -60,12 +63,33 @@ enum vc_intensity;
  * @con_blank:  blank/unblank the console. The target mode is passed in @blank.
  *		@mode_switch is set if changing from/to text/graphics. The hook
  *		is supposed to return true if a redraw is needed.
- * @con_set_palette: sets the palette of the console to @table (optional)
+ * @con_font_set: set console @vc font to @font with height @vpitch. @flags can
+ *		be %KD_FONT_FLAG_DONT_RECALC. (optional)
+ * @con_font_get: fetch the current font on @vc of height @vpitch into @font.
+ *		(optional)
+ * @con_font_default: set default font on @vc. @name can be %NULL or font name
+ *		to search for. @font can be filled back. (optional)
+ * @con_resize:	resize the @vc console to @width x @height. @from_user is true
+ *		when this change comes from the user space.
+ * @con_set_palette: sets the palette of the console @vc to @table (optional)
  * @con_scrolldelta: the contents of the console should be scrolled by @lines.
  *		     Invoked by user. (optional)
  * @con_set_origin: set origin (see &vc_data::vc_origin) of the @vc. If not
  *		provided or returns false, the origin is set to
  *		@vc->vc_screenbuf. (optional)
+ * @con_save_screen: save screen content into @vc->vc_screenbuf. Called e.g.
+ *		upon entering graphics. (optional)
+ * @con_build_attr: build attributes based on @color, @intensity and other
+ *		parameters. The result is used for both normal and erase
+ *		characters. (optional)
+ * @con_invert_region: invert a region of length @count on @vc starting at @p.
+ *		(optional)
+ * @con_debug_enter: prepare the console for the debugger. This includes, but
+ *		is not limited to, unblanking the console, loading an
+ *		appropriate palette, and allowing debugger generated output.
+ *		(optional)
+ * @con_debug_leave: restore the console to its pre-debug state as closely as
+ *		possible. (optional)
  */
 struct consw {
 	struct module *owner;
@@ -104,15 +128,7 @@ struct consw {
 			enum vc_intensity intensity,
 			bool blink, bool underline, bool reverse, bool italic);
 	void	(*con_invert_region)(struct vc_data *vc, u16 *p, int count);
-	/*
-	 * Prepare the console for the debugger.  This includes, but is not
-	 * limited to, unblanking the console, loading an appropriate
-	 * palette, and allowing debugger generated output.
-	 */
 	void	(*con_debug_enter)(struct vc_data *vc);
-	/*
-	 * Restore the console to its pre-debug state as closely as possible.
-	 */
 	void	(*con_debug_leave)(struct vc_data *vc);
 };
 
-- 
2.43.0


