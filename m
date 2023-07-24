Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE43075E5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 02:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGXAdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 20:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXAdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 20:33:00 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A71E9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 17:32:59 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-785d738d3feso90229339f.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 17:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690158779; x=1690763579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=okkG/ASud8bLD06JXRVQQQz75TIzTLjFE+g1R5XNRR0=;
        b=wzEpS8znt/KxoJH41SBjTpOAf7SjE8+6B76QKwyLShkp6frvxhQTjNA01CdMQpJvwH
         i4e46zjY7u+xtcpm3n+Jjpc1VkUT3Tx9CRwPSZ8n79ENbfx3zEJTBBIk/NVWzQ36PBkh
         WaiLgAMF89nIO4b973kH7KlJyNwsK2uARFgzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690158779; x=1690763579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okkG/ASud8bLD06JXRVQQQz75TIzTLjFE+g1R5XNRR0=;
        b=Z8QkybYOLrUeE01XQamX52b3sNnbVodzECnvYSoVUn4jOl2vvMwK+avpTE1mSvzbUB
         MGFEYbfj08p3zazKuB2mb1F6k7XQq4nsrfNWcektra8J+2zmq8zHUbR4UUB9eLpB5fzB
         bWJ9hkfN/Pwwr/SgW0wq19oqygvQkL6PcxAujzxaGTXxIVPr/qE8D5fyBQHqweska5Xi
         D/G+bGAKliRYYOaq9WzFkxlAyELOKeyfCiH/VyNzG4BZLt01soaADTLUGK5QRonTjDEt
         m4zNaKTPd35VDxps1mDtFD/Y3IvXjpYIPMaK48R+PhyFwPHSaBG0hIbLe6twyAVihLoh
         u7yA==
X-Gm-Message-State: ABy/qLbKdJNx81VnZOaGFuM6HtArXajFzjm1r1CKLsQhUV1IV2Zn4zEx
        euwnG5P+5psCjIrO4fWY3QFDxQ==
X-Google-Smtp-Source: APBJJlENT9DK1h4VT6XVyoZzt/3Fi6aMgmGbSTEM9F5klJFOr9BBANR8HvOe7z8qwGRAEPyA984uJw==
X-Received: by 2002:a5e:a810:0:b0:786:7100:5727 with SMTP id c16-20020a5ea810000000b0078671005727mr4057316ioa.1.1690158778914;
        Sun, 23 Jul 2023 17:32:58 -0700 (PDT)
Received: from localhost (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id m3-20020a056602018300b00786fd8e764bsm3115485ioo.0.2023.07.23.17.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 17:32:57 -0700 (PDT)
Date:   Mon, 24 Jul 2023 00:32:57 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        rcu@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BUG] Re: Linux 6.4.4
Message-ID: <20230724003257.GA60074@google.com>
References: <f18e165c-9196-4b41-a202-82cfd5ac7f8b@paulmck-laptop>
 <8682b08c-347b-5547-60e0-013dcf1f8c93@joelfernandes.org>
 <eb04b7d0-2f49-4e01-be09-9062d9f08404@paulmck-laptop>
 <32aec6d1-bf25-7b47-8f31-7b6318d5238d@joelfernandes.org>
 <9b42cb38-8375-fc41-475a-2bd26c60a7b9@joelfernandes.org>
 <5dcf7117-cec7-4772-8aad-e100484a84dc@paulmck-laptop>
 <7bfde9f4-2bd6-7337-b9ca-94a9253d847f@joelfernandes.org>
 <ad82995c-061e-4f97-a972-c13a85ad0b72@paulmck-laptop>
 <a7bcbcf2-9b34-4326-822f-e1f2aa5c5668@joelfernandes.org>
 <ebde8612-95de-4eaf-aa56-34e9b3a3fa86@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebde8612-95de-4eaf-aa56-34e9b3a3fa86@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 10:19:27AM -0700, Paul E. McKenney wrote:
> On Sun, Jul 23, 2023 at 10:50:26AM -0400, Joel Fernandes wrote:
> > 
> > 
> > On 7/22/23 13:27, Paul E. McKenney wrote:
> > [..]
> > > 
> > > OK, if this kernel is non-preemptible, you are not running TREE03,
> > > correct?
> > > 
> > >> Next plan of action is to get sched_waking stack traces since I have a
> > >> very reliable repro of this now.
> > > 
> > > Too much fun!  ;-)
> > 
> > For TREE07 issue, it is actually the schedule_timeout_interruptible(1)
> > in stutter_wait() that is beating up the CPU0 for 4 seconds.
> > 
> > This is very similar to the issue I fixed in New year in d52d3a2bf408
> > ("torture: Fix hang during kthread shutdown phase")
> 
> Agreed, if there are enough kthreads, and all the kthreads are on a
> single CPU, this could consume that CPU.
> 
> > Adding a cond_resched() there also did not help.
> > 
> > I think the issue is the stutter thread fails to move spt forward
> > because it does not get CPU time. But spt == 1 should be very brief
> > AFAIU. I was wondering if we could set that to RT.
> 
> Or just use a single hrtimer-based wait for each kthread?

[Joel]
Yes this might be better, but there's still the issue that spt may not be set
back to 0 in some future release where the thread gets starved.

> > But also maybe the following will cure it like it did for the shutdown
> > issue, giving the stutter thread just enough CPU time to move spt forward.
> > 
> > Now I am trying the following and will let it run while I go do other
> > family related things. ;)
> 
> Good point, if this avoids the problem, that gives a strong indication
> that your hypothesis on the root cause is correct.

[Joel]
And the TREE07 issue is gone with that change! So I think I'll roll into a
patch and send it to you. But I am also hoping that you are Ok with me
setting the stutter thread to RT in addition to the longer schedule_timeout.
That's just to make it more robust since I think it is crucial that it does
not stutter threads indefinitely due to the scheduler (for any unforeseen
reason in the future, such as scheduler issues). And maybe, as a part of
that I could also tackle that other TODO item about cleaning up
torture_create_kthead() as well to add support to it for setting things to
RT and use it for that.

Let me know what you think, thanks!

 - Joel

