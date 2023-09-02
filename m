Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91234790781
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351982AbjIBK7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjIBK7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:59:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3AD12D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 03:59:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31c7912416bso2552181f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 03:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693652340; x=1694257140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zny2uH4by9pLpS4qK+Kn968GAU8fo6gbh0NiotejarQ=;
        b=lIFxVBW4VYFKmBr1SAIQBnLqe7mDKTybpMs1ZNRLNZ7axgY7kw4Il6UMoKTtRbbfLV
         RHoZIkLRA9jvIE1Fq0muOAjcOT+HtnvKW94uFCZgr6ptYJWrlo+qcYxA+0qblPwzqqPx
         AkfZN2+PaWxm0KJ/YN34FshXhSmPjODshYr6Hj+WF4qX1flPg4X8+0lezXrtKwtmIU/A
         gFEaqDTLKI3y/LnfKxjcNzrMSuzriHGPut4QW3s0kxMbxoWfTwHJwuc2q8hkRFaixw9X
         QqflATCALtwepB0GJvznkigT9iSIYQrJPgj6x5BZZ0oqTJPxA4b7/ELHL0gGava77XRO
         kKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693652340; x=1694257140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zny2uH4by9pLpS4qK+Kn968GAU8fo6gbh0NiotejarQ=;
        b=ftcQlzsGPxIM425nhQ1fiQhQFhcfxh8WJGRAJPAm2G/vi6qPrl1ofl8XkMUhkuLw1X
         G6wExs6Yms3gAQVpDmQr2aH8qpZpr6qibxXr9gcG7KhFXDJSTjXFlFawRma1sEv0uDRS
         W1/H/bN3yWrku1eZLR6AAv7RahAfPaNtGVRyiXQoKlKgdTPQcXCL556r2lDn98iccUSg
         NNi2q9godfFp27MK9+XGZshQ/LwThdMwXutYpcC14JopELWaFw4T6MWOSu7CpkRDGe/J
         juEETIOK6z63FSV9Nwwu8ZFBHdn6JmXzkzDu5Cv56sQzY2KdT2lC+HPNU9y84YPGvXMs
         toog==
X-Gm-Message-State: AOJu0YxZdsZqdO+1xbx20ZgP6CtXwc1fPy/U7YQlCDHF6FSmnh+8uI/b
        9B2+D/Yh4VkeNw2oip8IN2A=
X-Google-Smtp-Source: AGHT+IHPvzcLwOYaq5tWRyJJJBzmerrAaU1ypc6iheIwQ9E3i2uYJvzjL3xbXTvby+aa+SgWwC6B3Q==
X-Received: by 2002:a5d:68ce:0:b0:319:7c7d:8d1 with SMTP id p14-20020a5d68ce000000b003197c7d08d1mr3542623wrw.44.1693652340130;
        Sat, 02 Sep 2023 03:59:00 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id l16-20020a5d6690000000b0031c6dc684f8sm8079521wru.20.2023.09.02.03.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 03:58:59 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 2 Sep 2023 12:58:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yu.c.chen@intel.com,
        ricardo.neri-calderon@linux.intel.com, iamjoonsoo.kim@lge.com,
        tim.c.chen@linux.intel.com, juri.lelli@redhat.com,
        rocking@linux.alibaba.com, joshdon@google.com
Subject: Re: [PATCH] sched/fair: optimize should_we_balance for higher SMT
 systems
Message-ID: <ZPMVcTFmtvshJRYH@gmail.com>
References: <20230902081204.232218-1-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902081204.232218-1-sshegde@linux.vnet.ibm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Shrikanth Hegde <sshegde@linux.vnet.ibm.com> wrote:

> should_we_balance is called in load_balance to find out if the CPU that
> is trying to do the load balance is the right one or not.
> With commit b1bfeab9b002("sched/fair: Consider the idle state of the whole
> core for load balance"), tries to find an idle core to do the load balancing
> and fallsback on an idle sibling CPU if there is no idle core.
> 
> However, on larger SMT systems, it could be needlessly iterating to find a
> idle by scanning all the CPUs in an non-idle core. If the core is not idle,
> and first SMT sibling which is idle has been found, then its not needed to
> check other SMT siblings for idleness
> 
> Lets say in SMT4, Core0 has 0,2,4,6 and CPU0 is BUSY and rest are IDLE.
> balancing domain is MC/DIE. CPU2 will be set as the first idle_smt and
> same process would be repeated for CPU4 and CPU6 but this is unnecessary.
> Since calling is_core_idle loops through all CPU's in the SMT mask, effect
> is multiplied by weight of smt_mask. For example,when say 1 CPU is busy,
> we would skip loop for 2 CPU's and skip iterating over 8CPU's. That
> effect would be more in DIE/NUMA domain where there are more cores.
> 
> Testing and performance evaluation
> The test has been done on this system which has 12 cores, i.e 24 small
> cores with SMT=4
> lscpu
> Architecture:            ppc64le
>   Byte Order:            Little Endian
> CPU(s):                  96
>   On-line CPU(s) list:   0-95
> Model name:              POWER10 (architected), altivec supported
>   Thread(s) per core:    8

Ok, so the performance figures are pretty convincing, and the approach
is fairly simple - so I've applied your patch to tip:sched/urgent,
to address the performance regression caused by b1bfeab9b002.

Thanks,

	Ingo
