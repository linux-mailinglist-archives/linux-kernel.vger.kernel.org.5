Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D297B236B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjI1RK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjI1RKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:10:10 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B2ECD0;
        Thu, 28 Sep 2023 10:10:08 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6c63117a659so372135a34.0;
        Thu, 28 Sep 2023 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695921007; x=1696525807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRE3ONenBcWJeFQYyX4IKWQ+NRnbxcCB20M0YVKhOZ0=;
        b=DWR77XWe55ygTxuB+y2b/UBYuD9YWBTgUr6DJ08OAFA1gGn7gNWI3oDvxn2den/UiH
         gaR2BoSORvdWLMrYJhrMVGOk+vmJ1kk/MedpY031YnFLr0vDPZE5nD5yBae0KPupkK/2
         Uj7eTlZsTVREVzhetJKqACh3RLCsngLxukTzgkJydLnl5F1AbnzGu/z2w8QJI6lH7xBH
         6Zt3rGddbTr6xP3EoS00LR8I5fsMd4+baFTcBPRV4/bdQprPdV8cv+Kkg6kFl97HU5UX
         aQyn3f9C9794Zn5O0KxG5RJGmldTmVGyAprig9Da0KzKXyvDzZWxFHwQfuR+IyLjmmcb
         isaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695921007; x=1696525807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRE3ONenBcWJeFQYyX4IKWQ+NRnbxcCB20M0YVKhOZ0=;
        b=FDQL8n7gnmVKjR6SD2EF18Es81sZjp3a5zUUxIARNP3BEXE4k72mogWgFQuc4nOko5
         RvxAOjyhEpmIALKgEsv7H5B/M2Zxq8zxMgKP7yQQQp9N/blopOykjhqQD/u3tSi8qrqq
         zlF6ATR3wx5lXArXRMNJT/fitln1FSD2SVsZwQEsyd4KbnW6Xev3QTvgoJPte1G3Sbka
         SVQsrNuI0pTlBwrs/0kvey48T8RNQQujFkBKpgSk92txEmxH37HGlkFZIYaQdbqUqeC3
         ZubNYIOZ2r06YN7DmWU6rXYQ01Ar7wCIdi3PsgC/FFQJCnoIvbHT1t6g5a8TpGcRKtxF
         1kLQ==
X-Gm-Message-State: AOJu0YzDp/QuOyMWYhB3vEFd6t2wYoIcona7vzuwIMteoOwpiGwoYdmC
        ZFaa1LpMYA0dtt9Y3tG2JuS8XNPdgtA=
X-Google-Smtp-Source: AGHT+IGpoNwRCja3vQJyPkeAWQOjNJF4gjQdXPln1c4Aa51njZlyMbZsJHSZzfWXyaOFsFT1fg0PxQ==
X-Received: by 2002:a9d:61da:0:b0:6b9:8feb:8337 with SMTP id h26-20020a9d61da000000b006b98feb8337mr1826391otk.9.1695921007317;
        Thu, 28 Sep 2023 10:10:07 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w6-20020a056830060600b006b9848f8aa7sm2848085oti.45.2023.09.28.10.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 10:10:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id CF13B27C0064;
        Thu, 28 Sep 2023 13:10:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Sep 2023 13:10:04 -0400
X-ME-Sender: <xms:bLMVZXAsIOspV9QnAM-PHMatOsy3DLmNZYdfO9uAZ8f5ShvHBGK0dg>
    <xme:bLMVZdin1WPPIiOVfCIdCzZG95Vs9PHbqtOm29E7eaqNJm5t8qbQpBcCHRH0l2iwv
    uaU4WADArsNo-yxOA>
X-ME-Received: <xmr:bLMVZSnfRHn1sKDqntY5Kgf4dHw0SgrvUl_WXNuvzrWXXp2F7MDzBiFX_1o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddtgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:bLMVZZxGgQ-hWWjkqs5FK41UyvHjbH_WlpojV6pSfk_hNQG7t7xx7w>
    <xmx:bLMVZcT8jluuzfhMUHuGIBtK7RwYXZDqiCCVHsjJ9153e2hjaDpvAw>
    <xmx:bLMVZcZTkPBEyK8HMfRx03Q68joZHLwye18A4Y02Zd3LOvpl12p09g>
    <xmx:bLMVZeFuUMJEoW1jRvWRU_BsjQl8X-6sF6X2OjXv6nf5Z-FlRYTZkQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Sep 2023 13:10:02 -0400 (EDT)
Date:   Thu, 28 Sep 2023 10:09:23 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Ogness <john.ogness@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [RFC PATCH] srcu: Use try-lock lockdep annotation for NMI-safe
 access.
Message-ID: <ZRWzQ5Fiav8aCYhj@boqun-archlinux>
References: <20230927160231.XRCDDSK4@linutronix.de>
 <ZRUX0YUrXfepRGKE@Boquns-Mac-mini.home>
 <20230928080900.GF9829@noisy.programming.kicks-ass.net>
 <ZRWTktRdej5OW53q@Boquns-Mac-mini.home>
 <20230928152942.GE27245@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928152942.GE27245@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 05:29:42PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 28, 2023 at 07:54:10AM -0700, Boqun Feng wrote:
> > On Thu, Sep 28, 2023 at 10:09:00AM +0200, Peter Zijlstra wrote:
> > > On Wed, Sep 27, 2023 at 11:06:09PM -0700, Boqun Feng wrote:
> > > 
> > > > I think this is a "side-effect" of commit f0f44752f5f6 ("rcu: Annotate
> > > > SRCU's update-side lockdep dependencies"). In verify_lock_unused(), i.e.
> > > > the checking for NMI lock usages, the logic is that
> > > 
> > > I think I'm having a problem with this commit -- that is, by adding
> > > lockdep you're adding tracepoint, which rely on RCU being active.
> > > 
> > > The result is that SRCU is now no longer usable from !RCU regions.
> > > 
> > 
> > Interesting
> > 
> > > Was this considered and intended?
> > > 
> > 
> > No, I don't think I have considered this before, I think I may still
> > miss something here, maybe you or Paul can provide an example for such
> > a case?
> 
> The whole trace_.*_rcuidle() machinery. Which I thought I had fully
> eradicated, but apparently still exists (with *one* user) :-/
> 
> Search for rcuidle in include/linux/tracepoint.h
> 
> Also, git grep trace_.*_rcuidle
> 

Thanks! But as I mentioned in the IRC, trace_.*_rcuidle() call the
special APIs srcu_read_{un,}lock_notrace(), and these won't call lockdep
annotation functions. And what the commit did was only changing the
lockdep annotation of srcu_read_{un,}lock(), so we are still fine here?

Regards,
Boqun

> 
