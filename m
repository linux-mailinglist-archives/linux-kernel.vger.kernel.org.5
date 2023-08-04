Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4968776FCC8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjHDJEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjHDJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:03:41 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509FC59DE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:59:56 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso1019871a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691139596; x=1691744396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HSY+DunDSeQrXcZFO969InECHp7DeoBzrBvcXm0lCi8=;
        b=Zi879f1Qs8tIrrQbhdLIhIQRAA09qfYZU9EnmpEAs/KuVXdGGdx0kpQJqHsJkKLBz5
         kYPsfGTVr02eVpS01e7CHYVEEqDDGscLRWy8fOMm0D0aQOCjtQkAyVuhicFKgn1q9BYZ
         BmttrEZRAzCPpfsChu8Ous37sbvlLT59xdHvQw/Jydbl6xOS0Q2EmG733GnvV5xG8nhY
         bYAuSlA1nSYxHxEXWyCUbE9Z63qBBBjjMq7i9oOS7ZPWjZqcCa+VIepNIogvymULzBqx
         janw3G67sE8NBtLs17VEBzMdVZVlMdwg2EZBH96t3HpGvuuruW1sOUh5enABu3km1H0K
         xmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691139596; x=1691744396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSY+DunDSeQrXcZFO969InECHp7DeoBzrBvcXm0lCi8=;
        b=QmI/ukkApADre9VfxHNn93B4Yj1AWvnBDbKa6cJva4yW4up+APU/plGjgqc/TC2Mvz
         lEjwaHc/duc9SRJt0R5mooxoQb8wt/9s0BFhl85+J2DkqfbiNJbGa0GuENer2EAYbZ15
         ya0WwgsBE8jqDBHALPQeFlqmM7dkxSO0TJckAvtBvIgzK8f4iBJWH2jExloyXo0JkUnY
         oA9hb9SKbj0qDyyQlMKjvep4wL0HRiADPKUfUb5DE9Rvg37wGxgJyKQGmN3ulTTw0IdG
         sBShSChKqsiRDaMFMaMTbpuPlrmIXgCjKa69IctAzwGIvYnOz7vPzA9Uqi0iogMhRxBZ
         4nRg==
X-Gm-Message-State: AOJu0YztwxpO1GcyC2iD1YokpGqiB8B9bg7e/RQbuVhK5OrrXZfzdTme
        LI+GlxJCx4G1Ao0ixJQXrZ9Xkg==
X-Google-Smtp-Source: AGHT+IF8J5czzbKu/eCtN3wCWVVm/XEbDfiwkdfOfPHo/4gwuCITkivYg61k8tLMjbRB+FJn2paCwA==
X-Received: by 2002:a05:6a21:7185:b0:13d:bf07:7444 with SMTP id wq5-20020a056a21718500b0013dbf077444mr855425pzb.0.1691139595585;
        Fri, 04 Aug 2023 01:59:55 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.39.102])
        by smtp.gmail.com with ESMTPSA id p25-20020a62ab19000000b006878cc942f1sm1142378pff.54.2023.08.04.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:59:55 -0700 (PDT)
Date:   Fri, 4 Aug 2023 16:59:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        james.clark@arm.com, mingo@redhat.com,
        baolin.wang@linux.alibaba.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 1/2] perf/core: Bail out early if the request AUX area
 is out of bound
Message-ID: <20230804085947.GB589820@leoy-yangtze.lan>
References: <20230804072945.85731-1-xueshuai@linux.alibaba.com>
 <20230804072945.85731-2-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804072945.85731-2-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:29:44PM +0800, Shuai Xue wrote:
> When perf-record with a large AUX area, e.g 4GB, it fails with:
> 
>     #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
>     failed to mmap with 12 (Cannot allocate memory)
> 
> and it reveals a WARNING with __alloc_pages():
> 
> [   66.595604] ------------[ cut here ]------------
> [   66.600206] WARNING: CPU: 44 PID: 17573 at mm/page_alloc.c:5568 __alloc_pages+0x1ec/0x248
> [   66.608375] Modules linked in: ip6table_filter(E) ip6_tables(E) iptable_filter(E) ebtable_nat(E) ebtables(E) aes_ce_blk(E) vfat(E) fat(E) aes_ce_cipher(E) crct10dif_ce(E) ghash_ce(E) sm4_ce_cipher(E) sm4(E) sha2_ce(E) sha256_arm64(E) sha1_ce(E) acpi_ipmi(E) sbsa_gwdt(E) sg(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) ip_tables(E) sd_mod(E) ast(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme(E) sysimgblt(E) i2c_algo_bit(E) nvme_core(E) drm_shmem_helper(E) ahci(E) t10_pi(E) libahci(E) drm(E) crc64_rocksoft(E) i40e(E) crc64(E) libata(E) i2c_core(E)
> [   66.657719] CPU: 44 PID: 17573 Comm: perf Kdump: loaded Tainted: G            E      6.3.0-rc4+ #58
> [   66.666749] Hardware name: Default Default/Default, BIOS 1.2.M1.AL.P.139.00 03/22/2023
> [   66.674650] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [   66.681597] pc : __alloc_pages+0x1ec/0x248
> [   66.685680] lr : __kmalloc_large_node+0xc0/0x1f8
> [   66.690285] sp : ffff800020523980
> [   66.693585] pmr_save: 000000e0
> [   66.696624] x29: ffff800020523980 x28: ffff000832975800 x27: 0000000000000000
> [   66.703746] x26: 0000000000100000 x25: 0000000000100000 x24: ffff8000083615d0
> [   66.710866] x23: 0000000000040dc0 x22: ffff000823d6d140 x21: 000000000000000b
> [   66.717987] x20: 000000000000000b x19: 0000000000000000 x18: 0000000000000030
> [   66.725108] x17: 0000000000000000 x16: ffff800008f05be8 x15: ffff000823d6d6d0
> [   66.732229] x14: 0000000000000000 x13: 343373656761705f x12: 726e202c30206574
> [   66.739350] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffff8000083af570
> [   66.746471] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 000000000005fff4
> [   66.753592] x5 : 0000000000000000 x4 : ffff000823d6d8d8 x3 : 0000000000000000
> [   66.760713] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000040dc0
> [   66.767834] Call trace:
> [   66.770267]  __alloc_pages+0x1ec/0x248
> [   66.774003]  __kmalloc_large_node+0xc0/0x1f8
> [   66.778259]  __kmalloc_node+0x134/0x1e8
> [   66.782081]  rb_alloc_aux+0xe0/0x298
> [   66.785643]  perf_mmap+0x440/0x660
> [   66.789031]  mmap_region+0x308/0x8a8
> [   66.792593]  do_mmap+0x3c0/0x528
> [   66.795807]  vm_mmap_pgoff+0xf4/0x1b8
> [   66.799456]  ksys_mmap_pgoff+0x18c/0x218
> [   66.803365]  __arm64_sys_mmap+0x38/0x58
> [   66.807187]  invoke_syscall+0x50/0x128
> [   66.810922]  el0_svc_common.constprop.0+0x58/0x188
> [   66.815698]  do_el0_svc+0x34/0x50
> [   66.818999]  el0_svc+0x34/0x108
> [   66.822127]  el0t_64_sync_handler+0xb8/0xc0
> [   66.826296]  el0t_64_sync+0x1a4/0x1a8
> [   66.829946] ---[ end trace 0000000000000000 ]---
> 
> 'rb->aux_pages' allocated by kcalloc() is a pointer array which is used to
> maintains AUX trace pages. The allocated page for this array is physically
> contiguous (and virtually contiguous) with an order of 0..MAX_ORDER. If the
> size of pointer array crosses the limitation set by MAX_ORDER, it reveals a
> WARNING.
> 
> So bail out early with -ENOMEM if the request AUX area is out of bound,
> e.g.:
> 
>     #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
>     failed to mmap with 12 (Cannot allocate memory)
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  kernel/events/ring_buffer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index a0433f37b024..c445e927368d 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -699,6 +699,9 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>  		watermark = 0;
>  	}
>  
> +	/* Can't allocate more than MAX_ORDER */

The comment is confused.  I'd like to refine it as:

  /*
   * kcalloc_node() is unable to allocate buffer if the size is larger
   * than: PAGE_SIZE << MAX_ORDER; directly bail out in this case.
   */

To be honest, I am not sure if perf core maintainers like this kind
thing or not.  Please seek their opinion before you move forward.

Thanks,
Leo

> +	if (get_order((unsigned long)nr_pages * sizeof(void *)) > MAX_ORDER)
> +		return -ENOMEM;
>  	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
>  				     node);
>  	if (!rb->aux_pages)
> -- 
> 2.39.3
> 
