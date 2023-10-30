Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80B87DC13E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjJ3Uff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjJ3Ufe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:35:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CA2AB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:35:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so413a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698698130; x=1699302930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vFDjtAEsjttTI22sc8G5a8nAtIAx3Cy/lcAcpUigTY=;
        b=SU8CnUDUyoZlJpXvqMJkWC+vPGTkTDyBMerx/C/B4IWlvmtpGHb5yLQ5IsEG4IZeoA
         k8H0fggV7DvD5UwkM0cc1EcRY38tLsenUJSwZ4QNStbyUH8Q/xpq++su6yxSN1f8Li4y
         HF/F6yoWX9mF/CY9DqkGQ1Lawz9547uCEMrbul71fXxGorqOgQC8TlVrfx8fdQHVi7GS
         HpuIAkNrOIHLvMRSRDfkJgMCFq73KWgc4voaBZSMxkkQje81nKw4S8xUVcy8Sg9UUDeG
         68rmAkod+JNp3nce/7hCgaXY8eoDtbV7PQ7AJfaWz7hTKMLg6LmxnPQWiJJ5eXtlhnGZ
         5y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698698130; x=1699302930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vFDjtAEsjttTI22sc8G5a8nAtIAx3Cy/lcAcpUigTY=;
        b=dgCeF3MZ4zQ6vdhb8ekuPQNXicY4jZuNmdV+rqIjYjzwbHH1M02BvXfsTP3EBwra0m
         ZImoxZ2/8z6KIBuk7EsW3Ob//qWuf+xow5QEWQ8HUudsOIdfeUjTiFI72Go2n24/+wFW
         HffcJen7rXkZQLQsCE647jXO3R570WoQiDXBCyWJ5QMmjJWpxlrTMJGZaSjceRgSdTz+
         2/MHgp3DzP2fDzROOOMfcBpWrCBkbZjQVhuIbRhfKE8yPNQgUCT9QlFklsYLihnCYi89
         ecJ+VPMTrNMvUIoEc1AnnjwuVpAjNcLt8yRX2bWHp0kWGYV+pjTZejTSYXHme6EB7w/w
         p3cQ==
X-Gm-Message-State: AOJu0YzhHDLjp62MMFsfvrx4nV5PopMlvVStKf9KX+hCCDFmrq/3cVDS
        O9hqrGP9r9ecB4C/Dy/7sVhw59W1qgFvj41K8rrJXg==
X-Google-Smtp-Source: AGHT+IH31+TiFXNuUyrjrcqRDXnwTQqwKlPmSQHk8e8Z0SC06WDOD05Veu2EH0W5nMXTlXnkAfTM4lJUkj0e/XKNmcM=
X-Received: by 2002:a05:6402:d69:b0:542:d79b:9529 with SMTP id
 ec41-20020a0564020d6900b00542d79b9529mr8777edb.7.1698698130518; Mon, 30 Oct
 2023 13:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231027213059.3550747-1-ptf@google.com> <415e0355-7d71-4b82-b4fc-37dad22486a9@gmail.com>
 <CAJs+hrEi8oo1q5mMfNbaUi8x1H-sBGmYToTkRfVXs=ga9LPupQ@mail.gmail.com> <cd23aed9-a792-4baa-ba1a-701e6512ce30@gmail.com>
In-Reply-To: <cd23aed9-a792-4baa-ba1a-701e6512ce30@gmail.com>
From:   Patrick Thompson <ptf@google.com>
Date:   Mon, 30 Oct 2023 16:35:19 -0400
Message-ID: <CAJs+hrGe=uyxa3Pp9sAQphjfopGRWKiRY55Tamwa6X68faBsyg@mail.gmail.com>
Subject: Re: [PATCH v2] net: r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     netdev@vger.kernel.org, Chun-Hao Lin <hau@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        nic_swsd@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The packet being filtered out by the multicast filter has a unicast
destination address matching the device, the frame only contains the
eapol protocol and does not have an IPv4 address associated with it.

I will send out a v3 patch with VER_48 included.

Sorry, I sent a non-plaintext email previously so I am resending it.

On Mon, Oct 30, 2023 at 3:38=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 30.10.2023 17:52, Patrick Thompson wrote:
> > I wouldn't trust the mc filter, the eap packet being filtered is not a
> > multicast packet so I wonder what else could be erroneously filtered.
> > I do agree that it would be nice to be able to override it for testing
> > purposes.
> >
>
> I'm not an EAP(OL) expert, just read that EAPOL can use unicast,
> broadcast , and ethernet multicast (01:80:C2:00:00:03).
> What's that target MAC and IP4 address of the packet being
> filtered out in your case?
>
> > Would you like me to add MAC_VER_48 to the patch? I would not be able
> > to test and confirm that it affects it in the same way I have for
> > VER_46.
> >
> Yes, VER_48 should be included because it has the same MAC as VER_46.
>
> > It is unfortunate that the naming doesn't quite line up.
> >
> > On Sat, Oct 28, 2023 at 4:38=E2=80=AFAM Heiner Kallweit <hkallweit1@gma=
il.com> wrote:
> >>
> >> On 27.10.2023 23:30, Patrick Thompson wrote:
> >>> MAC_VER_46 ethernet adapters fail to detect eapol packets unless
> >>> allmulti is enabled. Add exception for VER_46 in the same way VER_35
> >>> has an exception.
> >>>
> >> MAC_VER_48 (RTL8107E) has the same MAC, just a different PHY.
> >> So I would expect that the same quirk is needed for MAC_VER_48.
> >>
> >> MAC_VER_xx is a little misleading, actually it should be NIC_VER_xx
> >>
> >>> Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> >>> Signed-off-by: Patrick Thompson <ptf@google.com>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> - add Fixes tag
> >>> - add net annotation
> >>> - update description
> >>>
> >>>  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/=
ethernet/realtek/r8169_main.c
> >>> index 361b90007148b..a775090650e3a 100644
> >>> --- a/drivers/net/ethernet/realtek/r8169_main.c
> >>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> >>> @@ -2584,7 +2584,8 @@ static void rtl_set_rx_mode(struct net_device *=
dev)
> >>>               rx_mode |=3D AcceptAllPhys;
> >>>       } else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
> >>>                  dev->flags & IFF_ALLMULTI ||
> >>> -                tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35) {
> >>> +                tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35 ||
> >>> +                tp->mac_version =3D=3D RTL_GIGA_MAC_VER_46) {
> >>>               /* accept all multicasts */
> >>>       } else if (netdev_mc_empty(dev)) {
> >>>               rx_mode &=3D ~AcceptMulticast;
> >>
>
