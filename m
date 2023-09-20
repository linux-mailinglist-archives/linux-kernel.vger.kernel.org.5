Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73EB7A7169
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 06:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjITEE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 00:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjITEE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 00:04:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C69AC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 21:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695182546; x=1695787346; i=efault@gmx.de;
 bh=/CsQuqmag4gOxl+1Bemj4tV1kCHV/MEmiWHuu660Vc4=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=bxj7q5fTtk0x0ZLtYPfQ+ohuzvtNCIbjou1wxXiN3HQnQWpiYLCBROcSoXQvldSxePRadCZ4LuH
 kQBJauIy3IFzdW1YQdQifYI+zJfcK1H8lmHxQkVznJ1lcqlLlBtR+V1S0qxDwMf//TOOr2QT0DFvV
 KpdQJD3h2vnciQkIqj2yqg+Z7GYq832b+h1erURz9iWGcAg+I4Y7z29pWDaTvwHj5e9lTrzautTvK
 OK/mdERslFGB0aDfUdPiVwOnvIsAvrI7LIpCL53ngnr3GbzVL9toSu9Ev1Qvn03cie4MS9luN3/Zz
 ZqRNFseSujDtqGq+xpXFNnpkzKIIwn4sseaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.217.221]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv31W-1rZg1J32zA-00r3rA; Wed, 20
 Sep 2023 06:02:25 +0200
Message-ID: <c30367d351c821b13c2bdd9d680388d244fa74c5.camel@gmx.de>
Subject: Re: [PATCH 0/2] sched/eevdf: sched_attr::sched_runtime slice hint
From:   Mike Galbraith <efault@gmx.de>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        tglx@linutronix.de, daniel.m.jordan@oracle.com
Date:   Wed, 20 Sep 2023 06:02:17 +0200
In-Reply-To: <20230919210851.ktzi7ogxs3punger@airbuntu>
References: <20230915124354.416936110@noisy.programming.kicks-ass.net>
         <20230916213316.p36nhgnibsidoggt@airbuntu>
         <5bec3f08b4251c770545b59ede8fc4820c8d685b.camel@gmx.de>
         <20230919210851.ktzi7ogxs3punger@airbuntu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yva+oJd6VuIVnPMlRDlpn3XzLeW7DkobUBrXyZXR04kYPEwzkgr
 DEXYpRtDXcmKqI4KQpwLJxBI3TdEcSwTIBy1xyHOjWRmz14BbaFmXtyUCR5jEQT5y9yOMxJ
 OgNTOIQnqPm26P39KxmPiraHj4TyiD31YBmaz3PTNirIEYZ3My9EoM2HOKV4WgU1NWi1LeP
 uDULHFNzhL/ci3fCbn4ug==
UI-OutboundReport: notjunk:1;M01:P0:q8OgTkTdrbo=;1IX6w5Ql1U8Wo0QOMipyMzTs4ox
 V1GAWsLpTGE1nz7uu/WPT8CmgBhFJNRCjGbLcdZWYHKtzZepGiid8Dq499VeX22u/DpidEpOV
 KeQq9ux1S8zH55pScCNIvBAA7BODRcBB4JFQnZVjYF+gSR2h00ejMxAmZ45O8Hwucj8b616yF
 hpcmjHGnsyedudtx7mLmIG8l1UyLO4TW3BCKwTt5H/9/3DXjbp0EY1ONVMNCXM4Q3TLczSkwp
 sIBP7g13k3QAxGoecMz1G13tkglqejdjabDBrlrZR0c1HiewDk9z8WZRhKwABSScucNxb5uF4
 I/QtKXNVTz/qboSvtrGPXLCO3bZRuQqwgs3VNi6vExDOq3R4KhxHfchz1Njxs8PHbpEOHB6Z9
 KieZO/vrGREZ1vo5OtPleOieTkE88CdVE742Q7h8ogITCkvPJVgFPpphdL9cZtDnKOl8cytRQ
 qxVYQ8zrLYLWJZePzSKhOYWTtJ5TJ1n1Ns6gyEjDij1cp5dyHly6r5Fo6PfuVsTM3ACpOHhKm
 P2iS/e0bUqoNxmQAD2wnnPkP/nQiZjnet3qV9jginEAqDO6ktTfCJwo+qba3HIBi2x2puF4fF
 wtvyMF4MG+m0T370NxjxlzEbfvoCMgBhgSu/7+C7y/GRlcrUmRGdBVyffnQsnd2SIZyUAPtJ+
 wtER7Zn+SfgJntvIMcH87W4YlcU2WBdD33n0ZMQmz7nX/xZ6RqkqBLlEiJ5YHSmTWkFi5TDzX
 366vDRFWr1qe5rxZzPrXt3MGlhBSVpM+pCdPBD7vqwtFj96PprcS90ZW/3VFHq+xePL+MGKBQ
 oxtmweCJjllJaZ5UQyhUeWvx3f5hCKAtpUFbxQ/S50w13/xzMAAfEtZijR+iwFik0u4ntAScd
 jM65+PORQjwz2AO42+dCqLSAe5khhbbF3qtoK6FeXMWTfiwK7D/YkAH3o1vCsQMXODcwNlz5a
 VElJ/SRZK0md/Xp/8EGm/YW11rQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-19 at 22:08 +0100, Qais Yousef wrote:
> On 09/18/23 05:43, Mike Galbraith wrote:
> > On Sat, 2023-09-16 at 22:33 +0100, Qais Yousef wrote:
> > >
> > > Example of conflicting requirements that come across frequently:
> > >
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01. Improve wake up l=
atency without for SCHED_OTHER. Many tasks
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end up =
using SCHED_FIFO/SCHED_RR to compensate for this
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shortco=
ming. RT tasks lack power management and fairness and
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can be =
hard and error prone to use correctly and portably.
> >
> > This bit appears to be dealt with about as nicely as it can be in a
> > fair class by the latency nice patch set, and deals with both
> > individual tasks and groups thereof, ie has cgroups support.
>
> AFAIU the latency_nice is no longer going forward. But I could be mistak=
en.

Effectively it is, both making the same request under the hood, the
difference being trade negotiation idiom.

I took both to try out for no particularly good reason.  The only thing
silly looking in the result is one clipping at OMG the other at OMFG.

> > All three of those make my eyebrows twitch mightily even in their not
> > well defined form: any notion of applying badges to identify groups of
> > tasks would constitute creation of yet another cgroups.
>
> cgroups require root privilege. And it is intended for sysadmins to spli=
t
> system resources between apps. It doesn't help an app to describe the
> relationship between its tasks. Nor any requirements for them to do thei=
r job
> properly. But rather impose something on them regardless of what they wa=
nt.

The whys and wherefores are clear.  I suspect that addition of another
task group interface with conflicting scheduling parameters, policies,
hopes and/or prayers to be dealt with at each and every level of the
existing hierarchy is going to be hard to sell, but who knows, maybe
that skeleton looks more attractive to maintainers than it does to me.
I suppose we'll find out once you hang some meat on it.

	-Mike
