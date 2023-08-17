Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD4577FF70
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355116AbjHQVBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355119AbjHQVBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:01:01 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4FAD3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:01:00 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bba6a9b565so3217241fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1692306059; x=1692910859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeoBo3Vxb/EshwMcCgSTIf6m36vMo06kvicDB/Y5hQY=;
        b=wiKNV8szwHJVWXuZWC+0JMmrijpCjmso/okaZuZp3vP8PzNOiCFKS1DGuHCukrTuID
         ASpg2wKEzYP82O0HJ41Ddm27xtacbYSW92okQhi0j12iIEkkrL2FWrdvGe4YqtDzI5qA
         wYZZRb8ujS/GP6l5tsGZklRQct+GtgGFlfgEkwSzA+Ad8O3swB+mjz0I4trDt8kMEeC7
         gvg5hzR9DEe0+UHYwJWjsBh6n5UDnhT/FJfbS71IQHBgVvM6uO4rsXBFPqTK5ipm/emc
         4f0RVGyuFHAGVICY4VTINfEbthQnfaL8yxc1Pddzp+bBIN+NXJodSsAPWv+rIYd/5mTN
         OvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306059; x=1692910859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeoBo3Vxb/EshwMcCgSTIf6m36vMo06kvicDB/Y5hQY=;
        b=k1jOJ3hqQUuomUDlXxweiJudCLiBJfNAy5ClAsvmvUEEwnb+tT3wtOvze/dounTpiV
         uaWkM8nSzeugvmjnF/qAHfq4aRQH3kYgSnzxUPxfPjjBZ8GH62//UaIQ6qKQoFpo7SVk
         W2pVi6qrCvi0/1SP+n13z1AZWFF35RvYMplHTpEg9vQYsSQqMj33epmBh9igEFy9vxg6
         /Ll3rio6NgcU5HDbbpzub9E4fgiHp1YffjjuxQrAm4mKPrJS+v9Rf76WLNku3X/GewQu
         2gkcyVd3Al2sPpqXTPkQCcOQoYJ593ZivJCUm+7tpRJICI9fcvFr4k0YxJCiqZE4xhCk
         O7Pw==
X-Gm-Message-State: AOJu0YzLAGwW7pnGDMWkqV+ssnbh6cUkWZhwBav3iQKNGO6nw3DueB+N
        xFJTGbA8dZYLGUM1pdNx9NTwP/Z2nmMBILYakOke4g==
X-Google-Smtp-Source: AGHT+IFRtxE5z3SLxeHMJAAAD7Xny2uI/enCW9Yws/prSoO4Y1+eutJcq1qW6/e4TYhN2sbf4fU4sQ6rI0Wp0o4NMhA=
X-Received: by 2002:a2e:9943:0:b0:2b9:f13b:613c with SMTP id
 r3-20020a2e9943000000b002b9f13b613cmr443995ljj.2.1692306058686; Thu, 17 Aug
 2023 14:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230724151640.555490-1-frieder@fris.de> <CAJ+vNU27A15eLWtFfHCOVn8JgawcgoGUAv2PhKmEf3wcoerPXg@mail.gmail.com>
 <CAOMZO5At6U9_JinNnumCqLMi2ER=3RZXDtsfdAEyjS35SvBaKQ@mail.gmail.com>
In-Reply-To: <CAOMZO5At6U9_JinNnumCqLMi2ER=3RZXDtsfdAEyjS35SvBaKQ@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 17 Aug 2023 14:00:45 -0700
Message-ID: <CAJ+vNU2_W-4+mk53aMkh-jed=QkSJuLisTs4x-b8qMXd5JTGDQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: bridge: samsung-dsim: Fix init during host transfer
To:     Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder@fris.de>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 1:59=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Tim,
>
> On Thu, Aug 17, 2023 at 5:53=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
>
> > Frieder,
> >
> > Sorry for the delay. Yes this resolves the regression I ran into. I
> > tested it on top of v6.5-rc6 on a gw72xx-0x with a DFROBOT DRF0678 7in
> > 800x480 (Raspberry Pi) display which has the Toshiba TC358762
> > compatible DSI to DBI bridge.
> >
> > Let's please get this into v6.5 as soon as possible.
>
> Care to provide your Tested-by tag?

Fabio,

Yes, sorry:
Tested-by: Tim Harvey <tharvey@gateworks.com> #
imx8mm-venice-gw72xx-0x with toshiba tc358762 MIPI DSI bridge

best regards,

Tim
