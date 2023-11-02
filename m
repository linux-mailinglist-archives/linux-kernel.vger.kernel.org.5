Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7077DF7E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjKBQqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKBQqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:46:46 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E8A123;
        Thu,  2 Nov 2023 09:46:44 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-581fb6f53fcso602645eaf.2;
        Thu, 02 Nov 2023 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698943603; x=1699548403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeWMjKX0A15+aNxn4tBa5TwI+egpnMwKMRDogqWOO5M=;
        b=dmYVWSlloEGHEDidIB5QPCqutn/vVoByMtXOcMFwL0i3Uv9R2pvZbnZEwUW1ihNva8
         JOZItTE2FFgunPBCTbMUjFUsgM+nHXj9vdNGT/6ypcUSynHnmXfNwVQ1CPrQvWO5w+3P
         mMz9zKMXSyFRzfH5MjrmGNvuoHNZg+OLLVQeu1cZ2j7xSYLOpghH1ODJGQzMOOrAkQ6M
         8KHncvrXoaM7ESQlvQFLvRGEtWclzvJzbrSz7mOiMQrFQ4LcJEbwTNzX/y5AtVvOyEQH
         KufUwnBWqzZjL/4CFQzMs5HHEVfCRlCSaTrV7HFKzntTUaExouSej1eEVioLJQoxXEbS
         S7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698943603; x=1699548403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeWMjKX0A15+aNxn4tBa5TwI+egpnMwKMRDogqWOO5M=;
        b=TeSYuGQ+dAAPnK4s9ica6RQCIAYUwqdRLYBc15Q3zv7LEAKBJKgAbPWPWGOvyhHAPm
         +MZwFNOmOjB/PEoEbQvLqnK/vg3BVmPva5xQA/McoIOLUMFzPkmIx/xf0gCSG68E3UOZ
         iPTaTEpfiu14FpHH8dn+JrqFEFAbbRo4GgTlnbUc1YTYO2lNNjrFez+84y5RRGdfLtws
         DDAgQ7xAdYCA8hiLajuKjneT+6H+Bo0A+dHHedtzFEsZYN3X9JS6ZJiSP/A3H+xGto2P
         HCwRb77TYvp++WCyD1Y1/hzm4WXTmlMTC5SyiaTBSXq94//A0k/EQML10sicc6Os8rZG
         sR2Q==
X-Gm-Message-State: AOJu0YyP70LZKywI5oJ4r6T/iJwL/7I5d1PKzwGWM1Drof2hWrZekq0L
        svrE1J7eRJJrDyeTV0A2saKzUAhA6z604C3DI8pPcSodgNU=
X-Google-Smtp-Source: AGHT+IGi+h9nfKMxWfkNHYa63s5ikFipizpFdekV2CzzhNGv3uYjimDjANsV7PGySPXJIYMaQ1MvmaevA82D+GZEbLc=
X-Received: by 2002:a05:6358:cc26:b0:168:eaf6:da1d with SMTP id
 gx38-20020a056358cc2600b00168eaf6da1dmr15718873rwb.30.1698943603529; Thu, 02
 Nov 2023 09:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231102132616.1130960-1-eblanc@baylibre.com> <CAHp75VdvR0H7XVLWGqdZqSgoHprUUPQHGiyWEEaHjTgEbeinqQ@mail.gmail.com>
 <CWOGMAUT9MKY.2IBKELIOR1CF7@burritosblues>
In-Reply-To: <CWOGMAUT9MKY.2IBKELIOR1CF7@burritosblues>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Nov 2023 18:46:05 +0200
Message-ID: <CAHp75VdV5A+WpWj2eY9o_2wwPB7GTi6Eig7YyV8urdv1P3utgQ@mail.gmail.com>
Subject: Re: [PATCH v8] rtc: tps6594: Add driver for TPS6594 RTC
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 6:17=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com> =
wrote:
> On Thu Nov 2, 2023 at 5:00 PM CET, Andy Shevchenko wrote:
> > On Thu, Nov 2, 2023 at 3:26=E2=80=AFPM Esteban Blanc <eblanc@baylibre.c=
om> wrote:
> >
> > > Notes:
> > >     This patch was picked from a series since there is no dependency =
between
> > >     the two patches.
> >
> > Not sure if RTC maintainer uses the b4 tool, but as I said in previous
> > email for pinctrl change, there is no need to resend. b4 has an
> > ability to select patches from the series to be applied.
>
> Oh that's good to know, I was not aware of that.
> I resent it because there was some minor nits that I fixed on both
> patches.

Ah, that was not reflected in the changelog...

--=20
With Best Regards,
Andy Shevchenko
