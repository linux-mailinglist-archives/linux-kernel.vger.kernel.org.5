Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A18A79A027
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 23:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjIJVuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 17:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIJVuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 17:50:00 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7555188
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 14:49:56 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fac16ee5fso599978b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694382596; x=1694987396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap2gCwDznGcrACjN46HTkhogiuAiSp+gfJD39Hlrbis=;
        b=A6aavo+QoMzD7xtxnkKuo/0AoJfvCJpv6eyHijRIDMXdXh0WSOSuxGfHoC+l8lfjZ+
         dTJ42tA35b5WcjqiZS6WWJzXCzBMD6Erkr8php6tzqljSWzm3wNlsjqDv1XPe9eYfi8S
         06EoWbZDdnvhl9D35uBlzEDC/DNsuI8D0gUKYFm7thS7NWNA3IYV5XXalNttP8I+ny7A
         ox2Kx+Jl8E/pj7XfqTe7L9jQuYs3P6HNVsUNq/oKFd+ezU+PY3MmHw6hUPfNkY4Vz4Tv
         NBwnAjs+89h4Kpp3j5vjb7sO8UbinZp+W+omU28oKxy+L05mHgegPXQSNj2ElGAsNo3r
         xsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694382596; x=1694987396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap2gCwDznGcrACjN46HTkhogiuAiSp+gfJD39Hlrbis=;
        b=KDDsDnWcRxh90HSQqAEDYjU6IQjZ6v/Yl/ty+00cVwpaWb0FhEXh1m5dSsmGkHs/Ji
         1x2lViENu7Zzy5wzj+NoTwoq7/GafAxiK6G6Y5beyjEtdKkNJem5vyLdnBdbc0Mh+T4t
         GV4HY6ey74nVHj1LALzLTsN0mPp/bJjPL85Ym2Qq8SqcULzyRHEMFW+hcsfuDDe9mfEL
         MwZPyjnr8bLrEC6pZylJZTK7b/pbW6glyFglrWIaVIUTobZlRwmOouCBgO8rtljKQ0IY
         0BICxPbYz7cR6HGqUIZH9gfrXpDTRfSJgCwHfbgCY1yuCfJ5khFhWQebWxqrEd170KcW
         wR7g==
X-Gm-Message-State: AOJu0YzvmqsM2556yEELPeTdQXYhVyNNxdmr1TReJdJQHP3Fl0c0iF0V
        QPIiMJqLx0XasRCyWcLBu/jv23KIPPgj1cGZSzA=
X-Google-Smtp-Source: AGHT+IFAaeZYXvSAMNmSDSiEyPXZ+bYxU0+eTWjMoIIO+arAqg9AyavIHGotGQ32KMQ1T7cFwEtwrg==
X-Received: by 2002:a05:6a20:948f:b0:148:14ed:2b88 with SMTP id hs15-20020a056a20948f00b0014814ed2b88mr6201483pzb.30.1694382595729;
        Sun, 10 Sep 2023 14:49:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001b83e624eecsm5016601plg.81.2023.09.10.14.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 14:49:54 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qfSJT-00DVon-2V;
        Mon, 11 Sep 2023 07:49:51 +1000
Date:   Mon, 11 Sep 2023 07:49:51 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     alexjlzheng@gmail.com
Cc:     chandan.babu@oracle.com, djwong@kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v2] xfs: remove redundant batch variables for
 serialization
Message-ID: <ZP45/7KfB0sHuCIk@dread.disaster.area>
References: <20230909071750.2455895-1-alexjlzheng@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909071750.2455895-1-alexjlzheng@tencent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 03:17:51PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> Historically, when generic percpu counters were introduced in xfs for
> free block counters by commit 0d485ada404b ("xfs: use generic percpu
> counters for free block counter"), the counters used a custom batch
> size. In xfs_mod_freecounter(), originally named xfs_mod_fdblocks(),
> this patch attempted to serialize the program using a smaller batch size
> as parameter to the addition function as the counter approaches 0.
> 
> Commit 8c1903d3081a ("xfs: inode and free block counters need to use
> __percpu_counter_compare") pointed out the error in commit 0d485ada404b
> ("xfs: use generic percpu counters for free block counter") mentioned
> above and said that "Because the counters use a custom batch size, the
> comparison functions need to be aware of that batch size otherwise the
> comparison does not work correctly". Then percpu_counter_compare() was
> replaced with __percpu_counter_compare() with parameter
> XFS_FDBLOCKS_BATCH.
> 
> After commit 8c1903d3081a ("xfs: inode and free block counters need to
> use __percpu_counter_compare"), the existence of the batch variable is
> no longer necessary, so this patch is proposed to simplify the code by
> removing it.

Hmmmm. Fiddling with percpu counter batch thresholds can expose
unexpected corner case behaviours.  What testing have you done on
this change?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
