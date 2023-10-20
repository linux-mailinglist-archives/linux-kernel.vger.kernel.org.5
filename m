Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6967D1311
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377778AbjJTPmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377789AbjJTPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:42:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DE7AB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:42:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso1453307a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697816546; x=1698421346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGC+3Kmw+D+b5Dj58mb9CrKsjrP+aMd2+KprUNQqghc=;
        b=J13NetEmn6UJVj4RNFAMlmVDcXV9It1K5L4R91DVK+Gc402XcTqMkJlWHzBybOH0Bw
         tn+UGf/0m26Ij8t76V2irnXxUYm7qTr1jWAg9ooMYWQoDg3HPK6uDTxePgub3LV3Lt9a
         Ar4P2jJB5LdtqDnZ7Nf7/VCoyvg/K1qcDKB+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697816546; x=1698421346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGC+3Kmw+D+b5Dj58mb9CrKsjrP+aMd2+KprUNQqghc=;
        b=KWgxAL0ldc3pfK1BpYJJ0xQjXQtOekG+GIicS4WekNzl+WIu7lYnKE7TGpIFJXf/Hm
         pPQ2UNoPXnKEQaRQs/XIm9lJy8t2i88SXz69lcek3QP+s7X0DwJ9yuTvBJEGHxBiDRBc
         HGB1tocKsc6XoS2oGJw5chgmDBNPYV7tHPgXCphywQGKQS8qUB6YyEmQQF6rtiRZiHte
         ZqjnD7rpYow6l8Nrz2q3rAbjyVQUsVCJnNyytn6f2kQEI3m26EsDEnvB0013azn9Wj5i
         cwBYcC3JLj+0viJeywEF/4nQrGVDIF0tbdgfh44wm5srPIfezMuSETB5qMox1a+d3HhA
         Dasw==
X-Gm-Message-State: AOJu0Yzp7fAMczE500P9VlWFA9Hbe05P/Q6h8ECWO517huH8bNJ24JPt
        GRnlHwLVa7qdGlTPJRwdXwq2I3u1WEbxb28nQXktYI9J
X-Google-Smtp-Source: AGHT+IE38EnW05jODD2Rb6GzAhBq1JXmNKE5waT6kYR+UPMq4cWQiVB7GZmIUABq12U0oSBal5K2ig==
X-Received: by 2002:a05:6402:190d:b0:53e:6da7:72ba with SMTP id e13-20020a056402190d00b0053e6da772bamr2333796edz.38.1697816546266;
        Fri, 20 Oct 2023 08:42:26 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id da11-20020a056402176b00b0053ebe6c1396sm1652990edb.27.2023.10.20.08.42.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 08:42:25 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40853f2e93eso42285e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:42:25 -0700 (PDT)
X-Received: by 2002:a05:600c:4a22:b0:408:2b:5956 with SMTP id
 c34-20020a05600c4a2200b00408002b5956mr119419wmp.6.1697816544811; Fri, 20 Oct
 2023 08:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231019212130.3146151-1-dianders@chromium.org>
 <20231019142019.v4.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid> <eaf05cf1486c418790a1b54cbcda3a98@realtek.com>
In-Reply-To: <eaf05cf1486c418790a1b54cbcda3a98@realtek.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Oct 2023 08:42:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XZQ0XXY7XpX2_ubOwGsi0Hw5otHyuJS2=9QzDJsaSGWg@mail.gmail.com>
Message-ID: <CAD=FV=XZQ0XXY7XpX2_ubOwGsi0Hw5otHyuJS2=9QzDJsaSGWg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] r8152: Block future register access if register
 access fails
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Simon Horman <horms@kernel.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 20, 2023 at 4:31=E2=80=AFAM Hayes Wang <hayeswang@realtek.com> =
wrote:
>
> Douglas Anderson <dianders@chromium.org>
> > Sent: Friday, October 20, 2023 5:20 AM
> [...]
> >  static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
> > @@ -8265,6 +8353,17 @@ static int rtl8152_pre_reset(struct usb_interfac=
e *intf)
> >         if (!tp)
> >                 return 0;
> >
> > +       /* We can only use the optimized reset if we made it to the end=
 of
> > +        * probe without any register access fails, which sets
> > +        * `PROBED_WITH_NO_ERRORS` to true. If we didn't have that then=
 return
> > +        * an error here which tells the USB framework to fully unbind/=
rebind
> > +        * our driver.
> > +        */
> > +       if (!test_bit(PROBED_WITH_NO_ERRORS, &tp->flags)) {
> > +               mutex_unlock(&tp->control);
>
> I think you forget to remove mutex_unlock here.

Ugh, thanks for catching. I tested it with a bootup or two but I
didn't re-run all tests or spend lots of time looking through the logs
so I missed this. I'll run a few more cycles this time.


> > +               return -EIO;
> > +       }
> > +
> >         netdev =3D tp->netdev;
> >         if (!netif_running(netdev))
> >                 return 0;
> > @@ -8277,7 +8376,9 @@ static int rtl8152_pre_reset(struct usb_interface=
 *intf)
> >         napi_disable(&tp->napi);
> >         if (netif_carrier_ok(netdev)) {
> >                 mutex_lock(&tp->control);
> > +               set_bit(IN_PRE_RESET, &tp->flags);
> >                 tp->rtl_ops.disable(tp);
> > +               clear_bit(IN_PRE_RESET, &tp->flags);
> >                 mutex_unlock(&tp->control);
> >         }
> >
> > @@ -8293,6 +8394,8 @@ static int rtl8152_post_reset(struct usb_interfac=
e *intf)
> >         if (!tp)
> >                 return 0;
> >
> > +       rtl_set_accessible(tp);
> > +
>
> Excuse me. I have a new idea. You could check if it is possible.
> If you remove test_bit(PROBED_WITH_NO_ERRORS, &tp->flags) in pre_reset(),
> the driver wouldn't be unbound and rebound. Instead, you test PROBED_WITH=
_NO_ERRORS
> here to re-initialize the device. Then, you could limit the times of USB =
reset, and
> the infinite loop wouldn't occur. The code would be like the following,
>
>         if (!test_bit(PROBED_WITH_NO_ERRORS, &tp->flags)) {
>                 /* re-init */
>                 mutex_lock(&tp->control);
>                 tp->rtl_ops.init(tp);
>                 mutex_unlock(&tp->control);
>                 rtl_hw_phy_work_func_t(&tp->hw_phy_work.work);
>
>                 /* re-open(). Maybe move after checking netif_running(net=
dev) */
>                 mutex_lock(&tp->control);
>                 tp->rtl_ops.up(tp);
>                 mutex_unlock(&tp->control);
>
>                 /* check if there is any control error */
>                 if (test_bit(RTL8152_INACCESSIBLE, &tp->flags) {
>                         if (tp->reg_access_reset_count < REGISTER_ACCESS_=
MAX_RESETS) {
>                                 /* queue reset again ? */
>                         } else {
>                                 ...
>                         }
>                         /* return 0 ? */
>                 } else {
>                         set_bit(PROBED_WITH_NO_ERRORS, &tp->flags)
>                 }
>         }

The above solution worries me.

I guess one part of this is that it replicates some logic that's in
probe(). That's not necessarily awful, but we'd at least want to
reorganize things so that they could share code if possible, though
maybe that's hard to do with the extra grabs of the mutex?

The other part that worries me is that in the core when we added the
network device that something in the core might have cached bogus data
about our network device. This doesn't seem wonderful to me.

I guess yet another part is that your proposed solution there has a
whole bunch of question marks on it. If it's not necessarily obvious
what we should do in this case then it doesn't feel like a robust
solution.

It seems like your main concern here is with the potential for an
infinite number of resets. I have sent up a small patch to the USB
core [1] addressing this concern. Let's see what folks say about that
patch. If it is accepted then it seems like we could just not worry
about it. If it's not accepted then perhaps feedback on that patch
will give us additional guidance.

In the meantime I'll at least post v5 since I don't want to leave the
patch up there with the mismatched mutex. I'll have my v5 point at my
USB core patch.

[1] https://lore.kernel.org/r/20231020083125.1.I3e5f7abcbf6f08d392e31a5826b=
7f234df662276@changeid

-Doug
