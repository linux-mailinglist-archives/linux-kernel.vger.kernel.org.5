Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A167F5FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345427AbjKWNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345410AbjKWNOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:14:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C1D1B3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:14:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2857670af8cso170544a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1700745277; x=1701350077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fv8GZerhhui6fIHfOSZEUfr0KlTYNPj6B+LleuIkHfQ=;
        b=P+tsbNqj9G+Fug1Zx4EIV+b5TLy2T+ZBhD0N/inYzwRjlymadxTYDbADdcTpGHllpa
         fw1gZ3Lf54PeglSyVI0B3z9xEhfCxGMimHQxZ0yJBHu8eQw1c02EjRyRYEQvbflZ+2Ij
         /+7aOd7UlWnEUg0sMSEmOUovx08x0mF0Wo9V43ekLQRYjofKau578vmGcYuMuz7HKg47
         YM3pg5AHNRJLqbxDPc5Pr8g5QaQL03CSLWB2PfdAlZ4glMiIQrrgHGUXElmVzrkywCSk
         3Ynw4aX2zb/oCTzfRuPDYusb3pU+i1/YV2/xOwARIeKBZ+JSi1wQLF4oYBYnZWBtqfrr
         EGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700745277; x=1701350077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fv8GZerhhui6fIHfOSZEUfr0KlTYNPj6B+LleuIkHfQ=;
        b=gcPnG+OfRiu4YqqGMDTaSszep+erm+zG+P2MW8JC2Z3uDcBfptmhZF9Gve+tADUOoH
         lXgjy9tq28Tnknaxwz30zpP/tNJopQPyYlLwl2kXMsFheUeJ0WP28E8yei+YDEtkgnfb
         dmgah1vuGsuu97ryaGTvqbvXfSlYhtiJGflxXAA9w6H2xUhNVjrnwA2TNnjJDYZOm4Ij
         +tNLQFgKtUvQ9dBGs1BgJPMlXZEdQ6XU+etla+PAk5RqBVdiTKFluOnNDsB1SNtNTYlO
         W2Ztny3rXdjAHWANtxfZxDl/TCkmcfZ6w7mfEFCFTCSMoRKXCvkSo36Rv5plbSBEX7MZ
         n5Rg==
X-Gm-Message-State: AOJu0YygIXrN30sNZbkxd+fYXvRKe6jpou7tUnLht2ORwz3ekWPVlPvS
        roawDU3Ae0IvWDJAwUI9TFXso9zgxXYjH9u3WxuclQ==
X-Google-Smtp-Source: AGHT+IGpE8kpg4pZ6H9Fs4mTmjCY2nQNpRMeWwwwdgt3zz5RX07UlhDN5Hn4jS3hCeq2/goNhLXQJ8vVXXqliOC5MiE=
X-Received: by 2002:a17:90a:ab02:b0:285:6f1a:4a71 with SMTP id
 m2-20020a17090aab0200b002856f1a4a71mr985917pjq.32.1700745276789; Thu, 23 Nov
 2023 05:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20230914114521.1491390-1-naresh.solanki@9elements.com>
 <20230920130528.GG13143@google.com> <CABqG17j_gCr8xw65qjn4Kh7ChdraZbLsyGOsCmFEEWG3txjE4A@mail.gmail.com>
 <20230921103156.GB3449785@google.com> <CABqG17ibzHiYmzCZ6ZpAa8BZhj5N+0dQ0aa1yebtCk0YYVdsFQ@mail.gmail.com>
 <CABqG17h8hxgmMA=G5hitzgjNSX_BZ2utFsMZni9evn0Nogu0GA@mail.gmail.com>
 <20231117121531.GC137434@google.com> <CABqG17hPnx465dRKdMdSd2s38_T6DQFn5hsx1SL0RtA+r4JFZQ@mail.gmail.com>
 <20231121153302.GD173820@google.com> <CABqG17hufcNS5-wLEEpZniSE2MAfEeN9Ljhs5MPGeu-2xZP+HQ@mail.gmail.com>
 <20231122114958.GJ173820@google.com>
In-Reply-To: <20231122114958.GJ173820@google.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 23 Nov 2023 18:44:26 +0530
Message-ID: <CABqG17ifCpaAYuGbEJm-rS1ojSA+a1iw+EZ=teYyb0apEkVtuw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] leds: max5970: Add support for max5970
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee

On Wed, 22 Nov 2023 at 17:20, Lee Jones <lee@kernel.org> wrote:
>
> Please read this:
>
>   https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replyin=
g
Ack
>
> On Tue, 21 Nov 2023, Naresh Solanki wrote:
>
> > Hi Lee,
> >
> > Thank you for your insights. I appreciate your guidance on the matter.
> > Yes will rewrite the change as below:
> >
> >         regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> >         if (!regmap)
> >                 return -ENODEV;
> >
> > I believe this modification aligns with your suggestion. Please let me
> > know if this meets the requirements or if you have any further
> > suggestions or adjustments
>
> Please submit the next revision.
Ack

Regards,
Naresh
>
> > On Tue, 21 Nov 2023 at 21:03, Lee Jones <lee@kernel.org> wrote:
> > >
> > > On Mon, 20 Nov 2023, Naresh Solanki wrote:
> > >
> > > > Hi
> > > >
> > > > On Fri, 17 Nov 2023 at 17:45, Lee Jones <lee@kernel.org> wrote:
> > > > >
> > > > > On Thu, 09 Nov 2023, Naresh Solanki wrote:
> > > > >
> > > > > > Hey Lee,
> > > > > >
> > > > > > Is there anything specific you'd suggest changing in the curren=
t
> > > > > > patchset, or are we good to proceed?
> > > > >
> > > > > What do you mean by proceed?
> > > > >
> > > > > You are good to make changes and submit a subsequent version.
> > > > >
> > > > > Not entirely sure what you're asking.
> > > >
> > > > As a follow up on previous discussion regarding use of DEFER on pro=
be
> > > > if regmap isn't initialized, the implementation was based on other =
similar
> > > > drivers & hence it was retained although its not needed due to depe=
ndencies.
> > > >
> > > > I'm not entirely sure to keep the regmap check or make another
> > > > patch revision with regmap check removed ?
> > >
> > > You tell me.
> > >
> > > You should understand the device you're attempting to support along w=
ith
> > > the code you're authoring and its subsequent implications.  If you do=
n't
> > > know what a section of code does or whether/why it's required, why di=
d
> > > you write it?
> > >
> > > --
> > > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
