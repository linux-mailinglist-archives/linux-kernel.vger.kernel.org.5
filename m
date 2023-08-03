Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688B776DFE7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjHCFwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHCFwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:52:04 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DEF2D43
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 22:52:03 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53482b44007so315641a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 22:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691041923; x=1691646723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7Xjxw5oP4NVrDYaL/2U9f67DZbadaUYZn2oVTJWP4Y=;
        b=c9c3oFd5ZfGep7Y6Qt5e6nDkPbJRtR9CxU7dV/wdz5TM0eBVml0MCoWf3Unmm6codE
         cD2jDrO7kYLddk5ESrvpHQK4we0/lkaL7K719YCTkWk7uCK9NVu6RyhL6RJG3vsAcT3e
         JsFqzczjOZTEOAKx+fkIR56RL/kRoLOaZOrMGT8/iwX2X+ZXdgt5mHXRfzlAaCynXQYg
         U3VBfd+tGpqCING6LjH/HvNIxmfDGHjSRXFsGC1M6jMArcVmKpHj0Q7TqDWMqCo8Dptg
         VcAZoKk6UAURY6xm1bBHbLLAX0iZ1gq6qdoaA0dbJvjHvJG6hJKjWNlm1jZGQE7lbQP/
         4xlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691041923; x=1691646723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7Xjxw5oP4NVrDYaL/2U9f67DZbadaUYZn2oVTJWP4Y=;
        b=AaJAh+5526lPlzDRWIz8q1363+STPKQBoDeFVM4GbNjxzPzJp1UZjffycrdvQeSSXg
         0hc2+QO+2+aWOIltt1WauZPiVopRAmPeKpDtQKHqdeSh6urN5yCshgK/AfDN0y8eADQT
         XzyM0oKjfJeP6Op8Pi6ukss7kltwNUnnSKUiQPY0NmIktaGamcaZ3dfCY/cxomOXCy7O
         iCkTCLB6z5sxd91JwYBjhe/xBqD/Kecwtsn0/VPk0nLMKhJsL7fWaGicN/iMUV7GyMK7
         s3B1GYZ56X6e0gZ3FCIxaQG5W7OU13I7U0YQGkumgANlh6bzRiMmUSbVL1ojcLtuIoak
         RiEA==
X-Gm-Message-State: ABy/qLb7OLtubKABYNugqkYqQs1e+JE2D94dOCyL/nsKV8QAYc77LjOu
        bU82YjFNdlSZzDlOxcGmW+7TCQ==
X-Google-Smtp-Source: APBJJlFbeznejLOl5fuDUqmAF9iajzKw8sPutb+mj1oH4M1L7QAjZN+0V0ejGcBti4J4DuXx8P9j3A==
X-Received: by 2002:a17:902:ce86:b0:1bb:c64f:9a5e with SMTP id f6-20020a170902ce8600b001bbc64f9a5emr16747225plg.5.1691041920317;
        Wed, 02 Aug 2023 22:52:00 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001bbb1eec92esm13383748plb.281.2023.08.02.22.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 22:51:59 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:21:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     David Dai <davidai@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <20230803055157.6buxd5lcxjo4wrbk@vireshk-i7>
References: <20230731174613.4133167-1-davidai@google.com>
 <20230731174613.4133167-3-davidai@google.com>
 <20230801093620.ggz25g3faxycp44q@vireshk-i7>
 <CAGETcx-Y2MONWPEWYHXsWtBxuFQP51wTCS30wJt+NYKD969BuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-Y2MONWPEWYHXsWtBxuFQP51wTCS30wJt+NYKD969BuA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-08-23, 15:16, Saravana Kannan wrote:
> This is mainly an optimization to reduce the latency of the "frequency
> change" which has a huge impact on the performance (as can be seen
> from the numbers in the cover letter).
> 
> Setting this flag means that the vCPU thread triggering the MMIO
> handling (on the host side) is the thread on which the host needs to
> apply any uclamp settings. So this avoids the VMM having to look up
> the right vCPU thread that corresponds to this CPU, and any
> permissions issues wrt setting another threads uclamp, etc. This
> becomes even more important if/when BPF support is added for handling
> simple MMIO read/writes. Will Deacon has been working on the eBPF
> part[1] and IIUC, not setting this flag adds a lot of extra overhead
> on the BPF side.
> 
> So, yeah, this flag is very helpful wrt reducing latency/simplifying
> host side implementation and that's why we want it here.
> 
> [1] - https://kvm-forum.qemu.org/2023/talk/AZKC77/

Would be good to have a (big) comment in the code explaining that as
it isn't obvious. Thanks.

-- 
viresh
