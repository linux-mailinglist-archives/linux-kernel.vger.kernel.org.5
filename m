Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9FB757EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjGROHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjGROGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:06:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988AE199D;
        Tue, 18 Jul 2023 07:06:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-262ee777d1cso1062425a91.1;
        Tue, 18 Jul 2023 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689689184; x=1690293984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSKU9ufWgfw0wvYn93uUJwdM53ojWsYKme/xDOl+S+o=;
        b=LYS7ECjCRBJmB6WVzMvRRAeagOaBGvkqj0F8DZAFQaGHBRUY26l04hw7wkWkUECHlL
         r2GiT3YlZMe+HQ2sx153BFKtUuIpHMMyt1NGY9Z58SgvmNJBfAujNZgf7PirBFm0jjBC
         INqMd3nhawQIwQOiwJaVc7lAE3njQ3els8LRrywr2e4+YtgOBFZqXebSgjAXmSqem7xr
         e9BZTPHd3O4JMsn0eN4wzqms55UMMyZschZ/nZhJVyrmjldYhQL/K7GDBr+woUJ/u/eL
         C86TqnIF2e10kSlbPX7dM3X9twsps6XYh2obhdQXyGJVVzNSReWRfqDfB76gUuXcrYGt
         edpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689689184; x=1690293984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSKU9ufWgfw0wvYn93uUJwdM53ojWsYKme/xDOl+S+o=;
        b=LwrG+BVRjGsY0OEjd6A3dbAaFOA2r64nHkqgCkMYmqKUB0ckRHEQRDTvctX4z9ux98
         +ljpN5CggVSTge4a7gFF1nFU/gwgZBOo5lKoF49Rxbt6s76E6iIkPrIPowPRRjCoKOA0
         1hQhXirm+ojR8ysWz8cKGS9wD9r1hvxCFmN0WQmQxiJxvgFtrDRudWKskBUl6TyNtbRh
         lkLdcvJBpSVpj1NvBJt9p0kBDb6Zc+2+1rM4qAR69Jdm++bzxWSEuPjtPaJAgQkZ9Q8q
         fPnUTIyeagzaSk2FInMiVwnToLr/WA809imO9DpCp4IIWQ+sg03g1Y36nWGNymyrLCBT
         opMQ==
X-Gm-Message-State: ABy/qLblEjq/IEcrE0hidiPjowrKr6yMS/18AS3h84UupdBg3pdxe9ik
        MlIMBZY3vX7Um2HGnh9uFcjFzmNksQGmoQiAJPs=
X-Google-Smtp-Source: APBJJlHeeb8g4x839mcy3ufBF71lKw9RmjsTo6Todn9alxLRwpwmqidmLYWEoOWwsfltGYyB1l1gZGD0J2kQ+n3bHaw=
X-Received: by 2002:a17:90a:fb91:b0:262:f76d:b29c with SMTP id
 cp17-20020a17090afb9100b00262f76db29cmr9957658pjb.2.1689689183884; Tue, 18
 Jul 2023 07:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230717165127.2882535-1-m.felsch@pengutronix.de> <20230717165127.2882535-4-m.felsch@pengutronix.de>
In-Reply-To: <20230717165127.2882535-4-m.felsch@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 18 Jul 2023 11:06:12 -0300
Message-ID: <CAOMZO5AJoctN5mxcBdvVnRfFpzH4ypYQ_rz70gJiKS4No0ygvg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: freescale: Add DEBIX SOM A and SOM A
 I/O Board support
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, laurent.pinchart@ideasonboard.com,
        dan.scally@ideasonboard.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Mon, Jul 17, 2023 at 1:51=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> Add support for the Debix SOM A + SOM A I/O board. The commit enables
> only the basic features like:
>  - 2x UART
>  - 2x Network
>  - eMMC/=C2=B5SD
>  - CAN
>  - QSPI
>  - USB Host / Device
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
