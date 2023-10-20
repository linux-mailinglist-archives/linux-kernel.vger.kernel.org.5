Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B887D1097
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377274AbjJTNh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377002AbjJTNh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:37:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A4319E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:37:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53142351997so196650a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697809071; x=1698413871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXLDllsQlfgcB0N053/Ac6iwia8k1MwiyVxT73CFT+w=;
        b=KanOmSJR77LdIATF9x0+FOboSsT3l1lIepOayQ+9YTSa8dhHXnKYQkMmPWhfm58RWn
         q8XiVdkk7bTJ9P8NbPIDilgQ0h6W3xjB61/3fPfW8bK9sPALPU5AbjmOUpW2wraw8gfX
         CS7hXDqAgKaH9g4wVlmWrZtuRl8ptpvuE29ahBYlYA6AZf07BHYwKhJNBgIcqsUwMvqJ
         EWJG/cnybB8gXEL6G4Wns77ERBAm/lHJAgjKdqmoGWOgGBx0s2ZWM6r/VWgmUYxFcU9i
         NhMlncabKV/I9cSm1hGCxKsaRfWzvdzCBfM2jTnfazgXcm5UsZNkb4P2IiNY6y7un7QN
         JXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697809071; x=1698413871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXLDllsQlfgcB0N053/Ac6iwia8k1MwiyVxT73CFT+w=;
        b=YmPTHKyHjKVLOZ6sHjg3aevZzAKWpdZ6KpAuAuty1OZMey3qd/f+xtzCxZ9/UgLNl+
         9eeEV7PUGjMeB4TINM9LM7Yl9aFPo9WkJ+NO7RV3nxIkXobFSzuaG/LqmS1y1WFxmiRt
         TOHKTVxPXrTqb/IL2qT1WULIytlff9iMOubadVKKDw58OFUbCYaxrTHrV0RgERfKubPt
         kSl6EI+d/8fKR1eeEbnZFUvfb2N1TJ7ZppA2Fybb7Kh+F7gnAFB+l+HKZROOHUSEgIse
         bDsU2x3nehq4Re3AWdY9uK/KqRiUeb+uGetQhDMTHs7PBvFUdTYensoQDUWNLnqJC1PE
         ATpg==
X-Gm-Message-State: AOJu0Yyt5QxzfeaOCj9m8iMRAkL0yDcCdogjKHS8e8EtQEjuUb2qcHKv
        C8e0ye3/I9hp8J5KlnRoV+s=
X-Google-Smtp-Source: AGHT+IG6x40VrhXjKY/yt45sFIiA+33CWnG45eQFjowwJbsstEMnqyxFwUhCrtFIfV3hSg3rNtiNoQ==
X-Received: by 2002:a17:906:224b:b0:9a6:5340:c337 with SMTP id 11-20020a170906224b00b009a65340c337mr1381169ejr.2.1697809070633;
        Fri, 20 Oct 2023 06:37:50 -0700 (PDT)
Received: from ariel (dynamic-2a01-0c22-358a-4300-dabb-c1ff-fe05-d863.c22.pool.telefonica.de. [2a01:c22:358a:4300:dabb:c1ff:fe05:d863])
        by smtp.gmail.com with ESMTPSA id m10-20020a170906234a00b009b29668fce7sm1505464eja.113.2023.10.20.06.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 06:37:49 -0700 (PDT)
Sender: Emanuele Rocca <emarocca@gmail.com>
Date:   Fri, 20 Oct 2023 15:40:42 +0200
From:   Emanuele Rocca <ema@debian.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: Runtime overhead of PREEMPT_DYNAMIC
Message-ID: <ZTKDWnLrSnPs9VUi@ariel>
References: <ZTJFA_Ac6nWawIHb@ariel>
 <7a818250a8f36476f13b57a172fdb1ab23645edc.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a818250a8f36476f13b57a172fdb1ab23645edc.camel@gmx.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 2023-10-20 02:42, Mike Galbraith wrote:
> It's kinda hard to imagine the author's mailbox surviving submission
> day were it _that_ horrid, surely something is amiss.

Thanks for trying to reproduce! Let's see if we can find out what's
wrong in my setup then.

> voluntary (my usual)
> CONFIG_PREEMPT_VOLUNTARY_BUILD=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> # CONFIG_PREEMPT_DYNAMIC is not set
> 
> dynamic (same config, just flip dynamic switch)
> CONFIG_PREEMPT_BUILD=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_DYNAMIC=y

Here is the full diff between the kernel configurations I used. The only
change I made was setting CONFIG_PREEMPT_DYNAMIC=n, everything else was
a consequence of that AFAICT, but please do let me know if you see
anything that shouldn't be there.

--- config-6.5.0-0.preempt-dynamic-amd64	2023-10-11 15:30:02.000000000 +0200
+++ config-6.5.0-0.a.test-amd64	2023-10-11 14:30:02.000000000 +0200
@@ -125,13 +125,11 @@
 CONFIG_BPF_LSM=y
 # end of BPF subsystem
 
-CONFIG_PREEMPT_BUILD=y
+CONFIG_PREEMPT_VOLUNTARY_BUILD=y
 # CONFIG_PREEMPT_NONE is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_PREEMPT is not set
-CONFIG_PREEMPT_COUNT=y
-CONFIG_PREEMPTION=y
-CONFIG_PREEMPT_DYNAMIC=y
+# CONFIG_PREEMPT_DYNAMIC is not set
 # CONFIG_SCHED_CORE is not set
 
 #
@@ -156,11 +154,9 @@
 # RCU Subsystem
 #
 CONFIG_TREE_RCU=y
-CONFIG_PREEMPT_RCU=y
 # CONFIG_RCU_EXPERT is not set
 CONFIG_TREE_SRCU=y
 CONFIG_TASKS_RCU_GENERIC=y
-CONFIG_TASKS_RCU=y
 CONFIG_TASKS_RUDE_RCU=y
 CONFIG_TASKS_TRACE_RCU=y
 CONFIG_RCU_STALL_COMMON=y
@@ -1009,7 +1005,11 @@
 CONFIG_PREEMPT_NOTIFIERS=y
 CONFIG_PADATA=y
 CONFIG_ASN1=y
-CONFIG_UNINLINE_SPIN_UNLOCK=y
+CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
+CONFIG_INLINE_READ_UNLOCK=y
+CONFIG_INLINE_READ_UNLOCK_IRQ=y
+CONFIG_INLINE_WRITE_UNLOCK=y
+CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
 CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
 CONFIG_MUTEX_SPIN_ON_OWNER=y
 CONFIG_RWSEM_SPIN_ON_OWNER=y
@@ -5395,7 +5395,6 @@
 CONFIG_MEDIA_CEC_SUPPORT=y
 # CONFIG_CEC_CH7322 is not set
 # CONFIG_CEC_CROS_EC is not set
-# CONFIG_CEC_GPIO is not set
 CONFIG_CEC_SECO=m
 # CONFIG_CEC_SECO_RC is not set
 CONFIG_USB_PULSE8_CEC=m
@@ -10597,7 +10596,6 @@
 # end of Scheduler Debugging
 
 # CONFIG_DEBUG_TIMEKEEPING is not set
-CONFIG_DEBUG_PREEMPT=y
 
 #
 # Lock Debugging (spinlocks, mutexes, etc...)
@@ -10696,7 +10694,6 @@
 # CONFIG_FUNCTION_PROFILER is not set
 CONFIG_STACK_TRACER=y
 # CONFIG_IRQSOFF_TRACER is not set
-# CONFIG_PREEMPT_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
 # CONFIG_HWLAT_TRACER is not set
 # CONFIG_OSNOISE_TRACER is not set
