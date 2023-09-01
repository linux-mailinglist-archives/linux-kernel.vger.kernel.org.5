Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D49878FEE6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349974AbjIAOUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349960AbjIAOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:20:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEBC10F2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:20:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so9852a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693578021; x=1694182821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLYc3vJ+1jGUSwUQ2/6dymNSsyl9qkwUUYtxF6WyxJw=;
        b=2tfbcEwe0FPb5STb54hDNn+vHAGxRhrjXH190OnX6yXy26JH7tFnY0jtbG1iezDIA6
         n2REe+/c6z3ZqEom8fo8oxZoovPVoT2XUBzIH8+FJK6OLh3Y4MtT7ZVCx652s8iyy0iC
         V3QFxkbCJXgDxUZFyBn/4cnz1OH82V1VVKbZ/JKLBJfnNtauWGPKwlMw3ji0iutrcyyW
         VfouyVXdqfAYVSgPMUwQ3KPYGgYTeiEs6j/hh8CN+wlTpf3iuImLPSn4UPKehGCzibDJ
         1l4SbVqptRDw6Gca5JnGr8JB3bg+Atb23AUuRAXYoxK7TbvjODG9qq9TuW1nKhSbJgLv
         uNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693578021; x=1694182821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLYc3vJ+1jGUSwUQ2/6dymNSsyl9qkwUUYtxF6WyxJw=;
        b=BlY/igEXlKdWWY2koPqthvXJ3iHkG3nmlYxoX2rLIrtotttaAqHaYhvGRzJcEokkYT
         LG1Ja3LcBO8GN+YEyHq4s61m30lMIXGwwQLoY+RQRQLjLTXuE2ebAHBn/mohWa5UsoGL
         Sc3e3XSjTC8ELhlRKMOKJv5SN7/MuCfg+Z+1Bu1gOTUNj4sTszfhvtEUXRMLCtbHziRM
         /NWIRx9FgcQsZ1IMlDXygqOgukUftFKI0W8sFv3ELCOIPQdDyoW2uPhpylVHbudjZFJf
         9JvR5chmWYl+pMM0tWO455R5VaR7dr41bjLlHtOBziWT4VE9vlsy6nznEAvz2ili7lAq
         8dEg==
X-Gm-Message-State: AOJu0YzSUuCSSVmtrinkZV1g7aT/tRS3MHHjdg0hMkFaMLuQvYeRVgp/
        B6xGT+jIiBwiaIY0IsJyRhTcr5mt9UZ5JQ6Uk2zmVA==
X-Google-Smtp-Source: AGHT+IE6fqZNxfUiGPgMvrGpigzvO9Rm8Cr5t8QclfJHuwLJqwIUeKNnkpKrOdMXSwPYk16Aapf7gLbmTuVpnWuLLjc=
X-Received: by 2002:a50:8d5c:0:b0:525:573c:643b with SMTP id
 t28-20020a508d5c000000b00525573c643bmr116417edt.7.1693578020944; Fri, 01 Sep
 2023 07:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230606140041.3244713-1-ptf@google.com> <CAJs+hrHAz17Kvr=9e2FR+R=qZK1TyhpMyHKzSKO9k8fidHhTsA@mail.gmail.com>
 <7aa7af7f-7d27-02bf-bfa8-3551d5551d61@gmail.com> <20230606142907.456eec7e@kernel.org>
 <CAJs+hrEO6nqRHPj4kUWRm3UsBiSOU128a4pLEp8p4pokP7MmEg@mail.gmail.com> <5caf123b-f626-fb68-476a-5b5cf9a7f31d@gmail.com>
In-Reply-To: <5caf123b-f626-fb68-476a-5b5cf9a7f31d@gmail.com>
From:   Patrick Thompson <ptf@google.com>
Date:   Fri, 1 Sep 2023 10:20:08 -0400
Message-ID: <CAJs+hrGmHF4EHsYGVPCosSNOE075CzTsP1d9hppMNXAB1n=JAw@mail.gmail.com>
Subject: Re: [PATCH] r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        nic_swsd@realtek.com, Chun-Hao Lin <hau@realtek.com>
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

Okay sounds good. By the way, here's the patch where the VER_35 logic
was added. So one question would be are there more chips without
multicast hardware filters?
------------------

From: Nathan Walp <faceprint@xxxxxxxxxxxxx>

commit 0481776b7a70f09acf7d9d97c288c3a8403fbfe4 upstream.

RTL_GIGA_MAC_VER_35 includes no multicast hardware filter.

Signed-off-by: Nathan Walp <faceprint@xxxxxxxxxxxxx>
Suggested-by: Hayes Wang <hayeswang@xxxxxxxxxxx>
Acked-by: Francois Romieu <romieu@xxxxxxxxxxxxx>
Signed-off-by: David S. Miller <davem@xxxxxxxxxxxxx>
Signed-off-by: Herton Ronaldo Krzesinski <herton.krzesinski@xxxxxxxxxxxxx>
---
drivers/net/ethernet/realtek/r8169.c | 3 +++
1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169.c
b/drivers/net/ethernet/realtek/r8169.c
index eb81da4..e19e1f1 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -4271,6 +4271,9 @@ static void rtl_set_rx_mode(struct net_device *dev)
mc_filter[1] =3D swab32(data);
}

+ if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35)
+ mc_filter[1] =3D mc_filter[0] =3D 0xffffffff;
+
RTL_W32(MAR0 + 4, mc_filter[1]);
RTL_W32(MAR0 + 0, mc_filter[0]);

--
1.7.9.5

--

On Fri, Sep 1, 2023 at 8:48=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.co=
m> wrote:
>
> On 01.09.2023 14:28, Patrick Thompson wrote:
> > Hello,
> >
> > I was wondering if this should be extended to all RTL_GIGA_MAC_VERs
> > greater than 35 as well.
> >
> I *think* the mc filtering issue with version 35 is different from the
> one you're seeing. So not every chip version may be affected.
> As there's no public errata information let's wait for a statement
> from Realtek.
>
> > Realtek responded to me but I was slow to get them packet captures
> > that they needed. I am hoping to restart things and get back to this
> > over the finish line if it's a valid patch.
> >
> > I will add the appropriate tags and annotations once I hear back.
> >
> > On Tue, Jun 6, 2023 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >>
> >> On Tue, 6 Jun 2023 17:11:27 +0200 Heiner Kallweit wrote:
> >>> Thanks for the report and the patch. I just asked a contact in Realte=
k
> >>> whether more chip versions may be affected. Then the patch should be
> >>> extended accordingly. Let's wait few days for a response.
> >>>
> >>> I think we should make this a fix. Add the following as Fixes tag
> >>> and annotate the patch as "net" (see netdev FAQ).
> >>>
> >>> 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> >>
> >> Perhaps it's best if you repost with the Fixes tag included once
> >> Realtek responded.
>
