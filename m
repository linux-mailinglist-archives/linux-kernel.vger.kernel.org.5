Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5AC806378
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbjLFAdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346647AbjLFAd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:33:29 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C42AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:33:35 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35d57ab6f5bso57675ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 16:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701822814; x=1702427614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pHgxdCxOG12G1hvARrJ+hyIHKbL9mJBrNWPcoxsQ7k=;
        b=XmVhEfoZss/wiHOd7kVPScBYAeeyJo5NlqSI0mz85HoHkltkprnaJ9zdci1hqsQk0H
         P+6Y+amRR+APwRnskpDFSWFlsVv0znzCDwbPc0atXRvN4Ocswo+Sc3mMpoliq+OjKSu6
         ctTT4PO+BJQthTd4017Zt66s1npzRQ6fZFWZ5wBwi0QPz59hdHOW3TGydNtLb8sDwcdy
         bh+NApwelNfWt9oEM1c7TBkAaMpMPxc49l/ibPeNrqfpQSLE3KrwsY5PJEHn07otoYwV
         Cnvb4MXwJNHpre7h3T3lMrCve2y2GWOugqelXt/Dpz9yjnS4nZu0pqaX1HTBAh1nc5bY
         c6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701822814; x=1702427614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pHgxdCxOG12G1hvARrJ+hyIHKbL9mJBrNWPcoxsQ7k=;
        b=DNcMzxxcZYfdj93Hmb1vbzEooIhhFkMFiQAlWYahxvz/zoQSPFSrrIIIZsh5oP2FrD
         tRcI/mTGd30IUx5C6ihMrx5VCl2wEG8/F7k4HfZ4dS8UkYLFdHV8hitjtkj/57NC0AOe
         TWX5YAKlpu02Ts/TjTvc/HiDiFkbPmAGONQ1d+ha8GYcQIPySiDpqkYIQ1lLl/tDkcZT
         JPT6wxZUN5DnXx54xormTM5D7/HcSyPnNjUblb3iByBvfm5w0Kuvqf64OQBkJflu6tlI
         jlTjxy+Z+MRl9a20ySK4pNBh1xsRPpW5jzQihhRXeQBpUWVArcED8lBzxURUHpVEjAlM
         0g+w==
X-Gm-Message-State: AOJu0YzZfQcENsH4QP+qX7UDzYTJ/9jcQjwLXTZ1vfHHgJj1yFmQTFJh
        ueJa16aqxrBa0hnSlxsBS3PeoX9EZdojZ5WwmhmZXg==
X-Google-Smtp-Source: AGHT+IGRrPvNuiExO8WZWD5YJ2xzcRJ1o7a+xNPzL983Ng/SJCrQU88wzoHfETCiDN1jOHT+5OkqQxBLNAoxlCe/vnw=
X-Received: by 2002:a05:6e02:b43:b0:35c:b538:6d15 with SMTP id
 f3-20020a056e020b4300b0035cb5386d15mr110691ilu.28.1701822814416; Tue, 05 Dec
 2023 16:33:34 -0800 (PST)
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-4-peternewman@google.com> <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
 <CALPaoCg76nUsJ7eYcU61gied8WBuAAmqy0Pqpsq5=Z-S52Qg6w@mail.gmail.com>
 <31993ea8-97e5-b8d5-b344-48db212bc9cf@intel.com> <CALPaoCiPCxUeGKjZytxmse2oNs=qDBbRY9kH7AZGG6iXf1qtJw@mail.gmail.com>
 <04c9eb5e-3395-05e6-f0cc-bc8f054a6031@intel.com> <CALPaoCjg-W3w8OKLHP_g6Evoo03fbgaOQZrGTLX6vdSLp70=SA@mail.gmail.com>
 <e4a77e0c-a31c-429b-9de9-3cadd704ca34@intel.com>
In-Reply-To: <e4a77e0c-a31c-429b-9de9-3cadd704ca34@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 5 Dec 2023 16:33:23 -0800
Message-ID: <CALPaoCiRD6j_Rp7ffew+PtGTF4rWDORwbuRQqH2i-cY5SvWQBg@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] x86/resctrl: Add resctrl_mbm_flush_cpu() to
 collect CPUs' MBM events
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On Tue, Dec 5, 2023 at 1:57=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 12/1/2023 12:56 PM, Peter Newman wrote:
> > On Tue, May 16, 2023 at 5:06=E2=80=AFPM Reinette Chatre
> >> I think it may be optimistic to view this as a replacement of a PQR wr=
ite.
> >> As you point out, that requires that a CPU switches between tasks with=
 the
> >> same CLOSID. You demonstrate that resctrl already contributes a signif=
icant
> >> delay to __switch_to - this work will increase that much more, it has =
to
> >> be clear about this impact and motivate that it is acceptable.
> >
> > We were operating under the assumption that if the overhead wasn't
> > acceptable, we would have heard complaints about it by now, but we
> > ultimately learned that this feature wasn't deployed as much as we had
> > originally thought on AMD hardware and that the overhead does need to
> > be addressed.
> >
> > I am interested in your opinion on two options I'm exploring to
> > mitigate the overhead, both of which depend on an API like the one
> > Babu recently proposed for the AMD ABMC feature [1], where a new file
> > interface will allow the user to indicate which mon_groups are
> > actively being measured. I will refer to this as "assigned" for now,
> > as that's the current proposal.
> >
> > The first is likely the simpler approach: only read MBM event counters
> > which have been marked as "assigned" in the filesystem to avoid paying
> > the context switch cost on tasks in groups which are not actively
> > being measured. In our use case, we calculate memory bandwidth on
> > every group every few minutes by reading the counters twice, 5 seconds
> > apart. We would just need counters read during this 5-second window.
>
> I assume that tasks within a monitoring group can be scheduled on any
> CPU and from the cover letter of this work I understand that only an
> RMID assigned to a processor can be guaranteed to be tracked by hardware.
>
> Are you proposing for this option that you keep this "soft RMID" approach
> with CPUs  permanently assigned a "hard RMID" but only update the counts =
for a
> "soft RMID" that is "assigned"?

Yes

> I think that means that the context
> switch cost for the monitored group would increase even more than with th=
e
> implementation in this series since the counters need to be read on conte=
xt
> switch in as well as context switch out.
>
> If I understand correctly then only one monitoring group can be measured
> at a time. If such a measurement takes 5 seconds then theoretically 12 gr=
oups
> can be measured in one minute. It may be possible to create many more
> monitoring groups than this. Would it be possible to reach monitoring
> goals in your environment?

We actually measure all of the groups at the same time, so thinking
about this more, the proposed ABMC fix isn't actually a great fit: the
user would have to assign all groups individually when a global
setting would have been fine.

Ignoring any present-day resctrl interfaces, what we minimally need is...

1. global "start measurement", which enables a
read-counters-on-context switch flag, and broadcasts an IPI to all
CPUs to read their current count
2. wait 5 seconds
3. global "end measurement", to IPI all CPUs again for final counts
and clear the flag from step 1

Then the user could read at their leisure all the (frozen) event
counts from memory until the next measurement begins.

In our case, if we're measuring as often as 5 seconds for every
minute, that will already be a 12x aggregate reduction in overhead,
which would be worthwhile enough.

>
> >
> > The second involves avoiding the situation where a hardware counter
> > could be deallocated: Determine the number of simultaneous RMIDs
> > supported, reduce the effective number of RMIDs available to that
> > number. Use the default RMID (0) for all "unassigned" monitoring
>
> hmmm ... so on the one side there is "only the RMID within the PQR
> register can be guaranteed to be tracked by hardware" and on the
> other side there is "A given implementation may have insufficient
> hardware to simultaneously track the bandwidth for all RMID values
> that the hardware supports."
>
> From the above there seems to be something in the middle where
> some subset of the RMID values supported by hardware can be used
> to simultaneously track bandwidth? How can it be determined
> what this number of RMID values is?

In the context of AMD, we could use the smallest number of CPUs in any
L3 domain as a lower bound of the number of counters.

If the number is actually higher, it's not too difficult to probe at
runtime. The technique used by the test script[1] reliably identifies
the number of counters, but some experimentation would be needed to
see how quickly the hardware will repurpose a counter, as the script
today is using way too long of a workload for the kernel to be
invoking.

Maybe a reasonable compromise would be to initialize the HW counter
estimate at the CPUs-per-domain value and add a file node to let the
user increase it if they have better information. The worst that can
happen is the present-day behavior.

>
> > groups and report "Unavailable" on all counter reads (and address the
> > default monitoring group's counts being unreliable). When assigned,
> > attempt to allocate one of the remaining, usable RMIDs to that group.
> > It would only be possible to assign all event counters (local, total,
> > occupancy) at the same time. Using this approach, we would no longer
> > be able to measure all groups at the same time, but this is something
> > we would already be accepting when using the AMD ABMC feature.
>
> It may be possible to turn this into a "fake"/"software" ABMC feature,
> which I expect needs to be renamed to move it away from a hardware
> specific feature to something that better reflects how user interacts
> with system and how the system responds.

Given the similarities in monitoring with ABMC and MPAM, I would want
to see the interface generalized anyways.


>
> >
> > While the second feature is a lot more disruptive at the filesystem
> > layer, it does eliminate the added context switch overhead. Also, it
>
> Which changes to filesystem layer are you anticipating?

Roughly speaking...

1. The proposed "assign" interface would have to become more indirect
to avoid understanding how assign could be implemented on various
platforms.
2. RMID management would have to change, because this would introduce
the option where creating monitoring groups no longer allocates an
RMID. It may be cleaner for the
filesystem to just track whether a group has allocated monitoring
resources or not and let a lower layer understand what the resources
actually are. (and in the default mode, groups can only be created
with pre-allocated resources)

If I get the impression that this is the better approach, I'll build a
prototype on top of the ABMC patches to see how it would go.

So far it seems only the second approach (software ABMC) really ties
in with Babu's work.

Thanks!
-Peter

[1] https://lore.kernel.org/all/20230421141723.2405942-2-peternewman@google=
.com/
