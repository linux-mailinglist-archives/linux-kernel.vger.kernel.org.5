Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A4177BFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjHNSPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjHNSPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:15:04 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA471703
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:15:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7653bd3ff2fso423036885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692036901; x=1692641701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/S5l5CvIhmQwP1GjAxgBKT1Ie0OFLpqUVornGcRqOUs=;
        b=Pb57+E4DmKOpSo/5mANptALN6ceAlk8aiRAmdFjGKNWU4lVkQ5Ka3Wqg+2OGPsn5I+
         tTUWkyjBk3USc9f7ci/ZQqJuj7n/iLL94tMUDuAM99DunAfOUWsnvOk+b/hwGH3Cij/H
         8kzQZCP4ytm/otlpQheyKmH05N1EaLkJM6QCxKqSwLZThCyIeaiDWm6HJab/HtSfpyLa
         Vs0pmqhYx9HvNVBq1ycuA7opDdXI9LlzJNsF1Rzu1GcRzAl8sVsTKKwEXe4SQQv3OWVM
         RgMs16Qwg20zOXlOMS1WCmxZm0PfAp6ApGFwPuPih6o5e0Yo4mHxQVTekMTIM265u3vf
         PmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036901; x=1692641701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S5l5CvIhmQwP1GjAxgBKT1Ie0OFLpqUVornGcRqOUs=;
        b=Jfa8PEHjQTYFV22xBMftNuo30CcjSGlhXwBMLzcUK1iUMlOUctyWSyflI2eZDjA3I+
         1mjPOF4W5hL/TlVVSS9WSzvpdZsnPYu7JNT7jbs+J/vkFHhiU7JKCwWfhSZnWuH5ayai
         AXmB86napckHB1cQWljrI1qmgzbdPzWFm+vHZf+iyAnkos0M7SuZeGnnDlF/VuYzJ7GQ
         bp24sERxETvDK57bG/a+zmLJRouxQWUApnugNzULSTAGqsRDl3OxkRAhDq+n4TuvmvBx
         vXK7AOETCHur3txLo3M45lmM8Hhg4A9TucGqQRTluYoHNLVqkjgX/KG6BXbWvcMCzdf8
         GwTQ==
X-Gm-Message-State: AOJu0YwIgD9IMfP6CFs0n473xHO7mkalqYiOK9EJDw/oaETsZlL4TN2H
        83xmMdiueL5wVI1yDKTjfpbGvTBKYPQ=
X-Google-Smtp-Source: AGHT+IHJj47SZK2QZAzI1T+dBlrAyHjCKBrMLx691vkBmcAQq62LBpqtVMoDT4jwMiyVE8Zb0AyEZQ==
X-Received: by 2002:a05:620a:280d:b0:768:1e31:db83 with SMTP id f13-20020a05620a280d00b007681e31db83mr13952836qkp.17.1692036900575;
        Mon, 14 Aug 2023 11:15:00 -0700 (PDT)
Received: from localhost (98-159-221-50.static.firstlight.net. [98.159.221.50])
        by smtp.gmail.com with ESMTPSA id o20-20020a05620a111400b00767e2668536sm3196743qkk.17.2023.08.14.11.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:15:00 -0700 (PDT)
Date:   Mon, 14 Aug 2023 11:14:58 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2] cpumask: kernel-doc cleanups and additions
Message-ID: <ZNpvIj60sBU0vN1b@yury-ThinkPad>
References: <20230801050817.26872-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801050817.26872-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:08:17PM -0700, Randy Dunlap wrote:
> Clean up some punctutation and abbreviations.
> Add kernel-doc notation for one function and function return value
> for 39 functions.
> 
> cpumask.h:
> Fix some punctuation (plural vs. possessive).
> Fix some abbreviations (ie. -> i.e., id -> ID).
> 
> Fix 35 warnings like this:
> include/linux/cpumask.h:161: warning: No description found for return value of 'cpumask_first'
> 
> cpumask.c:
> Add Return: value for 4 functions.
> Add kernel-doc for cpumask_any_distribute().
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied in bitmap-for-next. Thanks!

> ---
> v2: combine the header & C source file patches (Andy);
>     add Rev-by: Andy
> 
>  include/linux/cpumask.h |  113 +++++++++++++++++++++++---------------
>  lib/cpumask.c           |   17 ++++-
>  2 files changed, 81 insertions(+), 49 deletions(-)
> 
> diff -- a/include/linux/cpumask.h b/include/linux/cpumask.h
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -4,7 +4,7 @@
>  
>  /*
>   * Cpumasks provide a bitmap suitable for representing the
> - * set of CPU's in a system, one bit position per CPU number.  In general,
> + * set of CPUs in a system, one bit position per CPU number.  In general,
>   * only nr_cpu_ids (<= NR_CPUS) bits are valid.
>   */
>  #include <linux/kernel.h>
> @@ -97,7 +97,7 @@ static inline void set_nr_cpu_ids(unsign
>   *
>   *  If !CONFIG_HOTPLUG_CPU, present == possible, and active == online.
>   *
> - *  The cpu_possible_mask is fixed at boot time, as the set of CPU id's
> + *  The cpu_possible_mask is fixed at boot time, as the set of CPU IDs
>   *  that it is possible might ever be plugged in at anytime during the
>   *  life of that system boot.  The cpu_present_mask is dynamic(*),
>   *  representing which CPUs are currently plugged in.  And
> @@ -112,7 +112,7 @@ static inline void set_nr_cpu_ids(unsign
>   *      hotplug, it's a copy of cpu_possible_mask, hence fixed at boot.
>   *
>   * Subtleties:
> - * 1) UP arch's (NR_CPUS == 1, CONFIG_SMP not defined) hardcode
> + * 1) UP ARCHes (NR_CPUS == 1, CONFIG_SMP not defined) hardcode
>   *    assumption that their single CPU is online.  The UP
>   *    cpu_{online,possible,present}_masks are placebos.  Changing them
>   *    will have no useful affect on the following num_*_cpus()
> @@ -155,7 +155,7 @@ static __always_inline unsigned int cpum
>   * cpumask_first - get the first cpu in a cpumask
>   * @srcp: the cpumask pointer
>   *
> - * Returns >= nr_cpu_ids if no cpus set.
> + * Return: >= nr_cpu_ids if no cpus set.
>   */
>  static inline unsigned int cpumask_first(const struct cpumask *srcp)
>  {
> @@ -166,7 +166,7 @@ static inline unsigned int cpumask_first
>   * cpumask_first_zero - get the first unset cpu in a cpumask
>   * @srcp: the cpumask pointer
>   *
> - * Returns >= nr_cpu_ids if all cpus are set.
> + * Return: >= nr_cpu_ids if all cpus are set.
>   */
>  static inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
>  {
> @@ -178,7 +178,7 @@ static inline unsigned int cpumask_first
>   * @srcp1: the first input
>   * @srcp2: the second input
>   *
> - * Returns >= nr_cpu_ids if no cpus set in both.  See also cpumask_next_and().
> + * Return: >= nr_cpu_ids if no cpus set in both.  See also cpumask_next_and().
>   */
>  static inline
>  unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask *srcp2)
> @@ -190,7 +190,7 @@ unsigned int cpumask_first_and(const str
>   * cpumask_last - get the last CPU in a cpumask
>   * @srcp:	- the cpumask pointer
>   *
> - * Returns	>= nr_cpumask_bits if no CPUs set.
> + * Return:	>= nr_cpumask_bits if no CPUs set.
>   */
>  static inline unsigned int cpumask_last(const struct cpumask *srcp)
>  {
> @@ -199,10 +199,10 @@ static inline unsigned int cpumask_last(
>  
>  /**
>   * cpumask_next - get the next cpu in a cpumask
> - * @n: the cpu prior to the place to search (ie. return will be > @n)
> + * @n: the cpu prior to the place to search (i.e. return will be > @n)
>   * @srcp: the cpumask pointer
>   *
> - * Returns >= nr_cpu_ids if no further cpus set.
> + * Return: >= nr_cpu_ids if no further cpus set.
>   */
>  static inline
>  unsigned int cpumask_next(int n, const struct cpumask *srcp)
> @@ -215,10 +215,10 @@ unsigned int cpumask_next(int n, const s
>  
>  /**
>   * cpumask_next_zero - get the next unset cpu in a cpumask
> - * @n: the cpu prior to the place to search (ie. return will be > @n)
> + * @n: the cpu prior to the place to search (i.e. return will be > @n)
>   * @srcp: the cpumask pointer
>   *
> - * Returns >= nr_cpu_ids if no further cpus unset.
> + * Return: >= nr_cpu_ids if no further cpus unset.
>   */
>  static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
>  {
> @@ -254,11 +254,11 @@ unsigned int cpumask_any_distribute(cons
>  
>  /**
>   * cpumask_next_and - get the next cpu in *src1p & *src2p
> - * @n: the cpu prior to the place to search (ie. return will be > @n)
> + * @n: the cpu prior to the place to search (i.e. return will be > @n)
>   * @src1p: the first cpumask pointer
>   * @src2p: the second cpumask pointer
>   *
> - * Returns >= nr_cpu_ids if no further cpus set in both.
> + * Return: >= nr_cpu_ids if no further cpus set in both.
>   */
>  static inline
>  unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
> @@ -373,7 +373,7 @@ unsigned int __pure cpumask_next_wrap(in
>   * @cpu: the cpu to ignore.
>   *
>   * Often used to find any cpu but smp_processor_id() in a mask.
> - * Returns >= nr_cpu_ids if no cpus set.
> + * Return: >= nr_cpu_ids if no cpus set.
>   */
>  static inline
>  unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
> @@ -388,11 +388,11 @@ unsigned int cpumask_any_but(const struc
>  }
>  
>  /**
> - * cpumask_nth - get the first cpu in a cpumask
> + * cpumask_nth - get the Nth cpu in a cpumask
>   * @srcp: the cpumask pointer
> - * @cpu: the N'th cpu to find, starting from 0
> + * @cpu: the Nth cpu to find, starting from 0
>   *
> - * Returns >= nr_cpu_ids if such cpu doesn't exist.
> + * Return: >= nr_cpu_ids if such cpu doesn't exist.
>   */
>  static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
>  {
> @@ -400,12 +400,12 @@ static inline unsigned int cpumask_nth(u
>  }
>  
>  /**
> - * cpumask_nth_and - get the first cpu in 2 cpumasks
> + * cpumask_nth_and - get the Nth cpu in 2 cpumasks
>   * @srcp1: the cpumask pointer
>   * @srcp2: the cpumask pointer
> - * @cpu: the N'th cpu to find, starting from 0
> + * @cpu: the Nth cpu to find, starting from 0
>   *
> - * Returns >= nr_cpu_ids if such cpu doesn't exist.
> + * Return: >= nr_cpu_ids if such cpu doesn't exist.
>   */
>  static inline
>  unsigned int cpumask_nth_and(unsigned int cpu, const struct cpumask *srcp1,
> @@ -416,12 +416,12 @@ unsigned int cpumask_nth_and(unsigned in
>  }
>  
>  /**
> - * cpumask_nth_andnot - get the first cpu set in 1st cpumask, and clear in 2nd.
> + * cpumask_nth_andnot - get the Nth cpu set in 1st cpumask, and clear in 2nd.
>   * @srcp1: the cpumask pointer
>   * @srcp2: the cpumask pointer
> - * @cpu: the N'th cpu to find, starting from 0
> + * @cpu: the Nth cpu to find, starting from 0
>   *
> - * Returns >= nr_cpu_ids if such cpu doesn't exist.
> + * Return: >= nr_cpu_ids if such cpu doesn't exist.
>   */
>  static inline
>  unsigned int cpumask_nth_andnot(unsigned int cpu, const struct cpumask *srcp1,
> @@ -436,9 +436,9 @@ unsigned int cpumask_nth_andnot(unsigned
>   * @srcp1: the cpumask pointer
>   * @srcp2: the cpumask pointer
>   * @srcp3: the cpumask pointer
> - * @cpu: the N'th cpu to find, starting from 0
> + * @cpu: the Nth cpu to find, starting from 0
>   *
> - * Returns >= nr_cpu_ids if such cpu doesn't exist.
> + * Return: >= nr_cpu_ids if such cpu doesn't exist.
>   */
>  static __always_inline
>  unsigned int cpumask_nth_and_andnot(unsigned int cpu, const struct cpumask *srcp1,
> @@ -497,7 +497,7 @@ static __always_inline void __cpumask_cl
>   * @cpu: cpu number (< nr_cpu_ids)
>   * @cpumask: the cpumask pointer
>   *
> - * Returns true if @cpu is set in @cpumask, else returns false
> + * Return: true if @cpu is set in @cpumask, else returns false
>   */
>  static __always_inline bool cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
>  {
> @@ -509,9 +509,9 @@ static __always_inline bool cpumask_test
>   * @cpu: cpu number (< nr_cpu_ids)
>   * @cpumask: the cpumask pointer
>   *
> - * Returns true if @cpu is set in old bitmap of @cpumask, else returns false
> - *
>   * test_and_set_bit wrapper for cpumasks.
> + *
> + * Return: true if @cpu is set in old bitmap of @cpumask, else returns false
>   */
>  static __always_inline bool cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
>  {
> @@ -523,9 +523,9 @@ static __always_inline bool cpumask_test
>   * @cpu: cpu number (< nr_cpu_ids)
>   * @cpumask: the cpumask pointer
>   *
> - * Returns true if @cpu is set in old bitmap of @cpumask, else returns false
> - *
>   * test_and_clear_bit wrapper for cpumasks.
> + *
> + * Return: true if @cpu is set in old bitmap of @cpumask, else returns false
>   */
>  static __always_inline bool cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
>  {
> @@ -560,7 +560,7 @@ static inline void cpumask_clear(struct
>   * @src1p: the first input
>   * @src2p: the second input
>   *
> - * If *@dstp is empty, returns false, else returns true
> + * Return: false if *@dstp is empty, else returns true
>   */
>  static inline bool cpumask_and(struct cpumask *dstp,
>  			       const struct cpumask *src1p,
> @@ -603,7 +603,7 @@ static inline void cpumask_xor(struct cp
>   * @src1p: the first input
>   * @src2p: the second input
>   *
> - * If *@dstp is empty, returns false, else returns true
> + * Return: false if *@dstp is empty, else returns true
>   */
>  static inline bool cpumask_andnot(struct cpumask *dstp,
>  				  const struct cpumask *src1p,
> @@ -617,6 +617,8 @@ static inline bool cpumask_andnot(struct
>   * cpumask_equal - *src1p == *src2p
>   * @src1p: the first input
>   * @src2p: the second input
> + *
> + * Return: true if the cpumasks are equal, false if not
>   */
>  static inline bool cpumask_equal(const struct cpumask *src1p,
>  				const struct cpumask *src2p)
> @@ -630,6 +632,9 @@ static inline bool cpumask_equal(const s
>   * @src1p: the first input
>   * @src2p: the second input
>   * @src3p: the third input
> + *
> + * Return: true if first cpumask ORed with second cpumask == third cpumask,
> + *	   otherwise false
>   */
>  static inline bool cpumask_or_equal(const struct cpumask *src1p,
>  				    const struct cpumask *src2p,
> @@ -643,6 +648,9 @@ static inline bool cpumask_or_equal(cons
>   * cpumask_intersects - (*src1p & *src2p) != 0
>   * @src1p: the first input
>   * @src2p: the second input
> + *
> + * Return: true if first cpumask ANDed with second cpumask is non-empty,
> + *	   otherwise false
>   */
>  static inline bool cpumask_intersects(const struct cpumask *src1p,
>  				     const struct cpumask *src2p)
> @@ -656,7 +664,7 @@ static inline bool cpumask_intersects(co
>   * @src1p: the first input
>   * @src2p: the second input
>   *
> - * Returns true if *@src1p is a subset of *@src2p, else returns false
> + * Return: true if *@src1p is a subset of *@src2p, else returns false
>   */
>  static inline bool cpumask_subset(const struct cpumask *src1p,
>  				 const struct cpumask *src2p)
> @@ -668,6 +676,8 @@ static inline bool cpumask_subset(const
>  /**
>   * cpumask_empty - *srcp == 0
>   * @srcp: the cpumask to that all cpus < nr_cpu_ids are clear.
> + *
> + * Return: true if srcp is empty (has no bits set), else false
>   */
>  static inline bool cpumask_empty(const struct cpumask *srcp)
>  {
> @@ -677,6 +687,8 @@ static inline bool cpumask_empty(const s
>  /**
>   * cpumask_full - *srcp == 0xFFFFFFFF...
>   * @srcp: the cpumask to that all cpus < nr_cpu_ids are set.
> + *
> + * Return: true if srcp is full (has all bits set), else false
>   */
>  static inline bool cpumask_full(const struct cpumask *srcp)
>  {
> @@ -686,6 +698,8 @@ static inline bool cpumask_full(const st
>  /**
>   * cpumask_weight - Count of bits in *srcp
>   * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
> + *
> + * Return: count of bits set in *srcp
>   */
>  static inline unsigned int cpumask_weight(const struct cpumask *srcp)
>  {
> @@ -696,6 +710,8 @@ static inline unsigned int cpumask_weigh
>   * cpumask_weight_and - Count of bits in (*srcp1 & *srcp2)
>   * @srcp1: the cpumask to count bits (< nr_cpu_ids) in.
>   * @srcp2: the cpumask to count bits (< nr_cpu_ids) in.
> + *
> + * Return: count of bits set in both *srcp1 and *srcp2
>   */
>  static inline unsigned int cpumask_weight_and(const struct cpumask *srcp1,
>  						const struct cpumask *srcp2)
> @@ -744,7 +760,7 @@ static inline void cpumask_copy(struct c
>   * cpumask_any - pick a "random" cpu from *srcp
>   * @srcp: the input cpumask
>   *
> - * Returns >= nr_cpu_ids if no cpus set.
> + * Return: >= nr_cpu_ids if no cpus set.
>   */
>  #define cpumask_any(srcp) cpumask_first(srcp)
>  
> @@ -753,7 +769,7 @@ static inline void cpumask_copy(struct c
>   * @mask1: the first input cpumask
>   * @mask2: the second input cpumask
>   *
> - * Returns >= nr_cpu_ids if no cpus set.
> + * Return: >= nr_cpu_ids if no cpus set.
>   */
>  #define cpumask_any_and(mask1, mask2) cpumask_first_and((mask1), (mask2))
>  
> @@ -769,7 +785,7 @@ static inline void cpumask_copy(struct c
>   * @len: the length of the buffer
>   * @dstp: the cpumask to set.
>   *
> - * Returns -errno, or 0 for success.
> + * Return: -errno, or 0 for success.
>   */
>  static inline int cpumask_parse_user(const char __user *buf, int len,
>  				     struct cpumask *dstp)
> @@ -783,7 +799,7 @@ static inline int cpumask_parse_user(con
>   * @len: the length of the buffer
>   * @dstp: the cpumask to set.
>   *
> - * Returns -errno, or 0 for success.
> + * Return: -errno, or 0 for success.
>   */
>  static inline int cpumask_parselist_user(const char __user *buf, int len,
>  				     struct cpumask *dstp)
> @@ -797,7 +813,7 @@ static inline int cpumask_parselist_user
>   * @buf: the buffer to extract from
>   * @dstp: the cpumask to set.
>   *
> - * Returns -errno, or 0 for success.
> + * Return: -errno, or 0 for success.
>   */
>  static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
>  {
> @@ -809,7 +825,7 @@ static inline int cpumask_parse(const ch
>   * @buf: the buffer to extract from
>   * @dstp: the cpumask to set.
>   *
> - * Returns -errno, or 0 for success.
> + * Return: -errno, or 0 for success.
>   */
>  static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
>  {
> @@ -817,7 +833,9 @@ static inline int cpulist_parse(const ch
>  }
>  
>  /**
> - * cpumask_size - size to allocate for a 'struct cpumask' in bytes
> + * cpumask_size - calculate size to allocate for a 'struct cpumask' in bytes
> + *
> + * Return: size to allocate for a &struct cpumask in bytes
>   */
>  static inline unsigned int cpumask_size(void)
>  {
> @@ -831,7 +849,7 @@ static inline unsigned int cpumask_size(
>   * little more difficult, we typedef cpumask_var_t to an array or a
>   * pointer: doing &mask on an array is a noop, so it still works.
>   *
> - * ie.
> + * i.e.
>   *	cpumask_var_t tmpmask;
>   *	if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
>   *		return -ENOMEM;
> @@ -887,6 +905,8 @@ bool zalloc_cpumask_var_node(cpumask_var
>   * a nop returning a constant 1 (in <linux/cpumask.h>).
>   *
>   * See alloc_cpumask_var_node.
> + *
> + * Return: %true if allocation succeeded, %false if not
>   */
>  static inline
>  bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
> @@ -1025,7 +1045,7 @@ set_cpu_dying(unsigned int cpu, bool dyi
>  }
>  
>  /**
> - * to_cpumask - convert an NR_CPUS bitmap to a struct cpumask *
> + * to_cpumask - convert a NR_CPUS bitmap to a struct cpumask *
>   * @bitmap: the bitmap
>   *
>   * There are a few places where cpumask_var_t isn't appropriate and
> @@ -1068,6 +1088,8 @@ static inline const struct cpumask *get_
>   * interface gives only a momentary snapshot and is not protected against
>   * concurrent CPU hotplug operations unless invoked from a cpuhp_lock held
>   * region.
> + *
> + * Return: momentary snapshot of the number of online CPUs
>   */
>  static __always_inline unsigned int num_online_cpus(void)
>  {
> @@ -1160,7 +1182,7 @@ static inline bool cpu_dying(unsigned in
>   * @mask: the cpumask to copy
>   * @buf: the buffer to copy into
>   *
> - * Returns the length of the (null-terminated) @buf string, zero if
> + * Return: the length of the (null-terminated) @buf string, zero if
>   * nothing is copied.
>   */
>  static inline ssize_t
> @@ -1183,7 +1205,7 @@ cpumap_print_to_pagebuf(bool list, char
>   * cpumask; Typically used by bin_attribute to export cpumask bitmask
>   * ABI.
>   *
> - * Returns the length of how many bytes have been copied, excluding
> + * Return: the length of how many bytes have been copied, excluding
>   * terminating '\0'.
>   */
>  static inline ssize_t
> @@ -1204,6 +1226,9 @@ cpumap_print_bitmask_to_buf(char *buf, c
>   *
>   * Everything is same with the above cpumap_print_bitmask_to_buf()
>   * except the print format.
> + *
> + * Return: the length of how many bytes have been copied, excluding
> + * terminating '\0'.
>   */
>  static inline ssize_t
>  cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
> diff -- a/lib/cpumask.c b/lib/cpumask.c
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -14,7 +14,7 @@
>   * @start: the start point of the iteration
>   * @wrap: assume @n crossing @start terminates the iteration
>   *
> - * Returns >= nr_cpu_ids on completion
> + * Return: >= nr_cpu_ids on completion
>   *
>   * Note: the @wrap argument is required for the start condition when
>   * we cannot assume @start is set in @mask.
> @@ -48,8 +48,9 @@ EXPORT_SYMBOL(cpumask_next_wrap);
>   * @node: memory node from which to allocate or %NUMA_NO_NODE
>   *
>   * Only defined when CONFIG_CPUMASK_OFFSTACK=y, otherwise is
> - * a nop returning a constant 1 (in <linux/cpumask.h>)
> - * Returns TRUE if memory allocation succeeded, FALSE otherwise.
> + * a nop returning a constant 1 (in <linux/cpumask.h>).
> + *
> + * Return: TRUE if memory allocation succeeded, FALSE otherwise.
>   *
>   * In addition, mask will be NULL if this fails.  Note that gcc is
>   * usually smart enough to know that mask can never be NULL if
> @@ -115,7 +116,7 @@ void __init free_bootmem_cpumask_var(cpu
>   * @i: index number
>   * @node: local numa_node
>   *
> - * Returns online CPU according to a numa aware policy; local cpus are returned
> + * Return: online CPU according to a numa aware policy; local cpus are returned
>   * first, followed by non-local ones, then it wraps around.
>   *
>   * For those who wants to enumerate all CPUs based on their NUMA distances,
> @@ -162,7 +163,7 @@ static DEFINE_PER_CPU(int, distribute_cp
>   * Iterated calls using the same srcp1 and srcp2 will be distributed within
>   * their intersection.
>   *
> - * Returns >= nr_cpu_ids if the intersection is empty.
> + * Return: >= nr_cpu_ids if the intersection is empty.
>   */
>  unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
>  			       const struct cpumask *src2p)
> @@ -181,6 +182,12 @@ unsigned int cpumask_any_and_distribute(
>  }
>  EXPORT_SYMBOL(cpumask_any_and_distribute);
>  
> +/**
> + * cpumask_any_distribute - Return an arbitrary cpu from srcp
> + * @srcp: &cpumask for selection
> + *
> + * Return: >= nr_cpu_ids if the intersection is empty.
> + */
>  unsigned int cpumask_any_distribute(const struct cpumask *srcp)
>  {
>  	unsigned int next, prev;
