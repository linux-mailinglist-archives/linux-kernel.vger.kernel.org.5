Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88257CB05C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjJPQxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbjJPQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:53:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E1B19B7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:47:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9adca291f99so741966766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697474818; x=1698079618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZJGLg3D+ucnPrjgrPwyMGRdiSy2W8deAmYMGodOcfI=;
        b=NEgBRQbaelu7WBM/f6gS6aelPx9qGiijcDF9QrAsaEcxd2nbDBPfkt6SRE15soiIkj
         4lhnUUzbiQgr0ob70QDPjZEBMrV3IZssUtc554leeWxAglo687E41tJBtrgFf0eYNPFY
         IK351SzBgEJt4xIzj7mH/ob47iiM+1TOrWs04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697474818; x=1698079618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZJGLg3D+ucnPrjgrPwyMGRdiSy2W8deAmYMGodOcfI=;
        b=wC9sPlwGGka3lrnB6h5uxTMjRpNEA6Jra6hOR3J1Eux7uKY+fyNHAu41DF2RwgpjHz
         w/xCli+QKdY5UG6E+Wsh8sdUp/3neuFcMlWl2paupAP4/PIKYxfCKxDO0y82Y8cKiyZy
         /QWfb64gU7Pb8BTVWoNNBZGbBWnz1sLtBhT7FkfEKZ3xo2AbedwWvGO5hNnXzgItx0Q9
         L0b2IDvA1XKWXFtrP6QRED201HhNSUl/m9IdALGHAYJYuU2419xoDiqaAU4UjBXMRIFz
         VFsWdr3WnUcDguh48F0OpmagP1w5sCQR2g2iiYS9sCsA/L+U4g2pBk/TRLEqVyBbFksx
         vX3A==
X-Gm-Message-State: AOJu0YzvTz5Quz8zizE1Ick4bsmDKNnnsbThQDw46hsdqw5rqmHYFMG+
        2tIAc11+RDzI4r0X3X95yKbZZhRkn7R53UWw6Np64A==
X-Google-Smtp-Source: AGHT+IHgP1uNEc4gzgdxVYSv4JIl32twagLpf7M6wlE7ldGsKJQn1Zao4Ce8GKGrsa8AJFeK43qarA==
X-Received: by 2002:a17:907:1c26:b0:9bf:5df1:38cc with SMTP id nc38-20020a1709071c2600b009bf5df138ccmr5436267ejc.4.1697474818245;
        Mon, 16 Oct 2023 09:46:58 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id u20-20020a170906c41400b009b9720a85e5sm4366744ejz.38.2023.10.16.09.46.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 09:46:57 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4053f24c900so1145e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:46:57 -0700 (PDT)
X-Received: by 2002:a05:600c:3c83:b0:405:38d1:e146 with SMTP id
 bg3-20020a05600c3c8300b0040538d1e146mr211926wmb.4.1697474816851; Mon, 16 Oct
 2023 09:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231012192552.3900360-1-dianders@chromium.org>
 <20231012122458.v3.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid> <29f9a2ff1979406489213909b940184f@realtek.com>
In-Reply-To: <29f9a2ff1979406489213909b940184f@realtek.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 16 Oct 2023 09:46:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U4rGozXHoK8+ejPgRtyoACy1971ftoatQivqzk2tk5ng@mail.gmail.com>
Message-ID: <CAD=FV=U4rGozXHoK8+ejPgRtyoACy1971ftoatQivqzk2tk5ng@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] r8152: Block future register access if register
 access fails
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Grant Grundler <grundler@chromium.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 16, 2023 at 2:16=E2=80=AFAM Hayes Wang <hayeswang@realtek.com> =
wrote:
>
> Douglas Anderson <dianders@chromium.org>
> > Sent: Friday, October 13, 2023 3:25 AM
> [...]
> >  static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
> > @@ -8265,6 +8353,19 @@ static int rtl8152_pre_reset(struct usb_interfac=
e
> > *intf)
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
>
> Would you stay in a loop of unbind and rebind,
> if the control transfers in the probe() are not always successful?
> I just think about the worst case that at least one control always fails =
in probe().

We won't! :-) One of the first things that rtl8152_probe() does is to
call rtl8152_get_version(). That goes through to
rtl8152_get_version(). That function _doesn't_ queue up a reset if
there are communication problems, but it does do 3 retries of the
read. So if all 3 reads fail then we will permanently fail probe,
which I think is the correct thing to do.

I can update the comment in __rtl_get_hw_ver() to make it more obvious
that this is by design?

>
> > +        */
> > +       mutex_lock(&tp->control);
>
> I don't think you need the mutex for testing the bit.

Sure, I'll remove it.


> > +       if (!test_bit(PROBED_WITH_NO_ERRORS, &tp->flags)) {
> > +               mutex_unlock(&tp->control);
> > +               return -EIO;
> > +       }
> > +       mutex_unlock(&tp->control);
> > +
> >         netdev =3D tp->netdev;
> >         if (!netif_running(netdev))
> >                 return 0;
> > @@ -8277,7 +8378,9 @@ static int rtl8152_pre_reset(struct usb_interface
> > *intf)
> >         napi_disable(&tp->napi);
> >         if (netif_carrier_ok(netdev)) {
> >                 mutex_lock(&tp->control);
> > +               set_bit(IN_PRE_RESET, &tp->flags);
> >                 tp->rtl_ops.disable(tp);
> > +               clear_bit(IN_PRE_RESET, &tp->flags);
> >                 mutex_unlock(&tp->control);
> >         }
> >
> > @@ -8293,6 +8396,10 @@ static int rtl8152_post_reset(struct usb_interfa=
ce
> > *intf)
> >         if (!tp)
> >                 return 0;
> >
> > +       mutex_lock(&tp->control);
>
> I don't think clear_bit() needs the protection of mutex.
> I think you could call rtl_set_accessible() directly.

Agreed, I'll take this out.


Unless something else comes up, I'll send a new version tomorrow with
the above small changes.

-Doug
