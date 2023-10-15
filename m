Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4E37C9A75
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 19:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjJORuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 13:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjJORuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 13:50:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED8EB7;
        Sun, 15 Oct 2023 10:50:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DECC433C7;
        Sun, 15 Oct 2023 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697392218;
        bh=tbm6AVjOHuNb7ND7lRa0uYuFFgqBHlGwd9LHu/mKIDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SzU5oQDtEtraGV3N1bF04WEnyv5AnydayWzjUJMpRojxZ5jo11p7vUvYUP5a2YSD8
         62RR6V0MpbtVE6Jj5orZhe19COCbbTFG/Lu9eMVBjr6jgCneOALU0QbHWgo6Iy4MJh
         8HRJctcRe9vl+Jr9X5gfdYESav4Fgp7gJOXIRdIA=
Date:   Sun, 15 Oct 2023 19:50:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4.19 00/29] 4.19.282-rc1 review
Message-ID: <2023101506-scrawny-handlebar-0734@gregkh>
References: <20230424131121.155649464@linuxfoundation.org>
 <CA+G9fYstB_fROK9LHYuQ8dc2ArieGGAW_x69eEX-eAi5xMeE3Q@mail.gmail.com>
 <20230426170945.0ec0f1ef@gandalf.local.home>
 <20230426181415.17c893f5@gandalf.local.home>
 <CA+G9fYtd=dJEM=+xOHA9Egs88r+gEfrnW_gFnTFm4of5uTQ7mA@mail.gmail.com>
 <CA+G9fYt518bg10DVo=ag=iGB8dj_NQZEmEty1CdkU3Cj+gtW0w@mail.gmail.com>
 <2023101132-playable-flagstick-1abf@gregkh>
 <2023101125-subpanel-enviably-28cd@gregkh>
 <20231011104529.75f53d4b@gandalf.local.home>
 <CA+G9fYuvtzQxL=RQ=zQB_Bn+-dcGwvXVnfHPqMaQHA-L5ydj4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuvtzQxL=RQ=zQB_Bn+-dcGwvXVnfHPqMaQHA-L5ydj4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 05:23:23PM +0530, Naresh Kamboju wrote:
> On Wed, 11 Oct 2023 at 20:14, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 11 Oct 2023 11:05:48 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > > > Ok, I'll queue it up now, I didn't realize it needed to be there, sorry.
> > >
> > > Nope, I can't, it doesn't apply there, so I need a backported, and
> > > TESTED version, for 5.4.y and 4.19.y if anyone wants to see it there.
> >
> > This is a quick backport for 4.19 as the conflict seemed to be due to added
> > code that is unrelated to this change. I built and booted it, but it should
> > have more testing.
> >
> > Naresh, if you want this in 4.19, please run it through your tests and give
> > your tested by.
> >
> > Greg, please do not take it until Naresh has tested it.
> 
> Below patch applied and tested on top of stable rc branches
>  - v4.19.296
>  - v5.4.258
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Thanks, now queued up.

greg k-h
