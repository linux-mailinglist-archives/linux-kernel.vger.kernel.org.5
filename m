Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F79A77D7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241027AbjHPBZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbjHPBY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:24:58 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D89211E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:24:57 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9cf2b1309so70083501fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692149096; x=1692753896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVAK93nBTUhP03UZuT1wSrhAJPoyMfizbB0mnMkFNas=;
        b=ahfd2FaAavrzi1WwrrZRyko+Td2LG1bR1Kx8JkpslXiLojkeczYWrXEdljkM6tTOpY
         UTPRwzdsOw7G957HJYRC/tJQuMSYZ8gpYkyLo1rWJDEmX2ES9RKNxdygtLUMURLUKL/Q
         iqnDnAFVCBv8p9KqzyPGyyKGN+gGAJ2eKwaHDKhB1uwcwq6FsLOZQ8mTS/4Hf0K1GyJg
         C89fylfIHknOwBXlL01BP0Jns+seERmbowEaTVW1iMb8yCs8c0awrSddBYdqCiD7RaXT
         mi+z1q9AYRC8DHtU1WB/XbuOcE86ftmI3Hx2qqTUYTWqEljgYubDoj7gYk+U+RPiRU55
         A9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692149096; x=1692753896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVAK93nBTUhP03UZuT1wSrhAJPoyMfizbB0mnMkFNas=;
        b=BFs9UhkeTybKQ00ufoMucJkpasDjmrdyYqa1+qC9+7GAoen+/mQ8GS8Ig2HgeuQn6c
         GIafKrRzgkRBw1q+D02NUWgt6yJ3gpzlACjStqm6166x3uRTWu6rvu5zr/zEzlCF74DN
         EDUTcE2IyreoDHYqqgEBc4+ae/5gRkCJItOW8+xJZFrWksnt3EKkmQWJ+pr89atQ9BZz
         9XktnJxMt14bXYiOmtBF+svQAAU8dKe+24zxxRMUyyGnjWKR1DhhXMt7dv0as7zeWWL1
         f2X311b+ER70PGkPZvAJcHh2M/6kDQWAKX3yHTvmUynwSfdpWShQ9LLvCqsC9aJiBCaC
         SLqg==
X-Gm-Message-State: AOJu0YzVIiDDchXSSY8Mzl6v0oVs9tOmd38jUatvRXsx7Pijlvmw9ubi
        ZzXRY4Hbb2oUdRA7dGCutdT9CwO14RnCYoLDSo8=
X-Google-Smtp-Source: AGHT+IFTLod9nEOcAA015vv80e7zw9VzyF0KXxsw8tvfEjh9XCNhjDLoG+w7VN9zKo4o1hJPDTqYZ0kSj+F8v0pkGDk=
X-Received: by 2002:a2e:905a:0:b0:2b6:e6ad:25be with SMTP id
 n26-20020a2e905a000000b002b6e6ad25bemr236975ljg.3.1692149095805; Tue, 15 Aug
 2023 18:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230815020711.2604939-1-yunlong.xing@unisoc.com> <ZNuDxFGoXPCwECyt@alley>
In-Reply-To: <ZNuDxFGoXPCwECyt@alley>
From:   Enlin Mu <enlinmu@gmail.com>
Date:   Wed, 16 Aug 2023 09:24:29 +0800
Message-ID: <CAAfh-jM0B2Cn579B0CkCrW44pJGGvjs112K+oMuViib+jDKafg@mail.gmail.com>
Subject: Re: [PATCH] printk: export symbols for debug modules
To:     Petr Mladek <pmladek@suse.com>
Cc:     Yunlong Xing <yunlong.xing@unisoc.com>, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, enlin.mu@unisoc.com,
        yunlong.xing23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek <pmladek@suse.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8815=E6=97=A5=
=E5=91=A8=E4=BA=8C 21:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue 2023-08-15 10:07:11, Yunlong Xing wrote:
> > From: Enlin Mu <enlin.mu@unisoc.com>
> >
> > the module is out-of-tree, it saves kernel logs when panic
> >
> > Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
>
> I am fine with it. After all, this API seems to here for
> similar purposes.
Thanks.
>
> Acked-by: Petr Mladek <pmladek@suse.com>
>
> Of course, it would be better to maintain the module in upstream.
> Is there any chance to get it upstream? It seems that it
> is GPL-compatible so...
Yes, currently under development. Once the code debugging is stable,
it will be pushed to the community.
>
> Best Regards,
> Petr

Best Regards,

Enlin
