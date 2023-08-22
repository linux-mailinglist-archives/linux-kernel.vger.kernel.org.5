Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70A47841C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbjHVNNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjHVNNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:13:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE1CCD4;
        Tue, 22 Aug 2023 06:13:36 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99357737980so588410866b.2;
        Tue, 22 Aug 2023 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692710015; x=1693314815;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W91Eo9iBN2pFWaKMu2gu126F7U31bTPuosbZBJlSlwo=;
        b=CTE9V0VBcqHx5DFHf3A0UaDX1nXzQXWERofkm2i+zVb4/t7txDCDTmoZTQ5NJuDXBK
         nVIQbPXg4IduILLIkzzqGZrFhNJHz+KJmfjQpIJTFKLYEjYW1CJvXAJDcplOvAmxSZjQ
         tzBplnPwkmlfWIH7IZLM1GmPX5KsumZExzJzC6IreExrhqLbvz20pOxYad1j9h1quH5S
         5YWQpK55elF/hR1QF8ndtvcfQw8znEMdc/ZEHYbDT1idfy0syzJ2qoljairrbCHlqik+
         jCH+6eNdw9i2nwGlmmlkvTBrl0JyPQh0+rfsi9PtaYLEna470AtUj1i5ot9edteg+YyG
         NsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692710015; x=1693314815;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W91Eo9iBN2pFWaKMu2gu126F7U31bTPuosbZBJlSlwo=;
        b=eZFELUkgq+2sdhWUOzMT6BUZ9I1siCsuEYN8gV7+NWOC22Yh3kwlcCceAt2w+/6k2l
         NcfyPt4pyjDsIW5NyjZ9l4V127kSPmIPDicB61UhrNNdw1u73Saso3sriTBTCXxFH/p9
         3YjhoZd9Cm23klJ14ArFttM2Uqv3vCBSW6MWQYjT6VSpDR9C7eP80eBSzeTMXk/H65At
         A9KUxzkuCcs/aYxvQHfH4HIHIyLqvX2Aa6+2tIscOWqxn3tD8QtsSpxq/w6/aprRQ43y
         1zgIZSRCqwUmq2ajl/S/KwZUidDLOz9aQ4w/Z6+xSTcjk7TTDcxC90duQmN6kwN7nADJ
         mwfg==
X-Gm-Message-State: AOJu0YyAR2BPxaVzgeBlprcWGXBsREpTBZaaSk0txbMw9s9Z/AFCFa3M
        k4cbmwiPz3BDnHCxpbDrkiY=
X-Google-Smtp-Source: AGHT+IEwTGxMHZTVDQockitW51L2tFBWDWmFxqwz0I8jsArfMemHj/kwl3eWf75+FoebV1p2hSzY7g==
X-Received: by 2002:a17:906:2011:b0:99b:f820:5d0e with SMTP id 17-20020a170906201100b0099bf8205d0emr7190363ejo.25.1692710014492;
        Tue, 22 Aug 2023 06:13:34 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id rp6-20020a170906d96600b0098e2eaec395sm8203801ejb.130.2023.08.22.06.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:13:33 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 22 Aug 2023 15:13:32 +0200
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-ID: <ZOS0fFjou2iRYDs+@krava>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
 <20230819101105.b0c104ae4494a7d1f2eea742@kernel.org>
 <ZOJ44P40bsSpUmYA@krava>
 <5703175.DvuYhMxLoT@pwmachine>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5703175.DvuYhMxLoT@pwmachine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 02:24:06PM +0200, Francis Laniel wrote:
> Hi.
> 
> Le dimanche 20 août 2023, 22:34:40 CEST Jiri Olsa a écrit :
> > On Sat, Aug 19, 2023 at 10:11:05AM +0900, Masami Hiramatsu wrote:
> > 
> > SNIP
> > 
> > > > > > > > +	func_addr = kallsyms_lookup_name(func);
> > > > > > > > +	for (i = 0; i < array.size; i++) {
> > > > > > > > +		struct trace_kprobe *tk_same_name;
> > > > > > > > +		unsigned long address;
> > > > > > > > +
> > > > > > > > +		address = array.addrs[i];
> > > > > > > > +		/* Skip the function address as we already 
> registered it. */
> > > > > > > > +		if (address == func_addr)
> > > > > > > > +			continue;
> > > > > > > > +
> > > > > > > > +		/*
> > > > > > > > +		 * alloc_trace_kprobe() first considers symbol name, 
> so we
> > > > > > > > set
> > > > > > > > +		 * this to NULL to allocate this kprobe on the given 
> address.
> > > > > > > > +		 */
> > > > > > > > +		tk_same_name = 
> alloc_trace_kprobe(KPROBE_EVENT_SYSTEM, event,
> > > > > > > > +						  (void *)address, NULL, 
> offs,
> > > > > > > > +						  0 /* maxactive */,
> > > > > > > > +						  0 /* nargs */, 
> is_return);
> > > > > > > > +
> > > > > > > > +		if (IS_ERR(tk_same_name)) {
> > > > > > > > +			ret = -ENOMEM;
> > > > > > > > +			goto error_free;
> > > > > > > > +		}
> > > > > > > > +
> > > > > > > > +		init_trace_event_call(tk_same_name);
> > > > > > > > +
> > > > > > > > +		if (traceprobe_set_print_fmt(&tk_same_name->tp, 
> ptype) < 0) {
> > > > > > > > +			ret = -ENOMEM;
> > 
> > also are we leaking tk_same_name in here?
> > 
> > > > > > > > +			goto error_free;
> > > > > > > > +		}
> > > > > > > > +
> > > > > > > > +		ret = append_trace_kprobe(tk_same_name, tk);
> > > > > > > > +		if (ret)
> > 
> > and here?
> 
> Good catch!
> Do you know if the appended probes are automatically freed? If so, can you 
> please indicate which function handles this?

hum, I don't see the release code going through the list of appended probes,
so I wonder you need to somehow do that in destroy_local_trace_kprobe

jirka
