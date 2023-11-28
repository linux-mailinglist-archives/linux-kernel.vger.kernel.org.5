Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FED7FB99C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343981AbjK1Lrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjK1Lrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:47:51 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B9BD56;
        Tue, 28 Nov 2023 03:47:57 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c1f8b0c149so3531471a12.3;
        Tue, 28 Nov 2023 03:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701172077; x=1701776877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P3miOdRF8CVqoKdjsClbnFzB/CKQ8+AB4xxyVwupsac=;
        b=f6TSC6NdEADf9wk8hDPSQXkzH2lhKzkiPM2jt8kqttBgLj1dw6SsNDg2ocvLbPaTwl
         4KZt1SMFb6izY+xuFhcdVdeKYK+WsKM3uZXCISy2jdf+2AsO57A1U8kV7RPITYyPx2k9
         nhR+QSeQGsPTh2mG/uL2maNf4g6SaKpJerZbv89evFDzVQOseE5LzU+ku/NmUJchmwj2
         /c32sSyiTZNxGPx6bUNLyHwkLGi2NLhOhTMWcFacCa7sWt6ojLKuaiLfsNnf+C7xmUx8
         OJVJnzFvEAalkxnZD4ocLbyMcWAyroZlY3B94HTCcpNFKav0tiGdWYeKBPb6b7aSeDXM
         9utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701172077; x=1701776877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3miOdRF8CVqoKdjsClbnFzB/CKQ8+AB4xxyVwupsac=;
        b=py6aM5UhwGZ4HhcHACgjfQRtH4GT6XzBX7QD9Jxg6qQzOc8HPsv4t6Up2A2heRbBbW
         sIKdoaV7Gl6U5qYgP6HX6iuR/AqsHoWjWPajh5Dffx5OizMq+ZVD/wMU/x1bVsnhS28e
         4oFuPOuEUpDY7xv5wLXuTZTqwPH/BLZunD2WsBeWF72tPM+WLm6O9WAlUsnUdzebm1BC
         abB3O6LvAPV0FFdQYvurqL+cN2qdUCEGmpzYN+JdGsCoqQXQcmGX460fEo+hM6XckqWA
         SoxvElvEmvBd2SseL102feHI3Dr6oal+zRZX/d1C6yaKjd+4lkb1Zh99nfrteUg4y9q2
         sH1g==
X-Gm-Message-State: AOJu0Yw1i8gkzYZBLx5UU3WF1kd7bf6H6hpwHu0OV6ruv64NIA8RJ+UV
        2bnyUhbKV2lRH9a9R4WYxOhhfsgYq5xPm/zpX94=
X-Google-Smtp-Source: AGHT+IEJDz+a7w4MmU1QcbLhcfRSij8f9BClowYOaPWqb0FDEI3GQrhi4bbaoMYafN+B5LLAZLAKf6DFN6neXD0aQUA=
X-Received: by 2002:a17:90b:1c8b:b0:285:6943:eca2 with SMTP id
 oo11-20020a17090b1c8b00b002856943eca2mr14359531pjb.29.1701172077284; Tue, 28
 Nov 2023 03:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20231117100958.425354-1-robimarko@gmail.com> <ZVdgmpvI+F4ClNmG@shell.armlinux.org.uk>
In-Reply-To: <ZVdgmpvI+F4ClNmG@shell.armlinux.org.uk>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 28 Nov 2023 12:47:46 +0100
Message-ID: <CAOX2RU7izQLrHQsTK9cFYEGtoE9=xOVTx64o7w-JZpg-+wYvuA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: phy: aquantia: validate PHY mode on AQR107
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ansuelsmth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 at 13:46, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Nov 17, 2023 at 11:09:48AM +0100, Robert Marko wrote:
> > The Aquantia driver is not setting the PHY mode itself, but it does however
> > still check if the PHY mode set in DTS is one of the supported modes.
> >
> > However, the set PHY mode does not have to match the actual one, so lets
> > add update the PHY mode during .config_init and warn if they differ.
>
> This looks completely wrong to me. These PHYs can be configured to
> change their MAC-facing interface mode according to the media negotiated
> speed, but you are only checking that _if_ the media is up, then the
> interface that has resulted from that negotiation matches what is in
> DTS. That could be dependent on the link partner, so what works for a
> platform when connected to one link partner may issue your "info"-level
> warning when connected to a different link partner.
>
> So no, this to me looks completely wrong.
>
> You need to check the VEND1_GLOBAL_CFG_* registers, and determine from
> those what interface mode(s) will be used, and then use that to validate
> the mode.
>
> It just so happens that...
>
> http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?h=net-queue&id=f7b531ee8855f81d267a8a42c44da51576f48daf
> http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?h=net-queue&id=f55389aa5d11da8a32dfd65a1b98049878ce09f0
>
> builds a bitmap that can then be tested to check this. Whether the
> above is entirely correct or not, I can't really say, I don't have
> enough information on this PHY.

Hi,
Yeah, I get the issue now.

Nice, those got merged into net-next, so I will iterate by using those.

Regards,
Robert
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
