Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06DC78FAAB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjIAJVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjIAJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8421704
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693560035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xAVi6FEyTQ7ZaKQpe4EYEPBaWu2yKhcef4tnVYwbnNY=;
        b=T5tsyDUcJJlRER/mlHz3QPbjXyS8X3Hzibtyg/FVaM4CH9rHyHmHgj2lHjn1JFrjMSs1AM
        fka6ockxN7Set7ug+K7FH099ASGmxGRHWSwy+ge9d5lqf0NQrEG7avRdniG/QITuX4Gyk+
        ZCSzmAMdvhtZ+u+CK7ydH6BME5zujZ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-vy1m6-6FNwyhmNL9Rjc7sQ-1; Fri, 01 Sep 2023 05:20:34 -0400
X-MC-Unique: vy1m6-6FNwyhmNL9Rjc7sQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4020645b2a2so11769855e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 02:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693560033; x=1694164833;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAVi6FEyTQ7ZaKQpe4EYEPBaWu2yKhcef4tnVYwbnNY=;
        b=ikSfv341KWBKANinptc9Pc7o8jHboU+thP3hEybLfTpfD8DB3Hxu2zf6cdH+gBKK2k
         oLDdHHR5T2fnUamFEIUM5FdDICs1fI/sef/T70vuINepLoa6CSKLSQEhXNOqvhYkuGzd
         vOqajouyHDDEZgGpeoda/p93i70zb0foxUfc6ijS7J5kEgbx5nMeIAinlEGrZbUUf1pn
         Rn210CL223j25wwlC/3RzFEHGGJQ9KZOK5PxxWOofq1n3iOZhy+xYgUKaDCvPkV+pKd3
         uayAzXg8MEuwtwx+ko0sWILLS9utz13R50ZDlfU7fOMFG2m8tysxvdBpH5w61Ce0uGpC
         SXfQ==
X-Gm-Message-State: AOJu0Yz4rzoJZzsJ4CxMpCjBGWV/+q3p4OnE2fqmVR4GYiL8jrsqh73E
        +hNan06T/Q7dyOAM+aP5bJRP/oFV40s82S2otQjJIPMpbXP1iwS7DRC4kTWAZZrevhyQO2JiLTw
        qA7sDx8TlZc0LKbReFYFL68op
X-Received: by 2002:a05:600c:22d7:b0:400:cc2d:5e00 with SMTP id 23-20020a05600c22d700b00400cc2d5e00mr1340035wmg.7.1693560032799;
        Fri, 01 Sep 2023 02:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdRbyjcV3yuvEE9fTarWwnwblnlMFp8tGApCFqFkxVcuX9ORq1ae/bQ34AyjAcivVN3u/tEw==
X-Received: by 2002:a05:600c:22d7:b0:400:cc2d:5e00 with SMTP id 23-20020a05600c22d700b00400cc2d5e00mr1340023wmg.7.1693560032486;
        Fri, 01 Sep 2023 02:20:32 -0700 (PDT)
Received: from vschneid.remote.csb (anice-256-1-26-111.w86-203.abo.wanadoo.fr. [86.203.135.111])
        by smtp.gmail.com with ESMTPSA id p5-20020a7bcc85000000b003fe1a96845bsm7470565wma.2.2023.09.01.02.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:20:32 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Eric Vaughn <ervaughn@linux.microsoft.com>,
        Sishuai Gong <sishuai.system@gmail.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        Zhang Zekun <zhangzekun11@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: Re: [GIT PULL] tracing: Updates for 6.6
In-Reply-To: <20230831115635.1bdea0d7@rorschach.local.home>
References: <20230831115635.1bdea0d7@rorschach.local.home>
Date:   Fri, 01 Sep 2023 11:20:31 +0200
Message-ID: <xhsmhr0nib674.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/08/23 11:56, Steven Rostedt wrote:
> Linus,
>
> [ Note, there's a minor conflict which should be fixed by:
>         mutex_lock(&trace_types_lock);
> -       if (unlikely(tr->current_trace && iter->trace->name != tr->current_trace->name)) {
> +       if (unlikely(tr->current_trace != iter->trace))
>  +              /* Close iter->trace before switching to the new current tracer */
>  +              if (iter->trace->close)
>  +                      iter->trace->close(iter);
> -               *iter->trace = *tr->current_trace;
> +               iter->trace = tr->current_trace;
>  +              /* Reopen the new current tracer */
>  +              if (iter->trace->open)
>  +                      iter->trace->open(iter);
>  +      }
>         mutex_unlock(&trace_types_lock);
> ]
>
> Tracing updates for 6.6:
>
>  User visible changes:
>
>   - Added a way to easier filter with cpumasks:
>      # echo 'cpumask & CPUS{17-42}' > /sys/kernel/tracing/events/ipi_send_cpumask/filter
>

It looks like the patches included are from v2 of [1], which still had some
(small) issues to fix. I have addressed these in [2], but I haven't sent
this out yet as I'm still working on the context_tracking/vmalloc part of
the series.

I'm happy to send just the tracing bits, if that helps - or just send the
deltas as separate fixes, whatever makes it easier.

Apologies for not bringing this up when the patches were picked up in [3],
I've only just come back from PTO/moving abroad and have started catching
up.

[1]: https://lore.kernel.org/all/20230720163056.2564824-1-vschneid@redhat.com/
[2]: https://gitlab.com/vschneid/linux/-/commits/redhat/isolirq/defer/v3-wip
[3]: https://lore.kernel.org/all/20230824021812.938245293@goodmis.org/

For reference, the git range-diff between the patches in
tracing/trace/for-next and those in my v3 is appended below (pure changelog
diffs removed)

---
 2:  39f7c41c908bc !  2:  e58d79bd79da2 tracing/filters: Enable filtering a cpumask field by another cpumask
      ## include/linux/trace_events.h ##
     @@ include/linux/trace_events.h: enum {
    @@ kernel/trace/trace_events_filter.c: static void filter_free_subsystem_filters(st
     +			return FILTER_DYN_STRING;
     +		if (strstr(type, "cpumask_t"))
     +			return FILTER_CPUMASK;
    -+		}
    ++	}

        if (strstr(type, "__rel_loc") && strstr(type, "char"))
                return FILTER_RDYN_STRING;
    @@ kernel/trace/trace_events_filter.c: static int parse_pred(const char *str, void
     +		maskstart = i;
     +
     +		/* Walk the cpulist until closing } */
    -+		for (; str[i] && str[i] != '}'; i++);
    ++		for (; str[i] && str[i] != '}'; i++)
    ++			;
    ++
     +		if (str[i] != '}') {
     +			parse_error(pe, FILT_ERR_MISSING_BRACE_CLOSE, pos + i);
     +			goto err_free;
    @@ kernel/trace/trace_events_filter.c: static int parse_pred(const char *str, void
     +
     +		/* Copy the cpulist between { and } */
     +		tmp = kmalloc((i - maskstart) + 1, GFP_KERNEL);
    -+		strscpy(tmp, str + maskstart, (i - maskstart) + 1);
    ++		if (!tmp)
    ++			goto err_mem;
     +
    ++		strscpy(tmp, str + maskstart, (i - maskstart) + 1);
     +		pred->mask = kzalloc(cpumask_size(), GFP_KERNEL);
    -+		if (!pred->mask)
    ++		if (!pred->mask) {
    ++			kfree(tmp);
     +			goto err_mem;
    ++		}
     +
     +		/* Now parse it */
     +		if (cpulist_parse(tmp, pred->mask)) {
    ++			kfree(tmp);
     +			parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
     +			goto err_free;
     +		}
    ++		kfree(tmp);
     +
     +		/* Move along */
     +		i++;
 5:  fe4fa4ec9b464 !  5:  03eefdab555b2 tracing/filters: Optimise cpumask vs cpumask filtering when user mask is a single CPU
      ## kernel/trace/trace_events_filter.c ##
     @@ kernel/trace/trace_events_filter.c: enum filter_pred_fn {
    @@ kernel/trace/trace_events_filter.c: static int parse_pred(const char *str, void
     +		if (single && field->filter_type == FILTER_CPUMASK) {
     +			pred->val = cpumask_first(pred->mask);
     +			kfree(pred->mask);
    ++			pred->mask = NULL;
     +		}
     +
                if (field->filter_type == FILTER_CPUMASK) {
 6:  ca77dd8ce4658 !  6:  f75aee048ce5a tracing/filters: Optimise scalar vs cpumask filtering when the user mask is a single CPU
    @@ Commit message
      ## kernel/trace/trace_events_filter.c ##
     @@ kernel/trace/trace_events_filter.c: static int parse_pred(const char *str, void *data,
    @@ kernel/trace/trace_events_filter.c: static int parse_pred(const char *str, void
     +		if (single && field->filter_type != FILTER_CPU) {
                        pred->val = cpumask_first(pred->mask);
                        kfree(pred->mask);
    -		}
    +			pred->mask = NULL;
     @@ kernel/trace/trace_events_filter.c: static int parse_pred(const char *str, void *data,
                                FILTER_PRED_FN_CPUMASK;
                } else if (field->filter_type == FILTER_CPU) {
                        pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
     +		} else if (single) {
    -+			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
    ++			if (pred->op == OP_BAND)
    ++				pred->op = OP_EQ;
    ++
     +			pred->fn_num = select_comparison_fn(pred->op, field->size, false);
     +			if (pred->op == OP_NE)
     +				pred->not = 1;
 7:  1cffbe6c62f10 !  7:  6a78ed47b0b06 tracing/filters: Optimise CPU vs cpumask filtering when the user mask is a single CPU
      ## kernel/trace/trace_events_filter.c ##
     @@ kernel/trace/trace_events_filter.c: static int parse_pred(const char *str, void *data,
    @@ kernel/trace/trace_events_filter.c: static int parse_pred(const char *str, void
     +		if (single) {
                        pred->val = cpumask_first(pred->mask);
                        kfree(pred->mask);
    -		}
    +			pred->mask = NULL;
     @@ kernel/trace/trace_events_filter.c: static int parse_pred(const char *str, void *data,
                                FILTER_PRED_FN_CPUMASK_CPU :
                                FILTER_PRED_FN_CPUMASK;
                } else if (field->filter_type == FILTER_CPU) {
     -			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
     +			if (single) {
    -+				pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
    ++				if (pred->op == OP_BAND)
    ++					pred->op = OP_EQ;
    ++
     +				pred->fn_num = FILTER_PRED_FN_CPU;
     +			} else {
     +				pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
     +			}
                } else if (single) {
    -			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
    -			pred->fn_num = select_comparison_fn(pred->op, field->size, false);
    +			if (pred->op == OP_BAND)
    +				pred->op = OP_EQ;

