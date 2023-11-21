Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA2A7F31D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjKUPCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjKUPCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:02:49 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D2610C;
        Tue, 21 Nov 2023 07:02:46 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c194b111d6so4365472a12.0;
        Tue, 21 Nov 2023 07:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700578966; x=1701183766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE81H57iTAMLIoJku/X+tUBOOe26MeLc/ZPIjayxX08=;
        b=OTVFqrTpyyhsLP6qCtThANh4Td/Ki4H5MFxf9BrEn6CGJMLR6JL94XhcAAccBOKT6v
         3o+ve5yG3Vb9C4+Yd0FRfgo9/MJo8yLnfyZ24LnXsj3dAe65kvM2hc8pUdmlRc1pDaTE
         jOZfjCYAEkOUoMisfzQVV0SF+dQf2OJ2oFLMjRCFvJGMy8v73Nmz51Pbe5CgVFjEsAgN
         xfr6ANEfoTM3p133wYHjAEw7TzsXfmkBzFlZzSEHhwsHBcH40EUqmPeKPGRywTIU+UGb
         6zLVY3TZVWLt/2cKtbKPrtIlB4bqceMiXyJ9v2FWrVbGZiNuK9Yh9WR6GB1Jgzh2oRYR
         SXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700578966; x=1701183766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NE81H57iTAMLIoJku/X+tUBOOe26MeLc/ZPIjayxX08=;
        b=iqms+1qyeVYABEUM/5vdiTQhARgh5pTQrK17GUaIwK5KHawrb+PevoIGb6Fd6azRNh
         8m0BsllBFP2dS8plZh8ZMuh1pTDkHminGDy4bhcbZ0cp3yRWs6i/VT5h7GWI0USn6C/X
         5GmA7ooBp3QVxm7edGgtyr2VDv5DK2hV/IBRmf2SUoHUaPia1WUkBSa9ynK4zl7/eiBj
         Z+ilXGQXGK6FoMm+VhskMTXNIndOsBYOqsh4wdvJpdR65BBPkuMCZS8ZqbYOLNSSk+yj
         Ux9KN2qmtNJs132Hs9FSjDuN+VF9fuWpN9C2y7jB2jCNcDGYPlqbWQQG0BWKPbs3S36p
         tPWg==
X-Gm-Message-State: AOJu0YxGryFav4VOXbYNssJHMIifXvV2DkggdTYApaNdVP7EXQJeV65g
        TKEZinwmeR6mZx89lw2yrW1h1gcF5V4pLm99MKg=
X-Google-Smtp-Source: AGHT+IHYEKGtBQb9kcBODuQ7JGPeu7bEDXrR+cb5gbSKKoTCL+Yh2YQGZU7xWkNVwL5gRCwehxoPaSuqFfOXULbTg9I=
X-Received: by 2002:a17:90b:3504:b0:280:74fc:6545 with SMTP id
 ls4-20020a17090b350400b0028074fc6545mr10534160pjb.24.1700578965690; Tue, 21
 Nov 2023 07:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20231120175657.4070921-1-stefan.maetje@esd.eu> <20231120175657.4070921-2-stefan.maetje@esd.eu>
In-Reply-To: <20231120175657.4070921-2-stefan.maetje@esd.eu>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 22 Nov 2023 00:02:34 +0900
Message-ID: <CAMZ6RqKBDfX3qnJ8pMnQ55JFDFgGCQEQhNVGPXJKiGNvvBWXdQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v10_1=2F2=5D_MAINTAINERS=3A_add_Stefan_M=C3=A4tje_a?=
        =?UTF-8?Q?s_maintainer_for_the_esd_electronics_GmbH_PCIe=2F402_CAN_drive?=
        =?UTF-8?Q?rs?=
To:     =?UTF-8?Q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
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

On Tue. 21 Nov. 2023 at 02:57, Stefan M=C3=A4tje <stefan.maetje@esd.eu> wro=
te:
> Adding myself (Stefan M=C3=A4tje) as a maintainer for the upcoming driver=
 of
> the PCIe/402 interface card family.
>
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 03011d7ee087..7db1bd399822 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7753,6 +7753,13 @@ L:       linux-can@vger.kernel.org
>  S:     Maintained
>  F:     drivers/net/can/usb/esd_usb.c
>
> +ESD CAN NETWORK DRIVERS
> +M:     Stefan M=C3=A4tje <stefan.maetje@esd.eu>
> +R:     socketcan@esd.eu
> +L:     linux-can@vger.kernel.org
> +S:     Maintained
> +F:     drivers/net/can/esd/

The MAINTAINERS file should be kept in alphabetical order.

So, maybe

  ESD CAN NETWORK DRIVERS

goes before

  ESD CAN/USB DRIVERS

?


At least, looking at the existing,

  ARM SUB-ARCHITECTURES

is before:

  ARM/ACTIONS SEMI ARCHITECTURE


>  ET131X NETWORK DRIVER
>  M:     Mark Einon <mark.einon@gmail.com>
>  S:     Odd Fixes
> --
> 2.34.1
>
>
