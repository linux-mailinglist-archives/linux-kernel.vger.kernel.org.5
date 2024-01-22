Return-Path: <linux-kernel+bounces-32861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A0D836107
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B482861C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D2248CE0;
	Mon, 22 Jan 2024 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdhujWBX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5748CC7;
	Mon, 22 Jan 2024 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921541; cv=none; b=ghkPxL7C48iyRKJiTFqZfs0tumy2abjZhdqNyTd9KtDQ1XeuAxU2acol8h+NiA8oxkUbXS4Y2xVa7rNXD8Dkf+po+993uVXJFx9FPUMhvuAe47oYW8moJmjPvAWVTyhOCQODgDxdgytjGebR16XN6qDlfq8L4/mnbt6M3rSK8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921541; c=relaxed/simple;
	bh=KGvlQ+oVy6yStyRJhHG28NzaVDmYtacIFUS99+0CPKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiOwjkGg5PZJwlDk/rlT5/KX3JGVWN+wnyoljCtT1NWMUZiiOwUF+m3nBuVYJRbN6rpLQ33PmR9PPzXDoVjW+Y8zmFD5AGsf7aps06DO3wq5in+1ZWCxx5Q4iOrfXKH5AkJ4nxVfttdWQ+9Dzv+mY5N92D3tSNDj7M3U8ZlQEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdhujWBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907F8C433B2;
	Mon, 22 Jan 2024 11:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921540;
	bh=KGvlQ+oVy6yStyRJhHG28NzaVDmYtacIFUS99+0CPKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdhujWBXEwTcKd/m2R1Vj/rOmHmYjc+BIT/++VzfoZbkM/aBjaukyMLbu9u4jtghg
	 L0p7gNudth/wnrspysxqGevIT5XtXJ9/1OoczKLHJ/CO5nJMKbQw5yMJAyK8poF7iM
	 inhazAMY72yYOWKs65IsP8cXD+o4gTrnSJQe9adgP3/lQWNY66gSWVkaPRAgRQeBSr
	 Gfy0iz+inAFod2/yOB2lNpMV6h8WWvC5UyZ4gDijjWZUzbKIaRzujIx0b+2M64rozL
	 ZwYLa4qqnN9Dr2KzFZ2fwwhcJ8Uz9rkHn5OMhT/4LZjcFTMFxPVINNtAIATx3pCboc
	 F/dXlGMyqlwDQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 46/47] tty: vt: fix up kernel-doc
Date: Mon, 22 Jan 2024 12:04:00 +0100
Message-ID: <20240122110401.7289-47-jirislaby@kernel.org>
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
index bfe51af9a0f3..e9cdcf40fe14 100644
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
@@ -2633,8 +2632,8 @@ static inline int vc_translate_ascii(const struct vc_data *vc, int c)
 
 
 /**
- * vc_sanitize_unicode - Replace invalid Unicode code points with U+FFFD
- * @c: the received character, or U+FFFD for invalid sequences.
+ * vc_sanitize_unicode - Replace invalid Unicode code points with ``U+FFFD``
+ * @c: the received character, or ``U+FFFD`` for invalid sequences.
  */
 static inline int vc_sanitize_unicode(const int c)
 {
@@ -2645,14 +2644,15 @@ static inline int vc_sanitize_unicode(const int c)
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
@@ -3030,16 +3030,16 @@ struct tty_driver *console_driver;
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
@@ -3047,8 +3047,8 @@ struct tty_driver *console_driver;
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
@@ -3960,7 +3960,7 @@ static void vtconsole_deinit_device(struct con_driver *con)
  * RETURNS: zero if unbound, nonzero if bound
  *
  * Drivers can call this and if zero, they should release
- * all resources allocated on con_startup()
+ * all resources allocated on &consw.con_startup()
  */
 int con_is_bound(const struct consw *csw)
 {
diff --git a/include/linux/console.h b/include/linux/console.h
index f1a334ad268d..d6d8b7e6b93b 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -155,7 +155,7 @@ static inline void con_debug_leave(void) { }
  */
 
 /**
- * cons_flags - General console flags
+ * enum cons_flags - General console flags
  * @CON_PRINTBUFFER:	Used by newly registered consoles to avoid duplicate
  *			output of messages that were already shown by boot
  *			consoles or read by userspace via syslog() syscall.
@@ -236,7 +236,7 @@ struct nbcon_state {
 static_assert(sizeof(struct nbcon_state) <= sizeof(int));
 
 /**
- * nbcon_prio - console owner priority for nbcon consoles
+ * enum nbcon_prio - console owner priority for nbcon consoles
  * @NBCON_PRIO_NONE:		Unused
  * @NBCON_PRIO_NORMAL:		Normal (non-emergency) usage
  * @NBCON_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
@@ -468,7 +468,7 @@ static inline bool console_is_registered(const struct console *con)
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


