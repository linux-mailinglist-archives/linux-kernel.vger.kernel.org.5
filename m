Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E767FF8EA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346628AbjK3R5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbjK3R5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:57:00 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC6510F4;
        Thu, 30 Nov 2023 09:57:04 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8798A5C02E6;
        Thu, 30 Nov 2023 12:57:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 30 Nov 2023 12:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701367021; x=1701453421; bh=5D
        inRe2Ja+E6Yl6fvgP5dTyogaDC1dFejinC1nN/SsY=; b=oEZgAwZ9WRw0EqIhAP
        uyMMCuO/T84vdiNjP6/l9KP8gUO9upcLSlIYc3E6VEhUh2NmIewXXmYR3GIsZy8T
        TWJYrn4iACpf2SwJWAYx8mDdvEXrChVpsb9XpJtBmw29i0z7vvZWNe7O13zoEYOD
        GGUEmr1zMICpv/Y+BR70OCnTEFGVrjQi8NfZ4JbIf9be6MWU3zwSEshzIYkiAYQV
        m8Oq3P7wSNgt3e4+GAqxJ3vC3RTiWXYDfcpyxhUQrH7Rd12JYwVwFqbOHdoKlqmz
        aW0CuI/iqTJrmYQio9aX7K6KWmNCDptb1o2MotlH7sNtrDQzJKv6v+Meg8wA7FaG
        1y9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701367021; x=1701453421; bh=5DinRe2Ja+E6Y
        l6fvgP5dTyogaDC1dFejinC1nN/SsY=; b=yBO7hsXuBEm3JxgYZ5HPuNJ/xO4J5
        9dqkV1sJtmbgeMtYafJ3A057AM819bf7N2TEfTE1fnr3FlKU7dSv76m7tZHsJ2nF
        QpbJ2YvTinQHEkslg1fDD3MX1iC5lrcqyLgKkkXktoPKlTMCbbNgrziOj4Z06u9h
        sSFhj9981nDzmLXH7mfPS9762YArlkQcfnqtvWMnGwxVGAXLrSw0nKEhpN7psHqA
        HUCsiwDwlsOFI8hzelbzKrlKmh7hNYLH6x/3pRzXMjviax/b7590IEPr+bz7Yz8v
        WPUNlqZgnkw7vyNcXVluubv/rwKgW2MPBUhs8DqnaGxOoykV5Khc+7cWA==
X-ME-Sender: <xms:7MxoZVpOfAx7qfsP93LoYsQN1_BRBuc1PjNXjheSHs_-DU_CTH4j4w>
    <xme:7MxoZXpUQI70Rhgl_FnEf89lCZ-cZB-AOKdwhcBR_qnahyhj6xw_gIbZmL_PiXGMx
    oGcgXcuJpA-_wlQsCc>
X-ME-Received: <xmr:7MxoZSPsIQEBNJn7T63OWWEjaxLq01UAbFXbmXdlP4ha7Bf8OKITJP03_lc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteek
    lefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:7cxoZQ5pwEScjoo3AckBkcdRZhq1jLnG3_MVuBlFYpofV94s68T83Q>
    <xmx:7cxoZU4Te13dn7yARTzaD6FovQE5uhGZFIl75RQkyXaNdJiGRvo_XA>
    <xmx:7cxoZYjojVE1o8Z-Jim2v5vufCNP_hPMdnqmcOUgjFs9uAULLVgo3Q>
    <xmx:7cxoZf0RBe_Fl3UR5u26L_cJWEhZ231zaiTOhMD2l7VCwmWH6rwIkg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 12:56:59 -0500 (EST)
Date:   Thu, 30 Nov 2023 10:56:58 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <ZWjM6trZ6uw6yBza@tycho.pizza>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <20231130173938.GA21808@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130173938.GA21808@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 06:39:39PM +0100, Oleg Nesterov wrote:
> Hi Tycho,
> 
> I can't really read this patch now, possibly I am wrong, but...

No worries, no rush here.

> On 11/30, Tycho Andersen wrote:
> >
> > @@ -263,16 +263,25 @@ void release_task(struct task_struct *p)
> >  	 */
> >  	zap_leader = 0;
> >  	leader = p->group_leader;
> > -	if (leader != p && thread_group_empty(leader)
> > -			&& leader->exit_state == EXIT_ZOMBIE) {
> > -		/*
> > -		 * If we were the last child thread and the leader has
> > -		 * exited already, and the leader's parent ignores SIGCHLD,
> > -		 * then we are the one who should release the leader.
> > -		 */
> > -		zap_leader = do_notify_parent(leader, leader->exit_signal);
> > -		if (zap_leader)
> > -			leader->exit_state = EXIT_DEAD;
> > +	if (leader != p) {
> > +		if (thread_group_empty(leader)
> > +				&& leader->exit_state == EXIT_ZOMBIE) {
> > +			/*
> > +			 * If we were the last child thread and the leader has
> > +			 * exited already, and the leader's parent ignores SIGCHLD,
> > +			 * then we are the one who should release the leader.
> > +			 */
> > +			zap_leader = do_notify_parent(leader,
> > +						      leader->exit_signal);
> > +			if (zap_leader)
> > +				leader->exit_state = EXIT_DEAD;
> > +		} else {
> > +			/*
> > +			 * wake up pidfd pollers anyway, they want to know this
> > +			 * thread is dying.
> > +			 */
> > +			wake_up_all(&thread_pid->wait_pidfd);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> somehow I can't believe this is a good change after a quick glance ;)

Yeah, I figured it would raise some eyebrows :)

> I think that wake_up_all(wait_pidfd) should have a single caller,
> do_notify_pidfd(). This probably means it should be shiftef from
> do_notify_parent() to exit_notify(), I am not sure...

__exit_signals() is what I was thinking in the patch description, but
I'll look at exit_notify() too.

Tycho
