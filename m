Return-Path: <linux-kernel+bounces-27308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC5182ED98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606041C23185
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FB61B800;
	Tue, 16 Jan 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxRBiHaT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32E1B7F6;
	Tue, 16 Jan 2024 11:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4C4C433F1;
	Tue, 16 Jan 2024 11:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705404141;
	bh=pxP6kZv9ytPstZGRD22UiO+Ci1ckJxrjLNHjcSdMk0k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CxRBiHaT+5wMIoFzzNgTZCojezrVW8JekUEKP1bSSyLImCEDyV8MbF+vcumBFlTux
	 tF5y3kdxgLK+TWy/CuOorQBh6A9HAD3hIAJboRrLF13BF4BL5yAvi4mF06Qwl3pIzT
	 x2AEFdD7B+zi8DTe7rnKC+cyqdm3qgcKaAXHKFOwAcDLcmcTX+PNJ+5lH8LP79LFo/
	 MLR72w9zGPYbZZsdltxajq1zglS24z7aG6+a8lCOIxtjLA09lVRT4mULfw6y4sKIWb
	 czw/htlLY61f7j576zJ7UNqjQxx/AHmGz3QV/lWpBb/vY0/5jXtx+Vz9Ub1t0RlUXR
	 r3qEREwmqJTMw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2041e117abaso4991612fac.0;
        Tue, 16 Jan 2024 03:22:21 -0800 (PST)
X-Gm-Message-State: AOJu0Yw3ZglFXuO6JFKYu5OabWhVjvuLDDlGDSnE7mzkUADgBmYfsjgp
	3y9+LP47NEqzkdrsUnND7TswhuKus9F4FXyc/8c=
X-Google-Smtp-Source: AGHT+IG4q1DjZqvWUrL5qi000PJiN6fQljf2ea6Ikx50ct4ZwO1TbVd6LnohzUyOLwcxR7i+y5W3n3WektV8rZVcbP4=
X-Received: by 2002:a05:6871:e00e:b0:204:1635:5ec5 with SMTP id
 by14-20020a056871e00e00b0020416355ec5mr6258252oac.79.1705404140694; Tue, 16
 Jan 2024 03:22:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c2adb439-0dea-4de1-996e-5a0caa5c729d@alu.unizg.hr>
 <ZaALOOhEdBP70lDH@bergen.fjasle.eu> <827b5e97-a436-47a7-a097-13657bcda948@alu.unizg.hr>
 <CAK7LNAToNP0hFvhzr_gYw6TXMxkJuCN4idWZvqmq3mSTNOHtSQ@mail.gmail.com>
 <b83bf78d-5fb0-4069-a1bb-c6a946b7b23c@alu.unizg.hr> <CAK7LNASCuuaO9tx44dbeS=deL-1Lvgy3REyC3FsVhfCmtWdB=w@mail.gmail.com>
 <b2acb406-11cb-4f5e-a924-e1f75a7f674c@alu.unizg.hr>
In-Reply-To: <b2acb406-11cb-4f5e-a924-e1f75a7f674c@alu.unizg.hr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Jan 2024 20:21:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR73NVGhE_UCwtsSfb6men=D9cy3t-8fPM-m1WaCogdqA@mail.gmail.com>
Message-ID: <CAK7LNAR73NVGhE_UCwtsSfb6men=D9cy3t-8fPM-m1WaCogdqA@mail.gmail.com>
Subject: Re: [PROBLEM] Very long .deb package build times for bindeb-pkg build target
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Nicolas Schier <nicolas@fjasle.eu>, Mirsad Todorovac <mirsad.todorovac@alu.hr>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 6:09=E2=80=AFAM Mirsad Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> On 1/13/24 16:16, Masahiro Yamada wrote:
> > On Sat, Jan 13, 2024 at 8:28=E2=80=AFPM Mirsad Todorovac
> > <mirsad.todorovac@alu.unizg.hr> wrote:
> >>
> >> On 1/13/24 06:40, Masahiro Yamada wrote:
> >>> On Fri, Jan 12, 2024 at 7:48=E2=80=AFAM Mirsad Todorovac
> >>> <mirsad.todorovac@alu.unizg.hr> wrote:
> >>>>
> >>>> On 11. 01. 2024. 16:37, Nicolas Schier wrote:
> >>>>> Hi Mirsad,
> >>>>>
> >>>>> On Thu 11 Jan 2024 13:22:39 GMT, Mirsad Todorovac wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> With this new release, it seems that Debian kernel build uses "xz"=
 in single-
> >>>>>> threaded mode:
> >>
> >> Hi, Masahiro,
> >>
> >> Thank you for your reply.
> >>
> >>> New release of what?
> >>
> >> Forgive me for not being precise. It was the new release of torvalds t=
ree mainline
> >> kernel 6.7+ (with merge commits up-to-date). I sort of mistakenly assu=
med that
> >> I wrote it, but it was declared in some mail on LKML.
> >
> > When you report a regression in the kernel code in the future,
> > please try to do "git bisect" and pin-point an offending commit.
> >
> > That is more helpful to figure out how to fix the issue.
> >
> > And, you will be sure whether or not the root cause exists
> > in the kernel.
>
> Good point. Thanks.
>
> But I did not notice any regression on Ubuntu 22.04 LTS system, and neith=
er on
> the Ubuntu 22.10 Mantic system which was upgraded. So I assumed it was no=
t related to
> particular commit, and I did not think of bisect.
>
> >> One environment was Ubuntu 23.10 Mantic Minotaur on the desktop at wor=
k.
> >>
> >> The laptop also has Mantic Minotaur, but for some reason it spawns mul=
tithreaded
> >> dpkg-deb when building packages, unlike desktop which spawned single-t=
hreaded "xz".
> >>
> >> This is at least what the "top" displayed when turning on "H" (show th=
reads).
> >>
> >> On one system (upgraded 23.10 from 22.04 LTS) the same dpkg-deb shows =
as multi-threaded
> >> dpkg-deb, while on the other it calls xz which didn't respect XT_OPT=
=3D-T0 (visible
> >> from the copy+paste from top output).
> >>
> >> I am perplexed myself.
> >>
> >>>>>> Tasks: 484 total,   2 running, 481 sleeping,   0 stopped,   1 zomb=
ie
> >>>>>> %Cpu(s):  2.5 us,  2.2 sy,  6.3 ni, 85.1 id,  2.3 wa,  0.0 hi,  1.=
7 si,  0.0 st
> >>>>>> MiB Mem :  64128.3 total,    524.3 free,   5832.0 used,  58540.9 b=
uff/cache
> >>>>>> MiB Swap:  32760.0 total,  32758.7 free,      1.2 used.  58296.3 a=
vail Mem
> >>>>>>
> >>>>>>       PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM    =
 TIME+
> >>>>>> COMMAND
> >>>>>>
> >>>>>>    978084 marvin    30  10  112440  97792   2432 R 100.0   0.1  29=
:30.23 xz
> >>>>>>
> >>>>>>
> >>>>>> Before dpkg-deb was using up to 3200% of CPU time on a 16 core SMT=
 CPU.
> >>>>>>
> >>>>>> Can it be something with dpkg-deb --thread-max=3D%n option?
> >>>>>
> >>>>> I cannot find any --thread-max option in Linux tree.  Do you call
> >>>>> dpkg-deb manually or somehow induce a thread maximum?
> >>>>>
> >>>>>> Waiting for half an hour just for the build of linux-image-...-dbg=
 package
> >>>>>> seems like an overkill ...
> >>>>>
> >>>>> With current v6.7 release tree I do not see the reported slow-downs
> >>>>> when building bindeb-pkg; I tested by cross-compiling for arm64 on
> >>>>> amd64 with CONFIG_MODULE_COMPRESS_XZ=3Dy and =3Dn).
> >>>>>
> >>>>> Both take roughly 5mins on my 24-core i9 system.
> >>>>>
> >>>>> Kind regards,
> >>>>> Nicolas
> >>>>
> >>>> I am perplexed too, but you can see from the top output the
> >>>> single-threaded xz with 29:30m processor time.
> >>>>
> >>>> On my laptop with the sam Ubuntu 23.10 mantic minotaur, I have
> >>>> dpkg-deb version 1.20.12 and it shows things like 400% and 3200%
> >>>> CPU time, so it is working multithreaded.
> >>>>
> >>>> On desktop machine with the same Ubuntu 23.10 and the same git
> >>>> torvalds tree, it starts single-threaded xz from dpkg-deb instead.
> >>>
> >>> You built the same mainline git tree on your laptop and desktop.
> >>> The former runs xz multi-threaded, the latter single-threaded.
> >>>
> >>> So, this is not about the kernel code, but about your environment,
> >>> isn't it?
> >>
> >> It should be. Somehow it doesn't behave rationally. To be true to the =
facts,
> >> one is 23.10 Mantic Minotaur upgraded from 22.04 LTS, and the other is
> >> fresh Mantic from install.
> >>
> >>> You mentioned you were using Ubuntu 23.10, where
> >>> dpkg-deb version is 1.22.0
> >>
> >> This is correct.
> >>
> >>> Your dpkg-deb version, 1.20.12, is too old for Ubuntu 23.10.
> >>> Is it a self-built one?
> >>
> >> Yes, it is the build from Debian 11 source package.
> >>
> >> This had the similar rationale because Ubuntu version ran single-threa=
ded.
> >>
> >> dpkg-deb from Debian 11 source package worked well for months.
> >>
> >>> dpkg-deb usually compresses binary packages, but the default
> >>> compression type depends on the distro.
> >>> (It is determined at "./configure" time)
> >>
> >> I see. But the home-built dpkg-deb also resorted to running "xz", and
> >> xz did not recognise XZ_OPT environment variable. Very odd. :-/
> >
> > It depends on the environment whether or not dpkg-deb
> > spawns the external 'xz' command.
> >
> > With WITH_LIBLZMA defined, dpkg-deb uses internal code
> > to compress the data with xz.  [1]
> >
> > Without WITH_LIBLZMA, dpkg-deb sparns "xz" processes. [2]
> >
> > [1]: https://salsa.debian.org/dpkg-team/dpkg/-/blob/1.20.12/lib/dpkg/co=
mpress.c?ref_type=3Dtags#L412
> > [2]: https://salsa.debian.org/dpkg-team/dpkg/-/blob/1.20.12/lib/dpkg/co=
mpress.c?ref_type=3Dtags#L663
> >
> > Since you said you saw "xz" in the "ps" command output,
> > I believe your case is the latter.
>
> Thanks for your insight. It is obviously a compile-time define.
>
> In previous build the defaults were apparently different. The Debian defa=
ulting to multi-threaded
> dpkg-deb was the exact reason why I did the hand build in the first place=
.
>
> In the long run, it saved an awful lot of time.
>
> But I can't see the logic of enforcing the single-threaded "xz" from dpkg=
-deg :-/
>
> > When dpkg-deb swarns the external "xz" command,
> > dpkg-deb unsets "XZ_OPT". [3]
> >
> > I believe that's why you do not see XZ_OPT propagated.
> >
> > [3]: https://salsa.debian.org/dpkg-team/dpkg/-/blob/1.20.12/lib/dpkg/co=
mpress.c?ref_type=3Dtags#L643
>
> Your insight really casts light on this. Now it is very clear.
>
> But IMHO single-threaded 30-min xz compression on a 16-core or 32-SMT mac=
hine is kind of weird.
> I wish there was something we could do about it.
>
> The same happened with the rpmbuild with similar defaults on Fedora. :-(
>
> >>> On Ubuntu, the default compression type for dpkg-deb is "zstd"
> >>> (while it is "xz" on Debian)
> >>>
> >>> Check "man dpkg-deb" on your Ubuntu machine.
> >>>
> >>>     -Zcompress=E2=80=90type
> >>>         Specify which compression type to use when building a package=
.
> >>>         Allowed values are gzip, xz (since dpkg 1.15.6),
> >>>         zstd (since dpkg 1.21.18) and none (default is zstd).
> >>
> >> Verified. "man dpkg-deb" confirms that.
> >>
> >>> You are still allowed to use xz with "make KDEB_COMPRESS=3Dxz deb-pkg=
".
> >>> Is this your case?
> >>
> >> Somehow, my Mantic's "xz" did not react to the environment variables. =
Maybe it is
> >> enchanted? :-/
> >>> Overall, your report is not sensible.
> >>
> >>> You should check what you are seeing.
> >>
> >> I was seeing exactly what I copy+pasted (top output). Give me the bene=
fit of doubt
> >> that I did not falsify copy+paste. Ideally, I should have submitted JP=
G terminal
> >> screenshot.
> >>
> >> Home-built dpkg-deb worked well on Ubuntu 22.04 LTS and 23.10 (upgrade=
d from 22.04).
> >> So it was a surprise that it started showing quirks on this new box wi=
th fresh 23.10
> >> from .iso.
> >>
> >> But I am only 16 months in the Linux kernel development, so it is prob=
ably my fault.
> >>
> >> I saw from the output of "ps xewww" that "xz" had "XZ_OPT=3D-T0", but =
it refused to obey
> >> the environment variable.
> >>
> >> This is probably worth digging and delving into to find the culprit, b=
ut eventually the
> >> workaround was the script manually prepending "--threads=3D0" to the p=
arameter list and
> >> calling system xz:
> >>
> >>          /usr/bin/xz --threads=3D0 "$@"
> >>
> >> Certainly, I need to establish "normality" before building complex ker=
nels and applying
> >> patches or the results will be non-reproducible and useless.
> >>
> >> I did the background search on your valuable contributions to the LK, =
but as we have this
> >> problem with the vanilla installation of Ubuntu, maybe we can think of=
 something to
> >> optimise the LK build time?
> >
> >
> > I do not think so.
> >
> > There already exists a solution to control the number of threads.
> >
> > See "man dpkg-deb"
> >
> >     DPKG_DEB_THREADS_MAX
> >         Sets the maximum number of threads allowed for compressors that
> >         support multi=E2=80=90threaded operations (since dpkg 1.21.9).
> >
> >         The --threads-max option overrides this value.
> > By setting this env variable, you should be able to control the multi-t=
hreading.
> >
> >
> > However, your dpkg-deb is 1.20.12, so you need to use a newer version.
> >
> > You locally hacked builddeb to add --threads-max, but it does not
> > work for you for the same reason; it requires dpkg 1.21.9+
> >
> >    --threads-max=3Dthreads
> >       Sets the maximum number of threads allowed for compressors that s=
upport
> >       multi=E2=80=90threaded operations (since dpkg 1.21.9).
> >
> > Why do you stick to the old home-built dpkg-deb?
> >
> > If you use the default dpkg-deb bundled with Ubuntu 23.10,
> > you will have a better experience.
>
> Yes, but I did it because Ubuntu dpkg-deb was single-threaded by default.=
 I did not
> know so many kbuild options at the time ...



No.

The dpkg-deb on Ubuntu works multi-threaded by default.

Just try /usr/bin/dpkg-deb installed by APT, then
you will see more than 100% CPU resources used.


With proper library installed, "./configure" for dpkg
should show:

  checking for lzma_stream_encoder_mt in -llzma... yes


With HAVE_LZMA_MT_ENCODER defined, filter_xz_get_cputhreads()
returns the number of threads to use.
The default is the number of available CPU cores.

[1]: https://salsa.debian.org/dpkg-team/dpkg/-/blob/main/lib/dpkg/compress.=
c?ref_type=3Dheads#L717












>
> > Or, if you still insist on a home-built dpkg-deb,
> > why don't you build a newer version?
>
> That's a good idea. But with Debian defaults, I suppose :-)
>
> Thank you for all your insight you provided, it really cleared a lot of d=
ubious things.
>
> Except that I thought I saw "XZ_OPT=3D-T0" in "ps xewww" environment list=
ing of the xz
> process itself. But right now I cannot access that box until Monday, so I=
 rest my case.
>
> IMHO, the build process should have optimal defaults. This would eventual=
ly reduce the
> load on the kbuild developers and maintainers, and increase overall user =
satisfaction.



As above, dpkg-deb works in parallel.

It is still possible to force the single-threading by "export
DPKG_DEB_THREADS_MAX=3D1",
but many people already benefit from multi-threaded compression, which is t=
he
default behavior on recent distributions.










>
> I will do what it takes, but for the real Linux newbies maybe it would be=
 more user-friendly
> to have the build system use all the cores out-of-the-box. But maybe not.
>
> There might be some cons to this, dunno. This way it is certainly more my=
stery ;-)
>
> Thanks again, and have a blessed weekend!
>
> Best regards,
> Mirsad
>
> >> To recall better from Thursday, I actually tried to prepend "XZ_OPT=3D=
--threads=3D0" to
> >> system xz, and it worked. But when called from dpkg-deb, it suddenly g=
ot amnesia, despite
> >> XZ_OPT=3D-T0 being seen in "ps xewww" output :-/
> >>
> >> I believe there should be a rational explanation rather than black or =
red magic.
> >>
> >> Thank you again for considering this problem report and have a nice we=
ekend!
> >>
> >> Best regards,
> >> Mirsad Todorovac
> >>
> >>>> I tried things like this:
> >>>>
> >>>> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> >>>> index d7dd0d04c70c..b2319c23db34 100755
> >>>> --- a/scripts/package/builddeb
> >>>> +++ b/scripts/package/builddeb
> >>>> @@ -38,7 +38,7 @@ create_package() {
> >>>>
> >>>>           # Fix ownership and permissions
> >>>>           if [ "$DEB_RULES_REQUIRES_ROOT" =3D "no" ]; then
> >>>> -               dpkg_deb_opts=3D"--root-owner-group"
> >>>> +               dpkg_deb_opts=3D"--threads-max=3D0 --root-owner-grou=
p"
> >>>>           else
> >>>>                   chown -R root:root "$pdir"
> >>>>           fi
> >>>>
> >>>> and it didn't work either - dpkg-deb --threads-max=3D0 still spawned=
 a
> >>>> single-threaded xz that ran 30 minutes.
> >>>>
> >>>> Then the workaround was a very simple xz shell script that adds opti=
on --threads=3D0
> >>>> and calls system xz:
> >>>>
> >>>> ~/bin/xz:
> >>>> ----------------------------------------------------------------
> >>>> #!/bin/bash -f
> >>>>
> >>>> /usr/bin/xz --threads=3D0 "$@"
> >>>> ----------------------------------------------------------------
> >>>>
> >>>> This finally worked, but sometimes I get:
> >>>>
> >>>> marvin@defiant:~/linux/kernel$ xz -9 --memlimit-compress=3D8000MiB l=
inux-image-6.7.0-rc8-dbg_6.7.0-rc8-6_amd64.deb
> >>>> /usr/bin/xz: Reduced the number of threads from 8 to 6 to not exceed=
 the memory usage limit of 8000 MiB
> >>>>
> >>>> (This is of course just an example of compressing a large file, as .=
deb is already compressed.)
> >>>>
> >>>> I used the default Ubuntu 23.10 config, with .pems excluded, and I t=
hink module compression
> >>>> did not work either. I had to turn it off ...
> >>>>
> >>>> Hope this helps.
> >>>>
> >>>> Regards,
> >>>> Mirsad
> >>>>
> >>>> --
> >>>> Mirsad Goran Todorovac
> >>>> Sistem in=C5=BEenjer
> >>>> Grafi=C4=8Dki fakultet | Akademija likovnih umjetnosti
> >>>> Sveu=C4=8Dili=C5=A1te u Zagrebu
> >>>>
> >>>> System engineer
> >>>> Faculty of Graphic Arts | Academy of Fine Arts
> >>>> University of Zagreb, Republic of Croatia
> >>>> The European Union
> >>>>
> >>>> "I see something approaching fast ... Will it be friends with me?"
> >>>>
> >>>>
> >>>
> >>>
> >
> >
> >
>


--=20
Best Regards
Masahiro Yamada

