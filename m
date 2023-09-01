Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B245978FD32
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349423AbjIAM25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjIAM24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:28:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E110CA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:28:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so8161a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693571331; x=1694176131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1I6dpx5TUvkoEh56JEMyzHdi0osjSjPWIDUEWZsPuU=;
        b=rvM0gAhDWAou9kQB1YjnLXb3i4me0qEkmyY8yuGiX7UUxl76FEMAYU12pr2KRAeG28
         sw5v/dP8gZenp7RCpmI8EY6G2zY8mCBRl+x14yUsC+TOSULDeMfJ/Xev3Cj0ZsRjzr6X
         76lTCBV7eilggzpMTpGVO1lK2aeImo10oaRA4JgE/bVVD/ZGpJiAQuPDGuLB2ldBQSne
         bQEgbHlilc30OOSPKSkmqn73L1/HOnMm6HnJPEOYbisyOU1LZGI1kLgS3RgC5IIG4qbL
         q9QxVTR2kS3uBtJdW0n34B45PBd7RvIZCGBSz6DfLeQgW1IfNW+9Lva42LVTC+3vbrOE
         ml7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693571331; x=1694176131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1I6dpx5TUvkoEh56JEMyzHdi0osjSjPWIDUEWZsPuU=;
        b=D4Egg/eH6Ins1gAwkjebStFajL1eEB4qRMAZ3Z3gK9vkqguf2Slp7LUdTOzAb/7XIq
         1hmfen5uEtqeIOp8EUWcljtT5Y/AIWtdh21gEYkYwlH/hLiwB+ew8HgOfR+qNfs6j9KU
         kv77P3QOceu+3VH1bhzLGAjkchgf2sFk9XAD4PxtijAOFCAeqBtPHY5iYTco76UO2bRf
         erosMFFDv3AGaRDSvHe2cY69hL0CZv35aW08wLP7nV0qvEI+nedtWCnXS0IKQCwreUTj
         xBsGCdmjcUJdPkT3y5phH3y5RxmSsYFZAoQQA78BO8iH3Zc1sI1jW2IlnfjHoTGY+Dhd
         /m9g==
X-Gm-Message-State: AOJu0YyphV6ByxO6MUwqRle+wLGmk8Cm7St4iUlawOpDI6w9dFov0s2n
        cIGw+eIZr/cHLMDjNAcc32yo73VT+ADsdHVxpPxrZA==
X-Google-Smtp-Source: AGHT+IFIBLQiVlMj8bo8BxSFikphD3uKWvzg1eE7vOLenZ7xS6hW5kH9XwxQdd6iZmktD/GoAJt1cIajikiHK/TkjDY=
X-Received: by 2002:a50:9f84:0:b0:51a:1ffd:10e with SMTP id
 c4-20020a509f84000000b0051a1ffd010emr96127edf.3.1693571330962; Fri, 01 Sep
 2023 05:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230606140041.3244713-1-ptf@google.com> <CAJs+hrHAz17Kvr=9e2FR+R=qZK1TyhpMyHKzSKO9k8fidHhTsA@mail.gmail.com>
 <7aa7af7f-7d27-02bf-bfa8-3551d5551d61@gmail.com> <20230606142907.456eec7e@kernel.org>
In-Reply-To: <20230606142907.456eec7e@kernel.org>
From:   Patrick Thompson <ptf@google.com>
Date:   Fri, 1 Sep 2023 08:28:39 -0400
Message-ID: <CAJs+hrEO6nqRHPj4kUWRm3UsBiSOU128a4pLEp8p4pokP7MmEg@mail.gmail.com>
Subject: Re: [PATCH] r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
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

Hello,

I was wondering if this should be extended to all RTL_GIGA_MAC_VERs
greater than 35 as well.

Realtek responded to me but I was slow to get them packet captures
that they needed. I am hoping to restart things and get back to this
over the finish line if it's a valid patch.

I will add the appropriate tags and annotations once I hear back.

On Tue, Jun 6, 2023 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 6 Jun 2023 17:11:27 +0200 Heiner Kallweit wrote:
> > Thanks for the report and the patch. I just asked a contact in Realtek
> > whether more chip versions may be affected. Then the patch should be
> > extended accordingly. Let's wait few days for a response.
> >
> > I think we should make this a fix. Add the following as Fixes tag
> > and annotate the patch as "net" (see netdev FAQ).
> >
> > 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
>
> Perhaps it's best if you repost with the Fixes tag included once
> Realtek responded.
