Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EAD7FE157
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjK2Ut1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjK2Ut0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:49:26 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3ECD67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:49:30 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1fa20395185so69867fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701290969; x=1701895769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uCwSK8iy7hq3osg12qE4HhNLJBHsTSSsnJBjaB7nWDA=;
        b=KFmRiIubAAs+D2sejbyGBOEi+CV1iCQKWGPggpjiDOCYEtDYjkrOEIuNE0xhaJpY6D
         Gf6jx8dGgVwBq4l9+7Nbh0+prinrDMbhaVrAu0CcP31Z5dBpcKX9X3eZhvSoVrxmoAoB
         1v5zhM344rmPkqlHpZU5uFyYvZMEhyJqsSDNP991EGzSslSzFaNHJrcRRnjoF1+VXng1
         8V/Sz9F+Zn+EzwogtEsZmMDfVNiLWGr0G8fQwp8CiZA5qLKAua35Gj+OI0FP4V9bG1a8
         vMKgpBsk5EhoLPb91wyGXUsBQk6qj28/Lu3uQDWY98wJKzlpkchEwGFIprlS4Vv77vET
         GGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290969; x=1701895769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCwSK8iy7hq3osg12qE4HhNLJBHsTSSsnJBjaB7nWDA=;
        b=KuH+3Nm5kzlkCOfRKe3ejROemsDoODIRetDVBSYbT6e+LshpKzPcVWGtYTsFHOpMa1
         IfXsCVXbxqntiu6H+TKXEgkotgqWA4/5tCgGogJs56ASqwEailWu2Rwq/wXM1W/U7Quu
         4per3gpvkUcQ/eQ7JBD5MgCpxmMojSrtFt32hZ55m/OPKE84IWvvXkHgtnKkZv5A05ON
         Ajp+MlM8I0Y2L5sib/KE6FA0WsZRqUcFxcR20N+PguEIKLI+YKWd2goVgTwHYHsAezxM
         ZxBwxqkIIMZtfpxR/UPn5or0WadQIxdC+1Kdf7y4BjF7nm6twGDEyC4N7K3SGL2Ql9DV
         4O5w==
X-Gm-Message-State: AOJu0Ywm/nZJakiuWpXFOTBm46G94hUvR0y9BP1AxIt8wYObcFKg5XfL
        peToJFRvVScMRK2avPuasR49yA4v0K7zICGovIRFAN5r
X-Google-Smtp-Source: AGHT+IHyw8cAX9UfK9a8fY501yC2wNYtr22mgVoI8sSdazvxSzWX4/ffV64sBqiXIbZ1QzuNOcv1vH6FSPHW3piU2iY=
X-Received: by 2002:a05:6870:2328:b0:1f9:faa4:8bd6 with SMTP id
 w40-20020a056870232800b001f9faa48bd6mr21314446oao.17.1701290969390; Wed, 29
 Nov 2023 12:49:29 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com> <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com> <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net> <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
 <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com> <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
 <CADnq5_OC=JFpGcN0oGbTF5xYEt4X3r0=jEY6hJ12W8CzYq1+cA@mail.gmail.com>
 <9595b8bf-e64d-4926-9263-97e18bcd7d05@gmail.com> <CADnq5_N6DF-huOzgaVygvS5N_j_oNUEC1aa4zRsZTzx8GOD_aw@mail.gmail.com>
 <CADnq5_PgMxoW=4iabtgeHydwye-6DvwvCyETdfBToEpuYWocmA@mail.gmail.com>
In-Reply-To: <CADnq5_PgMxoW=4iabtgeHydwye-6DvwvCyETdfBToEpuYWocmA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Nov 2023 15:49:17 -0500
Message-ID: <CADnq5_P0S7Jem0e4K6mG2+bboG8P56nELaGC1p4Pfx-8eV-BjQ@mail.gmail.com>
Subject: Re: Radeon regression in 6.6 kernel
To:     Luben Tuikov <ltuikov89@gmail.com>
Cc:     Phillip Susi <phill@thesusis.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-kernel@vger.kernel.org,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Danilo Krummrich <dakr@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000e4307b060b50ab61"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e4307b060b50ab61
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 3:10=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Actually I think I see the problem.  I'll try and send out a patch
> later today to test.

Does the attached patch fix it?

Alex

>
> Alex
>
> On Wed, Nov 29, 2023 at 1:52=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Wed, Nov 29, 2023 at 11:41=E2=80=AFAM Luben Tuikov <ltuikov89@gmail.=
com> wrote:
> > >
> > > On 2023-11-29 10:22, Alex Deucher wrote:
> > > > On Wed, Nov 29, 2023 at 8:50=E2=80=AFAM Alex Deucher <alexdeucher@g=
mail.com> wrote:
> > > >>
> > > >> On Tue, Nov 28, 2023 at 11:45=E2=80=AFPM Luben Tuikov <ltuikov89@g=
mail.com> wrote:
> > > >>>
> > > >>> On 2023-11-28 17:13, Alex Deucher wrote:
> > > >>>> On Mon, Nov 27, 2023 at 6:24=E2=80=AFPM Phillip Susi <phill@thes=
usis.net> wrote:
> > > >>>>>
> > > >>>>> Alex Deucher <alexdeucher@gmail.com> writes:
> > > >>>>>
> > > >>>>>>> In that case those are the already known problems with the sc=
heduler
> > > >>>>>>> changes, aren't they?
> > > >>>>>>
> > > >>>>>> Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Mayb=
e I'm
> > > >>>>>> misunderstanding what the original report was actually testing=
.  If it
> > > >>>>>> was 6.7, then try reverting:
> > > >>>>>> 56e449603f0ac580700621a356d35d5716a62ce5
> > > >>>>>> b70438004a14f4d0f9890b3297cd66248728546c
> > > >>>>>
> > > >>>>> At some point it was suggested that I file a gitlab issue, but =
I took
> > > >>>>> this to mean it was already known and being worked on.  -rc3 ca=
me out
> > > >>>>> today and still has the problem.  Is there a known issue I coul=
d track?
> > > >>>>>
> > > >>>>
> > > >>>> At this point, unless there are any objections, I think we shoul=
d just
> > > >>>> revert the two patches
> > > >>> Uhm, no.
> > > >>>
> > > >>> Why "the two" patches?
> > > >>>
> > > >>> This email, part of this thread,
> > > >>>
> > > >>> https://lore.kernel.org/all/87r0kircdo.fsf@vps.thesusis.net/
> > > >>>
> > > >>> clearly states that reverting *only* this commit,
> > > >>> 56e449603f0ac5 drm/sched: Convert the GPU scheduler to variable n=
umber of run-queues
> > > >>> *does not* mitigate the failed suspend. (Furthermore, this commit=
 doesn't really change
> > > >>> anything operational, other than using an allocated array, instea=
d of a static one, in DRM,
> > > >>> while the 2nd patch is solely contained within the amdgpu driver =
code.)
> > > >>>
> > > >>> Leaving us with only this change,
> > > >>> b70438004a14f4 drm/amdgpu: move buffer funcs setting up a level
> > > >>> to be at fault, as the kernel log attached in the linked email ab=
ove shows.
> > > >>>
> > > >>> The conclusion is that only b70438004a14f4 needs reverting.
> > > >>
> > > >> b70438004a14f4 was a fix for 56e449603f0ac5.  Without b70438004a14=
f4,
> > > >> 56e449603f0ac5 breaks amdgpu.
> > > >
> > > > We can try and re-enable it in the next kernel.  I'm just not sure
> > > > we'll be able to fix this in time for 6.7 with the holidays and all
> > > > and I don't want to cause a lot of scheduler churn at the end of th=
e
> > > > 6.7 cycle if we hold off and try and fix it.  Reverting seems like =
the
> > > > best short term solution.
> > >
> > > A lot of subsequent code has come in since commit 56e449603f0ac5, as =
it opened
> > > the opportunity for a 1-to-1 relationship between an entity and a sch=
eduler.
> > > (Should've always been the case, from the outset. Not sure why it was=
 coded as
> > > a fixed-size array.)
> > >
> > > Given that commit 56e449603f0ac5 has nothing to do with amdgpu, and t=
he problem
> > > is wholly contained in amdgpu, and no other driver has this problem, =
there is
> > > no reason to have to "churn", i.e. go back and forth in DRM, only to =
cover up
> > > an init bug in amdgpu. See the response I just sent in @this thread:
> > > https://lore.kernel.org/r/05007cb0-871e-4dc7-af58-1351f4ba43e2@gmail.=
com
> > >
> > > And it's not like this issue is unknown. I first posted about it on 2=
023-10-16.
> > >
> > > Ideally, amdgpu would just fix their init code.
> >
> > You can't make changes to core code that break other drivers.
> > Arguably 56e449603f0ac5 should not have gone in in the first place if
> > it broke amdgpu.  b70438004a14f4 was the code to fix amdgpu's init
> > code, but as a side effect it seems to have broken suspend for some
> > users.
> >
> > Alex

--000000000000e4307b060b50ab61
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-fix-buffer-funcs-setting-order-on-suspend.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-fix-buffer-funcs-setting-order-on-suspend.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lpk8pifj0>
X-Attachment-Id: f_lpk8pifj0

RnJvbSA5NmU3NWI1MjE4ZjdhMTI0ZWFmYTUzODUzNjgxZWVmOGZlNTY3YWI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMjkgTm92IDIwMjMgMTU6NDQ6MjUgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBmaXggYnVmZmVyIGZ1bmNzIHNldHRpbmcgb3JkZXIgb24gc3VzcGVuZAoK
V2UgbmVlZCB0byBtYWtlIGRpc2FibGUgdGhpcyBhZnRlciB0aGUgbGFzdCBldmljdGlvbgpjYWxs
LCBidXQgYmVmb3JlIHdlIGRpc2FibGUgdGhlIFNETUEgSVAuCgpGaXhlczogYjcwNDM4MDA0YTE0
ICgiZHJtL2FtZGdwdTogbW92ZSBidWZmZXIgZnVuY3Mgc2V0dGluZyB1cCBhIGxldmVsIikKTGlu
azogaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvYXJjaGl2ZXMvYW1kLWdmeC8yMDIzLU5v
dmVtYmVyLzEwMTE5Ny5odG1sClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4KQ2M6IFBoaWxsaXAgU3VzaSA8cGhpbGxAdGhlc3VzaXMubmV0PgpD
YzogTHViZW4gVHVpa292IDxsdHVpa292ODlAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKaW5kZXggYjVlZGY0MGI1ZDAzLi43ODU1M2UwMjdkYjQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTQ1MzEsOCArNDUz
MSw2IEBAIGludCBhbWRncHVfZGV2aWNlX3N1c3BlbmQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwg
Ym9vbCBmYmNvbikKIAogCWFtZGdwdV9yYXNfc3VzcGVuZChhZGV2KTsKIAotCWFtZGdwdV90dG1f
c2V0X2J1ZmZlcl9mdW5jc19zdGF0dXMoYWRldiwgZmFsc2UpOwotCiAJYW1kZ3B1X2RldmljZV9p
cF9zdXNwZW5kX3BoYXNlMShhZGV2KTsKIAogCWlmICghYWRldi0+aW5fczBpeCkKQEAgLTQ1NDIs
NiArNDU0MCw4IEBAIGludCBhbWRncHVfZGV2aWNlX3N1c3BlbmQoc3RydWN0IGRybV9kZXZpY2Ug
KmRldiwgYm9vbCBmYmNvbikKIAlpZiAocikKIAkJcmV0dXJuIHI7CiAKKwlhbWRncHVfdHRtX3Nl
dF9idWZmZXJfZnVuY3Nfc3RhdHVzKGFkZXYsIGZhbHNlKTsKKwogCWFtZGdwdV9mZW5jZV9kcml2
ZXJfaHdfZmluaShhZGV2KTsKIAogCWFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZF9waGFzZTIoYWRl
dik7Ci0tIAoyLjQyLjAKCg==
--000000000000e4307b060b50ab61--
