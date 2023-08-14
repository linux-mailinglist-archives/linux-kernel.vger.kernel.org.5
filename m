Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C877AFB4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjHNCzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjHNCzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:55:43 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1CBE65
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 19:55:42 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-589ed5132c5so8126287b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 19:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691981741; x=1692586541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smIMHxHMXsRlFYyRESAqNumkyyEmxXc2Ju+pIkoWNX4=;
        b=5fdxfd6F6QHgKWiN5mW0zFkn7HZ95IC9hzQtDBwX9+4px886A+/RyLZUzVZDMtkR/X
         jwYX3Fzbhiea8ecprls7+NAuymhEt0MZal5FkOD3kC1Gll/RId99A19ZN3lHPbYJxlvK
         +m5yhBRqq5jRIbbw8VMdM2jRQpTYMe34ek98FQ0btSRoW65rc+krBqjh1NjeUBkpL8AB
         Aha+3axkgMK4/BYaqpNf5RqwC6G9HdllnNeo207tiBQU8ME9ZEX9VQoBl5dPrJTV8vO2
         e9RaCgXYnntqxpD8jJVOwa50iYmBDbEUcFEBuu3Cpzjf02ZuCIqLV7nGnVZiu+/SQTma
         1Wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691981741; x=1692586541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smIMHxHMXsRlFYyRESAqNumkyyEmxXc2Ju+pIkoWNX4=;
        b=abz2wMhvnuXLYx4yMXJjvwXMLieZh0H8WGFF9oEdEQ0VzZ5aAimlga1rdOkf0BQ87g
         gdt4x7XlXdk9FD40fO+G22/1zww8dYUnqn6zjrBCwejGp7wXBSfxaiXhqyz0gDned7kb
         5seL5hv8xf/o3UKPZbENm3A4euqMfVMm00b7cTwQQR2ob7sge6CDmZzU9DV5oAIj/oes
         Q3a6X/EvlD91GYEhhpwDF4NbF7h1giT5qLFwRwcJrZ+Zc7niJY88wNR1ss0s3gWyk3DJ
         O+mHNbTv/bxDdfyyHseCmP3ZfYYYtNtwBMwsr0fT3KcAlSDqgL6DPXSR85zta+0bcOlE
         Pl/A==
X-Gm-Message-State: AOJu0YzXxsOyYstN7xEzR2sbfXb7e1o3EIGXLLKFf305sI3bxpQPIsE3
        kafeSifrI3HDV4FBw/RtTZ08fcnYzHMQpEjjuUeyFIThB2OAaWrmjzWLw/7/
X-Google-Smtp-Source: AGHT+IG5eGVA1fgt8OFg2gwjL9D77uPDNx98fJbKn/EmTxH945w+jh9Kjey/fFBygOqCrohF2XjCqJrJ4rFV2RY0dFk=
X-Received: by 2002:a81:5fc5:0:b0:57a:6e41:948e with SMTP id
 t188-20020a815fc5000000b0057a6e41948emr9043483ywb.11.1691981741173; Sun, 13
 Aug 2023 19:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230804085648.3721416-1-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20230804085648.3721416-1-ajye_huang@compal.corp-partner.google.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Mon, 14 Aug 2023 10:55:30 +0800
Message-ID: <CALprXBaxhSiDdX49vtUrw6d5cLh+Qv5cTUBHM_c8VBABmEujGQ@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: Intel: Add rpl_nau8318_8825 driver
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Terry Cheong <htcheong@chromium.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, apoorv <apoorv@intel.com>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

Could we have your reviews?

Before we had your reviews on "adl_nau8318_nau8825" driver name last year.
And now the adl and rpl ids were split, so add "rpl_nau8318_8825" back
to maintain support.

Thanks

On Fri, Aug 4, 2023 at 4:57=E2=80=AFPM Ajye Huang
<ajye_huang@compal.corp-partner.google.com> wrote:
>
> Boards were using this in older kernels before adl and rpl ids were
> split. Add this back to maintain support.
>
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>  sound/soc/intel/boards/sof_nau8825.c              | 10 ++++++++++
>  sound/soc/intel/common/soc-acpi-intel-rpl-match.c | 12 ++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/sound/soc/intel/boards/sof_nau8825.c b/sound/soc/intel/board=
s/sof_nau8825.c
> index 4fc6e1c6aef3..46b7ecf6f9f1 100644
> --- a/sound/soc/intel/boards/sof_nau8825.c
> +++ b/sound/soc/intel/boards/sof_nau8825.c
> @@ -684,6 +684,16 @@ static const struct platform_device_id board_ids[] =
=3D {
>                                         SOF_BT_OFFLOAD_SSP(2) |
>                                         SOF_SSP_BT_OFFLOAD_PRESENT),
>         },
> +       {
> +               .name =3D "rpl_nau8318_8825",
> +               .driver_data =3D (kernel_ulong_t)(SOF_NAU8825_SSP_CODEC(0=
) |
> +                                       SOF_SPEAKER_AMP_PRESENT |
> +                                       SOF_NAU8318_SPEAKER_AMP_PRESENT |
> +                                       SOF_NAU8825_SSP_AMP(1) |
> +                                       SOF_NAU8825_NUM_HDMIDEV(4) |
> +                                       SOF_BT_OFFLOAD_SSP(2) |
> +                                       SOF_SSP_BT_OFFLOAD_PRESENT),
> +       },
>         { }
>  };
>  MODULE_DEVICE_TABLE(platform, board_ids);
> diff --git a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c b/sound/so=
c/intel/common/soc-acpi-intel-rpl-match.c
> index 4eefdb2dd45c..1dd699181765 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
> @@ -351,6 +351,11 @@ static const struct snd_soc_acpi_codecs rpl_rt1019p_=
amp =3D {
>         .codecs =3D {"RTL1019"}
>  };
>
> +static const struct snd_soc_acpi_codecs rpl_nau8318_amp =3D {
> +       .num_codecs =3D 1,
> +       .codecs =3D {"NVTN2012"}
> +};
> +
>  struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[] =3D {
>         {
>                 .comp_ids =3D &rpl_rt5682_hp,
> @@ -373,6 +378,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_mach=
ines[] =3D {
>                 .quirk_data =3D &rpl_max98373_amp,
>                 .sof_tplg_filename =3D "sof-rpl-max98373-nau8825.tplg",
>         },
> +       {
> +               .id =3D "10508825",
> +               .drv_name =3D "rpl_nau8318_8825",
> +               .machine_quirk =3D snd_soc_acpi_codec_list,
> +               .quirk_data =3D &rpl_nau8318_amp,
> +               .sof_tplg_filename =3D "sof-rpl-nau8318-nau8825.tplg",
> +       },
>         {
>                 .comp_ids =3D &rpl_rt5682_hp,
>                 .drv_name =3D "rpl_rt1019_rt5682",
> --
> 2.25.1
>
