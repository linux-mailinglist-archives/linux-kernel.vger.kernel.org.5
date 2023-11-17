Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15A67EEB11
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 03:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjKQCbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 21:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQCbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 21:31:43 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C64CCE;
        Thu, 16 Nov 2023 18:31:40 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2802d218242so1286278a91.1;
        Thu, 16 Nov 2023 18:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700188300; x=1700793100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShHjQysUBtuxNJ+pH62O9En8/VVV59KhlFkmqvEAWnQ=;
        b=Qpv7NU8ZyGgmFckPiV2JBny6Kx8nOGRL9bZFfgRLvHxp+NzpHfqWRAOnSkFRYsQj+w
         WZe5oWrryy6VU/SZkL2pbRyDtX+RCDH1/DO0EHUz5aTWZhnEJY4jsTJoWZNSRM7aGNx8
         Lk7PkxBK0Z7i1Sg36l+BcBL2luoICaI3jjG/FXAdtutwhGqhkuCbUZjDnquoebQmIF+H
         OizYsLWTUrpHTgInjt4tjzX98jdA+P/Ebuka9d0U5BLQld+ufAg8569CKMRgWD6wLdfd
         B/LKP7WiQlHLLFh8i/WCREI/HmzcD194p9zhbsceZRgFj0K0/V756KaAWhcyhnYIbC6L
         7JdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700188300; x=1700793100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShHjQysUBtuxNJ+pH62O9En8/VVV59KhlFkmqvEAWnQ=;
        b=Q7yIpA1TQZypD4Oi+CChvC57LoE25FAkipG/jNpslKFjeiv5jY9XtSiCRDoLBK7408
         sIrLYfaMlidXE7GkSyMba4ppSNrgnOgC2PmeVB257r4OAUTG5HTE/rfRpQl20j+hPyF8
         n7J8xcxiqDocQRK2KNi4vXjnZN2xv34NU8HRgjez9q/SNg1BTrLK2Q0CgfMsalpR86ZD
         fgp0qEoFfeynf1ILgtXgRmJ+z/4Ke1UNI/0h9uUuPWq/stah9pUrL+X3dBP+PNWmCGyd
         USfO5K19I3CkUBTnRCQsrv4QPhjU5EuSeajpwetKQn3ovj8hjHlvWjZFcZFr4B0L4t52
         GgbQ==
X-Gm-Message-State: AOJu0YxZKRihEL+k49CD22OrnDSqmTBVK0y56Kvh9NjmpHifm6ahdiKY
        5FWTy8Hddbphc61I1C0MFpAXEAXctRQ7r8bs0PU=
X-Google-Smtp-Source: AGHT+IFzoGP+uMiVEu1AQsDTGoADAr9AfNfMW1RtojU6+Abv0tCKOjDTqiNoUIjGOCQyhiyrlqZzBZ2NHWvGGP6oOvs=
X-Received: by 2002:a17:90b:1810:b0:280:2652:d42 with SMTP id
 lw16-20020a17090b181000b0028026520d42mr20455528pjb.23.1700188299572; Thu, 16
 Nov 2023 18:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20231106141704.866455-1-zyytlz.wz@163.com> <87o7g7ueom.fsf@kernel.org>
 <CAJedcCytuGmvubqbSZgsU3Db=rg=xM+kSuLZn8BSvA18Yn+9Jw@mail.gmail.com>
 <18ba5520da0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAJedcCxoL+L1QPaZty27k6kqR2JRjxPVY=BV5xn7BSPojbxe=A@mail.gmail.com>
 <fa0e7536-9b05-42fb-9fff-acd2ffad9af9@broadcom.com> <CAJedcCzj9SFbx-=xDymqJyV2fu0xjmz2RH4+gT+Gxsqubg35ZA@mail.gmail.com>
 <18bd95c97f0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <87h6llmu7t.wl-tiwai@suse.de>
In-Reply-To: <87h6llmu7t.wl-tiwai@suse.de>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 17 Nov 2023 10:31:26 +0800
Message-ID: <CAJedcCzTv5oT-=+DaT6pCnor9QijUWGEkxg0PcZRWQDHxTWPeA@mail.gmail.com>
Subject: Re: [PATCH v5] wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, Zheng Wang <zyytlz.wz@163.com>,
        aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, johannes.berg@intel.com,
        marcan@marcan.st, linus.walleij@linaro.org,
        jisoo.jang@yonsei.ac.kr, linuxlovemin@yonsei.ac.kr,
        wataru.gohda@cypress.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        security@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, that makes this issue hard to fix. I was wondering why it binds the
worker with the timer rather than using just one of them.

Takashi Iwai <tiwai@suse.de> =E4=BA=8E2023=E5=B9=B411=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=BA=94 02:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 16 Nov 2023 19:20:06 +0100,
> Arend Van Spriel wrote:
> >
> > On November 15, 2023 4:00:46 PM Zheng Hacker <hackerzheng666@gmail.com>=
 wrote:
> >
> > > Arend van Spriel <arend.vanspriel@broadcom.com> =E4=BA=8E2023=E5=B9=
=B411=E6=9C=8813=E6=97=A5=E5=91=A8=E4=B8=80 17:18=E5=86=99=E9=81=93=EF=BC=
=9A
> > >>
> > >> On November 8, 2023 4:03:26 AM Zheng Hacker <hackerzheng666@gmail.co=
m>
> > >> wrote:
> > >>
> > >>> Arend Van Spriel <arend.vanspriel@broadcom.com> =E4=BA=8E2023=E5=B9=
=B411=E6=9C=886=E6=97=A5=E5=91=A8=E4=B8=80 23:48=E5=86=99=E9=81=93=EF=BC=9A
> > >>>>
> > >>>> On November 6, 2023 3:44:53 PM Zheng Hacker <hackerzheng666@gmail.=
com> wrote:
> > >>>>
> > >>>>> Thanks! I didn't test it for I don't have a device. Very apprecia=
ted
> > >>>>> if anyone could help with that.
> > >>>>
> > >>>> I would volunteer, but it made me dig deep and not sure if there i=
s a
> > >>>> problem to solve here.
> > >>>>
> > >>>> brcmf_cfg80211_detach() calls wl_deinit_priv() -> brcmf_abort_scan=
ning() ->
> > >>>> brcmf_notify_escan_complete() which does delete the timer.
> > >>>>
> > >>>> What am I missing here?
> > >>>
> > >>> Thanks four your detailed review. I did see the code and not sure i=
f
> > >>> brcmf_notify_escan_complete
> > >>> would be triggered for sure. So in the first version I want to dele=
te
> > >>> the pending timer ahead of time.
> > >>
> > >> Why requesting a CVE when you are not sure? Seems a bit hasty to put=
 it
> > >> mildly.
> > >
> > > I'm sure the issue exists because there's only cancler of timer but n=
ot woker.
> > > As there's similar CVEs before like : https://github.com/V4bel/CVE-20=
22-41218,
> > > I submit it as soon as I found it.
> >
> > Ah, yes. The cancel_work_sync() can also be done in
> > brcmf_notify_escan_complete().
>
> AFAIUC, brcmf_notify_scan_complete() is called from the work itself,
> too, hence you can't issue cancel_work_sync() there (unless you make
> it conditional).
>
>
> Takashi
