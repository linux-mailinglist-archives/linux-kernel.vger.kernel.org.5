Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558397563BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjGQND5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjGQND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:03:56 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA0A94;
        Mon, 17 Jul 2023 06:03:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E222A240007;
        Mon, 17 Jul 2023 13:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689599033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xFeGyiq0O4aqT1RUTL56PF+dTsP0yAysyKq2Bq6RFK4=;
        b=cS0kE+gtPXUZbb8K7Nu1gitcwIb6Pi9bf5JoKFGRrIJTtw9e/YFBjZISfZLgiXM/CovQeA
        bb8IJGJgqyZuC9I7xVEF1sQG6e4YFSwp8GSpTRg8KX7bowLLh9rCUFbyp9ZZpCW9Sw/jVR
        dYM4cFH/bI9TVl5RJFVnNKkMvXZhfFfH6iAlL1RNQNIkyla6Z7DZZsVxXhDS2KEI0XJl2a
        soutzWQACYIHJ/enPaSNhmmx5Mz7W6ziViz1BYP0xKw6fM1psf22brvmnzrmkpvCLfDj/4
        by7RaqWLBgEHRvYlX773BTuFMEDJfqQYCkf5/Td1fOsULThYpxgsYwnoJYoFJg==
Date:   Mon, 17 Jul 2023 15:03:51 +0200
From:   Herve Codina <herve.codina@bootlin.com>
Cc:     shumingf@realtek.com, flatmax@flatmax.com,
        ckeepax@opensource.cirrus.com, doug@schmorgal.com,
        fido_max@inbox.ru, pierre-louis.bossart@linux.intel.com,
        kiseok.jo@irondevice.com, liweilei@awinic.com,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yijiangtao@awinic.com,
        zhangjianming@awinic.com
Subject: Re: [PATCH V1 0/5]  ASoC: codecs: Add Awinic AW88261 audio
 amplifier driver
Message-ID: <20230717145456.5afee0cf@bootlin.com>
In-Reply-To: <20230717115845.297991-1-wangweidong.a@awinic.com>
References: <20230717115845.297991-1-wangweidong.a@awinic.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weidong,

On Mon, 17 Jul 2023 19:58:40 +0800
wangweidong.a@awinic.com wrote:

> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> The AW88261 is an I2S/TDM input, high efficiency
> digital Smart K audio amplifier with an integrated 10.25V
> smart boost convert
> 
> Add a DT schema for describing Awinic aw88261 audio amplifiers. They are
> controlled using I2C.
> 
> Weidong Wang (5):
>   ASoC: codecs: Add i2c and codec registration for aw88261 and their
>     associated operation functions
>   ASoC: codecs: aw88261 function for ALSA Audio Driver
>   ASoC: codecs: ACF bin parsing and check library file for aw88261
>   ASoC: codecs: aw88261 chip register file, data type file and Kconfig
>     Makefile
>   ASoC: dt-bindings: Add schema for "awinic,aw88261"
> 
>  .../bindings/sound/awinic,aw88261.yaml        |  53 +
>  sound/soc/codecs/Kconfig                      |  17 +
>  sound/soc/codecs/Makefile                     |   5 +
>  sound/soc/codecs/aw88261/aw88261.c            | 539 ++++++++++
>  sound/soc/codecs/aw88261/aw88261.h            |  52 +
>  sound/soc/codecs/aw88261/aw88261_data_type.h  | 144 +++
>  sound/soc/codecs/aw88261/aw88261_device.c     | 959 +++++++++++++++++
>  sound/soc/codecs/aw88261/aw88261_device.h     | 114 ++
>  sound/soc/codecs/aw88261/aw88261_lib.c        | 997 ++++++++++++++++++
>  sound/soc/codecs/aw88261/aw88261_lib.h        |  91 ++
>  sound/soc/codecs/aw88261/aw88261_reg.h        | 377 +++++++
>  11 files changed, 3348 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw88261.yaml
>  create mode 100644 sound/soc/codecs/aw88261/aw88261.c
>  create mode 100644 sound/soc/codecs/aw88261/aw88261.h
>  create mode 100644 sound/soc/codecs/aw88261/aw88261_data_type.h
>  create mode 100644 sound/soc/codecs/aw88261/aw88261_device.c
>  create mode 100644 sound/soc/codecs/aw88261/aw88261_device.h
>  create mode 100644 sound/soc/codecs/aw88261/aw88261_lib.c
>  create mode 100644 sound/soc/codecs/aw88261/aw88261_lib.h
>  create mode 100644 sound/soc/codecs/aw88261/aw88261_reg.h
> 
> 
> base-commit: 8d7868c41df58edabc4e408d119a1aef58a54d9d

A lot of code looks pretty similar (the same ?) to what was done for aw88395
  sound/soc/codecs/aw88395/

Is there a way to use common code instead of duplication ?

Best regards,
Hervé Codina
