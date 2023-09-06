Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02C07935DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbjIFHC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjIFHC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:02:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4232E63
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:02:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a41031768so2185149b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693983764; x=1694588564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bOnepIQCwDJc0Ol2faDFJoKyl17qehBQgFjOxk2yOU=;
        b=ItiOw4QjLUNO6wlW2bCq4O98I42nPVeRvL3ChIJ6iJzQoRDfFGmq7lPU8Oo6cR+cAo
         Fy1fHkcRi74NXog4vpPJXYl0EIbrVlEAwwYy4JENVFz//DWKCWlGiJ4WqI6a3dzv21As
         vYALOTkcqygLc04OgjO6z16v7Vxzkn1XgTmdaxjuvovTZ1AdFJ9B3URf6U+uCJ+nbMrv
         /XoOKM62s2I2FGaHkecxybYDWwoxecFvYoFn7BM3FHGN8NPhhzlTLmfTucOwE3Mk5U/m
         rtLYdpy0VWPn7FKjY954shMrfrbuyfiJ21e+QINYJd4trwHvmv6RxbaBKsCuLvh+MWQC
         y8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693983764; x=1694588564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bOnepIQCwDJc0Ol2faDFJoKyl17qehBQgFjOxk2yOU=;
        b=FISHtQjr1nHTX4/hJqea4V/4UiLLrkvQa5jDv1nOkeVGtILzx8xInP2z0hTycfLMUN
         5FgPZkv9nXVVma9ioSMnsGN7IdJkKl936uMqrp4gxQefC9kscXwx1fbDXapv65GE4wXy
         wwmtwHAeIZzeuB0MrgJAcEJedBF+8ylXWZSxuG7JOxlJ0RpR3PwBSH5bHKk2JWCfp4KS
         B6vfweLlsb12O8YZwBh5h0w+aSKxGPnQ7cF+EvTbKZjI3ANLeW3ikfbbwzxGmpWrfSUL
         dfITRv50MziXJkQbJCoD38ByAra2pQUlNxmhkOqdRkKeIqXvU0iQC3WK1RAwpEUO1Xt8
         uZgw==
X-Gm-Message-State: AOJu0Ywa0a/MoEnSMYFfVFr9UzrQpTVVG1rVwOwmxfxQpk+2/j0yLlMZ
        /G61aq71JBWJe0lYxnbEC6ucsA==
X-Google-Smtp-Source: AGHT+IGf8EtxGmsoMwjlaVopnTftJ5aYiB3q3jQlbgXnfvpOjee82EdHZhKtZ7IyleF+2HOGCXGfNg==
X-Received: by 2002:a05:6a21:3b4a:b0:142:aced:c643 with SMTP id zy10-20020a056a213b4a00b00142acedc643mr14336394pzb.31.1693983764200;
        Wed, 06 Sep 2023 00:02:44 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.29])
        by smtp.gmail.com with ESMTPSA id q19-20020a62ae13000000b0068a49aad7d4sm10167691pff.79.2023.09.06.00.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 00:02:43 -0700 (PDT)
Date:   Wed, 6 Sep 2023 15:02:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        baolin.wang@linux.alibaba.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 1/2] perf/core: Bail out early if the request AUX area
 is out of bound
Message-ID: <20230906070238.GC388456@leoy-huanghe.lan>
References: <20230804072945.85731-1-xueshuai@linux.alibaba.com>
 <20230804072945.85731-2-xueshuai@linux.alibaba.com>
 <20230804085947.GB589820@leoy-yangtze.lan>
 <534c5e53-07bb-07bd-0435-76a10b55228d@linux.alibaba.com>
 <bad0d23d-a66e-0558-469b-a2dd1d5eb497@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad0d23d-a66e-0558-469b-a2dd1d5eb497@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuai,

On Wed, Sep 06, 2023 at 11:27:38AM +0800, Shuai Xue wrote:

[...]

> >>> +	/* Can't allocate more than MAX_ORDER */
> >>
> >> The comment is confused.  I'd like to refine it as:
> >>
> >>   /*
> >>    * kcalloc_node() is unable to allocate buffer if the size is larger
> >>    * than: PAGE_SIZE << MAX_ORDER; directly bail out in this case.
> >>    */
> > 
> > Hi, Leo,
> > 
> > Thank you for your quick feedback. The comment is simplified from Peter's reply in v2
> > version. Your refined comment is more detailed and it makes sense to me, I would like
> > to adopt it if @Peter has no other opinions.
> > 
> >> To be honest, I am not sure if perf core maintainers like this kind
> >> thing or not.  Please seek their opinion before you move forward.
> >>
> > 
> > and hi, all perf core maintainers,
> > 
> > I have not received explicit objection from perf core maintainers @Peter or @James so
> > I moved forward to address their comments. It's fine to me to wait for more opinions from
> > perf core maintainers.
> > 
> > Best Regards,
> > Shuai
> > 
> 
> Hi, Leo, and all folks,
> 
> Any more comments? Should I move forward to send a new patch?

I am afraid I cannot give a reliable suggestion.

Anyway, I personally think the returned error value in this patch is
better than the kernel oops since the kernel oops is a bit scary for
tool's users ;)   Another reason is the perf core layer should report
error earlier rather than relying on the page buddy allocation layer
to detect the memory allocation failure, which is easier for both
developers and users to understand the failure.

IMHO, a good practice is to respin a new patch set and send out for
review.  Good luck!

Thanks,
Leo
