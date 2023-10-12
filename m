Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3A87C775F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442777AbjJLTw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347379AbjJLTwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:52:51 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C53ECF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:52:50 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1dcdfeb7e44so802426fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140369; x=1697745169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SQbLTF/nBP7FGlZ+VD31cjDqozBIbeI0qV+6FlSylA=;
        b=UeCg9F99lYybKj1+478pZxpuv1LgufGPJOaHA9nE2ZBq9jUNVctZ+4LLVIVVS9SZyg
         /AelS7nGaw9NWzWHlbODgc6zctArazmCIBD/8PuVt7g+rVK6yzTyHJFNJfsNgt4TuDSr
         irtM7wCb9OvJJUFeJd3zOvtognVjFsAH7yitQC2UZG6R3dHCmtPkygCgNg82JWb2V/A7
         uKsA9HltNQW8rontBuE/8ahdAz3ZTaEtwPFEN+6sPw/HF0GPmvqsC0Ap9TkFh/P4MTcw
         QKQSmCJn6noovRF9EJWNIwJoDlzGCc3w5mWjuFxp1ejfnKOUl6rooyJvmRJT4Q6QRt7Z
         W9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140369; x=1697745169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SQbLTF/nBP7FGlZ+VD31cjDqozBIbeI0qV+6FlSylA=;
        b=XnYhFGz739eA9NkfPtbuLS/c9EaYMuoqQw+sH00XCFw21WIZPUKzx/LtvwihhAdXxj
         xvuruW0FCO+/hrfeZxAms1LTwFObgctJKI3xW9VsOAncOPISnNNNd1FTBUBCJv2xHjfz
         ub5MDAlnw6lTcg+BFH6LBj5mW4ci94UcjrDUxywRNTtr5uZhx59K+z+EuBCmAbBFbYSS
         8ymQFfdldrJ3/H5obtXYWQ+1zotid3I3Yhw9gdb6ns56BcMba9KKiMD/aBsy+xmXElVJ
         7w8QngdAdXd95982PBYLmA9lNBzT0wrDHPaiQI01Wt8krlzZ7H1vItPQkXy/m8z9voN6
         VuFQ==
X-Gm-Message-State: AOJu0YxjzPsTyL09cQIxhRe0G8K+zrDrI20grMOEXfjBuoY34aMlpZgH
        fu5FIbK2aPIps+mpa2DC5xDJ8V/6577w/A==
X-Google-Smtp-Source: AGHT+IEQTqoQczcKKLYPAhJmZAjC57GjqvL848JpYZjkIaab9wi36k1khyCeRc+1KI+02Aol7doutg==
X-Received: by 2002:a05:6870:8456:b0:1d6:3d31:fb4b with SMTP id n22-20020a056870845600b001d63d31fb4bmr30700787oak.24.1697140369624;
        Thu, 12 Oct 2023 12:52:49 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78d43000000b0069268e3a659sm12093110pfe.132.2023.10.12.12.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:52:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Oct 2023 09:52:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Override implicit ordered attribute in
 workqueue_apply_unbound_cpumask()
Message-ID: <ZShOkOZR8Xnk3tLf@slm.duckdns.org>
References: <20231011024842.3348767-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011024842.3348767-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:48:42PM -0400, Waiman Long wrote:
> Commit 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1
> to be ordered") enabled implicit ordered attribute to be added to
> WQ_UNBOUND workqueues with max_active of 1. This prevented the changing
> of attributes to these workqueues leading to fix commit 0a94efb5acbb
> ("workqueue: implicit ordered attribute should be overridable").
> 
> However, workqueue_apply_unbound_cpumask() was not updated at that time.
> So sysfs changes to wq_unbound_cpumask has no effect on WQ_UNBOUND
> workqueues with implicit ordered attribute. Since not all WQ_UNBOUND
> workqueues are visible on sysfs, we are not able to make all the
> necessary cpumask changes even if we iterates all the workqueue cpumasks
> in sysfs and changing them one by one.
> 
> Fix this problem by applying the corresponding change made
> to apply_workqueue_attrs_locked() in the fix commit to
> workqueue_apply_unbound_cpumask().
> 
> Fixes: 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to wq/for-6.6-fixes.

Thanks.

-- 
tejun
