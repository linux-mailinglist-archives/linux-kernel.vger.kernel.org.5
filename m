Return-Path: <linux-kernel+bounces-121286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA988E4AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED1C1F26E20
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06C6131736;
	Wed, 27 Mar 2024 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHsjI+Fn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80182131197;
	Wed, 27 Mar 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542867; cv=none; b=BLznJS4ZJhs9ecvlhNBQsEWiMCz7nh1MjSYaO6F1P1RIcWTfK1W5MzitgdwLHNW+dyMby/EBp3zZgBrjXNWx+z/aJjmclAV+Zdy3FNlg2GbAirfvnIIxpqwjccIB1W3O3WrKKjk0T4LPUkKNH09c6IBMCjv78AIZ3dkuyffPbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542867; c=relaxed/simple;
	bh=8N3t+CDdKY3YFlH7oaNZFASNnUeM1RCAwnipRrhwJuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEusRmpZCL1wWq/9uu0RzKCGRqYlS5pAV8jLolZ/VXMEKxaPOg2/iHvSAtLI8Kn6em1hpukb/LyZk4rourhTqoZDNGbAV7tSOHuuUpv/saR79yzbjSs+h66UH/rEprv5Am7YIKrexqzNjV4kmhLgJb/l2HFu5kH7KoJZx8K0Htg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHsjI+Fn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5FEC433C7;
	Wed, 27 Mar 2024 12:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542866;
	bh=8N3t+CDdKY3YFlH7oaNZFASNnUeM1RCAwnipRrhwJuU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WHsjI+FniF8Z7sOkWvPE0p9O+aVYavDYf9XPeV+3iciywX8W/lv4HDbwn4U8bXqdu
	 t9UThFGat5QWDAEEdFSDMdFCP+83xuy0zQYv+kRkzTdAUSUPpaI5Pwo0PcGqXN7Z4h
	 AiB7QOBGfU1jUIPntJBDlxdKY36aoV9onQus2N40KzBrrZ00RAxG6NPutLTmiTOPev
	 VeDRcgqc0Urq5VRNUdFh2PRbE0Z4kFog0dNgD+pLz1Iu5FUQyT7hp8s860+MoyZIjp
	 J5r4PQuj6zm5I8zJ3F8uHkn5Bg43XW56RDrJFuL6Sk0ZKXbDmtENJM2UsCnTU4AlRW
	 VWyG3wXjQ1waQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d24a727f78so75601501fa.0;
        Wed, 27 Mar 2024 05:34:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPwcHeuTqI3GlLvlIDIoabS3WCBMTUbJ3LII8X/g5vUQDySb+fWRA9ya77tfpuYxt/ems9Ky2H+lDYMqueD0pIAPHr+ILruJtthgQpo8oC8BxKRxKOhcLNTKaJa3kFQIZrsFOuJs/7oADqmbEQJ6/U1cWZO9eY3MN24v5XZAvOdiii6MInvWx1g3FKkpzEFau/XDPjckdwBn7GXyYEBKOx
X-Gm-Message-State: AOJu0YwWZLs/t9gxnH/Fwzc0nHblwnaIU+hvWv2HqaGZ1ygtSv4D31v4
	i12aME69sRK24vw1MsHkylnxKZMrKMzRkXwxhGG8ViExQT/PMh80eURKzS5u/jfJ5Y1NjD3jT4G
	QFbhoHHa4LrcRmADsi+wNjz712w==
X-Google-Smtp-Source: AGHT+IGb/tvDk7BPc5ooPMe3vs21TSV/CGNkWTr1j3kZGhTSowTUtnyhhb9eTVfWHGXwW0jFHOVQ8E43Udn54x9e++k=
X-Received: by 2002:a2e:9c55:0:b0:2d6:c7e5:34d0 with SMTP id
 t21-20020a2e9c55000000b002d6c7e534d0mr4128198ljj.41.1711542844882; Wed, 27
 Mar 2024 05:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711048433.git.daniel@makrotopia.org> <20240325151046.GA3591150-robh@kernel.org>
 <ZgGaay6bLFAcCo2E@makrotopia.org> <20240326202449.GA3255378-robh@kernel.org> <ZgM-AR1BFU_FPaXh@makrotopia.org>
In-Reply-To: <ZgM-AR1BFU_FPaXh@makrotopia.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 27 Mar 2024 07:33:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKkr6Nnfwa5HevMhqmgsHDXvXMzMFSzw8tiu6Zwe353dg@mail.gmail.com>
Message-ID: <CAL_JsqKkr6Nnfwa5HevMhqmgsHDXvXMzMFSzw8tiu6Zwe353dg@mail.gmail.com>
Subject: Re: [PATCH 0/8] block: implement NVMEM provider
To: Daniel Golle <daniel@makrotopia.org>, 
	Architecture Mailman List <boot-architecture@lists.linaro.org>
Cc: Diping Zhang <diping.zhang@gl-inet.com>, Jianhui Zhao <zhaojh329@gmail.com>, 
	Jieying Zeng <jieying.zeng@gl-inet.com>, Chad Monroe <chad.monroe@adtran.com>, 
	Adam Fox <adam.fox@adtran.com>, John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Damien Le Moal <dlemoal@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, Christian Heusel <christian@heusel.eu>, Min Li <min15.li@samsung.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Avri Altman <avri.altman@wdc.com>, 
	Hannes Reinecke <hare@suse.de>, Christian Loehle <CLoehle@hyperstone.com>, Bean Huo <beanhuo@micron.com>, 
	Yeqi Fu <asuk4.q@gmail.com>, Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, 
	"Ricardo B. Marliere" <ricardo@marliere.net>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 4:29=E2=80=AFPM Daniel Golle <daniel@makrotopia.org=
> wrote:
>
> Hi Rob,
>
> On Tue, Mar 26, 2024 at 03:24:49PM -0500, Rob Herring wrote:
> > +boot-architecture list
>
> Good idea, thank you :)

Now really adding it. :(

Will reply to rest later.

> >
> > On Mon, Mar 25, 2024 at 03:38:19PM +0000, Daniel Golle wrote:
> > > On Mon, Mar 25, 2024 at 10:10:46AM -0500, Rob Herring wrote:
> > > > On Thu, Mar 21, 2024 at 07:31:48PM +0000, Daniel Golle wrote:
> > > > > On embedded devices using an eMMC it is common that one or more (=
hw/sw)
> > > > > partitions on the eMMC are used to store MAC addresses and Wi-Fi
> > > > > calibration EEPROM data.
> > > > >
> > > > > Implement an NVMEM provider backed by a block device as typically=
 the
> > > > > NVMEM framework is used to have kernel drivers read and use binar=
y data
> > > > > from EEPROMs, efuses, flash memory (MTD), ...
> > > > >
> > > > > In order to be able to reference hardware partitions on an eMMC, =
add code
> > > > > to bind each hardware partition to a specific firmware subnode.
> > > > >
> > > > > Overall, this enables uniform handling across practially all flas=
h
> > > > > storage types used for this purpose (MTD, UBI, and now also MMC).
> > > > >
> > > > > As part of this series it was necessary to define a device tree s=
chema
> > > > > for block devices and partitions on them, which (similar to how i=
t now
> > > > > works also for UBI volumes) can be matched by one or more propert=
ies.
> > > > >
> > > > > ---
> > > > > This series has previously been submitted as RFC on July 19th 202=
3[1]
> > > > > and most of the basic idea did not change since. Another round of=
 RFC
> > > > > was submitted on March 5th 2024[2] which has received overall pos=
itive
> > > > > feedback and only minor corrections have been done since (see
> > > > > changelog below).
> > > >
> > > > I don't recall giving positive feedback.
> > > >
> > > > I still think this should use offsets rather than partition specifi=
c
> > > > information. Not wanting to have to update the offsets if they chan=
ge is
> > > > not reason enough to not use them.
> > >
> > > Using raw offsets on the block device (rather than the partition)
> > > won't work for most existing devices and boot firmware out there. The=
y
> > > always reference the partition, usually by the name of a GPT
> > > partition (but sometimes also PARTUUID or even PARTNO) which is then
> > > used in the exact same way as an MTD partition or UBI volume would be
> > > on devices with NOR or NAND flash.
> >
> > MTD normally uses offsets hence why I'd like some alignment. UBI is
> > special because raw NAND is, well, special.
>
> I get the point and in a way this is also already intended and
> supported by this series. You can already just add an 'nvmem-layout'
> node directly to a disk device rather than to a partition and define a
> layout in this way.
>
> Making this useful in practice will require some improvements to the
> nvmem system in Linux though, because that currently uses signed 32-bit
> integers as addresses which is not sufficient for the size of the
> user-part of an eMMC. However, that needs to be done then and should
> of course not be read as an excuse.
>
> >
> > > Just on eMMC we usually use a GPT
> > > or MBR partition table rather than defining partitions in DT or cmdli=
ne,
> > > which is rather rare (for historic reasons, I suppose, but it is what=
 it
> > > is now).
> >
> > Yes, I understand how eMMC works. I don't understand why if you have
> > part #, uuid, or name you can't get to the offset or vice-versa. You
> > need only 1 piece of identification to map partition table entries to D=
T
> > nodes.
>
> Yes, either of them (or a combination) is fine. In practise I've mostly
> seen PARTNAME as identifier used in userland scripts, and only adding
> this for now will probably cover most devices (and existing boot firmware=
)
> out there. Notable exceptions are devices which are using MBR partitions
> because the BootROM expects the bootloader to be at the same block as
> we would usually have the primary GPT. In this case we can only use the
> PARTNO, of course, and it stinks.
> MediaTek's MT7623A/N is such an example, but it's a slingly outdated
> and pretty weird niche SoC I admit.
>
> > Sure, offsets can change, but surely the firmware can handle
> > adjusting the DT?
>
> Future firmware may be able to do this, of course. Current existing
> firmware already out there on devices such as the quite popular
> GL.iNet MT-6000, Netgear's Orbi and Orbi Pro series as well as all
> Adtran SmartRG devices does not. Updating or changing the boot
> firmware of devices already out there is not intended and quite
> challenging, and will make the device incompatible with its vendor
> firmware. Hence it would be better to support replacing only the
> Linux-based firmware (eg. with OpenWrt or even Debian or any
> general-purpose Linux, the eMMC is large enough...) while not having
> to touch the boot firmware (and risking to brick the device if that
> goes wrong).
>
> Personally, I'm rather burdened and unhappy with vendor attempts to
> have the boot firmware mess around too much in (highly customized,
> downstream) DT, it may look like a good solution at the moment, but
> can totally become an obstacle in an unpredictable future (no offense
> ASUS...)
>
> >
> > An offset would also work for the case of random firmware data on the
> > disk that may or may not have a partition associated with it. There are
> > certainly cases of that. I don't think we have much of a solution for
> > that other than trying to educate vendors to not do that or OS
> > installers only supporting installing to something other than eMMC. Thi=
s
> > is something EBBR[1] is trying to address.
>
> Absolutely. Actually *early* GL-iNet devices did exactly that: Use the
> eMMC boot hw-partitions to store boot firmware as well as MAC
> addresses and potentially also Wi-Fi calibration data.
>
> The MT-2500 is the example I'm aware of and got sitting on my desk for
> testing with this very series (which allows to also reference eMMC
> hardware partitions, see "[7/8] mmc: block: set fwnode of disk
> devices").
> Unfortunately later devices such the the flag-ship MT-6000 moved MAC
> addresses and WiFi-EEPROMs into a GPT partition on the user-part of
> the eMMC.
>
> >
> > > Depending on the eMMC chip used, that partition may not even be at th=
e
> > > same offset for different batches of the same device and hence I'd
> > > like to just do it in the same way vendor firmware does it as well.
> >
> > Often vendor firmware is not a model to follow...
>
> I totally agree. However, I don't see a good reason for not supporting
> those network-appliance-type embedded devices which even ship with
> (outdated, downstream) Linux by default while going through great
> lengths for things like broken ACPI tables in many laptops which
> require lots of work-arounds to have features like suspend-to-disk
> working, or even be able to run Linux at all.
>
> >
> > > Chad of Adtran has previously confirmed that [1], which was the
> > > positive feedback I was refering to. Other vendors like GL-iNet or
> > > Netgear are doing the exact same thing.
> > >
> > > As of now, we support this in OpenWrt by adding a lot of
> > > board-specific knowledge to userland, which is ugly and also prevents
> > > using things like PXE-initiated nfsroot on those devices.
> > >
> > > The purpose of this series is to be able to properly support such dev=
ices
> > > (ie. practially all consumer-grade routers out there using an eMMC fo=
r
> > > storing firmware).
> > >
> > > Also, those devices have enough resources to run a general purpose
> > > distribution like Debian instead of OpenWrt, and all the userland
> > > hacks to set MAC addresses and extract WiFi-EEPROM-data in a
> > > board-specific ways will most certainly never find their way into
> > > Debian. It's just not how embedded Linux works, unless you are lookin=
g
> > > only at the RaspberryPi which got that data stored in a textfile
> > > which is shipped by the distribution -- something very weird and very
> > > different from literally all of-the-shelf routers, access-points or
> > > switches I have ever seen (and I've seen many). Maybe Felix who has
> > > seen even more of them can tell us more about that.
> >
> > General purpose distros want to partition the disk themselves. Adding
> > anything to the DT for disk partitions would require the installer to b=
e
> > aware of it. There's various distro folks on the boot-arch list, so
> > maybe one of them can comment.
>
> Usually the installers are already aware to not touch partitions when
> unaware of their purpose. Repartitioning the disk from scratch is not
> what (modern) distributions are doing, at least the EFI System
> partition is kept, as well as typical rescue/recovery partitions many
> vendors put on their (Windows, Mac) laptops to allow to "factory
> reset" them.
>
> Installers usually offer to replace (or resize) the "large" partition
> used by the currently installed OS instead.
>
> And well, the DT reference to a partition holding e.g. MAC addresses
> does make the installer aware of it, obviously.
>
>
> Thank you for the constructive debate!
>
>
> Cheers
>
>
> Daniel
>
>
> >
> > Rob
> >
> > [1] https://arm-software.github.io/ebbr/index.html#document-chapter4-fi=
rmware-media

