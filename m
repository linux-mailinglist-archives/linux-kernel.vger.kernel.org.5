Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1957BD93D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346173AbjJILIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346157AbjJILIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:08:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A968BEA;
        Mon,  9 Oct 2023 04:08:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32329d935d4so3971880f8f.2;
        Mon, 09 Oct 2023 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696849720; x=1697454520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9risSfMSWEV6oRJZRPDScSLa9A8a5vl1EYTHeHk7jE=;
        b=lSnF+fqjtmj0BXsXfgTpSgv+ur7DkGd3lluTmOFkVtx1lQ7ZTDk374+zFoWR95Lkp0
         apgstSmJpShko9dXFXdPoSvzIL+8UTMLVQ48WRpue/gUaWXfff+Aivut2WWPnizttaLT
         MOMlMfIup+4u6BvxdVVufgUxOtNZ1X8kvcxiqP5ndVWgtgviLYvcN0zCSsG7QhMP5rH9
         Nrw/w+qSG0vjKaJhAzo8BvE4F1N0shGjtWlgxyrTCbh5/kiNj59e5DFvfM2+udxs3Y+F
         oMfjPUYWYCBL0cCN3SOUUSkgfN1Uuc/RG/DSRx5V6Og1IN9Agpa24i3dQth7iqzNaDKh
         xKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696849720; x=1697454520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9risSfMSWEV6oRJZRPDScSLa9A8a5vl1EYTHeHk7jE=;
        b=fuBTRd/TVZDvMhG03z/G78uF0wsfQ+vbtoSXsNs44PVc/M6JH9KB6jGxUMTLxZ8w4J
         mpAgXu1OnTOJgo96O/ZOAiZ5tu6hTuloy0ALlxgQPCDEALRlykUwFOlOcy3jvPGatp/C
         htKj9HVFaFWOKltpBI6G6ztFRyOXpyDYgpTYSx+q6w5o6PjDuqmBX9rc3zs8WBWXbcCF
         G4dvF1uYXzQSSPxyiFfGC1aOw6C16OIQuO8S9cRuBZUv1W4kS9gcaJiOpr43qiHU+6M/
         912AnlcbUY76GAvz4MP9IBLUE1muiR+w20GdP4bbNw63cemNSR0U1ZcUdtlNo4bqZj6t
         wbmQ==
X-Gm-Message-State: AOJu0YzXjUjvxtE4dMES/nG07YlYx79HRbEwfdGmqzWK82VY3RDxwN71
        D3XVXdcCTIuENvIByqhIEqY=
X-Google-Smtp-Source: AGHT+IGdW32gEgM9+C72he3zdPRbYXoNtsE33XkdTOkcjiBEGsczM0d1rp7Sq2SVBgr1zLbyqqJDng==
X-Received: by 2002:adf:fc4c:0:b0:319:785a:fce0 with SMTP id e12-20020adffc4c000000b00319785afce0mr13739262wrs.26.1696849719936;
        Mon, 09 Oct 2023 04:08:39 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b0040472ad9a3dsm10908725wmq.14.2023.10.09.04.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:08:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 13:08:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        vschneid@redhat.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, qperret@google.com,
        srikar@linux.vnet.ibm.com, pierre.gondois@arm.com,
        yu.c.chen@intel.com, tim.c.chen@linux.intel.com, pauld@redhat.com,
        lukasz.luba@arm.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 1/2] sched/topology: Remove EM_MAX_COMPLEXITY limit
Message-ID: <ZSPfMjuOC5dTkx5i@gmail.com>
References: <20231009060037.170765-1-sshegde@linux.vnet.ibm.com>
 <20231009060037.170765-2-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009060037.170765-2-sshegde@linux.vnet.ibm.com>
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

> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> The Energy Aware Scheduler (EAS) estimates the energy consumption
> of placing a task on different CPUs. The goal is to minimize this
> energy consumption. Estimating the energy of different task placements
> is increasingly complex with the size of the platform. To avoid having
> a slow wake-up path, EAS is only enabled if this complexity is low
> enough.

...

> To reflect this improvement, remove the EAS complexity check.
> Note that a limit on the number of CPUs still holds against
> EM_MAX_NUM_CPUS to avoid overflows during the energy estimation.
> 
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  Documentation/scheduler/sched-energy.rst | 29 ++----------------
>  kernel/sched/topology.c                  | 39 ++----------------------
>  2 files changed, 6 insertions(+), 62 deletions(-)

I've applied this patch to tip:sched/core, for a v6.7 merge, thanks!

	Ingo
