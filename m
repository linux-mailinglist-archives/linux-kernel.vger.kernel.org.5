Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E44B7CC1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjJQLkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJQLkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:40:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE2D9F;
        Tue, 17 Oct 2023 04:40:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e16f076b3so10405610a12.0;
        Tue, 17 Oct 2023 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697542811; x=1698147611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5iJwacoFWI2BNuJzwK5V8n8H3vFnlfIq5LRrlJHnDE=;
        b=NvBea/g20Bo0kMMq5/HM8MhYlGFWdqPG+kiCmPSdj50Hsgr1Ab4Co6XovD5zXsx599
         1FH8Rb5ROJumDPg6Z4Ts/NEGIhD7WpbRdCthw5MWBaeq7dJQOa0e3LRan7BjkbEp7Wk3
         tVNIVhpAh5HnikB9lIqDUfUzpuzbmz1hUAsj8lpscbg2kCAVskOGwGrnD0WXXtg4SD0N
         snGc/1F4FIuQNPaQTw/vqV+7Zz1vXGA9Eew548/7PNLSfWET2ezkQULGNVCbtXL+gfM/
         IZCiFjIkMJffHD1u/NJoc/Hab/lRqPtihqpD1SkABRIy+Ask8OSF1evunEke1rQUMZf3
         euBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697542811; x=1698147611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5iJwacoFWI2BNuJzwK5V8n8H3vFnlfIq5LRrlJHnDE=;
        b=X0c0AJTxGRlDdapD//x9FzYCiDN1eVWiTSItFqRAk1SweXZpjUlKdjaByLCFVobXGe
         OkjyvrEAxd9A+OgRbnO0/KX1h4DWi+7WNdb0urGM3tNp96JL6b8ytLbKkeVncK5hIc1X
         Zf4cVlIV4HHtzYImgwrG6aqbOIEnqKfnxv80BqomLmFOMcx4WR3Hq0Y5ciFPFjlq4942
         vL7FuyHwQtdd91noOppMoDkrat6A2UY5p8uz1Qk1jx4l6WKu8gb0sUgoRqT108uSufTV
         7KzxGJchASY5XVFuGG0wy5825YI80S8fjXBvM1Dhx4EA5o4jMsAAJUw4X0hyI2iDx4sD
         NGdA==
X-Gm-Message-State: AOJu0Yys7XGLFXBvfzXHs4CohjbB2EkM5Ts3dGSv3er3xyX8T/7Kadkl
        475N7+qNy7NstFhTrGrnU1keUcgoyt0=
X-Google-Smtp-Source: AGHT+IFeZAoGXNHXk+lHtbhO6GkkOtdA81psOy5RykrLlw87C/1PYlKtzm9OwKqmUA73sc6VKuAV5Q==
X-Received: by 2002:aa7:da18:0:b0:51d:b184:efd with SMTP id r24-20020aa7da18000000b0051db1840efdmr1513196eds.20.1697542810611;
        Tue, 17 Oct 2023 04:40:10 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id v23-20020a50d597000000b0053e2a64b5f8sm1060624edi.14.2023.10.17.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:40:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 17 Oct 2023 13:40:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZS5yl3RzVGKBkCvY@gmail.com>
References: <20231016044225.1125674-1-namhyung@kernel.org>
 <ZS0D53ckVx356k4o@gmail.com>
 <ZS1Y5PhXhp384ynY@kernel.org>
 <ZS1ajf/9HmgUyyCl@kernel.org>
 <ZS1cGMgyEDJQbwq9@kernel.org>
 <ZS1c9RCh9MkzPbFG@kernel.org>
 <ZS2ecyCVpK8B2cQq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS2ecyCVpK8B2cQq@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Oct 16, 2023 at 12:55:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Oct 16, 2023 at 12:51:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Now back at testing with with cgroups.
> 
> > Humm, even without the -G I get:
> 
> > [root@five ~]# perf stat -e context-switches,cgroup-switches perf bench sched pipe  -l 10000
> > # Running 'sched/pipe' benchmark:
> > # Executed 10000 pipe operations between two processes
>  
> >      Total time: 0.082 [sec]
>  
> >        8.246400 usecs/op
> >          121265 ops/sec
>  
> >  Performance counter stats for 'perf bench sched pipe -l 10000':
>  
> >             20,002      context-switches
> >             20,002      cgroup-switches
> 
> Same number, but then I forgot to add the 'taskset -c 0' part of the
> command line, if I have it:

Side note: it might make sense to add a sane cpumask/affinity setting 
option to perf stat itself:

  perf stat --cpumask 

... or so?

We do have -C:

    -C, --cpu <cpu>       list of cpus to monitor in system-wide

... but that's limited to --all-cpus, right?

Perhaps we could extend --cpu to non-system-wide runs too?

Thanks,

	Ingo
