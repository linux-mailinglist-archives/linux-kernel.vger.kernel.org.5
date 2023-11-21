Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A174D7F601F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345451AbjKWNVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbjKWNVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:21:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D551B3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:21:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32f737deedfso472723f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700745666; x=1701350466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=88DjvNfImhJw5JraXMVRRgOPHpe0FZ5MsRFCtVbbVY0=;
        b=iJHeAaCs5M7l+rlPH4EwgjuNlNAtd5dAlUbPFyXl85Yq0OvREOGW5Pneha9S8GMj5Y
         Q9jSxsyGPG1+Y5pZVdZww8IPBpFVH/vYYUuUUR8l9RPnzGh7mbZzBvjRDGLXP7RVsyHN
         R+ACsbPYRl1bETkOTPduar6/VGFoEWas8Gfn9Q+/6nh4XXxzRphw9yaAxk/DMVlaFbTr
         eos8GQCqVIFS65Xkpyc1ZyJUCLnhH8TJffkK4cRQRLat1ptV9eJVk3Slw24oBfiESJQI
         GLRg9Da5YpeBZkahrweZO6T7dk82AC+VWw2xV7jUdt5cFz1XkA2cfGenIUaO3fT/1Bds
         z+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700745666; x=1701350466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88DjvNfImhJw5JraXMVRRgOPHpe0FZ5MsRFCtVbbVY0=;
        b=ZkyMLe0835jHLpcCUHvPA45lfvqkirwFKXaHSwSLjuYOAhYK4pwYxtnDLIOTsVNcAs
         JJPuZPZMeVS9SDbSrauAG7nvgV6cWrZZ+rV/nzU9sfLGq0WSxvMO53wxNZZHmWyZN7fT
         rLQNlpQ2ZDI4XiLwgFhQXePF5QM4vIVjhqMu23nN5mkGjvbComWv9cdw0CoHOSlQvFwg
         7PngSIzr67gMg3YyHK5sDP1xD8FkYY3IEt+m2tAbLYygnKcSrWE6baJpAYLVQLgoD01/
         he2qd1ow48hlWtMFOjfc2JSSL3akv6t3B7EGUFGVN6io0ElHl/r5/iLQlHLDYq2zKrKQ
         zWqw==
X-Gm-Message-State: AOJu0YwKHvUKrM7vZaGGr/elroTPU4ydFokCF50hN7zsXK3V+cBG+6FP
        wfwQdp11bkI0SD7aioTuz2AYGA==
X-Google-Smtp-Source: AGHT+IF/A0yDHSLXIFsi63rXHJueMibOJy/J7w/B4pWgbOeyVSwMW3JdNeqCD8iE7ijFRWaG8nl7DQ==
X-Received: by 2002:a5d:698f:0:b0:332:cae1:c610 with SMTP id g15-20020a5d698f000000b00332cae1c610mr2656229wru.23.1700745666249;
        Thu, 23 Nov 2023 05:21:06 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d640c000000b00332cc7c3aaasm1672062wru.21.2023.11.23.05.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:21:05 -0800 (PST)
Date:   Tue, 21 Nov 2023 22:15:56 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Provide a boot time parameter to enable lazy RCU
Message-ID: <20231121221556.vtpmboamgszbt3jf@airbuntu>
References: <20231121205304.315146-1-qyousef@layalina.io>
 <811b2157-1009-4339-8ff2-0433512f3094@paulmck-laptop>
 <20231121214415.ovoskvbjarzpxi6e@airbuntu>
 <8ad4e628-7a88-490c-a54d-df09f851f189@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ad4e628-7a88-490c-a54d-df09f851f189@paulmck-laptop>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 15:26, Paul E. McKenney wrote:

> > Either way; I'll follow what the crowd wants too :-)
> 
> Usually a wise choice.  ;-)
> 
> But I must defer to the people using it.

From Android PoV I'd like to be able to boot with default disabled and allow
people to opt-in. At least for the time being until we have confidence no one
is caught with surprise if this caused unexpected problems.

In the future it might default to on once it gets wider usage and testing.

So having a new Kconfig to DEFAULT_OFF sounds good to me to enable a compile
time switch to pick the default with a boot time to further control.

Which would be my plan for v2 unless I hear another suggestion in the coming
week (where I hope people would have had a chance to look and think about it).

> > No need for the rcu_barrier() then? Only reason why we use the _cb flavour
> 
> The module_param() parameters are processed during early boot, before
> the boot CPU has enabled interrupts.  In fact, before rcu_init()
> is invoked, which is in turn long before the scheduler has started.
> Calling rcu_barrier() that early is not so good for your kernel's
> actuarial statistics.

Ah, I missed that it is done that early.

> 
> I am guessing that the module_param_cb() processing happens somewhat
> later in the kernel's lifetime.


Thanks!

--
Qais Yousef
