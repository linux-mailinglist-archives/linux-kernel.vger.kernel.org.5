Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F8777C462
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjHOAWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjHOAWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:22:21 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF32172A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:22:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686f0d66652so4680756b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692058939; x=1692663739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oVQcJUk34q5Jy7JwsqVrOJnhO5CfXC6D4qfVL7OASE=;
        b=aCTlaNuKFwPmWi6+79nnitf0o71uV+bqz4rX/k8vQQ/N7L7ZiNHPEb1cmdTZ0a2ro8
         n4jPqc2VuWg1tkBF34IBAkQiRjuln1cvX44EbVyLO2P4v0TC342pmwYIcEg8FOW89ztm
         0AIODjGm1QzNgINCm03rdU86z21Cb4oJhc2tbBQ9PhhzM6hVrjQrS93SuFQevIsA5ue+
         oH8G3C/n3D6h8IVkd0lOLM4hqfLaZJwEzbVkDPfA0h+hYiUaXoKnO79yvfVUdMaMpxpa
         j+0JOtyKgnE10qiQf7EXalsoCF7lLC/ulBq8M5juG8rw6jFbW85HuF8ygajqMHtLUhit
         ad6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692058939; x=1692663739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oVQcJUk34q5Jy7JwsqVrOJnhO5CfXC6D4qfVL7OASE=;
        b=O/Y/e4aHmfzxJp+1liT166Kgu5NDAba3x3VXiiHdZ3+wgIuOLLa55nQM0tvX01wvj4
         K4cXfWAsOrFvkt2PGcii9tjcG3mCiuxttvuDteWbQZ+SJoC5eP+/+YdDYSS8oG2ZFGIo
         hqBFHLYdeQN6BDwAfkjJ8ZkuoDQhxMP5Uc2zmLWuhDozpatws/w+xVXYFLZsR8Mo8uoo
         74cF2iZHdadzlKx5NTUKq4GUEg5edzOTsAXdMbkA3uUKAoVmwup6g/nFvsofpsYSpQji
         QW/01YXNO1djbJ7P53IvPDIKjRtlo6BhI1qdqQf3rOHbGsTGQ+1qpESTHtredE+32jVT
         LAYA==
X-Gm-Message-State: AOJu0Yz3agGXlvy4S1S2G4cVc7cZ1uArSmgsL6E39RRGcrvwb+XUEQw2
        KE65fYRzsOyOOMqOLeJGuw+F2FiBhyY=
X-Google-Smtp-Source: AGHT+IHmi/FlyEyGdQe6Ah98lj7M+FdLtWWzSDRQpcD/DYNaRO7XfSUNkSojpFb1FvDtwqvHUcAnQw==
X-Received: by 2002:a05:6a00:1a90:b0:682:5a68:9846 with SMTP id e16-20020a056a001a9000b006825a689846mr14235891pfv.16.1692058939421;
        Mon, 14 Aug 2023 17:22:19 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78008000000b00682669dc19bsm8388262pfi.201.2023.08.14.17.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 17:22:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Aug 2023 14:22:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Aaron Tomlin <atomlin@atomlin.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH v2 1/1] workqueue: Rename rescuer kworker
Message-ID: <ZNrFOf0wWbJavaUV@slm.duckdns.org>
References: <20230808120329.3400069-1-atomlin@atomlin.com>
 <20230808120329.3400069-2-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808120329.3400069-2-atomlin@atomlin.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 01:03:29PM +0100, Aaron Tomlin wrote:
> Each CPU-specific and unbound kworker kthread conforms to a particular
> naming scheme. However, this does not extend to the rescuer kworker.
> At present, a rescuer kworker is simply named according to its
> workqueue's name. This can be cryptic.
> 
> This patch modifies a rescuer to follow the kworker naming scheme.
> The "r" is indicative of a rescuer and after "-" is its workqueue's
> name e.g. "kworker/r-ext4-rsv-conver".
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Applied to wq/for-6.6 with prefix "r" replaced with "R" to make it more
distinct and consistent with how highpri pools are marked.

Thanks.

-- 
tejun
