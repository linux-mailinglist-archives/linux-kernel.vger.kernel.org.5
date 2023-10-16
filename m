Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07317CB163
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjJPRd1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Oct 2023 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJPRdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:33:25 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184B29F;
        Mon, 16 Oct 2023 10:33:24 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57c0775d4fcso722743eaf.0;
        Mon, 16 Oct 2023 10:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697477603; x=1698082403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/MpVr7DvcTYdzylCoC4nJbMI1/fcWumVgn9CJ0f4g0=;
        b=Vl1oXo7SzNTAJEtpVKDO9jtUOtBHV59ec1Xnzxxo5Dh5kLU154pHuT2tSV1KtEcn35
         wpbSHM2rxJN2FD2PYf9jWnKe2Kic4ytRwjTo8kkdWYe9nX1Zq5EumMO2klxd8EVmYQLq
         qJRKrI6YXr9CXc7UKB3pxjOygCwlx1LGK8+tFY709v3x4svxojjQNaNEi/zEpkvAiegP
         +wDmPORlbbF3EKrTnER/WugVlhHrLyOvLv2If9KAVwbw8aXfJNWPSNYJaA6T0FEa9JPU
         HcEIleEFx7Ik1IJ/r81QjY2p1203kZxT5xFyt23Dxs27837WoV2fFhWJiij8ksQTj+z1
         uLTQ==
X-Gm-Message-State: AOJu0YwEQ71E+pAOuK4vj41B58j0bQgOf1Qi4PR3QnNvzMikOq0vLTrz
        2Ro6AIegzw0i7WwEL9fSPPZ/o3OSOgpSV7K9HII=
X-Google-Smtp-Source: AGHT+IHuBH1Tg3joeut9lyus3T1mOYGHjhnmepUteU4zA+uJzHvYhrv8SoAH/jgQi1rVXk+Vr4pJyReIAvHSqi/DaTA=
X-Received: by 2002:a4a:de08:0:b0:56e:94ed:c098 with SMTP id
 y8-20020a4ade08000000b0056e94edc098mr33224175oot.0.1697477603348; Mon, 16 Oct
 2023 10:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231016160828.373599-1-wse@tuxedocomputers.com>
In-Reply-To: <20231016160828.373599-1-wse@tuxedocomputers.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Oct 2023 19:33:07 +0200
Message-ID: <CAJZ5v0itvrL7ijh07kB6i6o0ShCboWhv+09Gzo299DLK+GkH1w@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: resource: Do IRQ override on TongFang GMxXGxx
To:     Werner Sembach <wse@tuxedocomputers.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 6:08 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
>
> The TongFang GMxXGxx/TUXEDO Stellaris/Pollaris Gen5 needs IRQ overriding
> for the keyboard to work. Adding an entry for this laptop to the
> override_table makes the internal keyboard functional.
>
> v2: Rebase onto linux-next

Hans, any comments?

> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/acpi/resource.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 18f6353c142e..15a3bdbd0755 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -497,6 +497,18 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
>                 },
>         },
> +       {
> +               /* TongFang GMxXGxx/TUXEDO Polaris 15 Gen5 AMD */
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
> +               },
> +       },
> +       {
> +               /* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GM6XGxX"),
> +               },
> +       },
>         {
>                 /* MAINGEAR Vector Pro 2 15 */
>                 .matches = {
> --
> 2.34.1
>
