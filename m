Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D3D7A1F92
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjIONOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjIONOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:14:52 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEED1BEB;
        Fri, 15 Sep 2023 06:14:46 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-56a8794b5adso1731275a12.2;
        Fri, 15 Sep 2023 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694783686; x=1695388486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeXQAgEvCG5lWU7YEjnooq5zm07TURELH4onh5xtUHg=;
        b=SF6/yCazStqz90JyRnf4bGTsvxmvNUL5qe+jxCom9j2QOvqvu62tTyruQtDyqFhskK
         GMP6Prg7zpkMpACf9Vg88HyjADobrUbXdwD97fy/5TKrlZdzx7gyrYjJgcXHiV8Xp/Kv
         ZNbBbwiX9PXMKwEyC+4Jp/+9sncNBT8JaZX9bwzoPJiADxZsQlDqM3+/C4wwKzk04NaI
         QTSHzm1XBNGCM6x9fk0RcQAzU0w4jZ0/5Ws4MCAs3M8SoFu/D83y8rodDaORO5SScLad
         J3h3l6TPnzH71ZxfazwtTUAhVcIvoB4UZw2Mx8aJiIqsSMbA2jP2ird01ZODQuXHUw0H
         +tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694783686; x=1695388486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeXQAgEvCG5lWU7YEjnooq5zm07TURELH4onh5xtUHg=;
        b=IB0kVRYS9S/7+Thmm1zy1uOxtecuMQD3pnS8mz8IEYvlpZdAGGGaleFHjUJr13OAjw
         iplalxMLsSy46B71/1Jt+cyr8NfyrXBm11qs5LVC+5pVvPu07JquO6B3IIlxRb0AaQ2U
         tUydNsPQxi3F6q2awKggihSpTKENn4KF9YhsV1wxbJVyIUZ7lGQsKRQb697b75SKaZjP
         K5zX9LSAIIU2L0QspwOXUSaQrDxyR/9tqefaYyXPZ4xSV+cfCJ9eXcK2XSHN1HPcnwqj
         pqjR31Rjt/x5rvgt3CrFonl7886sHNaOeP46wFKb5+7Z2/BUg2Y85j0ad+Itd0jdTdnx
         Jp4A==
X-Gm-Message-State: AOJu0YxmIH4ut09bYNJFrXx2c7PHxv0kRQ63feJ/8TSC30/XU7LDZ3ii
        Zj4UlY6fi8rt9h+H+DALWYJ3boAm0HODe+0sb9NqvKqv5RY=
X-Google-Smtp-Source: AGHT+IGwQdOfBBcGiIToYcNqwva/3tvlNZxrGwwaqB/mVbsMDwp6XECrBHtfCJ1OyOlS/idai/gsl5ynbq923kvw+3Y=
X-Received: by 2002:a17:90b:88f:b0:271:9e59:df28 with SMTP id
 bj15-20020a17090b088f00b002719e59df28mr1287536pjb.29.1694783686026; Fri, 15
 Sep 2023 06:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230911140959.2046340-1-longqi90@gmail.com> <f4f0ed21-1e3b-a7c5-79f8-3469c4cfc471@linaro.org>
In-Reply-To: <f4f0ed21-1e3b-a7c5-79f8-3469c4cfc471@linaro.org>
From:   Zhang LongQi <longqi90@gmail.com>
Date:   Fri, 15 Sep 2023 21:14:34 +0800
Message-ID: <CAC0WRTWr66kUnaTvdJXWP=hw1MmXB=5R+zqn0OgOqNqGr==BdQ@mail.gmail.com>
Subject: Re: [PATCH] fixes the pin settings of two LEDs on board nanopi neo plus2
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Krzysztof, I will modify and submit.

sorry for the previous email which is the html format.


On Mon, Sep 11, 2023 at 10:42=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/09/2023 16:09, longqi wrote:
> > Signed-off-by: longqi <longqi90@gmail.com>
>
> Thank you for your patch. There is something to discuss/improve.
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
>
> Your commit msg is missing. Please describe the bug or the problem thus
> it will be obvious why this change is needed.
>
>
> Best regards,
> Krzysztof
>
