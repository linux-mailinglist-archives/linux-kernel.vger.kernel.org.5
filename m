Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C276F7BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjHDCUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjHDCUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:20:21 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B894488
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:20:19 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63d30554eefso9564436d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 19:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691115618; x=1691720418;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zmnXrnMCoUQERmV4zQ9ofrcawYkpYMyzngB6jAITZOg=;
        b=feI4Qs+FngTiAaC8tGb+tPeuESacSf6niZj/H0J5/tNxyQKAr67kpMP8T0QAOyZnDU
         nEyeiUCoZZzZzw2uEtuq+ck2vBWLS0ociw9eXnzd0D+UIwm1Zs9Xhfnz4YFZH//jgpXz
         62mdFX8Gc6JfZvFcx7WnZjAzzjgXauHMUJMbtp/yCAwLcm/VGYXIWaVIEpnhAWmdbxme
         IWjX09kXIQzgcLGvS95Zk1f0sv9UYyK5MKxy3V+0EIWZgkQxtakDtrnykXk4seDFgUAC
         teFOxtTxaPe91ELW/XnWXK2OxH0yY0mlAdvjEONOKKu+NGNkvRb4/QQvrCQuxr2LjMHI
         ibqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115618; x=1691720418;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmnXrnMCoUQERmV4zQ9ofrcawYkpYMyzngB6jAITZOg=;
        b=N4eA8wZgPk0roHzg4JnsdbwDB5ie/QV8z5D0J0HMFnoiZ4rmLkjulMOJSyAlU0Fzt1
         J5AfKQdyZJ3Nw8UlynS+90XRXMbPyQ96Z2pKArLUUmCtXYZfQ/GZ8kyahhXRWldUgsmO
         1+h9dITtW1g9isATTpm/T2Gz8cExrGdVHvfcgSMualVE7/WLtorug7kt24VLmGWSmsfj
         Di+AR3tnuWtF6FmpgBuk2MtiKyyPy3W/KuUxLEb9eKqXzGWi6syOw++FRDlUMK3LuRCn
         eZR2taxKjUqO0xIUs3SxEXRtQK1Wx0PzG/l8HD687xl6Bdcb/S8BdzIOlp19hNiGYZJE
         Tcwg==
X-Gm-Message-State: AOJu0Yx0W4getefWXeKbAMbBuuADFHhFA8Mxy5uK7ommBvHCO3ELzRHb
        GDoUUCj+A+TEgeLFfKp4QWQm
X-Google-Smtp-Source: AGHT+IFG7ViRHFPZBRIxeCryhQH5+nICbjzj5fRjTaQVE9+qm6PiewFcVsji7nEEBuz3DqEpUS3gqQ==
X-Received: by 2002:ad4:4f51:0:b0:635:e528:5213 with SMTP id eu17-20020ad44f51000000b00635e5285213mr372905qvb.23.1691115618294;
        Thu, 03 Aug 2023 19:20:18 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id p3-20020a0cf543000000b00636047c276csm326815qvm.126.2023.08.03.19.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:20:17 -0700 (PDT)
Date:   Thu, 03 Aug 2023 22:20:17 -0400
Message-ID: <c8f7b16afb26b2357fdc2b590a8cdcba.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] selinux: use u32 as bit type in ebitmap code
References: <20230728155501.39632-1-cgzones@googlemail.com>
In-Reply-To: <20230728155501.39632-1-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> The extensible bitmap supports bit positions up to U32_MAX due to the
> type of the member highbit being u32.  Use u32 consistently as the type
> for bit positions to announce to callers what range of values is
> supported.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/ss/ebitmap.c | 32 ++++++++++++++++----------------
>  security/selinux/ss/ebitmap.h | 32 ++++++++++++++++----------------
>  2 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 77875ad355f7..6ab2baf4cfb5 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -24,7 +24,7 @@
>  #include "ebitmap.h"
>  #include "policydb.h"
>  
> -#define BITS_PER_U64	(sizeof(u64) * 8)
> +#define BITS_PER_U64	((u32)(sizeof(u64) * 8))
>  
>  static struct kmem_cache *ebitmap_node_cachep __ro_after_init;
>  
> @@ -82,7 +82,8 @@ int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src)
>  int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1, const struct ebitmap *e2)
>  {
>  	struct ebitmap_node *n;
> -	int bit, rc;
> +	u32 bit;
> +	int rc;
>  
>  	ebitmap_init(dst);
>  
> @@ -113,8 +114,7 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
>  {
>  	struct ebitmap_node *e_iter = ebmap->node;
>  	unsigned long e_map;
> -	u32 offset;
> -	unsigned int iter;
> +	u32 offset, iter;
>  	int rc;

In this function 'iter' is used to iterate through ebitmap_node::maps
and it thus only indirectly related to an ebitmap spot/offset.

I don't think this change harms anything, but it isn't strictly
necessary.

>  	if (e_iter == NULL) {
> @@ -259,7 +259,7 @@ int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2, u32 las
>  	return 1;
>  }
>  
> -int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit)
> +int ebitmap_get_bit(const struct ebitmap *e, u32 bit)
>  {
>  	const struct ebitmap_node *n;
>  
> @@ -276,7 +276,7 @@ int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit)
>  	return 0;
>  }
>  
> -int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
> +int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value)
>  {
>  	struct ebitmap_node *n, *prev, *new;
>  
> @@ -287,7 +287,7 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
>  			if (value) {
>  				ebitmap_node_set_bit(n, bit);
>  			} else {
> -				unsigned int s;
> +				u32 s;
>  
>  				ebitmap_node_clr_bit(n, bit);
>  
> @@ -365,12 +365,12 @@ void ebitmap_destroy(struct ebitmap *e)
>  int ebitmap_read(struct ebitmap *e, void *fp)
>  {
>  	struct ebitmap_node *n = NULL;
> -	u32 mapunit, count, startbit, index;
> +	u32 mapunit, count, startbit, index, i;
>  	__le32 ebitmap_start;
>  	u64 map;
>  	__le64 mapbits;
>  	__le32 buf[3];
> -	int rc, i;
> +	int rc;
>  
>  	ebitmap_init(e);
>  
> @@ -384,7 +384,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>  
>  	if (mapunit != BITS_PER_U64) {
>  		pr_err("SELinux: ebitmap: map size %u does not "
> -		       "match my size %zd (high bit was %d)\n",
> +		       "match my size %d (high bit was %d)\n",
>  		       mapunit, BITS_PER_U64, e->highbit);
>  		goto bad;
>  	}
> @@ -471,18 +471,18 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>  int ebitmap_write(const struct ebitmap *e, void *fp)
>  {
>  	struct ebitmap_node *n;
> -	u32 count;
> +	u32 bit, count, last_bit, last_startbit;
>  	__le32 buf[3];
>  	u64 map;
> -	int bit, last_bit, last_startbit, rc;
> +	int rc;
>  
>  	buf[0] = cpu_to_le32(BITS_PER_U64);
>  
>  	count = 0;
>  	last_bit = 0;
> -	last_startbit = -1;
> +	last_startbit = (u32)-1;

I can't say I'm as current on all of the C standards and compilier
oddities as some other in the Linux kernel space, but my
understanding is that on assignment the right value is always
implicitly type cast to the type of the left variable, is that not
true?  Assuming it is true, I think this explicit cast isn't
necessary and could actually be harmful if we need to change the
ebitmap types in the future.

>  	ebitmap_for_each_positive_bit(e, n, bit) {
> -		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
> +		if (last_startbit == (u32)-1 || rounddown(bit, BITS_PER_U64) > last_startbit) {

This is a little more challenging as I know the rules for integer
comparisons are not quite as simple as assignments, but I do question
if the above change is an improvement.

One possibility would be to explicitly match the types, for example:

 x == (typeof(x))-1 

>  			count++;
>  			last_startbit = rounddown(bit, BITS_PER_U64);
>  		}
> @@ -496,9 +496,9 @@ int ebitmap_write(const struct ebitmap *e, void *fp)
>  		return rc;
>  
>  	map = 0;
> -	last_startbit = INT_MIN;
> +	last_startbit = (u32)-1;
>  	ebitmap_for_each_positive_bit(e, n, bit) {
> -		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
> +		if (last_startbit == (u32)-1 || rounddown(bit, BITS_PER_U64) > last_startbit) {
>  			__le64 buf64[1];

Both of these changes are discussed above.

>  			/* this is the very first bit */

--
paul-moore.com
