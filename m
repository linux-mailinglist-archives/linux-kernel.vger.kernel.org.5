Return-Path: <linux-kernel+bounces-67376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36570856A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B8D1C23A31
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D7136665;
	Thu, 15 Feb 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0xs+jnzl"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5313666C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016985; cv=none; b=tPztMLWMOu13+9EZVeXCdfIvj4MozK/tmfEH04QwJ0XA9wRX4Ns0YVe7rhSnJJTunZjxn5KD/T4h5eRbcCMtquq2V1I7b4xiW1TOwkucMLIDJgW8SIUC+tviGXFdkuiQXuVqeGTtuAddhX4J3ZAnj8V/F7y5m4oDPKbRqDxjGwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016985; c=relaxed/simple;
	bh=dhlcr81IYWrh82Ko2N01ekFoW11RZWY/i4I+x8etkvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgdVCrL4Wc0njdcrBMhj3CA1MjHP7fwYmzfqQ0KCyoysgYh6kgaMEV58szSfSYjvHxAy7IDV/H6M1tXWdrGvLsNuv/eyA4ifMbfc8YwBARgHSnw6NW8mjT2QFmUtnqcP3CK6oHQpt9SeJX9Sz9vm7/SMaIpZ9I+SotKe0X3omoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0xs+jnzl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7QfUkPY0q9Vg63Ue1vIAtywM3Voll+7cS6+wG56w5N8=; b=0xs+jnzlqXsPXqXO8A8VewRgux
	OKDYMbGWBskVDVM/YYsttI7QtQK+oj0Bes8pFYoyyTMFiQUWqluakuWUF8Oid8hHkLmIC6wqhnDOQ
	oJ2ndnDyhn7HnOuED2sKh5sgDwRMw8PxrL4nTjxrANNRmLITxAGZOT1/yp4ON/3XdBG/JI2EnqG23
	y4/9EIlW0BEdSQSMavWcw5XAcVzTLYh59S4IGfirPfQ1AT9SAfQqBkRMaSJg71E9kODB/EfzM8QAR
	Joc6dyLsdMUB87SFspJp1FenI+TwUca3EosNwS1pi83n1/7sOKXaCf7lHjDraZQMOJWFnYxBTCJTC
	rkSMEMuQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rafF0-0000000H7jz-1WgD;
	Thu, 15 Feb 2024 17:09:42 +0000
Message-ID: <36521a24-f21e-463f-be9c-c11f35d72959@infradead.org>
Date: Thu, 15 Feb 2024 09:09:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] seq_buf: Fix kernel documentation
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
References: <20240215152506.598340-1-andriy.shevchenko@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240215152506.598340-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/15/24 07:25, Andy Shevchenko wrote:
> There are plenty of issues with the kernel documentation here:
>   - misspelled word "sequence"
>   - different style of returned value descriptions
>   - missed Return sections
>   - unaligned style of ASCII / NUL-terminated / etc
>   - wrong function references
> 
> Fix all these.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice, thank you.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  include/linux/seq_buf.h | 12 ++++++------
>  lib/seq_buf.c           | 35 ++++++++++++++++++-----------------
>  2 files changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index 07b26e751060..fe41da005970 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -13,7 +13,7 @@
>   */
>  
>  /**
> - * seq_buf - seq buffer structure
> + * struct seq_buf - seq buffer structure
>   * @buffer:	pointer to the buffer
>   * @size:	size of the buffer
>   * @len:	the amount of data inside the buffer
> @@ -80,10 +80,10 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
>  }
>  
>  /**
> - * seq_buf_str - get %NUL-terminated C string from seq_buf
> + * seq_buf_str - get NUL-terminated C string from seq_buf
>   * @s: the seq_buf handle
>   *
> - * This makes sure that the buffer in @s is nul terminated and
> + * This makes sure that the buffer in @s is NUL-terminated and
>   * safe to read as a string.
>   *
>   * Note, if this is called when the buffer has overflowed, then
> @@ -93,7 +93,7 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
>   * After this function is called, s->buffer is safe to use
>   * in string operations.
>   *
> - * Returns @s->buf after making sure it is terminated.
> + * Returns: @s->buf after making sure it is terminated.
>   */
>  static inline const char *seq_buf_str(struct seq_buf *s)
>  {
> @@ -113,7 +113,7 @@ static inline const char *seq_buf_str(struct seq_buf *s)
>   * @s: the seq_buf handle
>   * @bufp: the beginning of the buffer is stored here
>   *
> - * Return the number of bytes available in the buffer, or zero if
> + * Returns: the number of bytes available in the buffer, or zero if
>   * there's no space.
>   */
>  static inline size_t seq_buf_get_buf(struct seq_buf *s, char **bufp)
> @@ -135,7 +135,7 @@ static inline size_t seq_buf_get_buf(struct seq_buf *s, char **bufp)
>   * @num: the number of bytes to commit
>   *
>   * Commit @num bytes of data written to a buffer previously acquired
> - * by seq_buf_get.  To signal an error condition, or that the data
> + * by seq_buf_get_buf(). To signal an error condition, or that the data
>   * didn't fit in the available space, pass a negative @num value.
>   */
>  static inline void seq_buf_commit(struct seq_buf *s, int num)
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index dfbfdc497d85..f3f3436d60a9 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -32,7 +32,7 @@
>   * @s: the seq_buf descriptor
>   * @len: The length to see if it can fit in the current buffer
>   *
> - * Returns true if there's enough unused space in the seq_buf buffer
> + * Returns: true if there's enough unused space in the seq_buf buffer
>   * to fit the amount of new data according to @len.
>   */
>  static bool seq_buf_can_fit(struct seq_buf *s, size_t len)
> @@ -45,7 +45,7 @@ static bool seq_buf_can_fit(struct seq_buf *s, size_t len)
>   * @m: the seq_file descriptor that is the destination
>   * @s: the seq_buf descriptor that is the source.
>   *
> - * Returns zero on success, non zero otherwise
> + * Returns: zero on success, non-zero otherwise.
>   */
>  int seq_buf_print_seq(struct seq_file *m, struct seq_buf *s)
>  {
> @@ -60,9 +60,9 @@ int seq_buf_print_seq(struct seq_file *m, struct seq_buf *s)
>   * @fmt: printf format string
>   * @args: va_list of arguments from a printf() type function
>   *
> - * Writes a vnprintf() format into the sequencce buffer.
> + * Writes a vnprintf() format into the sequence buffer.
>   *
> - * Returns zero on success, -1 on overflow.
> + * Returns: zero on success, -1 on overflow.
>   */
>  int seq_buf_vprintf(struct seq_buf *s, const char *fmt, va_list args)
>  {
> @@ -88,7 +88,7 @@ int seq_buf_vprintf(struct seq_buf *s, const char *fmt, va_list args)
>   *
>   * Writes a printf() format into the sequence buffer.
>   *
> - * Returns zero on success, -1 on overflow.
> + * Returns: zero on success, -1 on overflow.
>   */
>  int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
>  {
> @@ -104,12 +104,12 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
>  EXPORT_SYMBOL_GPL(seq_buf_printf);
>  
>  /**
> - * seq_buf_do_printk - printk seq_buf line by line
> + * seq_buf_do_printk - printk() seq_buf line by line
>   * @s: seq_buf descriptor
>   * @lvl: printk level
>   *
>   * printk()-s a multi-line sequential buffer line by line. The function
> - * makes sure that the buffer in @s is nul terminated and safe to read
> + * makes sure that the buffer in @s is NUL-terminated and safe to read
>   * as a string.
>   */
>  void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
> @@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(seq_buf_do_printk);
>   * This function will take the format and the binary array and finish
>   * the conversion into the ASCII string within the buffer.
>   *
> - * Returns zero on success, -1 on overflow.
> + * Returns: zero on success, -1 on overflow.
>   */
>  int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary)
>  {
> @@ -177,7 +177,7 @@ int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary)
>   *
>   * Copy a simple string into the sequence buffer.
>   *
> - * Returns zero on success, -1 on overflow
> + * Returns: zero on success, -1 on overflow.
>   */
>  int seq_buf_puts(struct seq_buf *s, const char *str)
>  {
> @@ -206,7 +206,7 @@ EXPORT_SYMBOL_GPL(seq_buf_puts);
>   *
>   * Copy a single character into the sequence buffer.
>   *
> - * Returns zero on success, -1 on overflow
> + * Returns: zero on success, -1 on overflow.
>   */
>  int seq_buf_putc(struct seq_buf *s, unsigned char c)
>  {
> @@ -222,7 +222,7 @@ int seq_buf_putc(struct seq_buf *s, unsigned char c)
>  EXPORT_SYMBOL_GPL(seq_buf_putc);
>  
>  /**
> - * seq_buf_putmem - write raw data into the sequenc buffer
> + * seq_buf_putmem - write raw data into the sequence buffer
>   * @s: seq_buf descriptor
>   * @mem: The raw memory to copy into the buffer
>   * @len: The length of the raw memory to copy (in bytes)
> @@ -231,7 +231,7 @@ EXPORT_SYMBOL_GPL(seq_buf_putc);
>   * buffer and a strcpy() would not work. Using this function allows
>   * for such cases.
>   *
> - * Returns zero on success, -1 on overflow
> + * Returns: zero on success, -1 on overflow.
>   */
>  int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len)
>  {
> @@ -259,7 +259,7 @@ int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len)
>   * raw memory into the buffer it writes its ASCII representation of it
>   * in hex characters.
>   *
> - * Returns zero on success, -1 on overflow
> + * Returns: zero on success, -1 on overflow.
>   */
>  int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
>  		       unsigned int len)
> @@ -307,7 +307,7 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
>   *
>   * Write a path name into the sequence buffer.
>   *
> - * Returns the number of written bytes on success, -1 on overflow
> + * Returns: the number of written bytes on success, -1 on overflow.
>   */
>  int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
>  {
> @@ -342,6 +342,7 @@ int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
>   * or until it reaches the end of the content in the buffer (@s->len),
>   * whichever comes first.
>   *
> + * Returns:
>   * On success, it returns a positive number of the number of bytes
>   * it copied.
>   *
> @@ -392,11 +393,11 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, size_t start, int cnt)
>   * linebuf size is maximal length for one line.
>   * 32 * 3 - maximum bytes per line, each printed into 2 chars + 1 for
>   *	separating space
> - * 2 - spaces separating hex dump and ascii representation
> - * 32 - ascii representation
> + * 2 - spaces separating hex dump and ASCII representation
> + * 32 - ASCII representation
>   * 1 - terminating '\0'
>   *
> - * Returns zero on success, -1 on overflow
> + * Returns: zero on success, -1 on overflow.
>   */
>  int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str, int prefix_type,
>  		     int rowsize, int groupsize,

-- 
#Randy

