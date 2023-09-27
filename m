Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7697B06DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjI0ObQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjI0ObM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:31:12 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BA1CC7;
        Wed, 27 Sep 2023 07:31:04 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d865685f515so11845303276.1;
        Wed, 27 Sep 2023 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695825063; x=1696429863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XcH3Kg4tqaXqUqMGIX62DqKGdxuMvU3zUQWNdRoSWU=;
        b=TX5h1zCnWPGDjUTUVKGIHt4DhaM6dHet5po93pn0BPDwOjnwPUpalc1uJlGHbWNQdN
         jFKDIuNI6tQn2RWyK/mZkm3YMPXgSbnFSKpRyULidm6fDGplVMfyWhHTB+72szsvi4FJ
         c/qUA1AY0Cw6kcdaNiluEoBRVy1HYyByfg54mYqk/O3pflvJk/PJPrI0DLTf74HWCbZL
         b618avgu/o1Yam3gn7nYi+lIsj334ytyGWGgwrn2wynsgyMDFiBKm8JtMvVXe1KEJaYj
         KJcDDklazDhYTxHnC0um+TCJdbApUBE6IgNTMIzi5nw9Bu6CgKqZTzNqmMeTaOzIK7Iu
         DW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695825063; x=1696429863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XcH3Kg4tqaXqUqMGIX62DqKGdxuMvU3zUQWNdRoSWU=;
        b=Tgd1faJawegb3CXuE+EUNRmKIPl9QFzNYLXyuuz3rilyO4ag676TxxjEQgwv+UPWOp
         xtNPIIoZIkkdx9cFcaiywS2Ajl2RD5L+6Yrmlp5T0jPFuXfg2NdxdL+XnxDi/gQUybBp
         lQ+LZ3sj5nw2Cb6QmSdH6L/mIxPyPXM6mae8RgSe94igkGZAwW7f7qH08UWkyE/m7HZt
         a8PlBfylXNiSbMaUioB1SM3VjunwSEUqe1k6sjxz51QPlT4F+D7LwTr+wBw57IR2cOER
         8NnYw7449YI3JLJNTWxeuPsHvCEXZQ0ehQNxoCj3PXwEoAk8u2IJ2ISP3SKNxcly7scA
         B8wQ==
X-Gm-Message-State: AOJu0YwcqQ88sbpUt8Z+M/vABcLSxvjwp1w9aM25ctriu8Skcs+UMRnD
        eLFQe1NyzCaJP7yoMzscRvtRipZB9k5YgqmWwDE=
X-Google-Smtp-Source: AGHT+IGIaO2Tlhc7AHmo2IhY2FbTkDnzNzwRH/dCMK4WzzYx3iWVKy6RrzH1eJ55DkG9Gy4zUeGJ8/NjX4+Ek9fyZ+c=
X-Received: by 2002:a25:688d:0:b0:d47:3fcc:9911 with SMTP id
 d135-20020a25688d000000b00d473fcc9911mr1867935ybc.2.1695825063536; Wed, 27
 Sep 2023 07:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695819243.git.mazziesaccount@gmail.com>
In-Reply-To: <cover.1695819243.git.mazziesaccount@gmail.com>
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
Date:   Wed, 27 Sep 2023 16:30:52 +0200
Message-ID: <CAFukWp0TM+v7Y93gFuHL2_ihefxxPmDkGT4R9nmruL70D7KNZA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support ROHM KX132ACR-LBZ Accelerometer
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hello Matti,

On Wed, Sep 27, 2023 at 2:56=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> The ROHM KX132ACR-LBZ is an accelerometer for industrial applications.
> It has a subset of KX022A (NOTE: Not KX132-1211) functionalities, droppin=
g
> support for tap, free fall and tilt detection engines. Also, the register
> interface is an exact subset of what is found on KX022A (except the
> WHO_AM_I register value).
>
> This series adds own DT compatible for the KX132ACR-LBZ and also own
> chip-info in driver to allow handling the different 'WHO_AM_I' value.
> The separation of the Kionix KX022A and ROHM KX132ACR-LBZ does also
> allow adding support for the KX022A tilt/free fall/tap engines which are
> not present on KX132ACR-LBZ.
>
> Matti Vaittinen (2):
>   dt-bindings: iio: Add KX132ACR-LBZ accelerometer
>   iio: kx022a: Support ROHM KX132ACR-LBZ
>
>  .../bindings/iio/accel/kionix,kx022a.yaml     | 10 +++---
>  drivers/iio/accel/kionix-kx022a-i2c.c         |  4 ++-
>  drivers/iio/accel/kionix-kx022a-spi.c         |  4 ++-
>  drivers/iio/accel/kionix-kx022a.c             | 34 ++++++++++++++++++-
>  drivers/iio/accel/kionix-kx022a.h             |  2 ++
>  5 files changed, 47 insertions(+), 7 deletions(-)
>

You could also mention this device in the list of supported devices
under drivers/iio/accel/Kconfig

--
Kind Regards
Mehdi Djait
