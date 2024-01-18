Return-Path: <linux-kernel+bounces-29831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8131083142A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BCD1F23155
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F1335883;
	Thu, 18 Jan 2024 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEPYShIE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6B35291;
	Thu, 18 Jan 2024 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564778; cv=none; b=eo1hxdVvP4jUxuHmp6rtJUNfPyFKxKcf9ZYf24apo/hgsxdOZs83LKVizpfoTUoIoOzXOGE/L+hbT2m6hlZddOuF8nTboNt9YkVkMvdfR76njxpnTw5mtoKwTqiJ29qK/FqrIfl2mrRHnJ4Ufr+nE7rJ5vF4Koc25nmg3F29qBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564778; c=relaxed/simple;
	bh=sch2oSklySkkA5uKtgIFo49P/8fkBuU14RBK4x6PEBU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=ETi4X8/tn685zd6cZWHBH1CFNwFSaCDx6B68dnzUxhM046deiCpPwUBAff3/GNADAmQ7wNTdwpzLUHalZucEF7ZVSUPstcXOnJeNNQUTF4O6AHe+SmsdEni/2G2+PD3l6XFOpzvP40pdHce4q3VHIDbPTvtUcXtG+q5O91U/pLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEPYShIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CF4C43390;
	Thu, 18 Jan 2024 07:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564778;
	bh=sch2oSklySkkA5uKtgIFo49P/8fkBuU14RBK4x6PEBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aEPYShIE76jCj+iduQRivOTb09yxfqTVTSqr5ORmMOkMCTfOhC5uEdCl48+co51+F
	 kHXx1EHOJoFu7L5XxQyTQh+bh1JII43MUMi00CnBHVSvmYe3yS6x0M4CEEMHgTrfF5
	 caJmj0QYayz73wDPVrOHF04dUQFTxMVl5C7BwodZoGZ7xot16aBBOava7BH92g07Hp
	 Iim94CsF+B3D+FwbbhRR0E1AUiJXi6R7xlf+UP9W2NNvCYxoJ5m4zG7hdrjckv8NBo
	 WOPmv1wgYSamFep6aK3I4PHzrHSi57FnB4rP5FAGimg5KXHRO4MvKYgH+eRdLPsRLG
	 We3bbtudrbk2g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 44/45] tty: vt: fix up kernel-doc
Date: Thu, 18 Jan 2024 08:57:55 +0100
Message-ID: <20240118075756.10541-45-jirislaby@kernel.org>
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

selection.c and vt.c still uses tabs in the kernel-doc. This misrenders the
functions in the output -- sphinx misinterprets the description. So
remove these tabs, incl. those around dashes.

'enum' keyword is needed before enum names. Fix that.

Superfluous \n after the comments are also removed. They are not
completely faulty, but this unifies all the kernel-doc in the files.

Finally fix up the cross references.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/selection.c | 30 ++++++-------
 drivers/tty/vt/vt.c        | 86 +++++++++++++++++++-------------------
 include/linux/console.h    |  6 +--
 3 files changed, 62 insertions(+), 60 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 34ee09f5a8f4..564341f1a74f 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -73,10 +73,12 @@ sel_pos(int n, bool unicode)
 }
 
 /**
- *	clear_selection		-	remove current selection
+ * clear_selection - remove current selection
  *
- *	Remove the current selection highlight, if any from the console
- *	holding the selection. The caller must hold the console lock.
+ * Remove the current selection highlight, if any from the console holding the
+ * selection.
+ *
+ * Locking: The caller must hold the console lock.
  */
 void clear_selection(void)
 {
@@ -110,13 +112,13 @@ static inline int inword(const u32 c)
 }
 
 /**
- *	sel_loadlut()		-	load the LUT table
- *	@lut: user table
+ * sel_loadlut() - load the LUT table
+ * @lut: user table
  *
- *	Load the LUT table from user space. Make a temporary copy so a partial
- *	update doesn't make a mess.
+ * Load the LUT table from user space. Make a temporary copy so a partial
+ * update doesn't make a mess.
  *
- *	Locking: The console lock is acquired.
+ * Locking: The console lock is acquired.
  */
 int sel_loadlut(u32 __user *lut)
 {
@@ -173,14 +175,14 @@ static int store_utf8(u32 c, char *p)
 }
 
 /**
- *	set_selection_user	-	set the current selection.
- *	@sel: user selection info
- *	@tty: the console tty
+ * set_selection_user - set the current selection.
+ * @sel: user selection info
+ * @tty: the console tty
  *
- *	Invoked by the ioctl handle for the vt layer.
+ * Invoked by the ioctl handle for the vt layer.
  *
- *	The entire selection process is managed under the console_lock. It's
- *	 a lot under the lock but its hardly a performance path
+ * Locking: The entire selection process is managed under the console_lock.
+ * It's a lot under the lock but its hardly a performance path.
  */
 int set_selection_user(const struct tiocl_selection __user *sel,
 		       struct tty_struct *tty)
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 35d303017653..72d089b502fe 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1115,21 +1115,20 @@ static inline int resize_screen(struct vc_data *vc, int width, int height,
 }
 
 /**
- *	vc_do_resize	-	resizing method for the tty
- *	@tty: tty being resized
- *	@vc: virtual console private data
- *	@cols: columns
- *	@lines: lines
- *	@from_user: invoked by a user?
+ * vc_do_resize - resizing method for the tty
+ * @tty: tty being resized
+ * @vc: virtual console private data
+ * @cols: columns
+ * @lines: lines
+ * @from_user: invoked by a user?
  *
- *	Resize a virtual console, clipping according to the actual constraints.
- *	If the caller passes a tty structure then update the termios winsize
- *	information and perform any necessary signal handling.
+ * Resize a virtual console, clipping according to the actual constraints. If
+ * the caller passes a tty structure then update the termios winsize
+ * information and perform any necessary signal handling.
  *
- *	Caller must hold the console semaphore. Takes the termios rwsem and
- *	ctrl.lock of the tty IFF a tty is passed.
+ * Locking: Caller must hold the console semaphore. Takes the termios rwsem and
+ * ctrl.lock of the tty IFF a tty is passed.
  */
-
 static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 			unsigned int cols, unsigned int lines, bool from_user)
 {
@@ -1277,16 +1276,17 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 }
 
 /**
- *	__vc_resize		-	resize a VT
- *	@vc: virtual console
- *	@cols: columns
- *	@rows: rows
- *	@from_user: invoked by a user?
+ * __vc_resize - resize a VT
+ * @vc: virtual console
+ * @cols: columns
+ * @rows: rows
+ * @from_user: invoked by a user?
+ *
+ * Resize a virtual console as seen from the console end of things. We use the
+ * common vc_do_resize() method to update the structures.
  *
- *	Resize a virtual console as seen from the console end of things. We
- *	use the common vc_do_resize methods to update the structures. The
- *	caller must hold the console sem to protect console internals and
- *	vc->port.tty
+ * Locking: The caller must hold the console sem to protect console internals
+ * and @vc->port.tty.
  */
 int __vc_resize(struct vc_data *vc, unsigned int cols, unsigned int rows,
 		bool from_user)
@@ -1296,16 +1296,15 @@ int __vc_resize(struct vc_data *vc, unsigned int cols, unsigned int rows,
 EXPORT_SYMBOL(__vc_resize);
 
 /**
- *	vt_resize		-	resize a VT
- *	@tty: tty to resize
- *	@ws: winsize attributes
+ * vt_resize - resize a VT
+ * @tty: tty to resize
+ * @ws: winsize attributes
  *
- *	Resize a virtual terminal. This is called by the tty layer as we
- *	register our own handler for resizing. The mutual helper does all
- *	the actual work.
+ * Resize a virtual terminal. This is called by the tty layer as we register
+ * our own handler for resizing. The mutual helper does all the actual work.
  *
- *	Takes the console sem and the called methods then take the tty
- *	termios_rwsem and the tty ctrl.lock in that order.
+ * Locking: Takes the console sem and the called methods then take the tty
+ * termios_rwsem and the tty ctrl.lock in that order.
  */
 static int vt_resize(struct tty_struct *tty, struct winsize *ws)
 {
@@ -2647,8 +2646,8 @@ static inline int vc_translate_ascii(const struct vc_data *vc, int c)
 
 
 /**
- * vc_sanitize_unicode - Replace invalid Unicode code points with U+FFFD
- * @c: the received character, or U+FFFD for invalid sequences.
+ * vc_sanitize_unicode - Replace invalid Unicode code points with ``U+FFFD``
+ * @c: the received character, or ``U+FFFD`` for invalid sequences.
  */
 static inline int vc_sanitize_unicode(const int c)
 {
@@ -2659,14 +2658,15 @@ static inline int vc_sanitize_unicode(const int c)
 }
 
 /**
- * vc_translate_unicode - Combine UTF-8 into Unicode in @vc_utf_char
+ * vc_translate_unicode - Combine UTF-8 into Unicode in &vc_data.vc_utf_char
  * @vc: virtual console
  * @c: character to translate
  * @rescan: we return true if we need more (continuation) data
  *
- * @vc_utf_char is the being-constructed unicode character.
- * @vc_utf_count is the number of continuation bytes still expected to arrive.
- * @vc_npar is the number of continuation bytes arrived so far.
+ * * &vc_data.vc_utf_char is the being-constructed unicode character.
+ * * &vc_data.vc_utf_count is the number of continuation bytes still expected to
+ *   arrive.
+ * * &vc_data.vc_npar is the number of continuation bytes arrived so far.
  */
 static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
 {
@@ -3044,16 +3044,16 @@ struct tty_driver *console_driver;
 #ifdef CONFIG_VT_CONSOLE
 
 /**
- * vt_kmsg_redirect() - Sets/gets the kernel message console
- * @new:	The new virtual terminal number or -1 if the console should stay
- * 		unchanged
+ * vt_kmsg_redirect() - sets/gets the kernel message console
+ * @new: the new virtual terminal number or -1 if the console should stay
+ *	unchanged
  *
  * By default, the kernel messages are always printed on the current virtual
  * console. However, the user may modify that default with the
- * TIOCL_SETKMSGREDIRECT ioctl call.
+ * %TIOCL_SETKMSGREDIRECT ioctl call.
  *
  * This function sets the kernel message console to be @new. It returns the old
- * virtual console number. The virtual terminal number 0 (both as parameter and
+ * virtual console number. The virtual terminal number %0 (both as parameter and
  * return value) means no redirection (i.e. always printed on the currently
  * active console).
  *
@@ -3061,8 +3061,8 @@ struct tty_driver *console_driver;
  * value is not modified. You may use the macro vt_get_kmsg_redirect() in that
  * case to make the code more understandable.
  *
- * When the kernel is compiled without CONFIG_VT_CONSOLE, this function ignores
- * the parameter and always returns 0.
+ * When the kernel is compiled without %CONFIG_VT_CONSOLE, this function ignores
+ * the parameter and always returns %0.
  */
 int vt_kmsg_redirect(int new)
 {
@@ -3974,7 +3974,7 @@ static void vtconsole_deinit_device(struct con_driver *con)
  * RETURNS: zero if unbound, nonzero if bound
  *
  * Drivers can call this and if zero, they should release
- * all resources allocated on con_startup()
+ * all resources allocated on &consw.con_startup()
  */
 int con_is_bound(const struct consw *csw)
 {
diff --git a/include/linux/console.h b/include/linux/console.h
index e0d5d84e918a..b105675b7ec4 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -163,7 +163,7 @@ static inline void con_debug_leave(void) { }
  */
 
 /**
- * cons_flags - General console flags
+ * enum cons_flags - General console flags
  * @CON_PRINTBUFFER:	Used by newly registered consoles to avoid duplicate
  *			output of messages that were already shown by boot
  *			consoles or read by userspace via syslog() syscall.
@@ -244,7 +244,7 @@ struct nbcon_state {
 static_assert(sizeof(struct nbcon_state) <= sizeof(int));
 
 /**
- * nbcon_prio - console owner priority for nbcon consoles
+ * enum nbcon_prio - console owner priority for nbcon consoles
  * @NBCON_PRIO_NONE:		Unused
  * @NBCON_PRIO_NORMAL:		Normal (non-emergency) usage
  * @NBCON_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
@@ -476,7 +476,7 @@ static inline bool console_is_registered(const struct console *con)
  * for_each_console() - Iterator over registered consoles
  * @con:	struct console pointer used as loop cursor
  *
- * The console list and the console->flags are immutable while iterating.
+ * The console list and the &console.flags are immutable while iterating.
  *
  * Requires console_list_lock to be held.
  */
-- 
2.43.0


