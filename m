Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27478605F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbjHWTLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238299AbjHWTLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:11:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC62E7C;
        Wed, 23 Aug 2023 12:11:15 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so93681331fa.2;
        Wed, 23 Aug 2023 12:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692817874; x=1693422674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/z++L67LsgS5CeBHRbV3vQihN14HaxRSYn9ahWfvaI=;
        b=j5NWQxKgKxiyKasFqwOGDRncYcWX5tb0apAk/rligFF/9nY20cTHqm7QfzSbRog0Iv
         0zbr1xpLQEWG8tXsZL9ShwNI1thvgYstvYrUA3N0ykI4dn9niP6hJEqHDPaior3M107f
         da4TUZIyTOvU6BPFriAjPDBO72Q6UOnYo5ewB4aba1BgpTPSFm2HU7jvv7v1dfSb03DJ
         OXfluvr5aF8yRJOTsdTm/PR65j/oe851GBxxk6YleLdenxTv7EmHcj5qY6ADMzNQc7f3
         zeG86A0qlUwhgdbKVfM7B0SvA7rueFk3uffJeE/i/mxGUK8SDkOCy7I4sNO+GbH8xdhr
         grGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692817874; x=1693422674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/z++L67LsgS5CeBHRbV3vQihN14HaxRSYn9ahWfvaI=;
        b=aOg2+P4ayWMHYa+zcYQpjlYElJSTgKD5cPGpQ36dgmRYZOzOO00v63NKKOo8az2Qws
         3GPd4TeSRxzBgwbnzhHSY6muoV6bi+SN5TXmiXXZt4WAiUyXTDO2WkdMhIWzGBtpIHTr
         QBXPUuC6QgpyNlCdf2lN2eAqLYLmNhOaqQi9Jp5muYTXzV6Go5TlXPcUlYmN+SS9Vsxv
         byfnj/u8dCJutd5Q/FfHeXPI+bC5ivgfpZLpZadWxJJuAuQKKBH3YHyHdb0p5quHVYkV
         DAPhXmUgO38UBfP5HQKaOomJ3zeI79HTVS+COkVzukt0JAjAr77cB+u3IUs0WPL6WBKi
         FJAA==
X-Gm-Message-State: AOJu0YyQcRnQT0e9Hcb7ja8liJcV7q6mlErn5pgpHii353O/RQLSPt03
        fgUkbaqb4UpbopB6aCbjJ2k=
X-Google-Smtp-Source: AGHT+IFTKofw15kfmJaES5wnAO8K/GJ/mqB+Un+40kpOipUOrSBoQbYDlcpIRBkEZyL3pswrSrTZ0Q==
X-Received: by 2002:a2e:9104:0:b0:2ba:5ca7:2311 with SMTP id m4-20020a2e9104000000b002ba5ca72311mr10376164ljg.41.1692817873870;
        Wed, 23 Aug 2023 12:11:13 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id rv6-20020a17090710c600b0099cc3c7ace2sm10189735ejb.140.2023.08.23.12.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:11:13 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] genpd: Explicitly include correct DT includes
Date:   Wed, 23 Aug 2023 21:11:10 +0200
Message-ID: <12268735.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <20230823170438.2489746-1-robh@kernel.org>
References: <20230823170438.2489746-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 23. avgust 2023 ob 19:04:37 CEST je Rob Herring napisal(a):
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2: Previously sent for drivers/soc/. Gathered up files which got moved
>     to genpd to new patch.
> ---
>  drivers/genpd/mediatek/mtk-pm-domains.c | 2 +-
>  drivers/genpd/mediatek/mtk-scpsys.c     | 2 +-
>  drivers/genpd/sunxi/sun20i-ppu.c        | 2 +-

for sun20i-ppu:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


