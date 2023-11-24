Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37907F84DB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346057AbjKXTqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjKXTqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:46:19 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3939A93
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:46:26 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35c767a9e76so38825ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700855185; x=1701459985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj3LV0uh4tcYVh+QVdDebQdSeI5pw/VXJnEd0vmrfC4=;
        b=UBNL18XmfyQr9hxl9uZSj/Uu9yD0QINYBtxB02DqWOWOsSWxMNQoilhhj5K102oiMs
         5l7KIXgjh2SAZEkcF7u6rKIO38JFVyXufNtrenuAv5DGGbn784r3iDH7PozZfYMIXVfF
         ubOSTC3K4tSGHiL7x33nDKs03558dr8o0PSkgG/1zCzXNQeC/iMCIS1Ogq6pLAPO0JSN
         RsYtwObcOWGnCcu3j5Iv60mQE96/xXUFmPd7r2+7Af4+aPVqJ/+t84hOnAuN3ATTTFl/
         NRGnlRFskfbjwt7xCd0TGDqCeUPY5JyVvvrCl44VW8vJcRJ+cJFYriNljp7oAm5uW1/t
         Qi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700855185; x=1701459985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj3LV0uh4tcYVh+QVdDebQdSeI5pw/VXJnEd0vmrfC4=;
        b=H1ww0kAG2i+teVZa/f1i8pVlEMVJFw79Zuq8FjFBpwFgqGpxx5JCTtGFfuS5qzWDra
         j5tC8MBLoZ7wQk4Jwj4ZIgvAkKI50nks4vck7hVcbHLXtj4twqKvkQpFSQ99Tj14BAy/
         8bqlX+Ip27eQovDDkVe/v6VHrlWIcX8/bQtBI68gqF7E+pcH9u66NEwrErX8T+HD+o7j
         3wfQV8fsVUIoVcGmQbta15vXwA+NRxxiVZTHaFimtkxKYiM5MOuXF/oRleZEL8CbyQmB
         HQBcsZ1bzZWW33ZYMDsekiOEEofrkoLY9S6yFbMdCEtotOBcBkHus9VEYnmqr/1vOT7w
         GvyQ==
X-Gm-Message-State: AOJu0YwHSlkLstw2iJEjuK47N1CD2gG6NRuFTwlqGanh9CrTEjxgBHed
        NbnnIBK4VA5RwXFWNRxmEvVKPc89eaFIJrAELvKK9A==
X-Google-Smtp-Source: AGHT+IG0dkghPqdI2MPDAlvUTwUJELhT/D90bgFXuX0z+ezsgl0QHdKsWo4WeND0UY3oXfty43OGyCmCyt2JcVWe+rQ=
X-Received: by 2002:a05:6e02:1a0c:b0:35a:faac:aee0 with SMTP id
 s12-20020a056e021a0c00b0035afaacaee0mr497567ild.29.1700855185427; Fri, 24 Nov
 2023 11:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20231120220549.cvsz2ni3wj7mcukh@skbuf> <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
 <20231121094354.635ee8cd@kernel.org> <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
 <20231122140850.li2mvf6tpo3f2fhh@skbuf> <20231122143618.cqyb45po7bon2xzg@skbuf>
 <20231122085459.1601141e@kernel.org> <20231122165955.tujcadked5bgqjet@skbuf>
 <20231122095525.1438eaa3@kernel.org> <CA+FuTSe+SOFciGf+d+e=Co22yZ56gGGkJ0WBbvfT-2P0+Ug8DQ@mail.gmail.com>
 <20231124172754.tneftor7uobrul5f@skbuf>
In-Reply-To: <20231124172754.tneftor7uobrul5f@skbuf>
From:   Willem de Bruijn <willemb@google.com>
Date:   Fri, 24 Nov 2023 14:45:46 -0500
Message-ID: <CA+FuTSc7aEokNcY2sJeDZQe3_iV9ARC_1hov=9-wTzdMAkcayA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 12:28=E2=80=AFPM Vladimir Oltean
<vladimir.oltean@nxp.com> wrote:
>
> Hi Willem,
>
> On Wed, Nov 22, 2023 at 01:11:02PM -0500, Willem de Bruijn wrote:
> > There already is a disconnect between configuring hardware timestamp
> > generation. Through the ioctl, which is a global admin-only interface.
> > And requesting timestamps with SO_TIMESTAMPING.
> >
> > Today the user of ptp4l already has to know that the admin has
> > configured the right RX and TX filters. That is no different if
> > multiple filters can be installed? (PHY for PTP, DMA for everything
> > else).
>
> Are you saying that ptp4l doesn't configure the RX and TX filters by
> itself, just the admin had to do that? Because it does.
> https://github.com/richardcochran/linuxptp/blob/master/sk.c#L59
>
> I'm not seeing the disconnect. SO_TIMESTAMPING is for the socket,
> SIOCSHWTSTAMP is for the configuration at the device level.
>
> It _is_ different if multiple filters can be installed, because either
> we let things be (and ptp4l issues the same ioctl which affects the
> default hwtstamp provider, which may or may not coincide with what we
> intend), or we teach ptp4l to deal with the multitude of providers that
> a port may have.

I see. By disconnect, I meant that the socket option is unprivileged and
can be set by many processes, while the ioctl is a global privileged
setting, so must be under control of a single admin.

But I did not know that ptp4l can take on both those roles for PTP.

Perhaps multiple SIOCSHWTSTAMP rules can coexist, up to
one per level:

HWTSTAMP_FILTER_PTP_V2_EVENT, level=3DPHY
HWTSTAMP_FILTER_ALL, level, level=3DDMA

Then ptp4l can manage all levels except the DMA level. And DMA
timestamps can be configured independently by another admin.

If only one timestamp can be communicated to the host, the earliest
match must takes precedence. Jakub pointed out how one device
handles this by having a separate queue for PHY  timestamped
packets.

This does not address the issue that packets with different
precision skb_shinfo(skb)->hwtstamps->hwtstamp may now exist
in the system. All packets reaching ptp4l sockets must have a high
resolution source, but there is no explicit annotation to ensure or
check this. This is fully based on trusting the HWSTAMP_FILTER.
Expanding the skb infra and cmsg might be follow-on work.
