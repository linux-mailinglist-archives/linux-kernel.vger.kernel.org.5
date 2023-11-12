Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A317E91EB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjKLSGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 13:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKLSGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:06:43 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E61B1BEF;
        Sun, 12 Nov 2023 10:06:35 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-779fb118fe4so238650785a.2;
        Sun, 12 Nov 2023 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699812394; x=1700417194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYBpqt2maZnXJZySEOxbkSAKhJ1TFL1DTl+f6jodsbI=;
        b=CPMbXXAYvvl4XNH3i1Xz0QDUQBmVIrNRqHppSX/obcoSlSClhoBJHlpDAgQv7nrMvL
         l2aLLyWPoPz2zlub5yDoHGcUxj+GpnlefUfCzwJOwEVPKNn44Il4kaouRZd4BY1njPQk
         X2qXNlDe1qP4nZApQyIl2r8boT08VEH/2nwhXoUNffMQSYpA+FcdxBF+YlqQchlWkCeg
         wlpqDYkpOMLLHvLeh6L3FoSCmijDmF2xBYv0tfOCyEDGdIqFihANfHTvDYXD3yzCozJJ
         bdYvTHEljZdubmkpPC9HJNPTIDA/5WVcFEA5DzV7WI29EGFzXJd9WtoTuBzziyDBX/rK
         9cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699812394; x=1700417194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYBpqt2maZnXJZySEOxbkSAKhJ1TFL1DTl+f6jodsbI=;
        b=o9ph4e0/rPTCdyZNgyx139cyj2s+8XHT1ju8UAzUleWDvEzMhoP441a5DNq77VIqmF
         YAhRRpEBwVHZM0+UpYSrKr2BJkjReBz6LHlod1m/TfMLvKtZ9iUc4ZHZWRz5JQvn/oI9
         wPBKAtXARd5IXbC412AVng5oeZNcI6cE8dMpevYQHabZu3t0tKJvFPiEMQFTH9MP1uKb
         JYPkk3oHyoTo2HsEkIAkKwKDLVLyVyJHZmfANVHkZjYrRbbSykrvS5e7xJkZSU1Os/Qh
         B1rWZrnZcyRDRiMGslU77OXLWt9/y7wjGyL0AE1gdIqEK1+YzzIRGg1emYzWcMA4qSgD
         nwHQ==
X-Gm-Message-State: AOJu0Yx2t3A9eHviQxUYpzCsfHYqvg+7dqGg7p5iWLoApJ+0So8fnXp+
        j29hbhOaB/kooGBj1Klv0ZU=
X-Google-Smtp-Source: AGHT+IFJ8x6v+MyEcgCMWlHG75yD0CeUScuXv5i/YFrWW0aTn2r7DUusfgfWijCP870D8Pb8/izHAQ==
X-Received: by 2002:a05:620a:4398:b0:767:2076:5bee with SMTP id a24-20020a05620a439800b0076720765beemr6126323qkp.9.1699812393971;
        Sun, 12 Nov 2023 10:06:33 -0800 (PST)
Received: from localhost ([50.201.95.250])
        by smtp.gmail.com with ESMTPSA id tp9-20020a05620a3c8900b007757eddae8bsm1292696qkn.62.2023.11.12.10.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 10:06:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 12 Nov 2023 12:06:32 -0600
From:   Tejun Heo <tj@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 13/36] sched_ext: Add scx_simple and scx_example_qmap
 example schedulers
Message-ID: <ZVEUKK2sMgEZsmO_@mtj.duckdns.org>
References: <20231111024835.2164816-14-tj@kernel.org>
 <202311121239.GTR1obNe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311121239.GTR1obNe-lkp@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 12:17:07PM +0800, kernel test robot wrote:
> Hi Tejun,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linux/master]
> [also build test ERROR on linus/master next-20231110]
> [cannot apply to tip/sched/core tj-cgroup/for-next v6.6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.

The patches are on top of bpf-next:

 git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master

> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]

Will do.

> url:    https://github.com/intel-lab-lkp/linux/commits/Tejun-Heo/sched-Restructure-sched_class-order-sanity-checks-in-sched_init/20231111-145751
> base:   linux/master
> patch link:    https://lore.kernel.org/r/20231111024835.2164816-14-tj%40kernel.org
> patch subject: [PATCH 13/36] sched_ext: Add scx_simple and scx_example_qmap example schedulers
> reproduce: (https://download.01.org/0day-ci/archive/20231112/202311121239.GTR1obNe-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311121239.GTR1obNe-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> Makefile:83: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  ../../vmlinux /sys/kernel/btf/vmlinux /boot/vmlinux-5.9.0-0.bpo.2-amd64".  Stop.

The example schedulers need the following options enabled.

  CONFIG_BPF=y
  CONFIG_SCHED_CLASS_EXT=y
  CONFIG_BPF_SYSCALL=y
  CONFIG_BPF_JIT=y
  CONFIG_DEBUG_INFO_BTF=y
  CONFIG_BPF_JIT_ALWAYS_ON=y
  CONFIG_BPF_JIT_DEFAULT_ON=y

Thanks.

-- 
tejun
