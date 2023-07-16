Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDEB754F80
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGPPxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjGPPxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:53:36 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E0E12B;
        Sun, 16 Jul 2023 08:53:34 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55adfa72d3fso2085769a12.3;
        Sun, 16 Jul 2023 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689522814; x=1692114814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abs11f8UHVu+fecLFEFwp0PW6/N5LPbHdu0gV+3y038=;
        b=ctFvETFr7bnJxUyExlXVogWAbDtwrZb9lVS8wjLMPmQtSNPHo3RiCI3D7RdOxnIdrg
         KbpcR1/UGhV4a5YawvKmm5xtctdaHE1Y2dXbL26fFQTaSX0YKeOV/OdxIyJKbt1uS4ux
         hJ+ypmbBTYuU/0+8zlCOkLGZN66xLUmjqjAzH+ld2Hhc9blh4Fq49cy4IOIvpkuA8rk8
         /T2QY0isHdD4iT54ky3nzir6HJuvASdSxwNzDb72h452fN816pfKhntGQz8sr5XV+/mt
         rAP4H23HyPcXpC+ErWLpMO/vyJHPu+an9200hVB3cUpgW4fAlnPVVUgrdnVB3YhPXzqZ
         Z30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689522814; x=1692114814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abs11f8UHVu+fecLFEFwp0PW6/N5LPbHdu0gV+3y038=;
        b=lR7ajQHIhRukgdvXEXm/qsppedfvycqQ4jyGa+hdyfincUD2DCTcXGyW4fhuPq5c0g
         5PRF7RV7vS8rHMHHcy6nKp30tNjjBMCFTJ31G4LUI1NAvcPBchh8Jl1cco/wTeAGp6YC
         hROFD921E0uAN+P/HgKTbDOlhJdD71ioS6sQKQxh7RBt4WLuPIeot3U3V50Ewt0q80AL
         NkuIQhhiuR4I8NgkXBxQjuuqFSild89bUEzDBqkOy5Ny1O4NTbIuOrT0shyKFMO0wgea
         um8RgpeJTQGjbITCewW1H93B3SvhFvYx8fxAHjLfp+0lskDR8AB8qJZp8p4utIeuwI1U
         fECw==
X-Gm-Message-State: ABy/qLbi6x4ZwwKsnMaEa6GoH3ChPJjqZmtLjh4uKcbjKjm5eK4NN1lO
        i+Iy+7FpXZ70fsQS2XwLmkanzf20V/n8KPX+TV4=
X-Google-Smtp-Source: APBJJlEGQtfsRwz1XtspqBQl34vmpvD+Dei7LRAoFDGxKuzO815i+XyeZQE6FVEUNXOjwbyrPM/p7K+ru97TpSRLgWA=
X-Received: by 2002:a17:90a:eb12:b0:24e:2e86:5465 with SMTP id
 j18-20020a17090aeb1200b0024e2e865465mr8674012pjz.31.1689522813638; Sun, 16
 Jul 2023 08:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <ZLO450xOIQ29VoBT@zephyrusG14>
In-Reply-To: <ZLO450xOIQ29VoBT@zephyrusG14>
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Sun, 16 Jul 2023 15:53:22 +0000
Message-ID: <CAEwRq=rUXpFpkrfKyCG8Eede10cCeo6V3RCDxv0McWA_g9t0CA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4 boards
To:     Yogesh Hegde <yogi.kernel@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
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

Hello,

On Sun, Jul 16, 2023 at 9:32=E2=80=AFAM Yogesh Hegde <yogi.kernel@gmail.com=
> wrote:
> Commit f471b1b2db08 ("arm64: dts: rockchip: Fix Bluetooth
> on ROCK Pi 4 boards") introduced a problem with the clock configuration.

Maybe you should add a "Fixes:" tag.
Look at:
Documentation/process/submitting-patches.rst
for details.

Cheers

--=20
Vincent Legoll
