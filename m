Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6067C0072
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjJJPfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjJJPfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:35:22 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A3DAC;
        Tue, 10 Oct 2023 08:35:17 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c64c2c0f97so3328897a34.3;
        Tue, 10 Oct 2023 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696952116; x=1697556916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndVd81mClEz/kosBkdySEFgzYfmv4B+oObJpOfkcufc=;
        b=IeT/u7G4psMEi4MzEe/Ce+isjkPADg1alwkNDnLxPL0XmooXdHvhlLTZID595k8MsK
         m+d8CjqC7kR2aXfiJE4GKFlip7kHg7YGr2b996jrG3+f0OBgS2v2HplWbPKcCGEcMoMo
         6g+O5ab8iGS5lJH1JWZndyRp2B7huYs57Lpcosoe7l8jDeyJRir9twCSG813JDmoHVLK
         /E26/2fa1bJyND9qLIEs9PP4nwgeGuzlTar5BcpFd1pitr6FlYhqNWUJNqtOH/jwYsz7
         evnObzHdEJRstaMqAuKtBqqxHShF8sxVRV+V3zY6DboXkgiJOvjwZRf8V/+AN8aBIBXm
         JacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696952116; x=1697556916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndVd81mClEz/kosBkdySEFgzYfmv4B+oObJpOfkcufc=;
        b=GI4CpdHvr4DuxDdaPX9Ygc35uf7jXAzqrLzn0Nt8+qWynB0yy9xfbkl9KtsiBYXfj8
         UvmuK8WE2rNN4HVWNA/IYmbpzGhGDfY/VSAqBSG6pkRp/oqhyLlc6oZLe2aCeXEjRIA7
         vgFVaCXOyZUB6qaowvcpeuRz6UbDBxcmGSB+gWl0FrsDhsFktAZ8aqY10+51aeo00vRf
         esG5Gp7iozXKwbHdgMwq1wusUFJ4p0ZbmnwK6AIzYCH0E8B8H7zkTowCtcB5ZbB2jpi7
         Bojq9/AzHg6VnN+Ygwd9VZwabSG0r5PD5bwsG1xaY9CHH+MPgZJgKbt3oXHiYkfv/TaN
         h9KA==
X-Gm-Message-State: AOJu0YwKwrkiR97EMBTg8ytRKBU5Ubj67U74Ck7OSywNgZlPaPY0Gl5j
        MCf3yVkAdUnu96WwLRdzOQs3PBRucAMdIlW5wOw=
X-Google-Smtp-Source: AGHT+IG+N+IBLEN5nf+W/LpicPkI30Fm/1TM+Prf6jRCdidly8Zin8PnZ6g64ry3oTTHTVSlAOtuL7FxHV1uFzE8BLg=
X-Received: by 2002:a05:6870:c6a4:b0:1d5:a4bd:6028 with SMTP id
 cv36-20020a056870c6a400b001d5a4bd6028mr18931770oab.8.1696952116450; Tue, 10
 Oct 2023 08:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
 <20231009083856.222030-7-u.kleine-koenig@pengutronix.de> <20231009111048.GF3208943@black.fi.intel.com>
In-Reply-To: <20231009111048.GF3208943@black.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Oct 2023 18:34:40 +0300
Message-ID: <CAHp75VdWnN1Uv0s=gFGp62DRs6SXk17FfEC6NYAEqQtgW_kGpg@mail.gmail.com>
Subject: Re: [PATCH 06/20] pinctrl: intel: lynxpoint: Convert to platform
 remove callback returning void
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 2:10=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Mon, Oct 09, 2023 at 10:38:42AM +0200, Uwe Kleine-K=C3=B6nig wrote:

...

> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Actually this one got skipped as there is no more ->remove() in the driver!

--=20
With Best Regards,
Andy Shevchenko
