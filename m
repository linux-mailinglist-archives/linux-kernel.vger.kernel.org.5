Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46253781473
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240461AbjHRUwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbjHRUwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:52:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D3C30C2;
        Fri, 18 Aug 2023 13:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF9C264631;
        Fri, 18 Aug 2023 20:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A666C433C8;
        Fri, 18 Aug 2023 20:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692391926;
        bh=2591KLTh34UdCImi9XsrGqT9RFuSjRzducgPr6mHRwc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RgxU+SV7mH3znQsNZFqDW5Yp5aTzKPsOHkAq5Z3fgA1k++Tp5ozEF9HHf6YWVEZlw
         wB9yWIxvCRnXiRL14T4vEiY8sn4YmSLv0bIoGZew3iQRC/VwAhzi5RgFixqTQfYRSj
         KRQ7Qmpc6S+QPNYcZnCRT9a8Fs8BxPM0EZpp3Qe8+fMCjlSeT2rlrw/LoU2QTS9fIu
         /nfWUNvYT0sMBKOEJ0SkzFBjGFRbxpeNn/0ceuNc9AY60srOZXGFyuzA46RuVDh8zD
         rppPP7+Y8HEF/dKG84UO5DJQ68oL9hdpoO2hc1nXigob2ysgsxvJ7i4PM3PO7vvHzl
         fFpfMzLSINX5Q==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so20611191fa.3;
        Fri, 18 Aug 2023 13:52:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YyMCJcSJuF5eavKoop/r24wIqUvXI4SK7XnaCVdyFd04TyoSHTW
        vMAE3Vn8F69MykVTCUPnh2YoWAtvIjIl9qdDYg==
X-Google-Smtp-Source: AGHT+IE+Ok/XyvO+uFADbXPAxOEICkIRa47fmEPW0YlmMjo/NQsJesPj00UvPrW+8iAiJ0f0mYLDfEnZR4zKfIGzn8c=
X-Received: by 2002:a2e:98d2:0:b0:2b6:e958:5700 with SMTP id
 s18-20020a2e98d2000000b002b6e9585700mr268641ljj.4.1692391924315; Fri, 18 Aug
 2023 13:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
In-Reply-To: <20230818153446.1076027-1-shenwei.wang@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 18 Aug 2023 15:51:52 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+XA_P-aRK9_WuGPmJ0_xJgsSr9smZy4BRbKZbmVsMQBQ@mail.gmail.com>
Message-ID: <CAL_Jsq+XA_P-aRK9_WuGPmJ0_xJgsSr9smZy4BRbKZbmVsMQBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, imx@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:35=E2=80=AFAM Shenwei Wang <shenwei.wang@nxp.com=
> wrote:
>
> Documenting the regulator power domain properties and usage examples.

This needs to answer why we need this.

It looks like just an abstraction layer to make regulators look like a
power domain.

Rob
