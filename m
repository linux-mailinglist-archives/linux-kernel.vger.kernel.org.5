Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCDE7F1DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjKTUQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKTUQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:16:05 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21730C7;
        Mon, 20 Nov 2023 12:16:02 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c88750e7d1so10141321fa.3;
        Mon, 20 Nov 2023 12:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1700511360; x=1701116160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UN/JaGs58VC/59LNr+VTcKEJIUnlEUBkYK0zXNn4XiM=;
        b=RgP6LbXNj8T/rWOEBj+R++Mu7IMJuqWdFn6TUIlD6NNy3Kks8f2op+6RUbhjlIasDz
         Itt33d2X0W/SO8vvbx7Jh39rK0Mv85+gvMWw/k8hqNER3biUd8zkM3XnbM7sodxGZS27
         I60kvj+d/iARZWLGQx1T6KsJnwBm7PVSXXdJFeSETX6NvUfygsX1AYU+ORb6wZ6mSsoB
         GtS0Lgdsa7PnzHcAAHZXT/K4EX8EF6699iCQvKFWYpZXer1gTeVPNpi84VRK1m+YY+8Q
         FxZcrq2fuRFuHNf1GUX4HQgnB7661+Rfgb0J+qyuftVLzqEbKt6aLazdOcxIe+lEMCQM
         Qi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700511360; x=1701116160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UN/JaGs58VC/59LNr+VTcKEJIUnlEUBkYK0zXNn4XiM=;
        b=W/S+c20oGZXInKuQZfjBzr7fHBXcuKRvftCmkZRtxVo/ZTrKVjsiIPoBmXp42W5qx8
         oPEE7BGzbKAGOJnYkn+GSzRb7IyJEGXHCscCjpa/L2aV1lh5eFOGzT1rR8lbUEvHUV86
         IQAZm9+1Mt2y66m/q7bLEGGxMkuWwIhL659sV1xBQIc8K3sSATIGHmc6GYYEvZCKgqXO
         ihqLmZkljz8tVHYO3/gMj0NMCruMSaEnNJ5MDwmQV9GuBlRDsZB5RIdC3mduvp4/LuGT
         7Phhe31SdKvyGYW0uiGBJgb405QOUPwc09FvB1eZ8uQfcd8Ra3ZtGpsvNB5pSLan+A5e
         Z3Ag==
X-Gm-Message-State: AOJu0Ywh+LKRwUpT3HtgMCk+7IW4hXKxsDovGWIvhLX8KegALgxhHsKt
        egBWjwLEGeK6lYGtnmwOKrG5RCXgTT+j/MgFHGg=
X-Google-Smtp-Source: AGHT+IEl/IXOE7od2X9WWhu+ZG0SDFd09Zq8exF4njB3w++Fo4CbFsOu9XbAGRiMyS6YdIDcYfwLVlLccZYXYBThqaE=
X-Received: by 2002:a2e:a30c:0:b0:2c5:ab3b:d676 with SMTP id
 l12-20020a2ea30c000000b002c5ab3bd676mr6035262lje.9.1700511359989; Mon, 20 Nov
 2023 12:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20231114-topic-amlogic-upstream-isp-pmdomain-v1-0-f01e6fca67a0@linaro.org>
 <20231114-topic-amlogic-upstream-isp-pmdomain-v1-2-f01e6fca67a0@linaro.org>
In-Reply-To: <20231114-topic-amlogic-upstream-isp-pmdomain-v1-2-f01e6fca67a0@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 Nov 2023 21:15:49 +0100
Message-ID: <CAFBinCDe3yoEBd6SzozNZtC=zGaUHt4VeO_uhV1s5XBaWp0w1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: amlogic: meson-ee-pwrc: add support for
 G12A ISP power domain
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
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

Hi Neil,

On Tue, Nov 14, 2023 at 11:19=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
[...]
> +static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_isp[] =3D {
> +       { G12A_HHI_ISP_MEM_PD_REG0, GENMASK(31, 0) },
> +       { G12A_HHI_ISP_MEM_PD_REG0, GENMASK(31, 0) },
I expected this second line to use G12A_HHI_ISP_MEM_PD_REG1 (note the
number at the end: 0 vs 1)
Is this correct?


Best regards,
Martin
