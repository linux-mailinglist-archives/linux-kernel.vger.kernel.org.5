Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A94078E055
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbjH3Tai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343984AbjH3RvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:51:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABA3193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:51:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27183f4ccc1so6287a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693417876; x=1694022676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWxHZBHe+McomQO2YHa9mxYrBp2VqVWidmsS0Hpwi+s=;
        b=SN/zYNMbx+ezV1EayCdP8voonBBDg6SwlypnEjXKu8qrYWhWlTOBZkWc1VHh8qa+lJ
         rz0iwG4TlPbBvMFHveEiUlbKWIKAl0Z/hnKSjoE4YydXYZnHY/bdcrDinQ1+iWC3pYQf
         Fq1TikPEVnG8AS4e/vHOb/Wp+XvtPIfTC6lUZpFSf1HecZ7wiIxmKdOt0pL5AQ09appS
         tsoDK8nNvdkYZu6bg+YA7UwmKOZYFuhbve0+rGVOtLdZCPxTJilDsCCAgv2xW9IAXVEz
         hm4EYrLnp0rcjPTzceiugYyY5E8b++NmTPmSMFaGRhZsE2FaTLFsehtMPeDOidNN11AO
         p0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693417876; x=1694022676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWxHZBHe+McomQO2YHa9mxYrBp2VqVWidmsS0Hpwi+s=;
        b=CEgC8PgPvJ70BKe8AtrUJGhXEaq/vs7JJ6EUwMb0msjPRcV1PCSF+0d568/XxUvDWs
         igvPVpJX8sF7wcBaSJj3HUP2QYm38H0HrHOnlNg82AkQNXc6afijbCB9xBWMiSsX82p5
         lMicyJLN3bfg2GCMaKEuC08CI5Rvi4eXltccCDIoyJEbUmdo5wg1kMI2LDUZl8igUS7Q
         rx+eSr/iSmh5xvqYlJT1qZVZIcHK3Ex9qX60MF/m9LBcaoYH/em9GzesCrSFVu/OOIOd
         LHBnRalBGKj/JeIfoTuiZ++3EAWBXsHC1gM7XXLVOycf2L4MulIi9LfuDxBdL/7bSxe1
         uhTA==
X-Gm-Message-State: AOJu0YwUZlG2fTuDTFxYh2GVlfmrbZXQIQuMVp0RYu7tzyaWGS/iOLhs
        05fsuibPFjXfC3D3Z+fr3Qbme0vGPR0=
X-Google-Smtp-Source: AGHT+IFOnDLb75qnIk8shTUqbVkDhI7QMBhXtBxk+doHCAIlVlzWjbe70pnsbZITl3aGZjTkxhiRNA==
X-Received: by 2002:a17:90b:196:b0:268:81c6:a01f with SMTP id t22-20020a17090b019600b0026881c6a01fmr2926973pjs.26.1693417875803;
        Wed, 30 Aug 2023 10:51:15 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id nh5-20020a17090b364500b0026b0b4ed7b1sm1525450pjb.15.2023.08.30.10.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 10:51:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Aug 2023 07:51:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: WQ_UNBOUND warning since recent workqueue refactoring
Message-ID: <ZO-BkaGuVCgdr3wc@slm.duckdns.org>
References: <f7e21caa-e98d-e5b5-932a-fe12d27fde9b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e21caa-e98d-e5b5-932a-fe12d27fde9b@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(cc'ing i915 folks)

On Wed, Aug 30, 2023 at 04:57:42PM +0200, Heiner Kallweit wrote:
> Recently I started to see the following warning on linux-next and presumably
> this may be related to the refactoring of the workqueue core code.
> 
> [   56.900223] workqueue: output_poll_execute [drm_kms_helper] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> [   56.923226] workqueue: i915_hpd_poll_init_work [i915] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> [   97.860430] workqueue: output_poll_execute [drm_kms_helper] hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
> [   97.884453] workqueue: i915_hpd_poll_init_work [i915] hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
> 
> Adding WQ_UNBOUND to these queues didn't change the behavior.

That should have made them go away as the code path isn't active at all for
WQ_UNBOUND workqueues. Can you please double check?

> Maybe relevant: I run the affected system headless.

i915 folks, workqueue recently added debug warnings which trigger when a
per-cpu work item hogs the CPU for too long - 10ms in this case. This is
problematic because such work item can stall other per-cpu work items.

* Is it expected for the above two work functions to occupy the CPU for over
  10ms repeatedly?

* If so, can we make them use an unbound workqueue instead?

Thanks.

-- 
tejun
