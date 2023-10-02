Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB1F7B5928
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbjJBRiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjJBRiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:38:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C06794
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:38:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F76C433CB;
        Mon,  2 Oct 2023 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696268297;
        bh=iWdE3PqQIPm1Gr1G+cGg8YEe3oOezdwkHyl6G540MoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CT+4DRXpnC5j+/uds8hb4RkFktfLHPXRzs7ng/fqmchLUYBjSOfxhkVmkzyYWbDQi
         V2NKwsjYFiNrwDRX9/hqIbvH9C1g7AC3wq0gH4iH1dx7W5JxhwjMPt9D1V+ZVMGkJH
         ot8nEr/JrPQAHK3yOq58eYA7GmIKvU3QSm8hT2ZnsnaezArtuBJH9OIXFuGo3RTOdS
         qMwYuSEoExlbap3JJ56Y8Tl+XjF1UuM5ZKexyPZsJVcZM22kQ/1dUGmLIO41GuhAyW
         ZKDtjfh876sfAeqwiLXAHl+b26xiUchF6LOtNy8YLubK4RSTIUOd/DAU8R0rppFcEp
         4GXrTwOX+ZI6g==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5043a01ee20so23238653e87.0;
        Mon, 02 Oct 2023 10:38:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YxLyaoUrxT1gSrb4/c8XUfJpKhxLqhVSQltjsR8bHxwy/hqJ24W
        aMBk/XqwzR42E/MLn+IvU3mh9KyA6BfxcgvM8Q==
X-Google-Smtp-Source: AGHT+IHZCP1YjecGYLwuoNyiko6dwgVXU8NRIFmzW6rhvr0X9Wrzo354jdzX9XwyQDAw5K8Is07bvjVR175Cr9/ex30=
X-Received: by 2002:a05:6512:6c7:b0:504:7e12:4846 with SMTP id
 u7-20020a05651206c700b005047e124846mr11636183lff.30.1696268295338; Mon, 02
 Oct 2023 10:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231002132635.2595382-1-andriy.shevchenko@linux.intel.com> <20231002132635.2595382-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231002132635.2595382-2-andriy.shevchenko@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Oct 2023 12:38:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKfg14iW2_DjN5NzbDwapeAwHK_r-XBMMPytrOjQdFY+A@mail.gmail.com>
Message-ID: <CAL_JsqKfg14iW2_DjN5NzbDwapeAwHK_r-XBMMPytrOjQdFY+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] amba: bus: Enable compile testing
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Frank Rowand <frowand.list@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 8:32=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is no architecture specific code in the implementation of
> AMBA bus, let's enable compile testing for it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> v2: new patch to make it easier to compile test on non-ARM
>
>  drivers/amba/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
> index fb6c7e0b4cce..9ff4638550c8 100644
> --- a/drivers/amba/Kconfig
> +++ b/drivers/amba/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config ARM_AMBA
> -       bool
> +       bool "AMBA bus support" || if COMPILE_TEST

Other than not compile testing a compile test enabling patch, it's
really "Arm (AMBA) Primecell Device bus". Despite the naming, AMBA
encompasses lots of Arm defined buses, but what this bus type is is
just peripherals which have the Primecell device ID registers.

Rob
