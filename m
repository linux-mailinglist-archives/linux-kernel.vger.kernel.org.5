Return-Path: <linux-kernel+bounces-15360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 405CB822AA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A5228560C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA30718650;
	Wed,  3 Jan 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELqwN5jC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16118AE9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704275704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUNMQ79ogrC/YGcsiAtw5PoRN1iC6K0qxqbshfQSuLQ=;
	b=ELqwN5jC7+uZinrgv+27IHEpPYAv9s/U/SP5HeXtdfeqUc2gvO1W0VSu1tC0gvHN5Xu8zb
	eTAEbQb0gD6CRfzLXtO0Ojg6bzFFkb3is+ovxCrgGrEvOMZw91Bs0CZf41hyS++Z1/Y+nD
	Gu+QjNaN3oN+Q1vsK/BPC+WbuwYHUvk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-h7RY3pU6NyeMHTDh5NVNfg-1; Wed, 03 Jan 2024 04:55:03 -0500
X-MC-Unique: h7RY3pU6NyeMHTDh5NVNfg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2cd11ec6159so9549321fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 01:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275700; x=1704880500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUNMQ79ogrC/YGcsiAtw5PoRN1iC6K0qxqbshfQSuLQ=;
        b=mRF+6LfsdAr0dvv5KanGPTwAu9zlt9Tc+Ds/iBUSwxxGRoYGYR8CgMn2gY0xyhnuBy
         IRm6EeQmwiUikKWRniZ2lDcoxE6TesnJmUxuB9fbyvVlbIvwRYBHywnTmCRLzKcy41wZ
         bb28C6PZ3jjSG1Sgzz29HkSmiseKDZX8oLVKhVsiqwLJ5wWFfMeBWPkKr9NhVXvOpgD0
         oEXBzep1ZJ1sK1mCgvrTqRdU1f48wkBFiu6FN3BCxUlMNPW0eDKWNQCx+Hh3Wii5JydF
         9jgfWTv6H1BuQRdkvVGwGkt2yWfIy2rsLVitOoKaUnUmp3X9PfueQwh7TjvPpptIJLlX
         5VSg==
X-Gm-Message-State: AOJu0YyCudnqUr5si9w75jKZeUvz1JJ9RAgP8Jx8OjgRvAB0c9LG0ehA
	Hcm4AxizI+TYICJXixYMS44L31LdIfJPUjdYQiyrpgom9lPmbYYSn24VfbuJCg8vIpNFeS9pCi8
	Zl9hoCNI2+n6usScrvG9P5s1LbdBGEt6Kxt9jpfB9
X-Received: by 2002:a19:651a:0:b0:50e:6a96:657c with SMTP id z26-20020a19651a000000b0050e6a96657cmr7716549lfb.4.1704275700636;
        Wed, 03 Jan 2024 01:55:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV2/ennabRRyL0nw5vU1t4bSn0h/fthL/itke0lGCeclSL3s6i3v2o/BdZZXVAyeBMd0adYQ==
X-Received: by 2002:a19:651a:0:b0:50e:6a96:657c with SMTP id z26-20020a19651a000000b0050e6a96657cmr7716531lfb.4.1704275700293;
        Wed, 03 Jan 2024 01:55:00 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b0040d62f97e3csm1787153wmq.10.2024.01.03.01.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 01:54:59 -0800 (PST)
Date: Wed, 3 Jan 2024 10:54:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, lenb@kernel.org,
 bhelgaas@google.com, mika.westerberg@linux.intel.com,
 boris.ostrovsky@oracle.com, joe.jin@oracle.com, stable@vger.kernel.org,
 Fiona Ebner <f.ebner@proxmox.com>, Thomas Lamprecht
 <t.lamprecht@proxmox.com>
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging
 multiple devices at a time
Message-ID: <20240103105458.1f548f33@imammedo.users.ipa.redhat.com>
In-Reply-To: <a8db0ed6-05f4-7c2d-c63e-5f2976d25a45@oracle.com>
References: <20231213003614.1648343-1-imammedo@redhat.com>
	<20231213003614.1648343-3-imammedo@redhat.com>
	<CAJZ5v0gowV0WJd8pjwrDyHSJPvwgkCXYu9bDG7HHfcyzkSSY6w@mail.gmail.com>
	<CAMLWh55dr2e_R+TYVj=8cFfV==D-DfOZvAeq9JEehYs3nw6-OQ@mail.gmail.com>
	<20231213115248-mutt-send-email-mst@kernel.org>
	<a8db0ed6-05f4-7c2d-c63e-5f2976d25a45@oracle.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Dec 2023 09:09:18 -0800
Dongli Zhang <dongli.zhang@oracle.com> wrote:

> Hi Igor,
>=20
> On 12/13/23 08:54, Michael S. Tsirkin wrote:
> > On Wed, Dec 13, 2023 at 05:49:39PM +0100, Igor Mammedov wrote: =20
> >> On Wed, Dec 13, 2023 at 2:08=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote: =20
> >>>
> >>> On Wed, Dec 13, 2023 at 1:36=E2=80=AFAM Igor Mammedov <imammedo@redha=
t.com> wrote: =20
> >>>>
> >>>> previous commit ("PCI: acpiphp: enable slot only if it hasn't been e=
nabled already"
> >>>> introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job =
and
> >>>> bridge reconfiguration in case of single HBA hotplug.
> >>>> However in virt environment it's possible to pause machine hotplug s=
everal
> >>>> HBAs and let machine run. That can hit the same race when 2nd hotplu=
gged
> >>>> HBA will start re-configuring bridge.
> >>>> Do the same thing as SHPC and throttle down hotplug of 2nd and up
> >>>> devices within single hotplug event.
> >>>>
> >>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>>> ---
> >>>>  drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
> >>>>  1 file changed, 6 insertions(+)
> >>>>
> >>>> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplu=
g/acpiphp_glue.c
> >>>> index 6b11609927d6..30bca2086b24 100644
> >>>> --- a/drivers/pci/hotplug/acpiphp_glue.c
> >>>> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> >>>> @@ -37,6 +37,7 @@
> >>>>  #include <linux/mutex.h>
> >>>>  #include <linux/slab.h>
> >>>>  #include <linux/acpi.h>
> >>>> +#include <linux/delay.h>
> >>>>
> >>>>  #include "../pci.h"
> >>>>  #include "acpiphp.h"
> >>>> @@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *d=
ev)
> >>>>  static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> >>>>  {
> >>>>         struct acpiphp_slot *slot;
> >>>> +        int nr_hp_slots =3D 0;
> >>>>
> >>>>         /* Bail out if the bridge is going away. */
> >>>>         if (bridge->is_going_away)
> >>>> @@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp=
_bridge *bridge)
> >>>>
> >>>>                         /* configure all functions */
> >>>>                         if (slot->flags !=3D SLOT_ENABLED) {
> >>>> +                               if (nr_hp_slots)
> >>>> +                                       msleep(1000); =20
> >>>
> >>> Why is 1000 considered the most suitable number here?  Any chance to
> >>> define a symbol for it? =20
> >>
> >> Timeout was borrowed from SHPC hotplug workflow where it apparently
> >> makes race harder to reproduce.
> >> (though it's not excuse to add more timeouts elsewhere)
> >> =20
> >>> And won't this affect the cases when the race in question is not a co=
ncern? =20
> >>
> >> In practice it's not likely, since even in virt scenario hypervisor wo=
n't
> >> stop VM to hotplug device (which beats whole purpose of hotplug).
> >>
> >> But in case of a very slow VM (overcommit case) it's possible for
> >> several HBA's to be hotplugged by the time acpiphp gets a chance
> >> to handle the 1st hotplug event. SHPC is more or less 'safe' with its
> >> 1sec delay.
> >> =20
> >>> Also, adding arbitrary timeouts is not the most robust way of
> >>> addressing race conditions IMV.  Wouldn't it be better to add some
> >>> proper synchronization between the pieces of code that can race with
> >>> each other? =20
> >>
> >> I don't like it either, it's a stop gap measure to hide regression on
> >> short notice,
> >> which I can fixup without much risk in short time left, before folks
> >> leave on holidays.
> >> It's fine to drop the patch as chances of this happening are small.
> >> [1/2] should cover reported cases.
> >>
> >> Since it's RFC, I basically ask for opinions on a proper way to fix
> >> SCSI_ASYNC_SCAN
> >> running wild while the hotplug is in progress (and maybe SCSI is not
> >> the only user that
> >> schedules async job from device probe). =20
> >=20
> > Of course not. And things don't have to be scheduled from probe right?
> > Can be triggered by an interrupt or userspace activity. =20
>=20
> I agree with Michael. TBH, I am curious if the two patches can
> workaround/resolve the issue.
>=20
> Would you mind helping explain if to run enable_slot() for a new PCI devi=
ce can
> impact the other PCI devices existing on the bridge?
>=20
> E.g.,:
>=20
> 1. Attach several virtio-scsi or virtio-net on the same bridge.
>=20
> 2. Trigger workload for those PCI devices. They may do mmio write to kick=
 the
> doorbell (to trigger KVM/QEMU ioeventfd) very frequently.
>=20
> 3. Now hot-add an extra PCI device. Since the slot is never enabled, it e=
nables
> the slot via enable_slot().
>=20
> Can I assume the last enable_slot() will temporarily re-configure the bri=
dge
> window so that all other PCI devices' mmio will lose effect at that time =
point?

That's likely what would happen.
The same issue should apply to native PCIe and SHPC hotplug, as they also u=
se
pci_assign_unassigned_bridge_resources().

Perhaps drivers have to be taught that PCI tree is being reconfigured or so=
me
another approach can be used to deal with it.
Do you have any ideas?

I'm comparing with Windows guest, which manages to reconfigure PCI hierarchy
on the fly. (though I haven't tested that under heavy load with several
devices on a bridge).

> Since drivers always kick the doorbell conditionally, they may hang forev=
er.
>=20
> As I have reported, we used to have the similar issue.
>=20
> PCI: Probe bridge window attributes once at enumeration-time
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D51c48b310183ab6ba5419edfc6a8de889cc04521
>=20
>=20
> Therefore, can I assume the issue is not because to re-enable an already-=
enabled
> slot, but to touch the bridge window for more than once?
>=20
> Thank you very much!
>=20
> Dongli Zhang
>=20
> >  =20
> >> So adding synchronisation and testing
> >> would take time (not something I'd do this late in the cycle).
> >>
> >> So far I'm thinking about adding rw mutex to bridge with the PCI
> >> hotplug subsystem
> >> being a writer while scsi scan jobs would be readers and wait till hot=
plug code
> >> says it's safe to proceed.
> >> I plan to work in this direction and give it some testing, unless
> >> someone has a better idea. =20
> >  =20
> >>> =20
> >>>> +
> >>>> +                                ++nr_hp_slots;
> >>>>                                 enable_slot(slot, true);
> >>>>                         }
> >>>>                 } else {
> >>>> -- =20
> >>> =20
> >  =20
>=20


