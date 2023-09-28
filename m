Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794797B120B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjI1F0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjI1F0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:26:09 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A263C18F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:26:06 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d84f18e908aso13719424276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695878766; x=1696483566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jUcNRKitwfZeZzDUwjkycYSF032UWMQ4DC1PKmCGsM=;
        b=Tihdztbf5FzidbrWEp1VE3+y1TL9rrOdgk5e0A5pN6xx2r2DxC/zlWKgniGA1DeS3l
         IXFXL3VqmRFHHyXiLQktcGLNif1bkKsUVHgXgB+VHJmeaFN2YLferHf5O8bexV2XyKtq
         qPoWI4pwpIQdjDn5Hu0ff4ziUkgg9lAn9Vs8Tdw+uNynqhgU2DLG/g2cRmJPwtM593y6
         YvBglsZZMSCfy/fhwMgj19Km+yEtJ+/bR9LXJA2fRoegAB/ufc9lBGq8236QfJLdD2/8
         2GmS7uxCSjbXa4CyU7lM+NTdeMaAbH4v55AtqHWwLX9kDs1RiwbncphfaAGW4KM8M7Iz
         Em0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695878766; x=1696483566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jUcNRKitwfZeZzDUwjkycYSF032UWMQ4DC1PKmCGsM=;
        b=T7EAlWea36WoTT12AfE7xQ+6aslgNiU2l4q/QIT8He65NNx5dlhx9z0iWy6RdtFGI1
         VIBf9y3KiQH0OE0+dHCezhCZP7n/tdGdAFxjPS0Wh4O2Wnj/jU6JNwprgIUI8gNZkaD/
         cmNq21yyeY8rAS5l/+OUBUfCXbRdb/ugOmPy1vls4edLSbCa1HPAMBpLg0H5EeN17Ztw
         Ms66idHZV3PtIVOEWO9+HL33vs7o3B3hxsvQ6H11E9XScsl+N11/HkfzcW9++RtgJ1mT
         yHuDhE7Tsk2xKNS8EdrL+Mp30aasJqox39a1mMepuQCNcsgLinZcHhDMODVuGHrQgqQv
         Ko9A==
X-Gm-Message-State: AOJu0YwyKbC5QCtWRBtX2v2nY00JzSktY1VPNTp+Qp/leJ/e6xJcBN9c
        m1+tRMgvcxQ6rWHmJhs1ST7w2kApzC/jY9hhurTTuQ==
X-Google-Smtp-Source: AGHT+IF89Wjz0txe77zXKboWBgQ0CWnIokkCJcdokbLP4Hi9a9DBk/9KCIQ1qBNaRRGMr6yPXEj4PFNnQ5FCi+NDnts=
X-Received: by 2002:a25:b10f:0:b0:d7e:dd21:9b16 with SMTP id
 g15-20020a25b10f000000b00d7edd219b16mr228934ybj.8.1695878765555; Wed, 27 Sep
 2023 22:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230915172818.761-1-shiju.jose@huawei.com> <20230915172818.761-3-shiju.jose@huawei.com>
 <CACw3F50jRzJnr9h7qYyD3t+6h7Uw9QMfkCkgu7a=7Lv0Tpi8Zg@mail.gmail.com> <20230922111740.000046d7@huawei.com>
In-Reply-To: <20230922111740.000046d7@huawei.com>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Wed, 27 Sep 2023 22:25:52 -0700
Message-ID: <CACw3F539gZc0FoJLo6VvYSyZmeWZ3Pbec7AzsH+MYUJJNzQbUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries
 for set of scrub attributes
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Luck, Tony" <tony.luck@intel.com>, dave.hansen@linux.intel.com,
        jon.grimm@amd.com, vilas.sridharan@amd.com
Cc:     linuxarm@huawei.com, shiju.jose@huawei.com,
        David Rientjes <rientjes@google.com>,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        naoya.horiguchi@nec.com, james.morse@arm.com, david@redhat.com,
        jthoughton@google.com, somasundaram.a@hpe.com,
        erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
        mike.malvestuto@intel.com, gthelen@google.com,
        tanxiaofei@huawei.com, prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 3:20=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 21 Sep 2023 17:07:04 -0700
> Jiaqi Yan <jiaqiyan@google.com> wrote:
>
> > On Fri, Sep 15, 2023 at 10:29=E2=80=AFAM <shiju.jose@huawei.com> wrote:
> > >
> > > From: Shiju Jose <shiju.jose@huawei.com>
> > >
> > > Add sysfs documentation entries for the set of attributes those are
> > > exposed in /sys/class/scrub/ by the scrub driver. These attributes
> > > support configuring parameters of a scrub device.
> > >
> > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > > ---
> > >  .../ABI/testing/sysfs-class-scrub-configure   | 82 +++++++++++++++++=
++
> > >  1 file changed, 82 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-confi=
gure
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/=
Documentation/ABI/testing/sysfs-class-scrub-configure
> > > new file mode 100644
> > > index 000000000000..347e2167dc62
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
> > > @@ -0,0 +1,82 @@
> > > +What:          /sys/class/scrub/
> > > +Date:          September 2023
> > > +KernelVersion: 6.7
> > > +Contact:       linux-kernel@vger.kernel.org
> > > +Description:
> > > +               The scrub/ class subdirectory belongs to the
> > > +               scrubber subsystem.
> > > +
> > > +What:          /sys/class/scrub/scrubX/
> > > +Date:          September 2023
> > > +KernelVersion: 6.7
> > > +Contact:       linux-kernel@vger.kernel.org
> > > +Description:
> > > +               The /sys/class/scrub/scrub{0,1,2,3,...} directories
> >
> > This API (sysfs interface) is very specific to the ACPI interface
> > defined for hardware patrol scrubber. I wonder can we have some
> > interface that is more generic, for a couple of reasons:
>
> Agreed that it makes sense to define a broad interface.  We have
> some hardware focused drivers we can't share yet (IP rules until
> a release date in the near future) where this is a reasonable fit
> - but indeed there are others such as mapping this to DDR ECS
> where it isn't a great mapping.
>
> I'd love to come up with an interface that has the right blend
> of generality and flexibility.  That is easiest done before we have
> any implementation merged.
>
> >
> > 1. I am not aware of any chip/platform hardware that implemented the
> > hw ps part defined in ACPI RASF/RAS2 spec. So I am curious what the
> > RAS experts from different hardware vendors think about this. For
> > example, Tony and Dave from Intel, Jon and Vilas from AMD. Is there
> > any hardware platform (if allowed to disclose) that implemented ACPI
> > RASF/RAS2? If so, will vendors continue to support the control of
> > patrol scrubber using the ACPI spec? If not (as Tony said in [1], will
> > the vendor consider starting some future platform?
> >
> > If we are unlikely to get the vendor support, creating this ACPI
> > specific sysfs API (and the driver implementations) in Linux seems to
> > have limited meaning.
>
> There is a bit of a chicken and egg problem here. Until there is
> reasonable support in kernel (or it looks like there will be),
> BIOS teams push back on a requirement to add the tables.
> I'd encourage no one to bother with RASF - RAS2 is much less
> ambiguous.

Here mainly to re-ping folks from Intel (Tony and Dave)  and AMD (Jon
and Vilas) for your opinion on RAS2.

>
> >
> > > +               correspond to each scrub device.
> > > +
> > > +What:          /sys/class/scrub/scrubX/name
> > > +Date:          September 2023
> > > +KernelVersion: 6.7
> > > +Contact:       linux-kernel@vger.kernel.org
> > > +Description:
> > > +               (RO) name of the memory scrub device
> > > +
> > > +What:          /sys/class/scrub/scrubX/regionY/
> >
> > 2. I believe the concept of "region" here is probably from
> > PATROL_SCRUB defined in =E2=80=9CAPCI section 5.2.20.5. Parameter Block=
". It
> > is indeed powerful: if a process's physical memory spans over multiple
> > memory controllers, OS can in theory scrub chunks of the memory
> > belonging to the process. However, from a previous discussion [1],
> > "From a h/w perspective it might always be complex". IIUC, the address
> > translation from physical address to channel address is hard to
> > achieve, and probably that's one of the tech reasons the patrol scrub
> > ACPI spec is not in practice implemented?
>
> Next bit is kind of an aside as I mostly agree with your conclusions ;)
>
> This obviously depends on your memory interleave. You want to present
> physical address ranges as single controllable regions - probably
> most interesting being stuff that maps to NUMA nodes.  The short
> answer is that any firmware control will end up writing to all the
> memory controllers involved in a given PA range - firmware can easily
> establish which those are.
>
> A memory controller can support multiple scrub regions
> which map from a PA range to a particular set of RAM addresses
> - that's implementation specific. The memory controller is getting
> the host PA and can carry out appropriate hashing if it wants to.
> Many scrub solutions won't do this - in which case it's max one
> region per memory controller (mapped by firmware to one region per
> interleave set - assuming interleave sets take in whole memory
> controllers - which they normally do).
>
> I would expect existing systems (not design with this differentiated
> scrub in mind) to only support scrub control by PA range at the
> granularity of interleave sets.
>
> Note that this general question of PA based controls also
> maps to things like resource control (resctl) where it's only interesting
> to partition memory bandwidth such that the partition applies to the
> whole interleave set - that's done for ARM systems anyway by having
> the userspace interface pretend there is only one control, but
> write the settings to all actual controllers involved. Not sure what
> x86 does.
>
> Taking a few examples that I know of.  All 4 socket server - with
> control of these as bios options ;).
> Assuming individual memory controllers don't allow scrub to be
> configured by PA range.
>
> 1. Full system memory interleave (people do this form of crazy)
>    In that case, there is only one set of firmware controls
>    that write to the interfaces of every memory controller.  Depending
>    on the interleave design that may still allow multiple regions.
>
> 2. Socket wide memory interleave.  In that case, firmware controls
>    need to effect all memory controllers in that socket if the
>    requested 'region' maps to them.  So 4 PA regions.
>
> 3. Die wide memory interleave.  Finer granularity of control
>    so perhaps 8 PA rgiones.
>
> 4. Finer granularity (there are reasons to do this for above mentioned
>    bandwidth resource control which you can only do if not interleaving
>    across multiple controllers).
>
>
>
> >
> > So my take is, control at the granularity of the memory controller is
> > probably a nice compromise.
> > Both OS and userspace can get a pretty
> > decent amount of flexibility, start/stop/adjust speed of the scrubbing
> > on a memory controller; meanwhile it doesn't impose too much pain to
> > hardware vendors when they provide these features in hardware. In
> > terms of how these controls/features will be implemented, I imagine it
> > could be implemented:
> > * via hardware registers that directly or indirectly control on memory
> > controllers
> > * via ACPI if the situation changes in 10 years (and the RASF/RAS2/PCC
> > drivers implemented in this patchset can be directly plugged into)
> > * a kernel-thread that uses cpu read to detect memory errors, if
> > hardware support is unavailable or not good enough
> >
>
> I more or less agree, but would tweak a little.
>
> 1) Allow for multiple regions per memory controller - that's needed
>    for RASF etc anyway - because as far as they are concerned there
>    is only one interface presented.
> 2) Tie the interface to interleave sets, not memory controllers.
>    NUMA nodes often being a good stand in for those.

Does you mean /sys/devices/system/node/nodeX/scrub, where scrub is a
virtual concept of scrubbing device that mapps to 1 or several
physical scrubber backends.

For example, starting/stopping the virtual device means issuing
START/STOP cmd to all backends. And...

>    Controlling memory controllers separately for parts of an interleave
>    isn't something I'd think was very useful.  This will probably get
>    messy in the future though and the complexity could be pushed to
>    a userspace tool - as long as enough info is available elsewhere
>    in sysfs.  So need those memory controller directories you propose
>    to include info on the PA ranges that they are involved in backing

is it acceptable if we don't provide PA range or region in the
interface *for now* if it complicates things a lot? I could be wrong,
but the user of scrubber seems would be ok with not being able to
scrub an arbitrary physical address range. In contrast, not knowing
the scrub results seems to be more annoying to users. So simply giving
some progress indicator like how many bytes a scrubber has scrubbed.

When we really need to support PA range or region, under the
/sys/devices/system/node/nodeX/scrub interface, it basically uses NUMA
node X's PA range. Then to scrub node memory in range [PA1, PA2), some
driver that understand all backends (or can talk to all backends'
drivers) needs to translate the PA into the address in backend's
address space, for example, [PA1, PA2) is mapped to 2 device ranges
[DA11, DA12) on backend_1 and [DA21, DA22) on backend_2.

>    (which to keep things horrible, can change at runtime via memory
>     hotplug and remapping of host physical address ranges on CXL etc)

CXL memory locally attached to the host is probably more or less the
same as normal physical memory. I wonder what it would be like for CXL
memory remotely attached through a memory pool. Does it make sense
that the controller/owner of the memory pool takes the responsibility
of controlling the CXL memory controller to control scrubbing? Does
the owner need to provide/mediate scrubbing support for other clients
using the memory pool?

Thanks,
Jiaqi

>
> > Given these possible backends of scrubbing, I think a more generic
> > sysfs API that covers and abstracts these backends will be more
> > valuable right now. I haven=E2=80=99t thought thoroughly, but how about
> > defining the top-level interface as something like
> > =E2=80=9C/sys/devices/system/memory_controller_scrubX/=E2=80=9D, or
> > =E2=80=9C/sys/class/memory_controllerX/scrub=E2=80=9D?
>
> No particular harm in the rename of the directory I guess.
> Though some of those 'memory_controllers' would be virtual as they
> wouldn't correspond to actual memory controllers but rather to
> sets of them.
>
> Jonathan
>
> >
> > [1] https://lore.kernel.org/linux-mm/SJ1PR11MB6083BF93E9A88E659CED5EC4F=
C3F9@SJ1PR11MB6083.namprd11.prod.outlook.com/T/#m13516ee35caa05b506080ae805=
bee14f9f958d43
>
> >
> > > +Date:          September 2023
> > > +KernelVersion: 6.7
> > > +Contact:       linux-kernel@vger.kernel.org
> > > +Description:
> > > +               The /sys/class/scrub/scrubX/region{0,1,2,3,...}
> > > +               directories correspond to each scrub region under a s=
crub device.
> > > +               Scrub region is a physical address range for which sc=
rub may be
> > > +               separately controlled. Regions may overlap in which c=
ase the
> > > +               scrubbing rate of the overlapped memory will be at le=
ast that
> > > +               expected due to each overlapping region.
> > > +
> > > +What:          /sys/class/scrub/scrubX/regionY/addr_base
> > > +Date:          September 2023
> > > +KernelVersion: 6.7
> > > +Contact:       linux-kernel@vger.kernel.org
> > > +Description:
> > > +               (RW) The base of the address range of the memory regi=
on
> > > +               to be patrol scrubbed.
> > > +               On reading, returns the base of the memory region for
> > > +               the actual address range(The platform calculates
> > > +               the nearest patrol scrub boundary address from where
> > > +               it can start scrubbing).
> > > +
> > > +What:          /sys/class/scrub/scrubX/regionY/addr_size
> > > +Date:          September 2023
> > > +KernelVersion: 6.7
> > > +Contact:       linux-kernel@vger.kernel.org
> > > +Description:
> > > +               (RW) The size of the address range to be patrol scrub=
bed.
> > > +               On reading, returns the size of the memory region for
> > > +               the actual address range.
> > > +
> > > +What:          /sys/class/scrub/scrubX/regionY/enable
> > > +Date:          September 2023
> > > +KernelVersion: 6.7
> > > +Contact:       linux-kernel@vger.kernel.org
> > > +Description:
> > > +               (WO) Start/Stop scrubbing the memory region.
> > > +               1 - enable the memory scrubbing.
> > > +               0 - disable the memory scrubbing..
> > > +
> > > +What:          /sys/class/scrub/scrubX/regionY/speed_available
> > > +Date:          September 2023
> > > +KernelVersion: 6.7
> > > +Contact:       linux-kernel@vger.kernel.org
> > > +Description:
> > > +               (RO) Supported range for the partol speed(scrub rate)
> > > +               by the scrubber for a memory region.
> > > +               The unit of the scrub rate vary depends on the scrubb=
er.
> > > +
> > > +What:          /sys/class/scrub/scrubX/regionY/speed
> > > +Date:          September 2023
> > > +KernelVersion: 6.7
> > > +Contact:       linux-kernel@vger.kernel.org
> > > +Description:
> > > +               (RW) The partol speed(scrub rate) on the memory regio=
n specified and
> > > +               it must be with in the supported range by the scrubbe=
r.
> > > +               The unit of the scrub rate vary depends on the scrubb=
er.
> > > --
> > > 2.34.1
> > >
> > >
> >
>
>
