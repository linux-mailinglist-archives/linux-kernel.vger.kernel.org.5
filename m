Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8091807D92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441974AbjLGBFr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 20:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441964AbjLGBFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:05:45 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77407D46
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:05:51 -0800 (PST)
Received: from [192.168.2.4] (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000007171C.0000000065711A6C.001192E6; Thu, 07 Dec 2023 02:05:48 +0100
Message-ID: <4adaf4d4a0b4baf808697fb644889410dcfed948.camel@irl.hu>
Subject: Re: [PATCH 0/2] ALSA: hda/tas2563: Add tas253 HDA driver
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Date:   Thu, 07 Dec 2023 02:05:47 +0100
In-Reply-To: <cover.1701733441.git.soyer@irl.hu>
References: <cover.1701733441.git.soyer@irl.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard this patch.
The tas2781-hda driver will handle this.

https://lore.kernel.org/all/cover.1701906455.git.soyer@irl.hu/

On Tue, 2023-12-05 at 00:45 +0100, Gergo Koteles wrote:
> The ta2563 is a smart amplifier. Similar to tas2562 but with DSP. Some 
> Lenovo laptops have it to drive the bass speakers. By default, it is in 
> software shutdown state.
> 
> To make the DSP work it needs a firmware and some calibration data.
> The latter can be read from the EFI in Lenovo laptops.
> 
> For the correct configuration it needs additional register data.
> It captured after running the Windows driver.
> 
> The firmware can be extracted as TAS2563Firmware.bin from the Windows 
> driver with innoextract.
> https://download.lenovo.com/consumer/mobiles/h5yd037fbfyy7kd0.exe
> 
> The driver will search for it as TAS2563-17AA3870.bin with the 14ARB7.
> 
> It uses the default program/configuration, and has no controls for these yet.
> 
> The amplifier works without firmware, but I don't know how safe is it, 
> that's why the firmware is required.
> 
> Gergo Koteles (2):
>   ASoc: tas2563: DSP Firmware loading support
>   ALSA: hda/tas2563: Add tas2563 HDA driver
> 
>  {sound/soc/codecs => include/sound}/tas2562.h |   8 +
>  include/sound/tas25xx-dsp.h                   | 100 ++++
>  sound/pci/hda/Kconfig                         |  14 +
>  sound/pci/hda/Makefile                        |   2 +
>  sound/pci/hda/patch_realtek.c                 |  22 +-
>  sound/pci/hda/tas2563_hda_i2c.c               | 508 ++++++++++++++++++
>  sound/soc/codecs/Kconfig                      |   7 +
>  sound/soc/codecs/Makefile                     |   2 +
>  sound/soc/codecs/tas2562.c                    |   2 +-
>  sound/soc/codecs/tas25xx-dsp.c                | 282 ++++++++++
>  10 files changed, 942 insertions(+), 5 deletions(-)
>  rename {sound/soc/codecs => include/sound}/tas2562.h (90%)
>  create mode 100644 include/sound/tas25xx-dsp.h
>  create mode 100644 sound/pci/hda/tas2563_hda_i2c.c
>  create mode 100644 sound/soc/codecs/tas25xx-dsp.c
> 
> 
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa

