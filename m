Return-Path: <linux-kernel+bounces-82156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A609868006
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FAC28E1A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04BE12FF66;
	Mon, 26 Feb 2024 18:47:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8E1292FF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973271; cv=none; b=r8DbMD4ymHDAkD/tf/b0hPwWxfvRIcZv26GSjjSE7xEz6T3xugGqOT9lQvP/ChJaDyRTf9KaO5dF9tMZXRk029Wyz216smyfA35yLl4A4Ud3SHpkrxRvP7dN/jXhmCQdCGMI5Uo73bI348WA1w6Ycnn3a5AS0E/M2co/jkOVB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973271; c=relaxed/simple;
	bh=IBgQ7YkMj+3tJKIboyqi6DmF4X89yamrjupGBGu5TUc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YvYCCfDalhgdyk/E4OFZWcr+uDx5K7Q6v+Yc5t2BWpfba0GEY94mH33w9xA1rsdbm8ghMFwHe8uhjXdvvEXkJM7Q94eN58pJt6CGsv0M3tCqEhcw2XDBDY3bKAg2UmDQY/4WTuJwoIEw3ar4y4tbKyOHdSjlwhnaQs90PWUa/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A376EC43390;
	Mon, 26 Feb 2024 18:47:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1reg2w-000000090ZS-40DS;
	Mon, 26 Feb 2024 13:49:50 -0500
Message-ID: <20240226184950.815545072@goodmis.org>
User-Agent: quilt/0.67
Date: Mon, 26 Feb 2024 13:49:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: [for-next][PATCH 1/5] ftrace: Fix most kernel-doc warnings
References: <20240226184932.303400070@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Randy Dunlap <rdunlap@infradead.org>

Reduce the number of kernel-doc warnings from 52 down to 10, i.e.,
fix 42 kernel-doc warnings by (a) using the Returns: format for
function return values or (b) using "@var:" instead of "@var -"
for function parameter descriptions.

Fix one return values list so that it is formatted correctly when
rendered for output.

Spell "non-zero" with a hyphen in several places.

Link: https://lore.kernel.org/linux-trace-kernel/20240223054833.15471-1-rdunlap@infradead.org

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/oe-kbuild-all/202312180518.X6fRyDSN-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 90 ++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 44 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 83ba342aef31..da1710499698 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1160,7 +1160,7 @@ __ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip)
  * Search a given @hash to see if a given instruction pointer (@ip)
  * exists in it.
  *
- * Returns the entry that holds the @ip if found. NULL otherwise.
+ * Returns: the entry that holds the @ip if found. NULL otherwise.
  */
 struct ftrace_func_entry *
 ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip)
@@ -1282,7 +1282,7 @@ static void free_ftrace_hash_rcu(struct ftrace_hash *hash)
 
 /**
  * ftrace_free_filter - remove all filters for an ftrace_ops
- * @ops - the ops to remove the filters from
+ * @ops: the ops to remove the filters from
  */
 void ftrace_free_filter(struct ftrace_ops *ops)
 {
@@ -1587,7 +1587,7 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
  * @end: end of range to search (inclusive). @end points to the last byte
  *	to check.
  *
- * Returns rec->ip if the related ftrace location is a least partly within
+ * Returns: rec->ip if the related ftrace location is a least partly within
  * the given address range. That is, the first address of the instruction
  * that is either a NOP or call to the function tracer. It checks the ftrace
  * internal tables to determine if the address belongs or not.
@@ -1607,9 +1607,10 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
  * ftrace_location - return the ftrace location
  * @ip: the instruction pointer to check
  *
- * If @ip matches the ftrace location, return @ip.
- * If @ip matches sym+0, return sym's ftrace location.
- * Otherwise, return 0.
+ * Returns:
+ * * If @ip matches the ftrace location, return @ip.
+ * * If @ip matches sym+0, return sym's ftrace location.
+ * * Otherwise, return 0.
  */
 unsigned long ftrace_location(unsigned long ip)
 {
@@ -1639,7 +1640,7 @@ unsigned long ftrace_location(unsigned long ip)
  * @start: start of range to search
  * @end: end of range to search (inclusive). @end points to the last byte to check.
  *
- * Returns 1 if @start and @end contains a ftrace location.
+ * Returns: 1 if @start and @end contains a ftrace location.
  * That is, the instruction that is either a NOP or call to
  * the function tracer. It checks the ftrace internal tables to
  * determine if the address belongs or not.
@@ -2574,7 +2575,7 @@ static void call_direct_funcs(unsigned long ip, unsigned long pip,
  * wants to convert to a callback that saves all regs. If FTRACE_FL_REGS
  * is not set, then it wants to convert to the normal callback.
  *
- * Returns the address of the trampoline to set to
+ * Returns: the address of the trampoline to set to
  */
 unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec)
 {
@@ -2615,7 +2616,7 @@ unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec)
  * a function that saves all the regs. Basically the '_EN' version
  * represents the current state of the function.
  *
- * Returns the address of the trampoline that is currently being called
+ * Returns: the address of the trampoline that is currently being called
  */
 unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec)
 {
@@ -2719,7 +2720,7 @@ struct ftrace_rec_iter {
 /**
  * ftrace_rec_iter_start - start up iterating over traced functions
  *
- * Returns an iterator handle that is used to iterate over all
+ * Returns: an iterator handle that is used to iterate over all
  * the records that represent address locations where functions
  * are traced.
  *
@@ -2751,7 +2752,7 @@ struct ftrace_rec_iter *ftrace_rec_iter_start(void)
  * ftrace_rec_iter_next - get the next record to process.
  * @iter: The handle to the iterator.
  *
- * Returns the next iterator after the given iterator @iter.
+ * Returns: the next iterator after the given iterator @iter.
  */
 struct ftrace_rec_iter *ftrace_rec_iter_next(struct ftrace_rec_iter *iter)
 {
@@ -2776,7 +2777,7 @@ struct ftrace_rec_iter *ftrace_rec_iter_next(struct ftrace_rec_iter *iter)
  * ftrace_rec_iter_record - get the record at the iterator location
  * @iter: The current iterator location
  *
- * Returns the record that the current @iter is at.
+ * Returns: the record that the current @iter is at.
  */
 struct dyn_ftrace *ftrace_rec_iter_record(struct ftrace_rec_iter *iter)
 {
@@ -4010,6 +4011,8 @@ ftrace_avail_addrs_open(struct inode *inode, struct file *file)
  * ftrace_notrace_write() if @flag has FTRACE_ITER_NOTRACE set.
  * tracing_lseek() should be used as the lseek routine, and
  * release must call ftrace_regex_release().
+ *
+ * Returns: 0 on success or a negative errno value on failure
  */
 int
 ftrace_regex_open(struct ftrace_ops *ops, int flag,
@@ -4626,7 +4629,7 @@ struct ftrace_func_mapper {
 /**
  * allocate_ftrace_func_mapper - allocate a new ftrace_func_mapper
  *
- * Returns a ftrace_func_mapper descriptor that can be used to map ips to data.
+ * Returns: a ftrace_func_mapper descriptor that can be used to map ips to data.
  */
 struct ftrace_func_mapper *allocate_ftrace_func_mapper(void)
 {
@@ -4646,7 +4649,7 @@ struct ftrace_func_mapper *allocate_ftrace_func_mapper(void)
  * @mapper: The mapper that has the ip maps
  * @ip: the instruction pointer to find the data for
  *
- * Returns the data mapped to @ip if found otherwise NULL. The return
+ * Returns: the data mapped to @ip if found otherwise NULL. The return
  * is actually the address of the mapper data pointer. The address is
  * returned for use cases where the data is no bigger than a long, and
  * the user can use the data pointer as its data instead of having to
@@ -4672,7 +4675,7 @@ void **ftrace_func_mapper_find_ip(struct ftrace_func_mapper *mapper,
  * @ip: The instruction pointer address to map @data to
  * @data: The data to map to @ip
  *
- * Returns 0 on success otherwise an error.
+ * Returns: 0 on success otherwise an error.
  */
 int ftrace_func_mapper_add_ip(struct ftrace_func_mapper *mapper,
 			      unsigned long ip, void *data)
@@ -4701,7 +4704,7 @@ int ftrace_func_mapper_add_ip(struct ftrace_func_mapper *mapper,
  * @mapper: The mapper that has the ip maps
  * @ip: The instruction pointer address to remove the data from
  *
- * Returns the data if it is found, otherwise NULL.
+ * Returns: the data if it is found, otherwise NULL.
  * Note, if the data pointer is used as the data itself, (see
  * ftrace_func_mapper_find_ip(), then the return value may be meaningless,
  * if the data pointer was set to zero.
@@ -5625,10 +5628,10 @@ EXPORT_SYMBOL_GPL(modify_ftrace_direct);
 
 /**
  * ftrace_set_filter_ip - set a function to filter on in ftrace by address
- * @ops - the ops to set the filter with
- * @ip - the address to add to or remove from the filter.
- * @remove - non zero to remove the ip from the filter
- * @reset - non zero to reset all filters before applying this filter.
+ * @ops: the ops to set the filter with
+ * @ip: the address to add to or remove from the filter.
+ * @remove: non zero to remove the ip from the filter
+ * @reset: non zero to reset all filters before applying this filter.
  *
  * Filters denote which functions should be enabled when tracing is enabled
  * If @ip is NULL, it fails to update filter.
@@ -5647,11 +5650,11 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter_ip);
 
 /**
  * ftrace_set_filter_ips - set functions to filter on in ftrace by addresses
- * @ops - the ops to set the filter with
- * @ips - the array of addresses to add to or remove from the filter.
- * @cnt - the number of addresses in @ips
- * @remove - non zero to remove ips from the filter
- * @reset - non zero to reset all filters before applying this filter.
+ * @ops: the ops to set the filter with
+ * @ips: the array of addresses to add to or remove from the filter.
+ * @cnt: the number of addresses in @ips
+ * @remove: non zero to remove ips from the filter
+ * @reset: non zero to reset all filters before applying this filter.
  *
  * Filters denote which functions should be enabled when tracing is enabled
  * If @ips array or any ip specified within is NULL , it fails to update filter.
@@ -5670,7 +5673,7 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter_ips);
 
 /**
  * ftrace_ops_set_global_filter - setup ops to use global filters
- * @ops - the ops which will use the global filters
+ * @ops: the ops which will use the global filters
  *
  * ftrace users who need global function trace filtering should call this.
  * It can set the global filter only if ops were not initialized before.
@@ -5694,10 +5697,10 @@ ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
 
 /**
  * ftrace_set_filter - set a function to filter on in ftrace
- * @ops - the ops to set the filter with
- * @buf - the string that holds the function filter text.
- * @len - the length of the string.
- * @reset - non zero to reset all filters before applying this filter.
+ * @ops: the ops to set the filter with
+ * @buf: the string that holds the function filter text.
+ * @len: the length of the string.
+ * @reset: non-zero to reset all filters before applying this filter.
  *
  * Filters denote which functions should be enabled when tracing is enabled.
  * If @buf is NULL and reset is set, all functions will be enabled for tracing.
@@ -5716,10 +5719,10 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter);
 
 /**
  * ftrace_set_notrace - set a function to not trace in ftrace
- * @ops - the ops to set the notrace filter with
- * @buf - the string that holds the function notrace text.
- * @len - the length of the string.
- * @reset - non zero to reset all filters before applying this filter.
+ * @ops: the ops to set the notrace filter with
+ * @buf: the string that holds the function notrace text.
+ * @len: the length of the string.
+ * @reset: non-zero to reset all filters before applying this filter.
  *
  * Notrace Filters denote which functions should not be enabled when tracing
  * is enabled. If @buf is NULL and reset is set, all functions will be enabled
@@ -5738,9 +5741,9 @@ int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
 EXPORT_SYMBOL_GPL(ftrace_set_notrace);
 /**
  * ftrace_set_global_filter - set a function to filter on with global tracers
- * @buf - the string that holds the function filter text.
- * @len - the length of the string.
- * @reset - non zero to reset all filters before applying this filter.
+ * @buf: the string that holds the function filter text.
+ * @len: the length of the string.
+ * @reset: non-zero to reset all filters before applying this filter.
  *
  * Filters denote which functions should be enabled when tracing is enabled.
  * If @buf is NULL and reset is set, all functions will be enabled for tracing.
@@ -5753,9 +5756,9 @@ EXPORT_SYMBOL_GPL(ftrace_set_global_filter);
 
 /**
  * ftrace_set_global_notrace - set a function to not trace with global tracers
- * @buf - the string that holds the function notrace text.
- * @len - the length of the string.
- * @reset - non zero to reset all filters before applying this filter.
+ * @buf: the string that holds the function notrace text.
+ * @len: the length of the string.
+ * @reset: non-zero to reset all filters before applying this filter.
  *
  * Notrace Filters denote which functions should not be enabled when tracing
  * is enabled. If @buf is NULL and reset is set, all functions will be enabled
@@ -7443,7 +7446,7 @@ NOKPROBE_SYMBOL(ftrace_ops_assist_func);
  * have its own recursion protection, then it should call the
  * ftrace_ops_assist_func() instead.
  *
- * Returns the function that the trampoline should call for @ops.
+ * Returns: the function that the trampoline should call for @ops.
  */
 ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops)
 {
@@ -7897,7 +7900,7 @@ void ftrace_kill(void)
 /**
  * ftrace_is_dead - Test if ftrace is dead or not.
  *
- * Returns 1 if ftrace is "dead", zero otherwise.
+ * Returns: 1 if ftrace is "dead", zero otherwise.
  */
 int ftrace_is_dead(void)
 {
@@ -8142,8 +8145,7 @@ static int kallsyms_callback(void *data, const char *name, unsigned long addr)
  * @addrs array, which needs to be big enough to store at least @cnt
  * addresses.
  *
- * This function returns 0 if all provided symbols are found,
- * -ESRCH otherwise.
+ * Returns: 0 if all provided symbols are found, -ESRCH otherwise.
  */
 int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs)
 {
-- 
2.43.0



