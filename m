Return-Path: <linux-kernel+bounces-67707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248D4856F74
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488AF1C212BD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4D1145343;
	Thu, 15 Feb 2024 21:38:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1331419AA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033090; cv=none; b=NDufL5YHPvdFdu3UPK3B3t5MqMZX1S1n9hOryG9rxOksZErzO6S8s+4ilhI1Dj/TJ5XxeBDchZ+xlV6dutvJDUUnN7NnQHikT0NRX6EOj4cqNb/DvsBciJyIkiYRA4I9wiklgp9UOCtJZ/L/aWgzTiP+7cS0YDAHXQkIYkTQ21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033090; c=relaxed/simple;
	bh=Rd3uZUtDcGif03vpp90H8EosR4hflWPyH8BYaOZzKUQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=q3kmZYJdO/A3qAypxMr6pVoE2n/r3/QoCBGL6DMN7Os/A1hVotKHMJN6IeU2d0TohRoi4M5l30FWMRHA5fXa+7cCnzCP3v0yJAFcc6J3Wvm6/pfenESe1xbjVNUKHFUBSGnleZH5/JTG+91P4/pCVvtJJ7ss1z2nBzZU4YjDlu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6F7C433F1;
	Thu, 15 Feb 2024 21:38:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rajSL-00000000ef0-0a1O;
	Thu, 15 Feb 2024 16:39:45 -0500
Message-ID: <20240215213944.995797439@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 15 Feb 2024 16:39:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: [for-linus][PATCH 4/4] seq_buf: Fix kernel documentation
References: <20240215213916.385127578@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There are plenty of issues with the kernel documentation here:
  - misspelled word "sequence"
  - different style of returned value descriptions
  - missed Return sections
  - unaligned style of ASCII / NUL-terminated / etc
  - wrong function references

Fix all these.

Link: https://lkml.kernel.org/r/20240215152506.598340-1-andriy.shevchenko@linux.intel.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/seq_buf.h | 12 ++++++------
 lib/seq_buf.c           | 35 ++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 07b26e751060..fe41da005970 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -13,7 +13,7 @@
  */
 
 /**
- * seq_buf - seq buffer structure
+ * struct seq_buf - seq buffer structure
  * @buffer:	pointer to the buffer
  * @size:	size of the buffer
  * @len:	the amount of data inside the buffer
@@ -80,10 +80,10 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
 }
 
 /**
- * seq_buf_str - get %NUL-terminated C string from seq_buf
+ * seq_buf_str - get NUL-terminated C string from seq_buf
  * @s: the seq_buf handle
  *
- * This makes sure that the buffer in @s is nul terminated and
+ * This makes sure that the buffer in @s is NUL-terminated and
  * safe to read as a string.
  *
  * Note, if this is called when the buffer has overflowed, then
@@ -93,7 +93,7 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
  * After this function is called, s->buffer is safe to use
  * in string operations.
  *
- * Returns @s->buf after making sure it is terminated.
+ * Returns: @s->buf after making sure it is terminated.
  */
 static inline const char *seq_buf_str(struct seq_buf *s)
 {
@@ -113,7 +113,7 @@ static inline const char *seq_buf_str(struct seq_buf *s)
  * @s: the seq_buf handle
  * @bufp: the beginning of the buffer is stored here
  *
- * Return the number of bytes available in the buffer, or zero if
+ * Returns: the number of bytes available in the buffer, or zero if
  * there's no space.
  */
 static inline size_t seq_buf_get_buf(struct seq_buf *s, char **bufp)
@@ -135,7 +135,7 @@ static inline size_t seq_buf_get_buf(struct seq_buf *s, char **bufp)
  * @num: the number of bytes to commit
  *
  * Commit @num bytes of data written to a buffer previously acquired
- * by seq_buf_get.  To signal an error condition, or that the data
+ * by seq_buf_get_buf(). To signal an error condition, or that the data
  * didn't fit in the available space, pass a negative @num value.
  */
 static inline void seq_buf_commit(struct seq_buf *s, int num)
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index dfbfdc497d85..f3f3436d60a9 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -32,7 +32,7 @@
  * @s: the seq_buf descriptor
  * @len: The length to see if it can fit in the current buffer
  *
- * Returns true if there's enough unused space in the seq_buf buffer
+ * Returns: true if there's enough unused space in the seq_buf buffer
  * to fit the amount of new data according to @len.
  */
 static bool seq_buf_can_fit(struct seq_buf *s, size_t len)
@@ -45,7 +45,7 @@ static bool seq_buf_can_fit(struct seq_buf *s, size_t len)
  * @m: the seq_file descriptor that is the destination
  * @s: the seq_buf descriptor that is the source.
  *
- * Returns zero on success, non zero otherwise
+ * Returns: zero on success, non-zero otherwise.
  */
 int seq_buf_print_seq(struct seq_file *m, struct seq_buf *s)
 {
@@ -60,9 +60,9 @@ int seq_buf_print_seq(struct seq_file *m, struct seq_buf *s)
  * @fmt: printf format string
  * @args: va_list of arguments from a printf() type function
  *
- * Writes a vnprintf() format into the sequencce buffer.
+ * Writes a vnprintf() format into the sequence buffer.
  *
- * Returns zero on success, -1 on overflow.
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_vprintf(struct seq_buf *s, const char *fmt, va_list args)
 {
@@ -88,7 +88,7 @@ int seq_buf_vprintf(struct seq_buf *s, const char *fmt, va_list args)
  *
  * Writes a printf() format into the sequence buffer.
  *
- * Returns zero on success, -1 on overflow.
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
 {
@@ -104,12 +104,12 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
 EXPORT_SYMBOL_GPL(seq_buf_printf);
 
 /**
- * seq_buf_do_printk - printk seq_buf line by line
+ * seq_buf_do_printk - printk() seq_buf line by line
  * @s: seq_buf descriptor
  * @lvl: printk level
  *
  * printk()-s a multi-line sequential buffer line by line. The function
- * makes sure that the buffer in @s is nul terminated and safe to read
+ * makes sure that the buffer in @s is NUL-terminated and safe to read
  * as a string.
  */
 void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
@@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(seq_buf_do_printk);
  * This function will take the format and the binary array and finish
  * the conversion into the ASCII string within the buffer.
  *
- * Returns zero on success, -1 on overflow.
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary)
 {
@@ -177,7 +177,7 @@ int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary)
  *
  * Copy a simple string into the sequence buffer.
  *
- * Returns zero on success, -1 on overflow
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_puts(struct seq_buf *s, const char *str)
 {
@@ -206,7 +206,7 @@ EXPORT_SYMBOL_GPL(seq_buf_puts);
  *
  * Copy a single character into the sequence buffer.
  *
- * Returns zero on success, -1 on overflow
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_putc(struct seq_buf *s, unsigned char c)
 {
@@ -222,7 +222,7 @@ int seq_buf_putc(struct seq_buf *s, unsigned char c)
 EXPORT_SYMBOL_GPL(seq_buf_putc);
 
 /**
- * seq_buf_putmem - write raw data into the sequenc buffer
+ * seq_buf_putmem - write raw data into the sequence buffer
  * @s: seq_buf descriptor
  * @mem: The raw memory to copy into the buffer
  * @len: The length of the raw memory to copy (in bytes)
@@ -231,7 +231,7 @@ EXPORT_SYMBOL_GPL(seq_buf_putc);
  * buffer and a strcpy() would not work. Using this function allows
  * for such cases.
  *
- * Returns zero on success, -1 on overflow
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len)
 {
@@ -259,7 +259,7 @@ int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len)
  * raw memory into the buffer it writes its ASCII representation of it
  * in hex characters.
  *
- * Returns zero on success, -1 on overflow
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
 		       unsigned int len)
@@ -307,7 +307,7 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
  *
  * Write a path name into the sequence buffer.
  *
- * Returns the number of written bytes on success, -1 on overflow
+ * Returns: the number of written bytes on success, -1 on overflow.
  */
 int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
 {
@@ -342,6 +342,7 @@ int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
  * or until it reaches the end of the content in the buffer (@s->len),
  * whichever comes first.
  *
+ * Returns:
  * On success, it returns a positive number of the number of bytes
  * it copied.
  *
@@ -392,11 +393,11 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, size_t start, int cnt)
  * linebuf size is maximal length for one line.
  * 32 * 3 - maximum bytes per line, each printed into 2 chars + 1 for
  *	separating space
- * 2 - spaces separating hex dump and ascii representation
- * 32 - ascii representation
+ * 2 - spaces separating hex dump and ASCII representation
+ * 32 - ASCII representation
  * 1 - terminating '\0'
  *
- * Returns zero on success, -1 on overflow
+ * Returns: zero on success, -1 on overflow.
  */
 int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str, int prefix_type,
 		     int rowsize, int groupsize,
-- 
2.43.0



