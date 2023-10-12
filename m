Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14657C6E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378687AbjJLM0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347226AbjJLM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:26:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FB1BE;
        Thu, 12 Oct 2023 05:26:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50435ad51bbso1227776e87.2;
        Thu, 12 Oct 2023 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697113601; x=1697718401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7arwf9Sbc63puBYbaOYgIueno4H8IZ31i37CuMkfbnw=;
        b=UnnjNiYcT+9l9Pld4cadI0V0x2Fzwapz9wcQ+1bXsoHHPWAC1cdZsWQC6My5UegWh2
         UdAu7r1eHLcx0TGOKI6prVVxJJ3cCSL3fAiwIpOAbxqiFWOvU85tYwd8s6F1Qbp1fCZb
         keqWzMVnb9wUITNZjCUrscNvWUdQs1Ag54NCBsl1QT92hhaEPd2M4ySVdjBci90txGjo
         PBd2trtS0WeMf8TVHgj+UFQdtghJkvU2innAaD3jj1d2BxXUDNPRSZSLKrdwHqANCtCf
         LunOoypC1vhH9N45mfTUW6QB+yEaqfLdXmogPjszDoVwO/JWqyyf7iikYru8YT6YOCOo
         ysPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697113601; x=1697718401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7arwf9Sbc63puBYbaOYgIueno4H8IZ31i37CuMkfbnw=;
        b=tEGahiwBqe7jxqyoSnUMvJSkTExBFEeluOM7tCgH1YcyYfA2vMOu/da7Zt+tAvUFUv
         gD4VnJav22bkQ2Mdz6kUccThcvxzw0YSyzlnjVUr7jp3hPo/6+xv/0uOPE85hlCqXS3u
         mQgoQBd50plJpmXgcxpvrfQs5GYjPtMf+rKiIqeLEQ5+KjlCZDD01mgooPNawT7YNM2u
         X+bsi2v42KLy0q1pw7gveR+hOwfPzuD7/0ZMc+6m9gWiWfqcbDJko7G6seMb2btT0jto
         9sxRYiQk1C39uPERSika6PGA4V9yFBfzS/6Z9JbTYw6QxGsi4TxIlu8gPvtE6iHeeyoq
         ujtw==
X-Gm-Message-State: AOJu0YxrCrqa5wil+CFEcRE38jS57mGfPXtxi0hJx+EEoVs2S3bjza6V
        Nw29a1L2VnNziFoM2HL++3wCAyJMtLq5XTpUdRbfyk1T/sA=
X-Google-Smtp-Source: AGHT+IGQvgR/UKmN6GRDSyaTVXmzOl1h+nOUHRAaAvR6F5hiNV89R5yePnyki+Zoz3z/4gmnYahvzHwm5qJk8blLM0E=
X-Received: by 2002:a17:907:c70d:b0:9ae:47c3:35a0 with SMTP id
 ty13-20020a170907c70d00b009ae47c335a0mr22047943ejc.47.1697113581261; Thu, 12
 Oct 2023 05:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230917-imx95-mbox-v1-0-440245287356@nxp.com>
In-Reply-To: <20230917-imx95-mbox-v1-0-440245287356@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 12 Oct 2023 15:26:08 +0300
Message-ID: <CAEnQRZBWgjPoY6mZUeD+3fbqWbWrpNX3VzMsMzETt0FciwNSfA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mailbox: imx: support new tx doorbell
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
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

On Sun, Sep 17, 2023 at 7:55=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> The new added channel type is for i.MX95 SCMI mailbox usage.
>
> i.MX95 using TX doorbell and RX doorbell for the SCMI mailbox transport.
> For TX doorbell, we relies on software reply from the other side in
> SCMI driver side using mbox_client_txdone to drive the tx tick.
>
> But the current MU tx doorbell using tasklet to emulate hardware ACK
> from mailbox driver side, so add a new doorbell type to support i.MX95
> SCMI mailbox transport.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


> ---
> Peng Fan (2):
>       dt-bindings: mailbox: fsl,mu: add new tx doorbell channel
>       mailbox: imx: support channel type tx doorbell v2
>
>  .../devicetree/bindings/mailbox/fsl,mu.yaml        |  5 ++--
>  drivers/mailbox/imx-mailbox.c                      | 32 ++++++++++++++++=
++++--
>  2 files changed, 32 insertions(+), 5 deletions(-)
> ---
> base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
> change-id: 20230916-imx95-mbox-88437c51ce54
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>
