Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B3E7B66BE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjJCKuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjJCKuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:50:20 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0406CAD;
        Tue,  3 Oct 2023 03:50:17 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57b9cb05fa3so352847eaf.1;
        Tue, 03 Oct 2023 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696330216; x=1696935016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/3GVTu0afK2EM7EWOS3wgoT181o6D5pcbv78as8HE0=;
        b=BJdkNwca2vPQDVw5FUJdcmJWwwaQYjVQvvlvvfnVMwcjzyuWIKn0GYjZSrHY7eGsTo
         eaD31vd7Fi3rUqcE97tQQ90NDsSHM3Tnz2C0GbDD0zbMBR81dtSa264aJRv72KYBVYP/
         7aIlxQgNJsL+vVFqb/LoZNpywcewi7IxZsLYsGPzK4TtJWr3d7qhTtzeBhzboOcvsBNZ
         gBM6nuuIfxe7ouxFVjZxYw0YldHMfH1Sxqbcc4cRLwT+GLCBquGNNreRl3LDcM0DJrRe
         5yqWC57p9aX3abNi5MmzzNE5WI0yLdaYqeaETR+f2tnBnDeExiLtc5uuprSlT+lWMa4z
         qfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696330216; x=1696935016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/3GVTu0afK2EM7EWOS3wgoT181o6D5pcbv78as8HE0=;
        b=vptTg7gAQKbFg+t6xb8nBJHJt/9dNhIWn/yk9tSsGDasokGC/8MWpvxfv5QJCLOhTx
         kGNyFFpJyAYs4rVkuXd0g0UvF8f2JbXIClOA1JG2aMAECW0m8ox/Lw7RqdBtpMxOGeqy
         46anehGGHF/kV0AxxiHq0sFghqKFx8dinfM7DiJnMHK7LMRRd7XQWuoZ3U9g3vTVHbyX
         Q89Woj6veS0cJXCQ5yGpI5fA9frzm73k6yTzF9xX0MI/tkK5oVKSV28fZ1dEhv69IHBV
         r+fxK2w6Xze/BsNWpEQbTFbOkSan0K8jhA1XDEMBZCn+cEbMYwIdtqhwVznX/Ck0XQFz
         aRxw==
X-Gm-Message-State: AOJu0YzlJX5jSy0YhcTXbMBiL5pbtJvvStxaB74t9lvMPjW1lN71rteT
        NAohAeWQHykBJhg3aFbneVPB3Q56DzNCdIrq3Js=
X-Google-Smtp-Source: AGHT+IGjvqSlP6GSpZt/GEk0OxELQYGIOGpISg+QgFtTkQ4ofCPdetgEL+fwI8pU6PjrCiy+Yiy/kvCap1plQHY20rE=
X-Received: by 2002:a4a:bc94:0:b0:576:bbf6:8a8e with SMTP id
 m20-20020a4abc94000000b00576bbf68a8emr1237644oop.2.1696330216245; Tue, 03 Oct
 2023 03:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231002200610.129799-1-tmaimon77@gmail.com> <20231002200610.129799-3-tmaimon77@gmail.com>
In-Reply-To: <20231002200610.129799-3-tmaimon77@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Oct 2023 13:49:40 +0300
Message-ID: <CAHp75VdjB6wqeezL_UotQj-65HKb83wYh4hfA=PPiooRN0QX8Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     ulf.hansson@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, adrian.hunter@intel.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, openbmc@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 2, 2023 at 11:06=E2=80=AFPM Tomer Maimon <tmaimon77@gmail.com> =
wrote:
>
> Add Nuvoton NPCM BMC sdhci-pltfm controller driver.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

...

> +static const struct of_device_id npcm_sdhci_of_match[] =3D {
> +       { .compatible =3D "nuvoton,npcm750-sdhci", .data =3D &npcm7xx_sdh=
ci_pdata, },
> +       { .compatible =3D "nuvoton,npcm845-sdhci", .data =3D &npcm8xx_sdh=
ci_pdata, },

Only in case when you need a new version, you may remove the inner
trailing commas,
no  need to do this right now.

> +       { }
> +};

--=20
With Best Regards,
Andy Shevchenko
