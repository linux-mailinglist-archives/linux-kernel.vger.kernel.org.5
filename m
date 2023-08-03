Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD25F76DEEA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjHCDYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjHCDYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:24:09 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1541AC3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:24:08 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-563e860df0fso301180a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 20:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691033047; x=1691637847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O8Il73H/EAGTWQG8TXMHqYxWH5H3YnlW7g1lYr0WqbY=;
        b=QLdGSUE6XDDTN4Asngv3TsGs5kBEYxf87gcrw0XEqhD59Eu0I4YdEyPiyh8FTHH50/
         PidziU6/O0dd2EejB+YY79ODrtwSbijsdReh9vet/XNyYcK8V2j/WK0FwvQKbYQj05e4
         rmx2J0Qhg6WD41aqMX27jdqRYzJpyTiQ3jUsxyqjQpuVnY4YTdkidm80rGl4yaBIH5IQ
         aXu5rdaHvtuQi7S6xkkKurnMuqytejHAuwVPAbyC8TVJ3zrxhST0dGp0nPu0Tp3IMD0O
         35K2WLFy1AEGmF6yF5lSa3ViOLNt4w/K7OMHCKhwI0JLhYZMIbaB0yKceE0mPPpYQQQD
         u1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691033047; x=1691637847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8Il73H/EAGTWQG8TXMHqYxWH5H3YnlW7g1lYr0WqbY=;
        b=eTZSxLlQfFOvTwQpBw/EujT+RROAKRyxY5+8vAbC9swn1oVdkmyVRPSHWB5LGylyhp
         v3EmFxIqoenGA7LeNlcTvRl4vPtIxFI+f3EaBPkh1HOuO3KVtFC/DV/CZ4/UVkh5Bzoo
         f/+FzhSE7F+kD0jdmHhRvvvHOn1T9NM06V9sJlIx4RRqJ36A1liCy8DlzpMpQJhrdB5P
         cI4f6XcYlDb6sLg+JBcnsmFkHUKddsDO6bq5aHNqBNvK0v2GMXGwD8hDA4NErhJtlfU0
         nRSGC6XIbj+1ZxALjcJA3EjlMmcOEW58/VJZsEuEVHQj7MuB7VjH6LfPHs1IQeEDn1kO
         hAvw==
X-Gm-Message-State: ABy/qLaTI0tTSrzEcnBeVowhsVCJ1Z4fGrvm4DPKOOOZ1rNAn4zuXY74
        BNoc736NEx/hBTbyH8hF7NKwLA==
X-Google-Smtp-Source: APBJJlE9sAhV1fn+iSnn8+55Y+IAz3JuvH86wQ9aj00ZHban9LGMDYZw5LvDvncwvC9rc0bhlVO3xQ==
X-Received: by 2002:a17:902:b714:b0:1bb:2020:be0d with SMTP id d20-20020a170902b71400b001bb2020be0dmr16136522pls.14.1691033047504;
        Wed, 02 Aug 2023 20:24:07 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.39.102])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f7d200b001b243a20f26sm13078343plw.273.2023.08.02.20.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 20:24:07 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:23:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf doc: Document ring buffer mechanism
Message-ID: <20230803032357.GB1306442@leoy-huanghe.lan>
References: <20230715035343.46737-1-leo.yan@linaro.org>
 <CAP-5=fVmBVA5XGac8BZks6UnjGaMv8bx_PhC6_YrWC2TGjw-Fg@mail.gmail.com>
 <CAP-5=fXHPCWKGrewGbfWWBCTKeZ2tYntPBkjL6grL94VN7uVpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXHPCWKGrewGbfWWBCTKeZ2tYntPBkjL6grL94VN7uVpg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 01:46:07PM -0700, Ian Rogers wrote:

[...]

> Picking up from here.
> 
> > > +The mechanism of AUX ring buffer
> > > +--------------------------------
> > > +
> > > +In this chapter, we will explain the implementation of the AUX ring
> > > +buffer.  In the first part it will discuss the connection between the
> > > +AUX ring buffer and the generic ring buffer, then the second part will
> > > +examine how the AUX ring buffer co-works with the generic ring buffer,
> > > +as well as the additional features introduced by the AUX ring buffer for
> > > +the sampling mechanism.
> > > +
> > > +The relationship between AUX and generic ring buffers
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +Generally, the AUX ring buffer is an auxiliary for the generic ring
> > > +buffer.  The generic ring buffer is primarily used to store the event
> > > +samples, and every event fromat complies with the definition in the
> 
> nit: s/fromat/format/
> 
> > > +union perf_event; the AUX ring buffer is for recording the hardware
> > > +trace data, and the trace data format is hardware IP dependent.  The
> > > +advantage of the AUX ring buffer is that it can de-couple the data
> > > +transferring between the generic perf events and the hardware tracing.
> 
> I'm wondering if the wording of the last sentence can be made a little
> easier. Perhaps:
> The general use and advantage of the AUX ring buffer is that it
> written to directly by hardware rather than by the kernel. For
> example, regular profile samples that write to the generic ring buffer
> cause an interrupt. Tracing execution requires a high number of
> samples and using interrupts would be overwhelming for the generic
> ring buffer mechanism. Having an aux buffer allows for a region of
> memory more decoupled from the kernel and written to directly by
> hardware tracing.

Thanks for helping to rephrase.  It's clear and good for me, will add
it into the next spin.

> > > +The AUX ring buffer reuses the same algorithm with the generic ring
> > > +buffer for the buffer management.  The control structure
> > > +perf_event_mmap_page extends the new fields aux_head and aux_tail for
> > > +the head and tail pointers of the AUX ring buffer.
> > > +
> > > +During the AUX trace initialisation, record_opts::auxtrace_mmap_pages
> > > +is set for the AUX buffer size in page unit, otherwise, this option is
> > > +the default value '0' which means a perf session is not attached to any
> > > +AUX trace.
> 
> This jumps into a bunch of perf tool details that it would be nice to
> discuss in more abstract terms. I think an important thing to mention
> is that unlike the mmap of the regular perf ring buffer, the aux mmap
> needs a second syscall.

Agreed.  Combining with the followed sentence, I rephrased it as:

During the initialisation phase, besides the mmap()-ed regular ring     
buffer, the perf tool invokes a second syscall in the                   
auxtrace_mmap__mmap() function for the mmap of the AUX buffer;          
rb_alloc_aux() in the kernel allocates pages, these pages will be       
deferred to map into VMA when handling the page fault, which is the
same lazy mechanism with the regular ring buffer.

> > > +
> > > +When record_opts::auxtrace_mmap_pages is a non-zero value, the
> > > +auxtrace_mmap__mmap() function invokes rb_alloc_aux() in the kernel for
> > > +allocating kernel pages; these pages will be deferred to map into VMA
> > > +when handling the page fault, which is the same lazy mechanism with the
> > > +generic ring buffer.
> > > +
> > > +The AUX event and AUX trace data are two different things.  Likewise the
> > > +PMU events, the AUX event will be saved into the generic ring buffer
> > > +while the AUX trace data is stored in the AUX ring buffer.  As a result,
> > > +the generic ring buffer and the AUX ring buffer are allocated in pairs,
> > > +even if only one hardware trace event is enabled.
> 
> nit: s/The AUX event and/AUX events and/
> 
> Would the hardware trace event be the aux event? Perhaps an example
> would be useful here.

Good point.  I refined it as:

AUX events and AUX trace data are two different things.  Let's see an
example:

        perf record -a -e cycles -e cs_etm/@tmc_etr0/ -- sleep 2

The above command enables two events: one is the event 'cycles' from PMU
and another is the AUX event 'cs_etm' from Arm CoreSight, both events
are saved into the regular ring buffer while the CoreSight's trace data
is stored in the AUX ring buffer.  As a result, the regular ring buffer
and the AUX ring buffer are allocated in pairs.

> > > +
> > > +Now let's see the AUX ring buffer deployment in the perf modes.  For
> > > +per-thread mode, perf tool allocates only one generic ring buffer and one
> > > +AUX ring buffer for the whole session; for the system wide mode, perf
> > > +allocates the generic ring buffer and the AUX ring buffer per CPU wise.
> 
> Perhaps mention per-thread with a CPU, as perf won't use per-thread
> mode without a command line argument.

Yeah, to make it clear, refined as:

Now, let's see the AUX ring buffer deployment in the perf modes.  The   
perf in default mode allocates the regular ring buffer and the AUX ring 
buffer per CPU-wise, which is the same as the system wide mode, although
the default mode records samples only for the profiled program, and the 
latter mode profiles for all programs in the system.  For per-thread    
mode, the perf tool allocates only one regular ring buffer and one AUX  
ring buffer for the whole session.  For the per-CPU mode, the perf      
allocates two kinds of ring buffers for CPUs specified by the option    
'-C'.                                                                   

[...]

> > > +Once the hardware trace data is stored into AUX ring buffer, the
> > > +function perf_aux_output_end() finishes two things:
> > > +
> > > +- It fills an event PERF_RECORD_AUX into the generic ring buffer, this
> > > +event delivers the information of the start address and data size for a
> > > +chunk of hardware trace data has been stored into the AUX ring buffer;
> > > +
> > > +- Since the hardware trace driver has stored new trace data into the AUX
> > > +ring buffer, the argument 'size' indicates how many bytes have been
> > > +consumed by the hardware tracing, thus perf_aux_output_end() updates the
> > > +header pointer perf_buffer::aux_head to reflect the latest buffer usage.
> > > +
> 
> Perhaps add a description of lost events?

Good point.  I tweaked above sentences as:

"Once the hardware trace data is stored into the AUX ring buffer, the PMU
driver will stop hardware tracing by calling the pmu::stop() callback.  
Similar to the regular ring buffer, the AUX ring buffer needs to apply  
the memory synchronization mechanism as discussed in the section "Memory
synchronization".  Since the AUX ring buffer is managed by the PMU      
driver, the barrier (B), which is a writing barrier to ensure the trace 
data is externally visible prior to updating the head pointer, is asked 
to be implemented in the PMU driver.                                    
                                                                        
Then pmu::stop() can safely call the perf_aux_output_end() function to  
finish two things:                                                      

...

At the end, the PMU driver will restart hardware tracing.  During this
temporary suspending period, it will lose hardware trace data, which
will introduce a discontinuity during decoding phase."

[...]

> Thanks again for all of this, sorry for the delay in the 2nd part of my review.

Very appreciate your detailed review and many suggestions which helped
to improve this doc a lot!

Leo
