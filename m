Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5187D2979
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 06:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjJWEtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 00:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWEtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 00:49:17 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137B5E4;
        Sun, 22 Oct 2023 21:49:16 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1dd1714b9b6so2197557fac.0;
        Sun, 22 Oct 2023 21:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698036555; x=1698641355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxPaFEHkN2GDdgDwBKgSaVnPaX2nDRtfg0nlj1uSc1Q=;
        b=c5GLwDPlR18T2PchyLvrJ7xTTaLdpdmT0F0iSskqyViIfO5I3cQSG+V20g4n1w7qBb
         bKFl0g+V5Jjx6q6L2Yb5Ms2aje/GqUyD0kQUDJFBvHnbxuULU2I2xDCU+47GAWW4xfpO
         x3+itzqXoDyqJAYHbmpW0bqENPJbOF49ibPwEcQABgcoNz9lFy0MQz+i0djy3Nduq4Mh
         Lkx5MXcWdvr2AH072btCir/lKB5l7ceM+xwP0ZdR/9nsALX1oUwI7J2Y43x2vUffDwu4
         /ND2QnDMA1FWRNtG5tqsRjKh01pZw/vxXWAjkGRPlPMMRLnSooxRa6bN1DtojZ3M3ZGT
         M5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698036555; x=1698641355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxPaFEHkN2GDdgDwBKgSaVnPaX2nDRtfg0nlj1uSc1Q=;
        b=TLrVSVC6Exktjc4dYdKYQ4kQdfEitHeSHW84upYOLWnHYEIv1eiQ7C8UlCtsUjAl3P
         SUr+OoI8P4UIgkBKVhSUPS6ZCaFLepo9KyFrvvxhQOC5LKehYxojResbbxcXu7EOjtvN
         TvWwhcI+x6B9TRWmX35Vu8aA1h0IxXfIlmtrTuwbE0xPGKsJY0D3qn6/MWyosB0Pp0pT
         HmUdi9y31cjLiz1bQ47Vra5Kdi+r/IHcWtWijSNcO8hEj2i3Ph2MjUPLDDDB4iUAuf6y
         BuJvidLy9IWa6eEaMo8dtQaxHs3d5qL0HB379s83vwK+LB6zf4OudEM1tVX1s3VgN78s
         5eCA==
X-Gm-Message-State: AOJu0YxS0lI2gs6M/+U+t4F/aYiOQ8R1IKGdKPNux+JQKdBftfMY/0T+
        n7stxIJtIZz4wNRE654FKBQOx7dzKgRjvZK7xSQ=
X-Google-Smtp-Source: AGHT+IFkk9nGKKxsfM2C5d0hR9EDQje2xJBgkluo3WMKyPwX7Agu5S6em1v6mPWAeUB+rfbbXPJuxNvLi9kHqqd7nBM=
X-Received: by 2002:a05:6870:3d97:b0:1d0:d78b:982e with SMTP id
 lm23-20020a0568703d9700b001d0d78b982emr11653745oab.35.1698036555076; Sun, 22
 Oct 2023 21:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231022163006.803800-1-sergio.paracuellos@gmail.com> <ccd29f0e-2c94-45bf-8fa1-12a88b475fc9@linaro.org>
In-Reply-To: <ccd29f0e-2c94-45bf-8fa1-12a88b475fc9@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 23 Oct 2023 06:49:03 +0200
Message-ID: <CAMhs-H-R-9ADNgr6LxK-7ATBuc7SB=LgJzxWC-bpYiX0jNarAQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: phy: ralink-usb-phy: convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
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

On Sun, Oct 22, 2023 at 6:37=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/10/2023 18:30, Sergio Paracuellos wrote:
> > Convert the ralink-usb-phy bindings to DT schema.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof

Thanks, Krzysztof!
