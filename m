Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877557D7F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJZJdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjJZJdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:33:03 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA83194
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:33:00 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66cfd0b2d58so4793736d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698312780; x=1698917580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QnzvHljoQK/wJ5DGmho6Kn8XEghwIxtbxfaqrnbWOA=;
        b=GCzXK2hPHua+XSayW+xE+2fyZROYNUG0bCkzuuaj5HQNnu1nqFbZUZC8LwGMYL3iZt
         coBW0iAwGJmsIGN2P1ebjt7AnTrthwRC4xrBPVCwFEXtsMe/OPdCtJUwJ/hsdHEz8LYq
         IBn6ekGK1oQ8ByYUTOM/xxk60R7i2cKomBzW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698312780; x=1698917580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QnzvHljoQK/wJ5DGmho6Kn8XEghwIxtbxfaqrnbWOA=;
        b=o8eV55tx5q5NyJJo9nWtXZD2lDq7M62vfDj3Au/sOJZhokc/MY/8o/A3biKf+LFld2
         JLTO1cwoSXlcHQNwmJHqFIYSw0xOCBWvQ7cMPOjxKJ19F6gc0qDq7ZVj6G8hDsnAVMrt
         v4qnxBVRqA0/sXq4SFAmnC7R5MdlcBTVLw0kOhdDKZTg/904WASgqCMx2mdl83qpNY8G
         bpbpFitLxAnEqK/5mdPKCKu+HWxGAzF90A25LcNom4Ief9RM4jbZ5M548+3jzgIuWAPQ
         jpGkqHiSXYqb3iUCyaPFaNR7TcfoTYAzCwDatmxRS3Nz6m3ZCbjlDPByXuywUCKGdCgZ
         OrKg==
X-Gm-Message-State: AOJu0Yz79BG8QnCLF+KjM/XpKIdFY1Jb+yks71Vf0m7e8R5cv/Eimwqi
        LCErGjKrnulV1w50MUA6VDrekreVQOVBRiaZ9nkIvzx0f8uZYBEm
X-Google-Smtp-Source: AGHT+IF80lstIgX6hCwQkudW7uP9KGjzyJuL2EcTR8jSvozl+A/cKDMws42mMr+uWnJ72O7GuiVVG5mUS6itxQcFUGc=
X-Received: by 2002:a05:6214:2602:b0:66d:44b6:8aa7 with SMTP id
 gu2-20020a056214260200b0066d44b68aa7mr21390279qvb.24.1698312779620; Thu, 26
 Oct 2023 02:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231016095610.1095084-1-korneld@chromium.org>
 <613c51f0-c32e-4de5-9627-525d92fb06ed@intel.com> <CAD=NsqybNrf-=9=5wvoj+9MT3xK3SbX7nDk3N3VLBMyA_u3KTQ@mail.gmail.com>
 <78bb4ad2-853a-4ed4-9998-c4e1122545b6@intel.com> <CAD=NsqxDA=usDRa-KV48RkeEROARsw8JqBF5vyJcEEV5r_Fg1w@mail.gmail.com>
 <f0aecb28-6f82-456e-a319-8d13a2e313b6@intel.com> <CAD=NsqyJHv4nrtrqU4igtaMR=u6xmUtCpoYk66XzarLpu95idA@mail.gmail.com>
 <cf207da8-8ec4-4b9c-8f01-00e1a8a46238@intel.com> <CAD=NsqyvGvbtyMim=Otp-Q-zWW9-+hAh95SOkgvnRusQC_--hQ@mail.gmail.com>
 <4221120e-61bb-4672-8775-e7c1512d824b@intel.com>
In-Reply-To: <4221120e-61bb-4672-8775-e7c1512d824b@intel.com>
From:   =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Date:   Thu, 26 Oct 2023 11:32:48 +0200
Message-ID: <CAD=Nsqy-JOdcYXiWYkJ+zw_e5Ox0ur0XGnNLrBg6R-Tihna2rA@mail.gmail.com>
Subject: Re: [PATCH] mmc: cqhci: Be more verbose in error irq handler
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:52=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 26/10/23 11:29, Kornel Dul=C4=99ba wrote:
> > On Thu, Oct 26, 2023 at 10:14=E2=80=AFAM Adrian Hunter <adrian.hunter@i=
ntel.com> wrote:
> >>
> >> On 26/10/23 10:56, Kornel Dul=C4=99ba wrote:
> >>> On Thu, Oct 26, 2023 at 8:25=E2=80=AFAM Adrian Hunter <adrian.hunter@=
intel.com> wrote:
> >>>>
> >>>> On 25/10/23 11:01, Kornel Dul=C4=99ba wrote:
> >>>>> On Mon, Oct 23, 2023 at 1:38=E2=80=AFPM Adrian Hunter <adrian.hunte=
r@intel.com> wrote:
> >>>>>>
> >>>>>> On 20/10/23 11:53, Kornel Dul=C4=99ba wrote:
> >>>>>>> On Fri, Oct 20, 2023 at 9:41=E2=80=AFAM Adrian Hunter <adrian.hun=
ter@intel.com> wrote:
> >>>>>>>>
> >>>>>>>> On 16/10/23 12:56, Kornel Dul=C4=99ba wrote:
> >>>>>>>>> There are several reasons for controller to generate an error i=
nterrupt.
> >>>>>>>>> They include controller<->card timeout, and CRC mismatch error.
> >>>>>>>>> Right now we only get one line in the logs stating that CQE rec=
overy was
> >>>>>>>>> triggered, but with no information about what caused it.
> >>>>>>>>> To figure out what happened be more verbose and dump the regist=
ers from
> >>>>>>>>> irq error handler logic.
> >>>>>>>>> This matches the behaviour of the software timeout logic, see
> >>>>>>>>> cqhci_timeout.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Kornel Dul=C4=99ba <korneld@chromium.org>
> >>>>>>>>> ---
> >>>>>>>>>  drivers/mmc/host/cqhci-core.c | 5 +++--
> >>>>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/c=
qhci-core.c
> >>>>>>>>> index b3d7d6d8d654..33abb4bd53b5 100644
> >>>>>>>>> --- a/drivers/mmc/host/cqhci-core.c
> >>>>>>>>> +++ b/drivers/mmc/host/cqhci-core.c
> >>>>>>>>> @@ -700,8 +700,9 @@ static void cqhci_error_irq(struct mmc_host=
 *mmc, u32 status, int cmd_error,
> >>>>>>>>>
> >>>>>>>>>       terri =3D cqhci_readl(cq_host, CQHCI_TERRI);
> >>>>>>>>>
> >>>>>>>>> -     pr_debug("%s: cqhci: error IRQ status: 0x%08x cmd error %=
d data error %d TERRI: 0x%08x\n",
> >>>>>>>>> -              mmc_hostname(mmc), status, cmd_error, data_error=
, terri);
> >>>>>>>>> +     pr_warn("%s: cqhci: error IRQ status: 0x%08x cmd error %d=
 data error %d\n",
> >>>>>>>>> +              mmc_hostname(mmc), status, cmd_error, data_error=
);
> >>>>>>>>> +     cqhci_dumpregs(cq_host);
> >>>>>>>>
> >>>>>>>> For debugging, isn't dynamic debug seems more appropriate?
> >>>>>>>
> >>>>>>> Dynamic debug is an option, but my personal preference would be t=
o
> >>>>>>> just log more info in the error handler.
> >>>>>>
> >>>>>> Interrupt handlers can get called very rapidly, so some kind of ra=
te
> >>>>>> limiting should be used if the message is unconditional.  Also you=
 need
> >>>>>> to provide actual reasons for your preference.
> >>>>>>
> >>>>>> For dynamic debug of the register dump, something like below is
> >>>>>> possible.
> >>>>>>
> >>>>>> #define cqhci_dynamic_dumpregs(cqhost) \
> >>>>>>         _dynamic_func_call_no_desc("cqhci_dynamic_dumpregs", cqhci=
_dumpregs, cqhost)
> >>>>>>
> >>>>> Fair point.
> >>>>> The reason I'm not a fan of using dynamic debug for this is that my
> >>>>> goal here is to improve the warning/error logging information that =
we
> >>>>> get from systems running in production.
> >>>>> I.e. if we get a lot of "running CQE recovery" messages, at the ver=
y
> >>>>> least I'd like to know what is causing them.
> >>>>
> >>>> So you are saying you want to collect debug information from product=
ion
> >>>> systems, but don't want to use dynamic debug to do it?
> >>>>
> >>>>>>> To give you some background.
> >>>>>>> We're seeing some "running CQE recovery" lines in the logs, follo=
wed
> >>>>>>> by a dm_verity mismatch error.
> >>>>>>> The reports come from the field, with no feasible way to reproduc=
e the
> >>>>>>> issue locally.
> >>>>>>
> >>>>>> If it is a software error, some kind of error injection may well
> >>>>>> reproduce it.  Also if it is a hardware error that only happens
> >>>>>> during recovery, error injection could increase the likelihood of
> >>>>>> reproducing it.
> >>>>>
> >>>>> We tried software injection and it didn't yield any results.
> >>>>> We're currently looking into "injecting" hw errors by using a small
> >>>>> burst field generator to interfere with transfers on the data line
> >>>>> directly.
> >>>>
> >>>> I just tried instrumenting a driver to inject CRC errors and it
> >>>> revealed several CQE recovery issues, including spurious TCN for
> >>>> tag 31.  I will send some patches when they are ready.
> >>>
> >>> Sorry, what I meant by it didn't yield results is that Ii didn't
> >>> trigger the dm-verity error that we're seeing on production.
> >>> With SW injection there are two potential issues that come to my mind=
:
> >>>
> >>> 1. In the cqhci_error_irq when TERRI is not valid only a single,
> >>> "random" task is marked as bad.
> >>> Then in cqhci_recover_mrq we're marking all pending requests as done.
> >>> For data transfers this is somewhat bening as it will return with
> >>> bytes_xfered=3D0.
> >>> IIUC this will then cause the upper layer to re-enqueue this request.
> >>
> >> Yes
> >>
> >>> The bigger problem is a CMD only mrq, which will be mistakenly marked
> >>> as completed successfully.
> >>
> >> I noticed that also.  Notably the only non-data CMD is cache flush.
> >>
> >> There are several other issues, but patches will describe
> >> them better.
> >
> > Sure. :)
> >
> > jfyi, I've just managed to inject CRC errors by using a burst field gen=
erator.
> > (Langer P23 if you're interested.)
> > I'm using it by touching the D0 MMC line directly, and it yields
> > surprisingly good results.
> > I've changed the spurious TCN WARN_ONCE to pr_warn and got the followin=
g:
> >
> > [   71.885698] mmc1: cqhci: error IRQ status: 0x00000000 cmd error 0
> > data error -84 TERRI: 0x972e0000
> > [   71.885730] mmc1: running CQE recovery
> > [   71.888135] cqhci_recovery_finish: TCN: 0x00000000
> > [   71.888141] mmc1: cqhci: recovery done
> > [   71.888223] mmc1: cqhci: spurious TCN for tag 23
> > (...)
> > [   95.558736] mmc1: cqhci: error IRQ status: 0x00000000 cmd error 0
> > data error -84 TERRI: 0x822e0000
> > [   95.558768] mmc1: running CQE recovery
> > [   95.561073] cqhci_recovery_finish: TCN: 0x00000000
> > [   95.561078] mmc1: cqhci: recovery done
> > [   95.561288] device-mapper: verity: 179:3: data block 712181 is corru=
pted
> >
> > Now I get a spurious TCN after every recovery, with the only exception
> > being the one that ends up with dm-verity error.
> > So it'd seem that there's a race in which the "spurious" TCN hits a
> > pending request, enqueued right after recovery was completed.
> > I'm currently looking into how to fix it, but if you beat me to it I
> > can also test your patches and see if it fixes the dm-verity issue.
>
> OK, but here are some hacks to try:
(snip)
Thanks, fyi, with them applied I can see the exact same behaviour,
including what I'm seeing in the logs.
>
> >
> >>
> >>>
> >>> 2. As for the spurious task completion warning.
> >>> I initially thought that it was bening.
> >>> The check for !mrq is done before checking if we're currently doing r=
ecovery.
> >>> So if it's called just right at the end of recovery, right after the
> >>> cqhci_recover_mrqs is executed that would explain it.
> >>> With that being said if that irq handler is run right after the
> >>> recovery is finished we'll end up with a race where a new request,
> >>> that was just enqueued, might be mistakenly marked as done.
> >>> This would explain the dm-verity errors we're seeing.
> >>>
> >>>>
> >>>>>>
> >>>>>>>
> >>>>>>> I'd argue that logging only the info that CQE recovery was execut=
ed is
> >>>>>>> not particularly helpful for someone looking into those logs.
> >>>>>>
> >>>>>> As the comment says, that message is there because recovery reduce=
s
> >>>>>> performance, it is not to aid debugging per se.
> >>>>>>
> >>>>>>> Ideally we would have more data about the state the controller wa=
s in
> >>>>>>> when the error happened, or at least what caused the recovery to =
be
> >>>>>>> triggered.
> >>>>>>> The question here is how verbose should we be in this error scena=
rio.
> >>>>>>> Looking at other error scenarios, in the case of a software timeo=
ut
> >>>>>>> we're dumping the controller registers. (cqhci_timeout)
> >>>>>>
> >>>>>> Timeout means something is broken - either the driver, the cq engi=
ne
> >>>>>> or the card.  On the other hand, an error interrupt is most likely=
 a
> >>>>>> CRC error which is not unexpected occasionally, due to thermal dri=
ft
> >>>>>> or perhaps interference.
> >>>>>
> >>>>> Right, but my point is that we don't know what triggered CQE recove=
ry.
> >>>>
> >>>> True, although probably a CRC error.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>> Hence I thought that I'd be appropriate to match that and do the =
same
> >>>>>>> in CQE recovery logic.
> >>>>>>
> >>>>>> It needs to be consistent. There are other pr_debugs, such as:
> >>>>>>
> >>>>>>                 pr_debug("%s: cqhci: Failed to clear tasks\n",
> >>>>>>                 pr_debug("%s: cqhci: Failed to halt\n", mmc_hostna=
me(mmc));
> >>>>>>                 pr_debug("%s: cqhci: disable / re-enable\n", mmc_h=
ostname(mmc));
> >>>>>>
> >>>>>> which should perhaps be treated the same.
> >>>>>>
> >>>>>> And there are no messages for errors from the commands in
> >>>>>> mmc_cqe_recovery().
> >>>>>
> >>>>> How about this.
> >>>>> As a compromise would it be okay to just do a single pr_warn direct=
ly
> >>>>> from cqhci_error_irq.
> >>>>
> >>>> Sure, printk_ratelimited() or __ratelimit()
> >>>>
> >>>>> We could simply promote the existing pr_debug to pr_warn at the
> >>>>> beginning of that function.
> >>>>> This would tell us what triggered the recovery. (controller timeout=
,
> >>>>> CRC mismatch)
> >>>>> We can also consider removing the "running CQE recovery" print for =
the
> >>>>> sake of brevity.
> >>>>
> >>>> No, that serves a different purpose.
> >>>>
> >>>>> The only downside of this that I can see is that we'd be running th=
e
> >>>>> logic from the interrupt handler directly, but I can't see an easy =
way
> >>>>> around that.
> >>>>> What do you think?
> >>>>
> >>>> Should be OK with rate limiting.
> >>>
> >>> OK, I'll look into the rate limiting and will send a v2.
> >>>
> >>>>
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>       /* Forget about errors when recovery has already been tri=
ggered */
> >>>>>>>>>       if (cq_host->recovery_halt)
> >>>>>>>>
> >>>>>>
> >>>>
> >>
>
