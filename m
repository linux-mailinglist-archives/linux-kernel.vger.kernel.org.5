Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0147E298D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjKFQRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKFQRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:17:15 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EBC191
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:17:11 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7bae0c07086so1327335241.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699287431; x=1699892231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYrrVMbxc0VRl0T51sQL5ouQRKzVXCSKTbYsaRlfNlk=;
        b=VtQ2pRc9qkkwnGp61Kg4sTF477QJWI2V+AzBR4HGGzifA9fiTkfJTudzMUwKLWPwWF
         74Mqno8HF0gwP6/NyoCLQNPxs2mx3VVcLbWSUFQhwdGBRuj02AzneXBhpgM4XGGZDDMY
         6ee13vWGsV8MyYrQZyAdoHIEIz9y7okzFsGsSOd7cjMOVuVrrmobaeRJZgP2yzfmk9jn
         wzYZSjo1eZjuBbzjz68b6zTs9R9/+hV7AdVb0wFKw9CIoHip/W4ShTg2fZjQVxxl9G7E
         83a1rjxpuBMdWRUrbMfNPJIAJwSP6iPlfThbKJe7HlNnyvgL84syqgYbjXeDBH9aN78P
         UKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287431; x=1699892231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYrrVMbxc0VRl0T51sQL5ouQRKzVXCSKTbYsaRlfNlk=;
        b=gvAJgVgp/SK97E1g07SjqlkWkmDIOsHCAPF+8ltXDejDfg2/wk6Pf5JCKrusZu9eLB
         j6hiyGvWxFrZveOElZt90PGExIptrRwAhqwLuDazaNAx9fbiC+h+Q+tZAPQaxEqNvtc8
         ehlizf/ODuwbW2W4mhVAJMe20D/Gc1WCSdAI6vSoexW9W6pdu9spSEVtOIqxg3ZVWWP8
         nyI/wNkuqW8jPleU3uFz+HTSrLSesgXvQcbw/TZWoCU3iBcktdAGSZIzEsrDDqH4ZXES
         ksbkFfAdHJcgSCDUoHTKFQyR4sfxVb6C5VMe8dgsjuwYVBdI14XSipI/prrvMvzobB8U
         1arw==
X-Gm-Message-State: AOJu0YxgsEdTtzcVakf8R6LE0GmpcL1OtRRKjkALYi4BTFB2PcjZtFx8
        kxx8bNIyQM4MFql8pEs5bsXxwsW4cYvNdRB6Zk1MPw==
X-Google-Smtp-Source: AGHT+IFKRHhGeayrcltrTH556Eh/wQ5NKx4PCQ4wk+vJDgH/5qrxyMWbaO+rqL9VaJ/IXq+99r8jAFRWwAeQrY8H4U4=
X-Received: by 2002:a67:e0c5:0:b0:45d:b6af:99ae with SMTP id
 m5-20020a67e0c5000000b0045db6af99aemr3856813vsl.35.1699287430954; Mon, 06 Nov
 2023 08:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20231106162310.85711-1-mario.limonciello@amd.com>
In-Reply-To: <20231106162310.85711-1-mario.limonciello@amd.com>
From:   Raul Rangel <rrangel@google.com>
Date:   Mon, 6 Nov 2023 09:17:00 -0700
Message-ID: <CAHQZ30DP8ED4g3bib-tZ53rm2q2_ouEEL3TxD-SgK4YrCe3bew@mail.gmail.com>
Subject: Re: [PATCH] rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        alvin.zhuge@gmail.com, renzhamin@gmail.com, kelvie@kelvie.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 9:14=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Intel systems > 2015 have been configured to use ACPI alarm instead
> of HPET to avoid s2idle issues.
>
> Having HPET programmed for wakeup causes problems on AMD systems with
> s2idle as well.
>
> One particular case is that the systemd "SuspendThenHibernate" feature
> doesn't work properly on the Framework 13" AMD model. Switching to
> using ACPI alarm fixes the issue.
>
> Adjust the quirk to apply to AMD/Hygon systems from 2021 onwards.
> This matches what has been tested and is specifically to avoid potential
> risk to older systems.
>
> Cc: stable@vger.kernel.org # 6.1+
> Reported-by: alvin.zhuge@gmail.com
> Reported-by: renzhamin@gmail.com
> Closes: https://github.com/systemd/systemd/issues/24279
> Reported-by: Kelvie Wong <kelvie@kelvie.ca>
> Closes: https://community.frame.work/t/systemd-suspend-then-hibernate-wak=
es-up-after-5-minutes/39392
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/rtc/rtc-cmos.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index 228fb2d11c70..696cfa7025de 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -818,18 +818,24 @@ static void rtc_wake_off(struct device *dev)
>  }
>
>  #ifdef CONFIG_X86
> -/* Enable use_acpi_alarm mode for Intel platforms no earlier than 2015 *=
/
>  static void use_acpi_alarm_quirks(void)
>  {
> -       if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
> +       switch (boot_cpu_data.x86_vendor) {
> +       case X86_VENDOR_INTEL:
> +               if (dmi_get_bios_year() < 2015)
> +                       return;
> +               break;
> +       case X86_VENDOR_AMD:
> +       case X86_VENDOR_HYGON:
> +               if (dmi_get_bios_year() < 2021)
> +                       return;
> +               break;
> +       default:
>                 return;
> -
> +       }
>         if (!is_hpet_enabled())
>                 return;
>
> -       if (dmi_get_bios_year() < 2015)
> -               return;
> -
>         use_acpi_alarm =3D true;
>  }
>  #else
> --
> 2.34.1
>
Acked-by: Raul E Rangel <rrangel@chromium.org>
