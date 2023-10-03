Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ABF7B5E2C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbjJCAZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjJCAZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:25:13 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4471FC6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:25:10 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-668e4fd13a3so2149096d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 17:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696292709; x=1696897509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh/oxoD92H1kiVOKUBO0S5GEjMsZkflJV2yuTcOo5N8=;
        b=Z21ctcqcbn7indUeHN4PBnci7y/5Fk/pua7VJBc1LmcgPIfdwncQyKN7gKsgOwrQsh
         NEfsHdQcc9mSemNdhXySQUyZQF9j2H17jxJ/TFenJK37PykbvzGKU/JgNq1vJKvrx1ib
         1lJoDtaBHYB529rZN9836rVpv+r7/b/yBJ3aQG13rd9Kkaeg3xC3o/A/dbHWC5Yz74fP
         xIpThMXuExHv2GKUC9WvpIx67emjL9+VKNARktcsmj4h8gSetLNvX5CvrM1db283UdGJ
         cIK3aaGLzS3mDXQ1mraNKlmesgLtvsNb6Q+FMqYHCdGnUWVVdmaDTmZSenfHrqib7RUu
         2RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696292709; x=1696897509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rh/oxoD92H1kiVOKUBO0S5GEjMsZkflJV2yuTcOo5N8=;
        b=fsXoZIcKRnWi2M2wTNPvNIlo+IWmTCKZI70k3KZWLF9OnJXlaB84lJ2ak0uD70ds+U
         HNma1JXu6+N7blwQc/nrigBPlr6/WtdbDICG5vBvir5QflVrelgwI/WoRc4+SbGOw1Fd
         /8EEUfx6+rn3/Vmk/mvZQKgx6dCRgOZyi92MP6fuZBPKY5W+wWcYFQmhpEmaibV/lStp
         av53qnK/W2Az5Lnn8mggRQiTBzWfCq1HIs9tU/C7z1H++UTX3/VS6RDI43odXFmhkttg
         osuygh+bNZSIlDRf7ttOOSQCIOLP/YBnfYY3i60HK+/Ix8C03gMfos/n21m6U18yQdxE
         RfUQ==
X-Gm-Message-State: AOJu0Yyea3OwewtFHpmfhXt+TgLGF1bXFxEH98bLSAL5eDcDqfAVqVZ1
        KHesH7PJtMZ+fLA2j4N+IYrYqCH3Xrj1BaZ4souw0Q==
X-Google-Smtp-Source: AGHT+IHb1/dimsEF/amBatrEHtKMQJThYkcDNmFcwv+eDoLhBq5FmQ86t7uGcpK84si2gXDwiQxCjrgiZwt9P4z1hQM=
X-Received: by 2002:a0c:e1d2:0:b0:65b:1594:264e with SMTP id
 v18-20020a0ce1d2000000b0065b1594264emr10894257qvl.51.1696292709241; Mon, 02
 Oct 2023 17:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230929023740.1611161-1-maheshb@google.com> <ZRiQqLYpzJGbiqYX@hoboy.vegasvil.org>
In-Reply-To: <ZRiQqLYpzJGbiqYX@hoboy.vegasvil.org>
From:   =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>
Date:   Mon, 2 Oct 2023 17:24:43 -0700
Message-ID: <CAF2d9jj4m4i278PN3F91VVudEG4nLFU8PJqk9Dnkqf=QOXTX0A@mail.gmail.com>
Subject: Re: [PATCH 2/4] ptp: add ptp_gettimex64any() support
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>
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

On Sat, Sep 30, 2023 at 2:18=E2=80=AFPM Richard Cochran
<richardcochran@gmail.com> wrote:
>
> On Thu, Sep 28, 2023 at 07:37:40PM -0700, Mahesh Bandewar wrote:
>
> > diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_cl=
ock.h
> > index 05cc35fc94ac..1f1e98966cff 100644
> > --- a/include/uapi/linux/ptp_clock.h
> > +++ b/include/uapi/linux/ptp_clock.h
> > @@ -69,6 +69,14 @@
> >   */
> >  #define PTP_PEROUT_V1_VALID_FLAGS    (0)
> >
> > +enum ptp_ts_types {
> > +     PTP_TS_CYCLES =3D 0,
> > +     PTP_TS_REAL,
> > +     PTP_TS_MONO,
> > +     PTP_TS_RAW,
> > +     PTP_TS_MAX,
> > +};
>
> There is no need for a new set of enumerated values.  Why not use the
> existing clockid_t ?
>
I'm not sure which one you are referring to. These defs need to be
UAPI and the one defined in time.h are not all relevant in this case
(we just need only a few of those) hence the definition. However, if I
missed something, please point me to it.

> Thanks,
> Richard
