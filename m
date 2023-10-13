Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C87C8B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjJMQZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjJMQZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:25:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ED24EF1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:13:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a81cd8d267so13106667b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697213605; x=1697818405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Xx0BMu30zSxzvDEomgzg9E7JT9rYro1tljom2/GGKE=;
        b=rWmCD4NQ8jNkQakOaTPmXWmr1an3sT6PvgjoRNlGOKSlDaFVpE3WtlV92kXTlLY5Ep
         gy4+BOqGjCu1k7TzuX5Y316BzsVOpBmAGQKLEqm56BWsH4juZkohVp6ZQ8qeUonRyfgG
         +RffzadLU+0kKF+52HDrSaeTs3Gf7qBsiO8nuLUcVCDs/89md313fiGqMTdDrdzrPmug
         cbzLPfcqweGMtpVo4F8vXxawYxSGRzxvs6vlzGZUo7FpPYvwfqLKNtFwhKbPD1acibQK
         VE8N43M0kQ6CF2NYLQg4EkyJSPQhQkXqhjynQ+i6qKK0BdVEszz44GWafU0IBNKgiu9a
         yatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697213605; x=1697818405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Xx0BMu30zSxzvDEomgzg9E7JT9rYro1tljom2/GGKE=;
        b=PU6M3BGJjSj+vBcDcYcbh74kueG1KgI+2MwJMZDaaiyHhc+E48wDUUnXgkK9gSAtEg
         5uSeKL3l1r0aFuCoO4yB/VkmvaHogzknNlWOSgllHWkm0cOOk5NMF6HpIKIdv/RcjFSz
         odi1WgXeFph4IIThcUit8kwOh5PhgQoxWhVrbnDZsLkh+M2nlbvfTQJQ0RVXDQInEiQS
         bH50KMGwtk+Qg6Qmj7qI6kcFo5H+1OSpDm/oAiccxCfXRAFoxLjgp8+JLthBwug1nZvq
         c/azDEyRA1N3sgeQSiwRfHH6oz1noBPTRlEJFjt4cRFGp+Y3JZjI78K8JdZWbMZzx7dy
         ioGg==
X-Gm-Message-State: AOJu0Yw4b3UxfVm33WHetzuaOUe8nFJ0Q2YlzBnCnZlNxt1s9AK+QUG8
        RujfzvlifkQDjztf4icQfPMMAUo3Mnw=
X-Google-Smtp-Source: AGHT+IE10ZBYKMQNsvc4otdqbSm0jYPRU/RLCtR3agfzWnBXi4zl5QG1flqcubxcBd+LqSyFJIHYTvcnNks=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:5c9:0:b0:d8b:737f:8240 with SMTP id
 w9-20020a5b05c9000000b00d8b737f8240mr566788ybp.0.1697213605131; Fri, 13 Oct
 2023 09:13:25 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:13:23 -0700
In-Reply-To: <ZSfJ6c5fo5enjvv+@fedora.fritz.box>
Mime-Version: 1.0
References: <ZSGpl_hT23B6ix0M@mainframe> <20231007203411.GA8085@noisy.programming.kicks-ass.net>
 <ZSQqfr96SfZM_OEk@google.com> <ZSfJ6c5fo5enjvv+@fedora.fritz.box>
Message-ID: <ZSlsowuVqQA3ecUb@google.com>
Subject: Re: [PATCH] perf/x86/p4: Fix "Wunused-but-set-variable" warning
From:   Sean Christopherson <seanjc@google.com>
To:     Lucy Mielke <lucymielke@icloud.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023, Lucy Mielke wrote:
> Am Mon, Oct 09, 2023 at 09:29:50AM -0700 schrieb Sean Christopherson:
> > 
> > rdmsr() writes to "high", but nothing ever reads from high.  FWIW, I would _love_
> > for rdmsrl() to have return semantics, e.g. to be able to do:
> > 
> > 	low  = (u32)rdmsrl(MSR_IA32_MISC_ENABLE);
> > 
> > or even
> > 
> > 	if (!(rdmsrl(MSR_IA32_MISC_ENABLE) & BIT(7)))
> 
> I have taken a look and it seems to me like this macro is called quite a lot
> for different things thoughout the kernel tree, including drivers. If
> one were to change it to have return semantics instead of the way it
> currently works, you'd have to change around 300 occurences, right?

Yep, which is the only reason I haven't force the issue.
