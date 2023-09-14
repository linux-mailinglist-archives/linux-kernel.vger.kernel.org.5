Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0694D7A11F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjINXkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjINXkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:40:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1A11FE5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:40:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so5724672a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694734800; x=1695339600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20RRzKZLtjTRYGrIOvHQDuGLhkZQtE0VsAgSgkickKw=;
        b=BMR683HUJujNfUzFXbJhPk0Rp/IwHqn+5393dS7Eh7HHtuv1al2nzMeLilAONnf/cE
         0gkxGAV9aolELuj8kwHihgvk+vGw4Ll4S4uzsCljs1rwy+7QyLK0YBNBBt01wkfsnxyA
         3H0yYCPRV9wRwkwDaV8ZcnPPOuTJywYERLSeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694734800; x=1695339600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20RRzKZLtjTRYGrIOvHQDuGLhkZQtE0VsAgSgkickKw=;
        b=dAkd+JpskECftmAF2/LwftcYND7O8qLo2OCyNLQdo71f8k0YP3lIsEkldlpaxKPRH4
         PIfApzIX7JjScVfz+hPY7V/OIobjWmHAqb94WMCXEaOLHdF9qnSyE2wicEtVOjN+zY/0
         m9W2qCxgjJvPyS2t5L4Dzk7W5UZYq6iZCtKlicMmQ5VBazVKTnWf7qY7nS1K57n6prvR
         he1tILUycWqfFlFDLifFiOMy3tTy3QzwqwdEoInOAayyEG4WSsGYhf8yKf0tsRks7Apt
         Ytvh/DuJC7v8oiyiV+97zM2sDsKrXICgP2M4uTudCR5FqDKHNXzHLw+hNT1KvjuqnF+W
         Km7w==
X-Gm-Message-State: AOJu0YyPgAEEADqDpYXsWLmvoHjnbc2n2gBTWGQUj7ds9bmciEq03kCK
        gyKT6UePVoXKEakcLAMOZO+FNu0x8ngjgD7n18nElA==
X-Google-Smtp-Source: AGHT+IGNR1TcxDylCIi6+M678wfMB8bw16xmGIi09K4xK+PXEARajpILw3KHnCTwOFK+5OzT6ZtRIA==
X-Received: by 2002:a17:906:8a6b:b0:9a9:d5d1:35a4 with SMTP id hy11-20020a1709068a6b00b009a9d5d135a4mr121838ejc.7.1694734799829;
        Thu, 14 Sep 2023 16:39:59 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id bj26-20020a170906b05a00b00997e99a662bsm1609105ejb.20.2023.09.14.16.39.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 16:39:59 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso15395e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:39:59 -0700 (PDT)
X-Received: by 2002:a05:600c:22d4:b0:3fe:ef25:8b86 with SMTP id
 20-20020a05600c22d400b003feef258b86mr64827wmg.4.1694734798662; Thu, 14 Sep
 2023 16:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230823071306.131373-1-sheng-liang.pan@quanta.corp-partner.google.com>
In-Reply-To: <20230823071306.131373-1-sheng-liang.pan@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Sep 2023 16:39:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XUW+9F-gUV57bBYMn0wgM4Axr9MM5X8kBXoDekJo3AfA@mail.gmail.com>
Message-ID: <CAD=FV=XUW+9F-gUV57bBYMn0wgM4Axr9MM5X8kBXoDekJo3AfA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add no-esim sku for sc7180-lazor family and new
 board version for audio codec ALC5682i-VS
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Wed, Aug 23, 2023 at 12:13=E2=80=AFAM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
>
>
> Changes in v6:
> - commit update, add dependent patch link
> - remove unnecessary symbol
> - sort out the order of properties
>
> Changes in v5:
> - rebased on patch moving rt5682s to a fragment
>
> Changes in v4:
> - combine pathc2 and patch3
>
> Changes in v3:
> - correct corresponding of new board and new sku
> - sort out the node order alphabetically
>
> Changes in v2:
> - add new entry rev9 with Parade bridge chip
> - correct newly create dts files
>
> Sheng-Liang Pan (2):
>   dt-bindings: arm: qcom: add sc7180-lazor board bindings
>   arm64: dts: qcom: sc7180: Add sku_id and board id for lazor/limozeen
>
>  .../devicetree/bindings/arm/qcom.yaml         | 31 +++++++++++++
>  arch/arm64/boot/dts/qcom/Makefile             |  5 +++
>  ...sc7180-trogdor-lazor-limozeen-nots-r10.dts | 29 ++++++++++++
>  .../sc7180-trogdor-lazor-limozeen-nots-r9.dts |  6 +--
>  .../sc7180-trogdor-lazor-limozeen-r10.dts     | 45 +++++++++++++++++++
>  .../qcom/sc7180-trogdor-lazor-limozeen-r9.dts | 10 ++---
>  .../dts/qcom/sc7180-trogdor-lazor-r10-kb.dts  | 23 ++++++++++
>  .../dts/qcom/sc7180-trogdor-lazor-r10-lte.dts | 27 +++++++++++
>  .../dts/qcom/sc7180-trogdor-lazor-r10.dts     | 19 ++++++++
>  .../dts/qcom/sc7180-trogdor-lazor-r9-kb.dts   |  4 +-
>  .../dts/qcom/sc7180-trogdor-lazor-r9-lte.dts  |  4 +-
>  .../boot/dts/qcom/sc7180-trogdor-lazor-r9.dts |  4 +-
>  12 files changed, 193 insertions(+), 14 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozee=
n-nots-r10.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozee=
n-r10.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.=
dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte=
.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts

This patch series would also be keen to get landed. As mentioned in
the dts commit, it depends on the other patch I just pinged, AKA:

https://lore.kernel.org/r/20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3=
e01923220@changeid

If there is something outstanding that needs to be changed, please yell! :-=
)

-Doug
