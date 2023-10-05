Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF81F7BA930
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjJESds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjJESdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:33:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F019B;
        Thu,  5 Oct 2023 11:33:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2739c8862d2so285605a91.1;
        Thu, 05 Oct 2023 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696530824; x=1697135624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2WQ61S9JRRXerRwVjcd6ONvIOqeXxJCrw12591ed3o=;
        b=i+diHiKwmAypapHBWL31//SUWrz+ktmzBB9JqhhqW7pDtppXivLoAxh9cqI3PC5LGF
         Qca6YkGyXyluAKvX4eIgyvOVF0znjleevCGbSin+AuZL1x/dn40E9E6P/E5cKtbOT8PX
         27zuinNT/ZtCZsCA+4XTubdnpfKuKQPzuSj0PKMwypY4SxK9JdeNK8o2wSagh11d16Kc
         7ymvpBkehM6kqxCEoLEhhVs0qes9l9Hy94NcY5I3nAuvJr1YXq/2xr9ql0p4rxETxKxk
         5+eolQRcIior8ohI4K0EOa+WBvkue78vhp6LR263CKAQuHZIQtTaY3FyPzgLqnUuRuzx
         /FXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696530824; x=1697135624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2WQ61S9JRRXerRwVjcd6ONvIOqeXxJCrw12591ed3o=;
        b=pqUwsge4+K24S6Xteo5eBbVJh4jZDXWKyu1c0TasgVFRZUz+lSVEfHqdDcB3PVWGgu
         2D3xgc4LNosFP5f2J2UYtMHWt1WK7nvhFO5H6g9LGLlvMhLFqD/g76xvkmvmxhyirGAw
         E+tSqV/0M1TfbCMqJQhj+jifEq1ySIzkxo5Gmz2RhkEPeD1xlAx61hL7pNBZRaSETXgI
         xw0f3OI1AtMeWeP/c8wRfAP+pxIVHCEEmNmWtb61+74Z1FNqFPztqVrhnxVJ3UhR9i6/
         Toi/lUAulvaJ4+hTPHQFo7m4oCkC0Rn2o3lJel+2V9o3d3JPEWin4bxre/ZPw5JKDxMq
         lw8w==
X-Gm-Message-State: AOJu0YzQFgfzk3fYnRoIN16kpAV9FWU/Sp/+YCV3xWBkIFqgS/lFSokg
        qMmL9oIoHoFEgmovQaW1yTwhWQaX460zXnEot7o=
X-Google-Smtp-Source: AGHT+IFPPDTHLTWktZfn17tw7eH/XR2oBWR5rf+6xB+epk31DjznCv/UfT68cOOTjJ2KmY34Ngi2oCidf08drxk7naU=
X-Received: by 2002:a17:90a:4ca4:b0:274:99ed:a80c with SMTP id
 k33-20020a17090a4ca400b0027499eda80cmr5438613pjh.3.1696530824460; Thu, 05 Oct
 2023 11:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231004234657.44592-1-aford173@gmail.com> <20231004234657.44592-4-aford173@gmail.com>
In-Reply-To: <20231004234657.44592-4-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 5 Oct 2023 15:33:33 -0300
Message-ID: <CAOMZO5CHFUePWymoCz+fnmi8Eo_De+Xjz+uqVBsS6Mw2wmuC1A@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] arm64: dts: imx8mp-beacon: Add DMIC support
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Oct 4, 2023 at 8:47=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> The baseboard has a connector for a pulse density microphone.
> This is connected via the micfil interface and uses the DMIC
> audio codec with the simple-audio-card.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
