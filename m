Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108F87B2037
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjI1OyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1OyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:54:17 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46EAF9;
        Thu, 28 Sep 2023 07:54:15 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c4d625da40so6149467a34.1;
        Thu, 28 Sep 2023 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695912855; x=1696517655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS2kv7BAsbZD2ZX4Mq9AGaJQ8pugaCatVESsia7nc7Y=;
        b=YMCGR7mYwOutvi2Yd1kt3q+EPOP8wKBI69x//NgW+97jiM9o3d1hJYxxHx50BeB8nW
         yyJ2CCZoehpxik8qCSNKWepojzyBmnGZXKWrk3HmNdbjizD/95Z2+7NuhRVX0XfRbQa9
         F8Ola2VDsddKsdXd9Qjdvm2Cq691Jr/bkk8XPIg+Bu+l+Sgnf8s+aF5lHpqMTIZ29OTP
         Q/tQ60rubSr5buGuQRuV+ciRg2ugk8fyaX+GHjmqBCFSbwXlX6b2IxmqaUX2pXfKFMgh
         L4pmNtHUPWavWU/RfCDihuwtG3pEJuEL74no90d6FX0PbnzZ0/RpELcP4LSN3RRD8MQe
         rkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695912855; x=1696517655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iS2kv7BAsbZD2ZX4Mq9AGaJQ8pugaCatVESsia7nc7Y=;
        b=mLmdrr0idkb1D6kd5jyLp0RdhDaLeTDgtpHA0HvPmSlseB4EVOluwpHcVI4tWYW4nl
         +wxpWdj0CEEpHDrL6ao+tM3C1M9qmq/LCN5UNC+77iCkr5Hv4GArPvR4Qr2i4e+R6q97
         fTsKdutuKaqudWkK6hL4zUhTnXRFk64i9qflAUgxfT1v/CFiZ8Q/z+ZDLkGese9ULvAo
         Xnpat0JAHE1RJQrnlzjj1H6jvAss9Klpogo7x087BCJbGfyJ8UqzLM6bFG/+C274WKQB
         UR6YfAhghFn0GQYufZi5wslUbWT4VWQbk+5uKymDsU/DZyIE63dp9+jcivsviejvoPdd
         g9aw==
X-Gm-Message-State: AOJu0Yw5/XLeMrl8y4rPKfOREaHa9SaLYKUMVUSwrkPuce6zcOp2PfNj
        q0Pn7Xja6vRWSl/5Is3IJI8=
X-Google-Smtp-Source: AGHT+IE4NpmFgaCPOKloaywslGsTuQr+IyiBNAZyGEiFubiz0BvLChalGbhx7FMi2wIiHiW+J6Bc8Q==
X-Received: by 2002:a9d:7b57:0:b0:6bd:7252:9db1 with SMTP id f23-20020a9d7b57000000b006bd72529db1mr1562554oto.11.1695912854903;
        Thu, 28 Sep 2023 07:54:14 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id az3-20020a056830458300b006b89596bc61sm2287880otb.61.2023.09.28.07.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 07:54:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id AA2BB27C005C;
        Thu, 28 Sep 2023 10:54:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 28 Sep 2023 10:54:12 -0400
X-ME-Sender: <xms:lJMVZdBv4otvSsWMZUpfUuE116qjXNKPuoxsuevbMqYUD0zLjkHtoA>
    <xme:lJMVZbiXlLsFKM2pjGTNbDtE7zoFFMR8cTUZDvd_O8hs0698PWNdOzJr2cZlX0_PW
    v9rpyYvhXVQcl_PTw>
X-ME-Received: <xmr:lJMVZYlBlMO5bopXvTMT1y0umYhSj3roXmID_MyJZFVUQSS6rwunq1Dnvm0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddtgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:lJMVZXxpMPaxolvqzQm1MILdMsQZ0szCDwYRYBclKf_okRw5ZyhLRA>
    <xmx:lJMVZSQW9lOU5ZKvIJJr4FFyi4llzH3EqIpWVYpyLfy0R2jzyJ2rkQ>
    <xmx:lJMVZaZhwvll23vS9yKNtI8YEdZD2_jhvRi229J7Zo47j4kk7i-0fQ>
    <xmx:lJMVZcGF0g0u-zEYprLpwTxUowGc1fh2m37-gsTeiZPCsHVf_Zbt8Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Sep 2023 10:54:11 -0400 (EDT)
Date:   Thu, 28 Sep 2023 07:54:10 -0700
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
Message-ID: <ZRWTktRdej5OW53q@Boquns-Mac-mini.home>
References: <20230927160231.XRCDDSK4@linutronix.de>
 <ZRUX0YUrXfepRGKE@Boquns-Mac-mini.home>
 <20230928080900.GF9829@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928080900.GF9829@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:09:00AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 27, 2023 at 11:06:09PM -0700, Boqun Feng wrote:
> 
> > I think this is a "side-effect" of commit f0f44752f5f6 ("rcu: Annotate
> > SRCU's update-side lockdep dependencies"). In verify_lock_unused(), i.e.
> > the checking for NMI lock usages, the logic is that
> 
> I think I'm having a problem with this commit -- that is, by adding
> lockdep you're adding tracepoint, which rely on RCU being active.
> 
> The result is that SRCU is now no longer usable from !RCU regions.
> 

Interesting

> Was this considered and intended?
> 

No, I don't think I have considered this before, I think I may still
miss something here, maybe you or Paul can provide an example for such
a case?

One thing though, before the commit, srcu_read_lock() already has an
rcu_lock_acquire() annotation which eventually calls lock_acquire()
which has a tracepoint in it.

Regards,
Boqun
