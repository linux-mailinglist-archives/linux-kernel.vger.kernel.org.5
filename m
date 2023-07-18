Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6157574C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjGRG6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjGRG6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:58:41 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396781738
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:58:22 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-78374596182so265137139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689663501; x=1692255501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpRPsRseawRNMEQyVyymjJ3tqvGUqABUcHLZuDbCtO8=;
        b=Txh+ojcbrW4FTKOnB4V+1u1wCrKzM4bX8retJLdEX9GNay9NiKJNk7whalb6vINRP4
         tChw1Tw39Bpz6SzLjkSXoT/dkJLGREdBhwVR/T/KmljpeXQyFZh7C7XGQFx6CCuOuW4J
         gBe1SsW53Ca3nFPq6dwrCpBKVhU2NBPfRQOZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689663501; x=1692255501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpRPsRseawRNMEQyVyymjJ3tqvGUqABUcHLZuDbCtO8=;
        b=Lp3Dt4lQZJxShLOR+Z3QMSgklr+GeHd1ncwCPBXkboBbuOoeydPl7rY1wEakvicsEz
         8zSw/cIHbFM+QyWYO2aXEFnJR4hgnzeb2Ck98+NBFwaaYQYiFAv6LgWrr8equwHU+u4P
         4ZuCbdbsRlVBD+ivGPTnwyatyOL/GdjF81u4bo6NBwLHoVwwPJHbklvqWEfOBOs9DNWI
         IZkWqQjWXW4SCB4beuD8DfcTGBYM7dZ7PEfPdv/Ji8pgwC8KVbynIUEVbtuuh6M6md12
         bpTRTnSQMTDwZowPQDCu/9yNu4VPNlI2IOC6mxSMvTbDh1dhbRJx4U0kWSTSy7GDUQKx
         Ma9A==
X-Gm-Message-State: ABy/qLbqfliDHoEpEuZSCWiEmRVMrEaoQzFw4JpSLmfosafDG5pJtC4Z
        yTLkXc+x9ADmLVQ4OtQ15M5kz7tnpufEDjTCiEw=
X-Google-Smtp-Source: APBJJlGImUrChdT1mgPZxJWakMhy8sEDBX+HdzAhpoje6IkFZjg7O3o28WT56gt35YjjYwbl+GsHEw==
X-Received: by 2002:a05:6602:257c:b0:787:8cf:fe4d with SMTP id dj28-20020a056602257c00b0078708cffe4dmr1571920iob.11.1689663501350;
        Mon, 17 Jul 2023 23:58:21 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id h16-20020a0566380f1000b0042bbd3e49b9sm373401jas.24.2023.07.17.23.58.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:58:20 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-78374596182so265135839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:58:20 -0700 (PDT)
X-Received: by 2002:a6b:f60d:0:b0:787:1a8f:1d08 with SMTP id
 n13-20020a6bf60d000000b007871a8f1d08mr1573813ioh.15.1689663500438; Mon, 17
 Jul 2023 23:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230717173934.1.If004a6e055a189c7f2d0724fa814422c26789839@changeid>
In-Reply-To: <20230717173934.1.If004a6e055a189c7f2d0724fa814422c26789839@changeid>
From:   Fei Shao <fshao@chromium.org>
Date:   Tue, 18 Jul 2023 14:57:44 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhFP6+fo-OU86PzCMtK77x+X23C1O4Bt=hxOsC+xzVGig@mail.gmail.com>
Message-ID: <CAC=S1nhFP6+fo-OU86PzCMtK77x+X23C1O4Bt=hxOsC+xzVGig@mail.gmail.com>
Subject: Re: [PATCH] spmi: mediatek: Fix UAF on device remove
To:     Yu-Che Cheng <giver@chromium.org>
Cc:     James Lo <james.lo@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 5:41=E2=80=AFPM Yu-Che Cheng <giver@chromium.org> w=
rote:
>
> The pmif driver data that contains the clocks is allocated along with
> spmi_controller.
> On device remove, spmi_controller will be freed first, and then devres
> , including the clocks, will be cleanup.
> This leads to UAF because putting the clocks will access the clocks in
> the pmif driver data, which is already freed along with spmi_controller.
>
> This can be reproduced by enabling DEBUG_TEST_DRIVER_REMOVE and
> building the kernel with KASAN.
>
> Fix the UAF issue by using unmanaged clk_bulk_get() and putting the
> clocks before freeing spmi_controller.
>
> Reported-by: Fei Shao <fshao@chromium.org>
> Signed-off-by: Yu-Che Cheng <giver@chromium.org>

Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>
