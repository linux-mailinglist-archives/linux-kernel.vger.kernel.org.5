Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DE17B5B4D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbjJBTYo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 15:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJBTYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:24:43 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DA7B0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:24:36 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59c0b9ad491so1768147b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 12:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696274675; x=1696879475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVY5oe6cxZolq597xXeHHc74+BUTHOMrBBxd13HG4jU=;
        b=QPyfItL3VETiGQ0y4dnY7I6cZ2R8p2i/4h/1lExDroDGO9U7bapmBExmgfx8VqnI5u
         NS74EG87NJAhukXc4vj2EfnJy7uKz8vN2k15P/53YU7sEY0/bGKqMsCtrpt5wlzoBYIz
         yJ0AmeiY5R7rwTDYzj88WuhYFnLoSmguHeoVx5pKbRnYDSb4s38iIIXQ6raUVUX99ajG
         TRIIVQVjwM9Vo4ZRma3pJ0WXGV2LEAO3IciWoYqgIcd4miXiWwFqR7fuy+D0Bb870yTI
         rIyOcBwrDRkF1GBiAaHp1rZQ+wOc4i3PBv6VrKYw01PxATbtrqVpAfy9Im+42gLFaUk4
         iRkQ==
X-Gm-Message-State: AOJu0YzQ7REIjanPzCQkag0Gc7BgS/2W9PG6tvsAMNCtTWo5iAFf1Ssg
        juVkpMmFZiPM811IXvgm4fWEQ9R4I1yQjQ==
X-Google-Smtp-Source: AGHT+IEK1Khd/lFcmPUFvvijcB/X5Eb1mYem2q0mBSCGI12sRS8pMMQz6zsYOdJ1o9t72P+F4Qbc8A==
X-Received: by 2002:a81:8603:0:b0:5a1:e4bf:ee5a with SMTP id w3-20020a818603000000b005a1e4bfee5amr12723447ywf.41.1696274675060;
        Mon, 02 Oct 2023 12:24:35 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id z1-20020a0dd701000000b0059bd8447721sm7906155ywd.21.2023.10.02.12.24.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 12:24:34 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a1ec43870cso1880027b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 12:24:34 -0700 (PDT)
X-Received: by 2002:a0d:d9c2:0:b0:576:7dfc:e73e with SMTP id
 b185-20020a0dd9c2000000b005767dfce73emr12588061ywe.32.1696274674269; Mon, 02
 Oct 2023 12:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231002090434.1896-1-shenghao-ding@ti.com>
In-Reply-To: <20231002090434.1896-1-shenghao-ding@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Oct 2023 21:24:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXr5oRgkFqYZnPe3Xdyq_QjtzhfL8Wa_e9JA0S1XhEhWw@mail.gmail.com>
Message-ID: <CAMuHMdXr5oRgkFqYZnPe3Xdyq_QjtzhfL8Wa_e9JA0S1XhEhWw@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: tas2781: fixed compiling issue in m68k
To:     Shenghao Ding <shenghao-ding@ti.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        kevin-lu@ti.com, 13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shenghao,

Thanks for your patch!

On Mon, Oct 2, 2023 at 4:38 PM Shenghao Ding <shenghao-ding@ti.com> wrote:
> fixed m68k compiling issue: mapping table can save code field; storing the

Please replicate the actual error message from the compiler, so it
is recorded in the commit description, and easy to find when someone
searches for the actual error message

From the Reported-by (which is not included in the actual description,
as it is below the "---"):

       {standard input}: Assembler messages:
    >> {standard input}:992: Error: value -148 out of range
       {standard input}:992: Error: value of ffffff6c too large for
field of 1 byte at 0000045f

> dev_idx as a member of block can reduce unnecessary  time and system
> resource comsumption of dev_idx mapping every time the block data writing
> to the dsp.

I am sorry, but I don't understand what this means.
Can you please elaborate?

Also, can you please explain what the real issue is?
(My first guess when seeing the error message before was that a  signed
 integer is truncated to an unsigned char or so, but I couldn't see
 immediately where that is happening)

> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
>
> ---
> Changes in v1:
>  - | Reported-by: kernel test robot <lkp@intel.com>
>    | Closes:
>    | https://lore.kernel.org/oe-kbuild-all/202309222048.RnSqEIK5-lkp@intel.
>    | com/

> --- a/include/sound/tas2781-dsp.h
> +++ b/include/sound/tas2781-dsp.h
> @@ -77,6 +77,11 @@ struct tasdev_blk {
>         unsigned int nr_cmds;
>         unsigned int blk_size;
>         unsigned int nr_subblocks;
> +       /* fixed m68k compiling issue, storing the dev_idx as a member of block
> +        * can reduce unnecessary timeand system resource comsumption of
> +        * dev_idx mapping every time the block data writing to the dsp.
> +        */

What is so special about "m68k" that it (1) fails there (and only there?
and only for some config/compiler combos, as it builds fine for me?),
and (2) is needed to mention this in comments all over the place?

> +       unsigned char dev_idx;
>         unsigned char *data;
>  };
>
> diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
> index eb55abae0d7b..e27775d834e9 100644
> --- a/sound/soc/codecs/tas2781-fmwlib.c
> +++ b/sound/soc/codecs/tas2781-fmwlib.c
> @@ -80,10 +80,72 @@ struct tas_crc {
>         unsigned char len;
>  };
>
> +struct blktyp_devidx_map {
> +       unsigned char blktyp;
> +       unsigned char dev_idx;
> +};
> +
>  static const char deviceNumber[TASDEVICE_DSP_TAS_MAX_DEVICE] = {
>         1, 2, 1, 2, 1, 1, 0, 2, 4, 3, 1, 2, 3, 4
>  };
>
> +/* fixed m68k compiling issue: mapping table can save code field */
> +static const struct blktyp_devidx_map ppc3_tas2781_mapping_table[] = {
> +       { MAIN_ALL_DEVICES_1X, 0x80 },
> +       { MAIN_DEVICE_A_1X, 0x81 },
> +       { COEFF_DEVICE_A_1X, 0xC1 },
> +       { PRE_DEVICE_A_1X, 0xC1 },
> +       { PRE_SOFTWARE_RESET_DEVICE_A, 0xC1 },
> +       { POST_SOFTWARE_RESET_DEVICE_A, 0xC1 },
> +       { MAIN_DEVICE_B_1X, 0x82 },
> +       { COEFF_DEVICE_B_1X, 0xC2 },
> +       { PRE_DEVICE_B_1X, 0xC2 },
> +       { PRE_SOFTWARE_RESET_DEVICE_B, 0xC2 },
> +       { POST_SOFTWARE_RESET_DEVICE_B, 0xC2 },
> +       { MAIN_DEVICE_C_1X, 0x83 },
> +       { COEFF_DEVICE_C_1X, 0xC3 },
> +       { PRE_DEVICE_C_1X, 0xC3 },
> +       { PRE_SOFTWARE_RESET_DEVICE_C, 0xC3 },
> +       { POST_SOFTWARE_RESET_DEVICE_C, 0xC3 },
> +       { MAIN_DEVICE_D_1X, 0x84 },
> +       { COEFF_DEVICE_D_1X, 0xC4 },
> +       { PRE_DEVICE_D_1X, 0xC4 },
> +       { PRE_SOFTWARE_RESET_DEVICE_D, 0xC4 },
> +       { POST_SOFTWARE_RESET_DEVICE_D, 0xC4 },
> +};
> +
> +static const struct blktyp_devidx_map ppc3_mapping_table[] = {
> +       { MAIN_ALL_DEVICES_1X, 0x80 },
> +       { MAIN_DEVICE_A_1X, 0x81 },
> +       { COEFF_DEVICE_A_1X, 0xC1 },
> +       { PRE_DEVICE_A_1X, 0xC1 },
> +       { MAIN_DEVICE_B_1X, 0x82 },
> +       { COEFF_DEVICE_B_1X, 0xC2 },
> +       { PRE_DEVICE_B_1X, 0xC2 },
> +       { MAIN_DEVICE_C_1X, 0x83 },
> +       { COEFF_DEVICE_C_1X, 0xC3 },
> +       { PRE_DEVICE_C_1X, 0xC3 },
> +       { MAIN_DEVICE_D_1X, 0x84 },
> +       { COEFF_DEVICE_D_1X, 0xC4 },
> +       { PRE_DEVICE_D_1X, 0xC4 },
> +};
> +
> +static const struct blktyp_devidx_map non_ppc3_mapping_table[] = {
> +       { MAIN_ALL_DEVICES, 0x80 },
> +       { MAIN_DEVICE_A, 0x81 },
> +       { COEFF_DEVICE_A, 0xC1 },
> +       { PRE_DEVICE_A, 0xC1 },
> +       { MAIN_DEVICE_B, 0x82 },
> +       { COEFF_DEVICE_B, 0xC2 },
> +       { PRE_DEVICE_B, 0xC2 },
> +       { MAIN_DEVICE_C, 0x83 },
> +       { COEFF_DEVICE_C, 0xC3 },
> +       { PRE_DEVICE_C, 0xC3 },
> +       { MAIN_DEVICE_D, 0x84 },
> +       { COEFF_DEVICE_D, 0xC4 },
> +       { PRE_DEVICE_D, 0xC4 },
> +};
> +
>  static struct tasdevice_config_info *tasdevice_add_config(
>         struct tasdevice_priv *tas_priv, unsigned char *config_data,
>         unsigned int config_size, int *status)
> @@ -316,6 +378,37 @@ int tasdevice_rca_parser(void *context, const struct firmware *fmw)
>  }
>  EXPORT_SYMBOL_NS_GPL(tasdevice_rca_parser, SND_SOC_TAS2781_FMWLIB);
>
> +/* fixed m68k compiling issue: mapping table can save code field */
> +static unsigned char map_dev_idx(struct tasdevice_fw *tas_fmw,
> +       struct tasdev_blk *block)
> +{
> +
> +       struct blktyp_devidx_map *p =
> +               (struct blktyp_devidx_map *)non_ppc3_mapping_table;

Please do not cast away constness when not needed (also below).

> +       struct tasdevice_dspfw_hdr *fw_hdr = &(tas_fmw->fw_hdr);
> +       struct tasdevice_fw_fixed_hdr *fw_fixed_hdr = &(fw_hdr->fixed_hdr);
> +
> +       int i, n = ARRAY_SIZE(non_ppc3_mapping_table);

size_t

> +       unsigned char dev_idx = 0;
> +
> +       if (fw_fixed_hdr->ppcver >= PPC3_VERSION_TAS2781) {
> +               p = (struct blktyp_devidx_map *)ppc3_tas2781_mapping_table;
> +               n = ARRAY_SIZE(ppc3_tas2781_mapping_table);
> +       } else if (fw_fixed_hdr->ppcver >= PPC3_VERSION) {
> +               p = (struct blktyp_devidx_map *)ppc3_mapping_table;
> +               n = ARRAY_SIZE(ppc3_mapping_table);
> +       }
> +
> +       for (i = 0; i < n; i++) {
> +               if (block->type == p[i].blktyp) {
> +                       dev_idx = p[i].dev_idx;
> +                       break;
> +               }
> +       }
> +
> +       return dev_idx;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
