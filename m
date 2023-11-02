Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D00D7DE9D8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 02:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjKBBFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 21:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjKBBFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 21:05:54 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220D4FD;
        Wed,  1 Nov 2023 18:05:51 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67089696545so2659146d6.0;
        Wed, 01 Nov 2023 18:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698887150; x=1699491950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3Pfx+C9lqoY1P4YDWqNHdNTiZWMwJmMu4H3k+fMFlw=;
        b=U+TDjwIiDrGPElxmQhbvnE1e3E7aOiY53eQsVzDRdzEmvEDJ+PBxkEdo+C9oYDnWbX
         8R5ItVpGvpBFd8c7GOYLZq6O+Y1oqoTG6AYURtDUy5R+szRGArfsnhQo/VqfbisljrYd
         Kr+iXwTSl5j+SDjK7iTPIU1NotzEIZ4AsBjhh63Jsip+PzV7lksXvsqnxZ3dfY2NIluZ
         pBeDQTyWHQNMUnqURvnuEoVMlWDIzgaA17iV0NkkcvSYI7T+PZ1V4YmxQflOL+clfFo5
         cWuR+oBiZbYo16yl0JvhogjZz11gDeuE8OwMNYLSJsSTHy+OqkXOxupynelLpQqc8Rem
         2vKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698887150; x=1699491950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3Pfx+C9lqoY1P4YDWqNHdNTiZWMwJmMu4H3k+fMFlw=;
        b=fNJRMfPcbwbfXW+wA3FcYJSaV4XkZE7qfwoVW3kg6YCi/yuDFEPdqBG2HssE8YsMo9
         hbFd7AcQeVVDbjp1KaFW+bUw0/jGi7JVEa6XcNvV0680J6qCEzOgE9lu/fKPPOIXUNw1
         0r80OdsalhFqP9B9GMlpPYAY+Xw93Pa8+WVWCnto6bbxt7SK2FfXnBdCgqOE530ya7Z5
         d3ZTIJttxreAcY8lKb4ilRufLCzrexf+sz9TKnzOTquVpVD9/EMVDP/k1D/fwuUylk+v
         ori3jrT6cmVw/QrNJnvZzd31M/cm7EfOj9Cd5+70vScJbySWOiR1gZT+WuDdIbiuTYGH
         ELLw==
X-Gm-Message-State: AOJu0Yy4nETQ+8f/Fc7nuyYlxKzCotDpn8zB4s/Udz7RvLrNqGPgiaIi
        uIVpz97BlJjPYhYSNy7HySx+YnliTko=
X-Google-Smtp-Source: AGHT+IHs1aMinNyliEY+onERDKWoYniE5JoxmuCVqIn7VGhvY/pPmOucDjHsDZ0SFCST7KxCCKjIZA==
X-Received: by 2002:a05:6214:f24:b0:66d:4680:6dc5 with SMTP id iw4-20020a0562140f2400b0066d46806dc5mr22748055qvb.50.1698887149690;
        Wed, 01 Nov 2023 18:05:49 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i5-20020ad44ba5000000b0065b22afe53csm1961843qvw.94.2023.11.01.18.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 18:05:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id AC60827C005A;
        Wed,  1 Nov 2023 21:05:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 01 Nov 2023 21:05:47 -0400
X-ME-Sender: <xms:6fVCZXSBddb0zMOl3HFp2nBJC7XMuTzW61jw436P3fPE9PipjDuXkg>
    <xme:6fVCZYxyPBldefhSSYH5HW8iSz89ScKPaoYXAKvqPjIAP9Xi69Lp5zQisgpHUe-hz
    BdnNqdo6csgxKfFWg>
X-ME-Received: <xmr:6fVCZc3lFgbpcL2E1_pXVsvQ2ditM-uWPariwStVcfZ8h8ZdRmTA6OYh5A0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:6fVCZXByFQ7n9moHqdlxct7jtAIgLaFLqYM02s1oNPICbPtectogFQ>
    <xmx:6fVCZQgedh-Vfyz4_ZeVXlj7o_fdiIILCI2En3iEgV74UDBbUCbEoA>
    <xmx:6fVCZbqVjKQ4NvK9jBE1heyhfZx5PHz_sRmBJMDHIeR28sEMiDebqQ>
    <xmx:6_VCZZXbLvKleKvKm_avcuj27grHTOjgcqufWvGjAFo_hsB9-OsLeA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 21:05:45 -0400 (EDT)
Date:   Wed, 1 Nov 2023 18:04:40 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/3] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZUL1qEOV8QBHVFHP@boqun-archlinux>
References: <20231025140915.590390-1-urezki@gmail.com>
 <20231025140915.590390-2-urezki@gmail.com>
 <ZTlNogQ_nWUzVJ9M@boqun-archlinux>
 <ZTpk7gvIgdHioL3c@pc636>
 <ZT6ilzH0HQNFLb2Y@boqun-archlinux>
 <ZUIpfzEt_rpTAS8T@pc636>
 <ZUJwKXcjK0064zkb@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUJwKXcjK0064zkb@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 04:35:05PM +0100, Uladzislau Rezki wrote:
[...]
> > Basically it does not work, because you do not fix the mixing "issue".
> > I have been working on it and we agreed to separate it. Because it is
> > just makes sense. The reason and the problem i see, i described in the
> > commit message of v2.

As I understand it, your point is "if we want synchronize_rcu() faster
in all the cases, then a separate list makes a lot of sense since it
won't be affected by different configs and etc.", right? If so, then
understood.

I don't have any problem on that your patch does a good work on making
synchronize_rcu() faster, and actually I don't think my proposal
necessarily blocks your patch. However, I wonder: why synchronize_rcu()
is more special than other call_rcu_hurry() cases? Sure,
synchronize_rcu() means blocking and unblocking ealier is always
desirable, but call_rcu_hurry() could also queue a callback that wake
up other thread, right? By making synchronize_rcu() faster, do we end up
making other call_rcu_hurry() slow? So in my proposal, as you can see,
I tried to be fair among all call_rcu_hurry() users, and hope that's
a better solution from the whole kernel viewpoint.

Also another fear I have is the following story:

(Let say your improvement gets merged. And 6 months later)

Someone shows up and say "hi, the synchronize_rcu() latency reduce work
is great, but we have 1024 CPUs, so the single list in sr_normal_state
becomes a bottleneck, synchronize_rcu() on some CPUs gets delayed by
other CPU's synchronize_rcu(), can we make the list percpu?"

(And 6 months later)

Someone shows up and say "hi, the percpu list for low latency
synchronize_rcu() is great, however, we want to save some CPU power by
putting CPUs into groups and naming one leader of each group to handle
synchronize_rcu() wakeups for the whole group, let's use kconfig
CONFIG_RCU_NOSR_CPU to control that feature"

Well, it's a story, so it may not happen, but I don't think the
possiblity of totally re-inventing RCU callback lists and NOCB is 0 ;-)

Anyway, I should stop being annoying here, I will use your test steps to
check my idea, and will let you know!

> > 
> > >
> > > Do you have a benchmark I can try out to see if my diff can achieve the
> > > similar result? Thanks!
> > > 
> > There is no a good benchmark. But you can write it for sure. I tested
> > three scenarios:
> > 
> > - Run a camera app on our Android devices. Measuring app launch in
> >   milliseconds;
> > - Doing synchronize_rcu() and kfree(ptr) simultaneously by 10K/etc
> >   workers. It is important test case because we have a fallback to
> >   this scenario for our kvfree_rcu_mightslepp() API.
> > - I had a look at time delta of loading 100 kernel modules.
> > 
> > That were my main test cases.
> > 
> I will provide the patches and test steps, so you can try on.
> Tomorrow i will send it!
> 

Thanks!

Regards,
Boqun

> --
> Uladzislau Rezki
