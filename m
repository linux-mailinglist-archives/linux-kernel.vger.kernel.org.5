Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EC87EC686
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344305AbjKOPAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjKOPAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:00:49 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787B4101;
        Wed, 15 Nov 2023 07:00:46 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c34e87b571so5845603b3a.3;
        Wed, 15 Nov 2023 07:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700060446; x=1700665246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk//b/44SpaY6x16B5W5sNmaMz2/gBaDq0KHkpkbQWE=;
        b=L+0JimstNlPwV98gWbapTovOoNxNrSRoTSX9Qd84t4Ao9OEJ56gHSiR+XXbl4oDt41
         yRGgF6NZC/BwjU5rMkk/M7dNj/ZlgOyv52xqjowOeIgOzvRAhBblINYjwLCn/iTDRv3K
         zrSkDrORB60mItw5ffg/fvnx1/3GsJ6BAxR8smqFHpG51GIZyKYbhisXEVw1JkV5Ko9p
         qV7iaTQFGmbQsy5Os0Xg0LCbyBCBHYmLsWFyrBTsvar/hAegVJDQo1h1Q2teQW85kCeM
         ItFczANc/+noDQV0qI+otCAvdkdk0jKpwQ7wqf6UYDD4Js+9OinOoTWtdVQ17sNr2X9E
         oCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700060446; x=1700665246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk//b/44SpaY6x16B5W5sNmaMz2/gBaDq0KHkpkbQWE=;
        b=U+kOfiq+xNcNvuhL/xF4T7A5Sa04VgKvU/RKHvns4dSD0XdvGpEDgk4zSZuKEDLsv4
         peq1HLbokxWm+SXMAV4wgVBmWjOGedtPTPV2Oi4/iIYVcAoyiVCxWFOm1vlvwZLjGuFG
         tmAut5iE+0eyi4PETVImPLAezY1Og8wKrhIYgZh3nfbxCAPLpygFigQr746ALSHssFnx
         1Zcu3UR7rR9B6N25EARcUjb0XFI+0IjruaViti4dQYgpspDx1cLh2hiHk6A5FaLcA/Po
         7gFFyWd4fmZLzxdLI4mL8bOMAVxBqvgx6NVt/WVB31QPpeaRrSgiNwOmVFkbOnbHR+o7
         OUNA==
X-Gm-Message-State: AOJu0YzRC8zMT24mhGy83Xqep18BMJDRYYq1RhLCucB0yLzMIfhX4uG4
        /GBN9itgESbVjIJyaTqjBYz1GL9XCWzDzCWRCdk=
X-Google-Smtp-Source: AGHT+IFES6h9/DKjhqBaWgyZPzFL9fEJSQPlCWZV//0MH8HJO+4a5yXo/kWWb0Sg5QvHY7y78rynth2VBACtRmH8QFA=
X-Received: by 2002:a05:6a00:1d2a:b0:6c3:41fd:3a3e with SMTP id
 a42-20020a056a001d2a00b006c341fd3a3emr11265622pfx.27.1700060445747; Wed, 15
 Nov 2023 07:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20231106141704.866455-1-zyytlz.wz@163.com> <87o7g7ueom.fsf@kernel.org>
 <CAJedcCytuGmvubqbSZgsU3Db=rg=xM+kSuLZn8BSvA18Yn+9Jw@mail.gmail.com>
 <18ba5520da0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAJedcCxoL+L1QPaZty27k6kqR2JRjxPVY=BV5xn7BSPojbxe=A@mail.gmail.com> <fa0e7536-9b05-42fb-9fff-acd2ffad9af9@broadcom.com>
In-Reply-To: <fa0e7536-9b05-42fb-9fff-acd2ffad9af9@broadcom.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 15 Nov 2023 23:00:33 +0800
Message-ID: <CAJedcCzj9SFbx-=xDymqJyV2fu0xjmz2RH4+gT+Gxsqubg35ZA@mail.gmail.com>
Subject: Re: [PATCH v5] wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Zheng Wang <zyytlz.wz@163.com>,
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> =E4=BA=8E2023=E5=B9=B411=E6=
=9C=8813=E6=97=A5=E5=91=A8=E4=B8=80 17:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On November 8, 2023 4:03:26 AM Zheng Hacker <hackerzheng666@gmail.com>
> wrote:
>
> > Arend Van Spriel <arend.vanspriel@broadcom.com> =E4=BA=8E2023=E5=B9=B41=
1=E6=9C=886=E6=97=A5=E5=91=A8=E4=B8=80 23:48=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On November 6, 2023 3:44:53 PM Zheng Hacker <hackerzheng666@gmail.com>=
 wrote:
> >>
> >>> Thanks! I didn't test it for I don't have a device. Very appreciated
> >>> if anyone could help with that.
> >>
> >> I would volunteer, but it made me dig deep and not sure if there is a
> >> problem to solve here.
> >>
> >> brcmf_cfg80211_detach() calls wl_deinit_priv() -> brcmf_abort_scanning=
() ->
> >> brcmf_notify_escan_complete() which does delete the timer.
> >>
> >> What am I missing here?
> >
> > Thanks four your detailed review. I did see the code and not sure if
> > brcmf_notify_escan_complete
> > would be triggered for sure. So in the first version I want to delete
> > the pending timer ahead of time.
>
> Why requesting a CVE when you are not sure? Seems a bit hasty to put it
> mildly.

I'm sure the issue exists because there's only cancler of timer but not wok=
er.
As there's similar CVEs before like : https://github.com/V4bel/CVE-2022-412=
18,
I submit it as soon as I found it.

>
> > As I'm not very familiar with the logic here. I'm still not sure if we
> > should delete the timer_shutdown_sync.
> > Looking forward to your reply :)
>
> Reading the kerneldoc of timer_shutdown_sync() has the advantage that
> the timer can not be rearmed by another thread. However, that will only
> happen when a new scan is initiated in firmware, but the bus is already
> down so that can not happen. The only improvement (no bug fix!) I see
> here is to replace timer handling code in brcmf_notify_escan_complete():
>
> -       if (timer_pending(&cfg->escan_timeout))
> -               del_timer_sync(&cfg->escan_timeout);
> +       timer_delete_sync(&cfg->escan_timeout);
>

Very thanks for your reviews and suggestions! I thinks it's a good
idea. I'll make
another patch sooner or later.

Best regards,
Zheng

> Regards,
> Arend
