Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5F577BCFF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjHNP3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjHNP2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:28:49 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B336F10CE;
        Mon, 14 Aug 2023 08:28:48 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56d0d7300d9so3407210eaf.1;
        Mon, 14 Aug 2023 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692026928; x=1692631728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCvHBwn8CD2knwCB3WcjLa+i49354PVrQZORJ/R7fww=;
        b=WWCj667pWIPBS80FaFiXp3HGyT7gRYNopLWlbsklMerG5TtrFzbhgvtSFy1q4YEBWH
         OVdiLwOA+dvYblrcvZt0+tXailL5/aBp7sTpWI+EhMCjUSL6M5GKRbhgRjqyZGV6ZtTY
         lzHgi6yHvTLdfz2KiD0EKSfFIEW7b7taj/NUACjXgGIftuVA10Z0DGxn7E/hxQPi0fwR
         l2asn14MA0Xsob26qICK1PjmuLK1RSSfZuxXwdmVKjq/vu1NgSaYuL/ZcMhL19HWSxJc
         /8DhfiGu7P1QSUXFjv2zRQZRcjtb4N355L7rWXivjXKgFQjQrsE39WU6eGnJYZqf26Qy
         LBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692026928; x=1692631728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCvHBwn8CD2knwCB3WcjLa+i49354PVrQZORJ/R7fww=;
        b=JefqFVjHiIgwrt1QhBC+lQf62kyP8Vx4Yl3+x5scju7VwzbrZwmg2hkaPK0qy6nWft
         h/694Y5C91Ffl++cVEsskOc8QYQ8A23Imq2FVb37CxWB7YbQCerhzKNWcjrSuNN/dHQD
         rwxcW9yhrV7KtLplKtvxCBp7LdFIrxLzN1N6GpRmojMORDGAymB7ZImfJhhTw0cSXF11
         yop0d3EXLNHV26vfOvz+dDnbUxVxdkRIRtgg+pDX5FEYzWjxcOvRv5MgrzrminRsnxed
         2stZn0LztBXmMxqOXFyuJlNVr2hhrsru3U6OPB7NTrz8DrgpMj2rj5dDCs8HA1wmXumk
         mDuw==
X-Gm-Message-State: AOJu0YyjKhgCBCSrV37dQLPFTwQI342cgei3czb/LlFhM0cCweB2bb+k
        RM5Iw7Wxc3GXuWCX3UHBTy/Ry+iHmrT00HM4FgY=
X-Google-Smtp-Source: AGHT+IGISBrg3aobCyozkZXvvOgi+agc5YUmPvbQpaXwwjPo0coUaZI8wHsySCLw5oNfPPu4pieuC/gPF7XqXFX2SlE=
X-Received: by 2002:a4a:6557:0:b0:560:ac0f:b87c with SMTP id
 z23-20020a4a6557000000b00560ac0fb87cmr7695073oog.8.1692026927978; Mon, 14 Aug
 2023 08:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230814073924.1066390-1-arnd@kernel.org> <a6c2f193-ef7c-54a0-dfbb-13915be259a1@163.com>
 <1834eee9-3fbd-4bea-9e22-960ca993303c@app.fastmail.com> <672725bc-6ebf-0a35-96ab-8862be7de193@redhat.com>
In-Reply-To: <672725bc-6ebf-0a35-96ab-8862be7de193@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Aug 2023 18:28:12 +0300
Message-ID: <CAHp75VcR2k=ko4esuO=KNeZRQxeGojTxKeozRGCB+EXrGXgoSQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: simatic: add PCI dependency
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "xingtong.wu" <xingtong_wu@163.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andy@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Haeussler, Gerd" <gerd.haeussler.ext@siemens.com>,
        "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
        "xingtong.wu" <XingTong.Wu@siemens.com>
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

On Mon, Aug 14, 2023 at 11:51=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:
> On 8/14/23 10:48, Arnd Bergmann wrote:

...

> Right P2SB would benefit from being changed into a hidden
> symbol.

Yes, I dunno why it wasn't that way from day 1. Perhaps due to the
original contribution done by somebody else...

> Andy, any comments on making P2SB a hidden symbol ?

I'm fine with that.

--=20
With Best Regards,
Andy Shevchenko
