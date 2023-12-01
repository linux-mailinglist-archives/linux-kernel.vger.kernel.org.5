Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF23801823
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441932AbjLAXwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441926AbjLAXwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:52:07 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1011BEA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:51:48 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a185fb3aa18so486715666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20230601.gappssmtp.com; s=20230601; t=1701474706; x=1702079506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pf2tnTinXuxDyl3nKRHwSTUjqBMUY0SHJXZlyfM0i1U=;
        b=LPe1iLg937woGEy02r4KHrg4zzZayoev+gCQl18ogSaanscHYzaZhvbPGOnUxLOxn2
         XSd+UeGxlYgIN6+ahTgVY1yC4PlvIKgSt7KuUzdqwYJ3calm5OjAXR9XiGqKueMjdtkv
         S2z50OWAmZIEIt568V+Y4sBM9ZIvCNFh/fQGnGiKTY+btI5KedeEtQYibiYLuRkMOid+
         /O8rTv1cKP2EUjstnAajiiOxo0naYFR6DTAD6ytbXjsWCwqjdZVNqJ7NtdGCDEj8YqHt
         qCw3sStS0efqMoNexqIK33IEgCzuoE9S/m4w5nBgu3OKDcVMLgEN2DQrtdQU+7enyVbx
         1XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474706; x=1702079506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf2tnTinXuxDyl3nKRHwSTUjqBMUY0SHJXZlyfM0i1U=;
        b=DpCX5xfhlRqXIjiYX2Il5tuCU98e5Axn+d6i35qPyQksjFYignVa8kaMflI7WqKnXc
         kz6t93QeG1uCSxaVhCpAbe/WQVlhFrnsxa3JWtH7v9ihJqBZlvUqpe/+gJzm0L8EsGyP
         s6Fa4I1pnM3JdPNTiYfSNzVtQuENA4osSXmw/Ut+tGjqJCkjOSIY2IyK5toEB6s7T6I3
         d0FZfNnRaCzEU7SOoXFyFh+mOvR+p6JO2tBbjwZdgyazXHhsXf20gdOuPzCHpC5Pi70F
         x4Fut1Wru+Eg8OQ+Oy8z1Q146BIb4StmEtz5bOpEHLCWJb3GERTGOhe0kW9SMV95BFdz
         FY5Q==
X-Gm-Message-State: AOJu0YwmQeelb2YCf9xYvcCNQvzPagyy36M6tQpaFSNldQDl9GXc040V
        kw9vp0fPO52p7KtiI0YU4+h3u02OHNUtqQwxkkDMFw==
X-Google-Smtp-Source: AGHT+IEEt/ftI+tc+thqQKSQdbSez4jIsu22rycQSypQMieda1m4MfxMRf1pPNqMiLPMrES/RloO4iJVDQ+c9fzJqrM=
X-Received: by 2002:a17:906:5193:b0:a1a:5cbf:4b5c with SMTP id
 y19-20020a170906519300b00a1a5cbf4b5cmr289954ejk.15.1701474706293; Fri, 01 Dec
 2023 15:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20231102002453.1299195-1-william@wkennington.com> <20231102101009.15104-1-william@wkennington.com>
In-Reply-To: <20231102101009.15104-1-william@wkennington.com>
From:   William Kennington <william@wkennington.com>
Date:   Fri, 1 Dec 2023 15:51:35 -0800
Message-ID: <CAD_4BXgmCdc_H-XfmGnW3fa6H=cbONma6QzUiofNVZWJtcBwOg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: npcm: Add CPU hotplug callbacks for kexec support
To:     tmaimon77@gmail.com, tali.perry1@gmail.com, avifishman70@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Brian Ma <chma0@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 3:10=E2=80=AFAM William A. Kennington III
<william@wkennington.com> wrote:
>
> From: Brian Ma <chma0@nuvoton.com>
>
> Add callbacks required for kexec to function. The NPCM7xx does
> not expose controls for powering down CPU cores, so just wait in idle
> loop.
>
> Signed-off-by: Brian Ma <chma0@nuvoton.com>
> Signed-off-by: William A. Kennington III <william@wkennington.com>
> ---
>  arch/arm/mach-npcm/platsmp.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm/mach-npcm/platsmp.c b/arch/arm/mach-npcm/platsmp.c
> index 41891d3aa124..6cc7b5894f08 100644
> --- a/arch/arm/mach-npcm/platsmp.c
> +++ b/arch/arm/mach-npcm/platsmp.c
> @@ -69,10 +69,27 @@ static void __init npcm7xx_smp_prepare_cpus(unsigned =
int max_cpus)
>
>         iounmap(scu_base);
>  }
> +#ifdef CONFIG_HOTPLUG_CPU
> +static void npcm7xx_cpu_die(unsigned int cpu)
> +{
> +       while (1)
> +               cpu_do_idle();
> +}
> +
> +static int npcm7xx_cpu_kill(unsigned int l_cpu)
> +{
> +       return 1;
> +}
> +#endif
> +
>
>  static struct smp_operations npcm7xx_smp_ops __initdata =3D {
>         .smp_prepare_cpus =3D npcm7xx_smp_prepare_cpus,
>         .smp_boot_secondary =3D npcm7xx_smp_boot_secondary,
> +#ifdef CONFIG_HOTPLUG_CPU
> +       .cpu_die                        =3D npcm7xx_cpu_die,
> +       .cpu_kill                       =3D npcm7xx_cpu_kill,
> +#endif
>  };
>
>  CPU_METHOD_OF_DECLARE(npcm7xx_smp, "nuvoton,npcm750-smp", &npcm7xx_smp_o=
ps);
> --
> 2.42.0.820.g83a721a137-goog
>'

Mind taking another look? This should be updated accordingly.
