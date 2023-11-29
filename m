Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C544D7FE1DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjK2V1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjK2V1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:27:14 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7712170A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:27:08 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a002562bd8bso47311766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701293226; x=1701898026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ka42P07XD3cUN5FmdYHNdz0HlIW/qLMANiOksrtIlmU=;
        b=Y6QhwAfEG0WiSrtFokzSRFvATNtVphVuV7Xrwfn0KCnHhcAP9syha/MMvcIG9kEDwb
         fWZGsK3wO957wSdYBxMaA++cJiM/vBti1DMOK4rz5mDe4B/PtJu9kd7e4GT/Yj/1c+S3
         GuIqgpQ+GmIpwFXcE6u+8e09KA/JPU+wd8Aj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293226; x=1701898026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ka42P07XD3cUN5FmdYHNdz0HlIW/qLMANiOksrtIlmU=;
        b=UQ2D760jVpN4ck/RguvlgzSMO7onSgq7L/DNlJkEfLOW/MzMvlvE9EETlRb78OhIMr
         bGXHWdKgqP9pbB8qTDoBN0RLaC4hjdGbgRq70dLS5fclbhWp+GJ5Mwf2Us7yP9ATMFOQ
         fSNKmiHMWmyHajZ4kJxw8wmnXC61sevAZhwSb15BISoV+frqw9WKVLXHQgr4PXHcYZBt
         0uPLFZOyJJpSpd9WaIzR/M98fI/4y8zP4gnN1fN9Djc3g1xld7PFZoWQBMWeLLf0xNbD
         I/FK8v2xBBowgBJs6o+8BTAaiUxsKkzw0F1ODBzHWPGhAc5GjEil0gi80a2KTmhDydVl
         VkIQ==
X-Gm-Message-State: AOJu0YwNlIb7n5nIpSEoUi1Ud9jFzx9d/6fhHtDEXH50Gg56Wk/1kzNR
        FgeJIwCEuLzEvK+rkaWEUASXL8G+8uGzo6qRUAJ66Vi8
X-Google-Smtp-Source: AGHT+IH9RCRsVZyu+nw28uwWL+IpBoI9Y+ohfIwhM4PoO+rBahYgCQBx9Gj1LREono+GWvLgy/I8CA==
X-Received: by 2002:a17:906:11e:b0:a01:ae9a:c1d3 with SMTP id 30-20020a170906011e00b00a01ae9ac1d3mr19197353eje.11.1701293225999;
        Wed, 29 Nov 2023 13:27:05 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id r5-20020a170906c28500b00a0b66ef92dfsm5834755ejz.218.2023.11.29.13.27.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 13:27:05 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40b35199f94so21555e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:27:05 -0800 (PST)
X-Received: by 2002:a7b:c415:0:b0:40b:33aa:a2b9 with SMTP id
 k21-20020a7bc415000000b0040b33aaa2b9mr40631wmi.4.1701293224778; Wed, 29 Nov
 2023 13:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20231128133811.net.v2.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
 <20231128133811.net.v2.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid> <d6f843b90b7146059332c82159ba79ff@realtek.com>
In-Reply-To: <d6f843b90b7146059332c82159ba79ff@realtek.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 29 Nov 2023 13:26:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VOdj5z76Rvue93MUriGhX2Arijo-ZMifHw=qO6kxbjtQ@mail.gmail.com>
Message-ID: <CAD=FV=VOdj5z76Rvue93MUriGhX2Arijo-ZMifHw=qO6kxbjtQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/5] r8152: Add RTL8152_INACCESSIBLE checks to more loops
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Laura Nao <laura.nao@collabora.com>,
        Edward Hill <ecgh@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Grant Grundler <grundler@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Simon Horman <horms@kernel.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 29, 2023 at 4:47=E2=80=AFAM Hayes Wang <hayeswang@realtek.com> =
wrote:
>
> Douglas Anderson <dianders@chromium.org>
> > Sent: Wednesday, November 29, 2023 5:38 AM
> [...]
> > @@ -3000,6 +3000,8 @@ static void rtl8152_nic_reset(struct r8152 *tp)
> >                 ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, CR_RST);
> >
> >                 for (i =3D 0; i < 1000; i++) {
> > +                       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> > +                               return;
> >                         if (!(ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CR) &=
 CR_RST))
> >                                 break;
> >                         usleep_range(100, 400);
> > @@ -3329,6 +3331,8 @@ static void rtl_disable(struct r8152 *tp)
> >         rxdy_gated_en(tp, true);
> >
> >         for (i =3D 0; i < 1000; i++) {
> > +               if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> > +                       return;
>
> I think you have to replace return with break.
> Otherwise, rtl_stop_rx() wouldn't be called.
> And, you may free the memory which is using, when rtl8152_close () is cal=
led.
>
> >                 ocp_data =3D ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CT=
RL);
> >                 if ((ocp_data & FIFO_EMPTY) =3D=3D FIFO_EMPTY)
> >                         break;
> > @@ -3336,6 +3340,8 @@ static void rtl_disable(struct r8152 *tp)
> >         }
> >
> >         for (i =3D 0; i < 1000; i++) {
> > +               if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> > +                       return;
>
> Same as above.

Good catch, thanks! I've changed all of the `return` statements in
this patch to `break` for consistency, though for the other ones it
doesn't really matter. For patch #3 I also changed the `return` to a
`break`, but for patches #4 and #5 the return was better so I left
those.

v3 posted now with this fix.

-Doug
