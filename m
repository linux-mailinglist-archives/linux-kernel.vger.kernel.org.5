Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE948789906
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjHZU1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjHZU1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 16:27:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D6DE4B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:27:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401bdff4cb4so9753955e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693081633; x=1693686433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72TWidDa5V3wcjBf5rFQ2XFVxxhYZZuMbJHwfYjO6bA=;
        b=2TDhdcV9VXxzp4NxT5PJej22jakoZiFRsA1FJog+Hr2dQllce8U7PCMK7tsNwQPixP
         D8pV6SF1bNMMpPsMdACPcRphO9QAo5lBnZBe2fk49BfAjAFbn3xzaCQNPUhg9jcL+A8U
         ZNSAaovaj1SBT2CZnmE2yzQgh1AP4Ru4lcYwFv6fzkd9ltPuLxFzQxyMWts0nC3GNEaK
         90t1hdjFwzqPZgjI0mL5fWxiP1ybzZ/aR5BVCM2AAdxOf2Y+y4Adc1Z2M1ECDfCI7FVw
         61yqjiRFTIDL+XS/1rK+nzSgP9GMgACUVL5w9I3UVklHYA60mdilKGVb8ehv2ab5SOBt
         NTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693081633; x=1693686433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72TWidDa5V3wcjBf5rFQ2XFVxxhYZZuMbJHwfYjO6bA=;
        b=LnhrZBy5DetQruH3oh64DnEmS+MJS4NRJYx/+1gNNMOOWBmaRZGCxc9U1XXEvC/nXQ
         QU58nd5jpRZrQS03DkE7ZLwqO9hDewvvi/yXCAVShNuALJv5/0fwwAdHH7qSwxetqJhR
         73BbqIpvXoNWcACveprMmbX8NxrrFWLwbt6fARKBzO6fGerLgRhX/uS2H2q63rf03mnT
         bWTyZRi2NyuTntG+GR/6/OaVUXv39hd+PPygR3s7le+jT5yOXJy+nAXJSI4j5pcrJqri
         NDE/zLkbM7+Cd9qn2IEDrp7QY1UWXaG2iMAReNksuC1V3yiyj3D5KHvI385pgOudlD2F
         IdqA==
X-Gm-Message-State: AOJu0YxTQvZg7EMRMLJ0h7hQ+pxdaphWYmKpRGKM6A67TlNg7GA92f4c
        drZPYULEMrOBA6Usc1Y5S1jiZg==
X-Google-Smtp-Source: AGHT+IEBWYTe9P61o6OWH0KI80+a0++6wrib1qOUIkg87AJysBhqFjAvztbJd83CdAy3PQC+bJh/6g==
X-Received: by 2002:a05:600c:2349:b0:3fb:ac9c:e6f with SMTP id 9-20020a05600c234900b003fbac9c0e6fmr17660116wmq.38.1693081632924;
        Sat, 26 Aug 2023 13:27:12 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id x23-20020a1c7c17000000b003fbb1a9586esm9052160wmc.15.2023.08.26.13.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 13:27:12 -0700 (PDT)
Date:   Sat, 26 Aug 2023 21:27:11 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH RFC 4/4] sched: cpufreq: Apply DVFS headroom to CFS only
Message-ID: <20230826202711.n73r5wcpibdoiiba@airbuntu>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-5-qyousef@layalina.io>
 <7fdfff24-80ed-acbf-810f-b641570141fd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7fdfff24-80ed-acbf-810f-b641570141fd@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/23 18:41, Dietmar Eggemann wrote:
> On 20/08/2023 23:06, Qais Yousef wrote:
> > RT and Deadline have exact performance requirement when running. RT runs
> > at max or a specific OPP defined by uclamp_min. Deadline's OPP is
> > defined by its bandwidth. Both of which are known ahead of time and
> > don't require a headroom to grow into.
> > 
> > IRQs on the other hand have no specific performance requirement and
> > cruises along at whatever the current OPP happens to be when they occur.
> > 
> > Now they all have PELT pressure signals that does impact frequency
> > selection and task placement. The question is do they need DVFS
> > headroom?
> > 
> > I think the answer is no because when CFS is not running at all, these
> > pressure signal has no real impact on performance for RT, DL or IRQ.
> > 
> > If CFS util is not zero, we already add their pressure as an
> > *additional* headroom to account for the lost/stolen time. So I argue
> > that the pressure are headroom themselves and shouldn't need an
> > additional DVFS headroom applied on top.
> > 
> > In summary final outcome should be:
> > 
> > 	CFS + DVFS headroom + (RT, DT, IRQ) pressure headroom
> 
> I assume here you want to align the difference that EAS deals with

This function is used on all systems that use schedutil - EAS being one of them
but not the only one. The definition isn't, and shouldn't, be tied to EAS.
I'm certainly intending this change for all possible users of schedutil.

> `util_cfs` vs `capacity` whereas power deals with `util` vs
> `capacity_orig`? You want that power should only apply the 1.25 to util_cfs?

I don't get what you're saying. But I think it's similar to what I'm saying.

To clarify. What I'm saying is that when we try to calculate the effective
util, CFS is the only entity in practice that interacts with DVFS. DL and RT by
design 'disable' DVFS and when they become runnable set the frequency to
a constant fixed point.  For them DVFS latencies are not acceptable - although
in practice they do take a single hit for the freq change on wake up. IRQ on
the other hand doesn't really care about DVFS. So we end up in practice that
CFS is the only entity that interacts with DVFS, so when we calculate the
DVFS headroom, we should only take its util into account.


Thanks!

--
Qais Yousef
