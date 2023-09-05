Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89B792AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjIEQoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353892AbjIEIcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:32:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F23FCC7;
        Tue,  5 Sep 2023 01:32:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c0d5b16aacso12942405ad.1;
        Tue, 05 Sep 2023 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693902772; x=1694507572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/q6jNtHSwHERulydP7Pe8HQtoEZ+Uz8MhsR1d8WvTBE=;
        b=gTC7z+PSa6Ovrc7+W1/5QQOURdvssFfWezhnQ7LG6sXs8cyrYKZtO1mMhG+HjrDgU9
         7sqrfhZDKCzHXPPF4zGwRTNHGU9IAIyJS38fGQM12fa/4YOuuofbdsnlMz0RvdwMWdrt
         b2GQO5rpOEQZ84bwX6GUAOEX9OEJB1VM5A5SQbk/WziwJKEQkvgwCKAJE8IP+bWpZ0DY
         +dCdqILduM8C1oLga/Rb8mX+mGHYhVh6NjlrCAyUmiEbpH/r3CBwKK8SQJ5ImNB89ZGM
         /DvE1ePx4phDqZwhVq6JOWitq4MuzqWgwSSCXuv0/0A9Brbgu3KRupJVDpklH6rEpX0r
         UgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693902772; x=1694507572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/q6jNtHSwHERulydP7Pe8HQtoEZ+Uz8MhsR1d8WvTBE=;
        b=UMwL1U6d5GijSAjSLyQ1R9ZLicfNqdLIyuccJzekIEq09pFb1C7wY43C0DT5TRYu5W
         41z3SwRtBdPX5tzvidFnMm0u7E0eOmW/NRYjjWonpE7cABbD1LfP6QRN1kWNWX1S69Wf
         8FcHg8UmQQuLKJngMmRmwl/JeC0LX9WCi+uagKGFmhAj2ujZ9txgDbsUqypJWzGeqLXj
         dBQuNpTyBY6ERn2YL3NgQiu+rrke5p60Q8YPqTSFo/Cqq4B23XVIZOFoEKcwq4brPgPJ
         wjiEDR+MtaMdoqM2MZWF81s2ufCwgdksfc6hwGtNLyeSJYM7v3SMeD3J7YIrgBSZNu3i
         HjjQ==
X-Gm-Message-State: AOJu0YybfvTzZYTkYOWBEuokjHXiJ/auwJzorOy1aykV16ckJkiaB7/z
        33Bjw6fa+O1cZyiQsllXxj8fHtJt+Lu4UvAiDmQ=
X-Google-Smtp-Source: AGHT+IH4h9i51nym+jesGSU5cRAI7CLzMCSnpmF7Tm2RMwaqhuxJS4ZYXdyV4+Zf/xer1JLzDJQR1ws+UfCoShomFXA=
X-Received: by 2002:a17:90a:e64a:b0:271:8195:8 with SMTP id
 ep10-20020a17090ae64a00b0027181950008mr8397207pjb.36.1693902771793; Tue, 05
 Sep 2023 01:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230607151127.1542024-1-pavacic.p@gmail.com> <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com>
 <CAO9szn00vRFm+iM1m7KgkW0WRuKyJEgVU4tVx4f5tF6KPnE=2w@mail.gmail.com>
 <CACRpkdaw8M3dSkmiV5QDOt3BBB7Jo6NxT0Og=zvA4REMA_7y9g@mail.gmail.com>
 <CAO9szn29A0qCABG0ACni42UGpsGKLwG7OT1y_ho3DgQ0WLvfmw@mail.gmail.com>
 <CACRpkdYXtQwmZR1u-1fwmyC_8Yq4bMkjDBcUCfuGqSz_UhXWJQ@mail.gmail.com>
 <CAO9szn0OuKW+-JZMs3TPUHiwLCe6cUPcsUq+og64K2utMyZpqQ@mail.gmail.com>
 <CACRpkdb5stXKb7FNk_FC-PKduCngRX3sZTbzcxN+kRskz78fuQ@mail.gmail.com>
 <CAO9szn3oTzrrwiyr91H14ep7OPUkA-SDST3CSQAQHvFFnkJWfA@mail.gmail.com>
 <0d43e653-32cd-b25e-40fa-6f0571048467@denx.de> <CAO9szn20RY3uBDceyUJ1S+gb=FN8Hd5qqMfOSbitHFyFCZ+iLg@mail.gmail.com>
 <8b0ae1d1-c769-1f55-0452-4bbc62da133b@denx.de> <CAO9szn1QdB5WGshuyCOGqb0qbBWHqoikeiMkk+bNGhAF5TX5ew@mail.gmail.com>
 <45488dcc-226e-1e7c-c681-c1d9be17bcbb@denx.de> <CAO9szn3scWfrP3mB8QnvPewZegV0=6iD8PE2bOS09HuN6gywmg@mail.gmail.com>
 <ff5270e7-573d-2700-881f-1358683f2618@denx.de>
In-Reply-To: <ff5270e7-573d-2700-881f-1358683f2618@denx.de>
From:   Paulo <pavacic.p@gmail.com>
Date:   Tue, 5 Sep 2023 10:32:39 +0200
Message-ID: <CAO9szn2Y8GubEpxMBp__1eHYhL9UqqfxzPWL0oOQPTs6TZ2oOQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
To:     Marek Vasut <marex@denx.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> The latest 5.15.y is 5.15.120 , can you re-test on that version ?
>

unfortunately it seems that I won't be able to do testing with
5.15.120. I won't have
access to hardware any more.

> > [   20.255330] Hardware name: XXX i.MX8XX board:XXX (DT)
>
> Is this some NXP downstream kernel fork with thousands of extra patches?
> The version string 2.1.0 looks very much like NXP versioning scheme ...

Yes, this is NXP fork of the kernel.

>
> [...]

Best regards,
Paulo
