Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D777F746F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbjKXM60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXM6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:58:24 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0AA193;
        Fri, 24 Nov 2023 04:58:31 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2809748bdb0so403836a91.0;
        Fri, 24 Nov 2023 04:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700830711; x=1701435511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75yoMjRCfMCs1tFne3RBs4pKvNnXjN/9OD4+CQf96SM=;
        b=jo5utnEHo4+rRRehxqXwFhlKIt9YytSb1vHZ5Ioya40T6LbHf9FKZftlDzv8rFy8+M
         jiKgmizf/MzjG0rgGPnM+82mgvYFJcQ4jNGbCL+Wab3Wr5Ieec3EcWehxcWK5SEODryT
         3ufVTNcMfhi/TzZmrnHELGSw5XpKlFCbVrzDYnn/VM9sETuz9h0OLMOS+67YwUm32h3h
         gKWfGiMeBRBOW8RxMhFKpJBDvGewPowyg/SqAiQw2lChH2qtMkh1iE5nEdqREzB5XS5+
         MpMHwlc1dbvm5sSraSj77bmoH2oxica9ttTECXIO5nl5eaPOVT9RuZI0A3hj1omcchUi
         hSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700830711; x=1701435511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75yoMjRCfMCs1tFne3RBs4pKvNnXjN/9OD4+CQf96SM=;
        b=kMLFXkUtIpi6uhm1CSMCDBvXM7XJfmgOyijF7A61SV58+/5JsWf5r4aL5IJzwD+unP
         XfDlhztNItdY5LXarzoSyqkUVuK9WdYEo0JDlwH6Zvhye5+NY2M2o+kyOq3rQP7RY/n3
         fVASxfOmAjSRnTVGv7TEitbK0x0HYo+7nCuNamgXgwVvAvihqhQyIJKBXgLTKtX1jD4s
         iF+9km0NhXnV/IaMbyUBwNIXhCucNWlAMEgPQqoHq0mQLObNyA+lRIuft7Rk2LFIq62F
         KbJvmfjbIGUZ8jr72DGIkPbQgF3szRSdv8LDlliNo4A5jEFv0JOz3JzQMG6mpteiunqU
         Gu/A==
X-Gm-Message-State: AOJu0YykR12DkNxxOD3Zcz5BHMNLmBRrvQngUv2ed6Xqud37SNgGCoJ6
        QPeNwxAIRBSeDFQsHmHG9pocK0S3FGm5fm0VrgWqyvBLzUc=
X-Google-Smtp-Source: AGHT+IEMsxB74TR4lZftjaujl2AV+WMLj732Gt8q7aYd1oPnh7Qvd8iW4ygm5fUJ2Z9GDK3Uf2Qv60nL57E5XSYErBo=
X-Received: by 2002:a17:90a:f695:b0:27d:2762:2728 with SMTP id
 cl21-20020a17090af69500b0027d27622728mr2580201pjb.0.1700830710880; Fri, 24
 Nov 2023 04:58:30 -0800 (PST)
MIME-Version: 1.0
References: <2023100450-charger-disregard-9683@gregkh> <AM0PR09MB2675934BBFB6E1DA8E0F626295B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
In-Reply-To: <AM0PR09MB2675934BBFB6E1DA8E0F626295B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 24 Nov 2023 09:58:19 -0300
Message-ID: <CAOMZO5AgDjwUeePO4ibUeKkpf-YV9v=Dws0S01HMERdDf85yoQ@mail.gmail.com>
Subject: Re: [PATCH v2] serial: imx: fix tx statemachine deadlock
To:     Paul Geurts <paul_geurts@live.nl>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

Hi Paul,

On Fri, Nov 24, 2023 at 9:55=E2=80=AFAM Paul Geurts <paul_geurts@live.nl> w=
rote:
>
> When using the serial port as RS485 port, the tx statemachine is used to
> control the RTS pin to drive the RS485 transceiver TX_EN pin. When the
> TTY port is closed in the middle of a transmission (for instance during
> userland application crash), imx_uart_shutdown disables the interface
> and disables the Transmission Complete interrupt. afer that,
> imx_uart_stop_tx bails on an incomplete transmission, to be retriggered
> by the TC interrupt. This interrupt is disabled and therefore the tx
> statemachine never transitions out of SEND. The statemachine is in
> deadlock now, and the TX_EN remains low, making the interface useless.
>
> imx_uart_stop_tx now checks for incomplete transmission AND whether TC
> interrupts are enabled before bailing to be retriggered. This makes sure
> the state machine handling is reached, and is properly set to
> WAIT_AFTER_SEND.
>
> Fixes: cb1a60923609 serial: imx: implement rts delaying for rs485

One nit: the correct format for the Fixes tag is:

Fixes: cb1a60923609 ("serial: imx: implement rts delaying for rs485")

And no blank line is needed between the Fixes and Signed-off-by line.

> Signed-off-by: Paul Geurts <paul_geurts@live.nl>
