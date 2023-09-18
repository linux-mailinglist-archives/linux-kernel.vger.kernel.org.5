Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F267A3FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbjIRDpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbjIRDo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:44:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4497120
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 20:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695008627; x=1695613427; i=efault@gmx.de;
 bh=XQvLqFoh2PFs32MqsjD5mfcVyMTBP3xq3vr8BgDVJoE=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=HqD2wbihOWj/BhPzjUwOfAqZeKyCC7/S0li3gX3alzrznvr691IuvDadoCAEql9sF3n37FBp55+
 t0kzh+KROKNlpY+dOiXRCkPH/rFXq4RCw5i3/gD8UbU2o7PdKiPPXTMUxfjz1xt0xdw8R2GfeSMw6
 ma6yj7n67voaV7+rfcqJX/3viEI5OGP4V2pg3erHnnugrxpt4dBFFEprfl1ek9A/UXoESSg36QHav
 NB0AAsZsmqOa8oKs1f2Hw8d6l7ssCQQ2bIhQydQp/EBUc6nSo3hWOGdSVUJWycnwnCSR8Vk76C/B1
 OpIcQhxevErIC66/8G9k3H4l6YNhPqckdlwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6llE-1qn3Fd0vXy-008KcI; Mon, 18
 Sep 2023 05:43:47 +0200
Message-ID: <5bec3f08b4251c770545b59ede8fc4820c8d685b.camel@gmx.de>
Subject: Re: [PATCH 0/2] sched/eevdf: sched_attr::sched_runtime slice hint
From:   Mike Galbraith <efault@gmx.de>
To:     Qais Yousef <qyousef@layalina.io>, peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de,
        daniel.m.jordan@oracle.com
Date:   Mon, 18 Sep 2023 05:43:43 +0200
In-Reply-To: <20230916213316.p36nhgnibsidoggt@airbuntu>
References: <20230915124354.416936110@noisy.programming.kicks-ass.net>
         <20230916213316.p36nhgnibsidoggt@airbuntu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LtDp4vGX8VnjuvQut3hazcb96i5QhezlHOO9DMujzkozOHrnXAf
 Cw/paXOF9CMNbZ3syClTzE27JBhFsXeWliu+egC0BceqspJSIh2efAHnoXyTbc0ZrzRHivG
 XRxP187sskNQHrO0yhei+f8qQE4s0E2ejNFiQ/IfW3WXv9Oy0sUTXDex7/JUhc0YXNVEJRT
 XvxM/9QvMj1oD1zKPV1gw==
UI-OutboundReport: notjunk:1;M01:P0:VLJ4tvkfiFM=;BnE64NquNAAGhkQbUV4IUliK7+2
 2TrT6wraNFMvaeAs9eIlDQB02NZrr33FwdoEzkfei/rts/lPngpBtB4OOIFzoy174+U7GYggY
 Dd/4BPiz7nCgLrfEUXemjmHZJuyjj5LEyrC7U8hiETgdSRXh7GpEhac1La+sa9limJcmj82lO
 vFh65dvZ2IXxLmkNdhERXfuc7MayKFSF3odtOuR3wUb/8sQBtnCEyJBD5sp/50Pb7HtQTr1Aq
 vVxJZ4kamwu2SS4s0blR+XOavgaKmIokxMtBqg0emHsug48aSODrgl8N+95FrGEzIrcxfR1fx
 7Fe0rNhw8EjSawYtJiYCg8sf43QFYqMapjpBxEXEPcu9tyBAq/xGNWFPzBQ62SFjCYyD/l3vA
 xFLA1eDg5AuwgjYTCYPzDiwpUQ3mY8Gj4TxvE8zplwRR8KfyNrJcUskRnNqFE7U0qgRK2s+V2
 RFdrMcrh1k94VP4n9eBCUyCrQ1Yn7NJ6XicD5y3nJ5h0siVleDuvi+gEsN9vsXWEEC3zY4Pk6
 9lvgwXCSGLhjbMPl8Xm+YhHte5soQJIBGKz2kj4Yx+ATW8u2tkHXqikhQAEok4T5KjMVr/iZl
 jJm7BQHA7JKfOv+KDZNOrbyflniG4kvMKMxdGvSAjQlT1eXpP70qOxqV4q0Vbc4pnwkimKiD/
 mBV4r8bscKziCUZE20iE+03c42CQg3HSKNBxwaDfXl9hLyWuqGWN9swSsQeubBo96LLoouReJ
 Q9EpQuq/9Mg/4cfsnivks9zUPOP74yoVkbB0BEA6fFsWVBZ9480Rn1Ws6R9llwK2vjAbC9NLN
 m53Y2kqraoySrkq00CAQwih7BJufxCe9qlGKoXXXUEhYS+KnrZnlHb4bGyavA7hCRMS5JiTOD
 Ql1GM9CmfDjCiLVi+GVIJZaCgrY263Azn5oXbNfumZHDGgvq1GwzQTnyNInPplQnjg9vnb8Je
 8soeBR7Dxf43f8Rn0d4jhtmGEaY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-09-16 at 22:33 +0100, Qais Yousef wrote:
>
> Example of conflicting requirements that come across frequently:
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01. Improve wake up laten=
cy without for SCHED_OTHER. Many tasks
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end up usin=
g SCHED_FIFO/SCHED_RR to compensate for this
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shortcoming=
. RT tasks lack power management and fairness and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can be hard=
 and error prone to use correctly and portably.

This bit appears to be dealt with about as nicely as it can be in a
fair class by the latency nice patch set, and deals with both
individual tasks and groups thereof, ie has cgroups support.

Its trade slice for latency fits EEVDF nicely IMHO.  As its name
implies, the trade agreement language is relative niceness, which I
find more appropriate than time units, use of which would put the deal
squarely into the realm of RT, thus have no place in a fair class.

I don't yet know how effective it is.  I dinged up schedtool to play
with both it and $subject, but have yet to target any pet piglets or
measured impact of shiny new lipstick cannon.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02. Prefer spreading vs p=
refer packing on wake up for a group of
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tasks. Geek=
bench-like workloads would benefit from
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parallelisi=
ng on different CPUs. hackbench type of workloads
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can benefit=
 from waking on up same CPUs or a CPU that is
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 closer in t=
he cache hierarchy.
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03. Nice values for SCHED=
_OTHER are system wide and require
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 privileges.=
 Many workloads would like a way to set relative
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nice value =
so they can preempt each others, but not be
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 impact or b=
e impacted by other tasks belong to different
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 workloads o=
n the system.
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04. Provide a way to tag =
some tasks as 'background' to keep them
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out of the =
way. SCHED_IDLE is too strong for some of these
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tasks but y=
et they can be computationally heavy. Example
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tasks are g=
arbage collectors. Their work is both important
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and not imp=
ortant.

All three of those make my eyebrows twitch mightily even in their not
well defined form: any notion of applying badges to identify groups of
tasks would constitute creation of yet another cgroups.

	-Mike
