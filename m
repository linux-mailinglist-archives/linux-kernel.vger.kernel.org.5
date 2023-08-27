Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB3789B56
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 06:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjH0EPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 00:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjH0EPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 00:15:46 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E94E1AC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 21:15:44 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1c504386370so1544201fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 21:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693109742; x=1693714542;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yt7H9ySicMeQ6CipjH35qj5+nF/2PyaMgGzn05Vybi8=;
        b=VjNpwv46Ds0oNBdkjzqAcQmeeXEzwAZA0VnMUYxq2xHXIT2KlnzZ82nndTyc4BL7tj
         MC0n8srTzz++vFBulgnkkZfW+VMV+fUYfU4lrNhExo+vt90av/TwTizVFchvjCZbpjEo
         Ge4+q9SGK3JopZ8MStAdV++By+EHrz8EozzNq3LFx6eQbgZvYANOVrScaE4a78O8L8bu
         S98d0/ydDhaTZ4ZMf6tXGpIlZd6qgx+zwbbXq+LtMGOQkmyL6rc8FLddIGYyFCIfXqQf
         7+whShT1TQmiAviWLR9ZYf2Qj58X8JK60uDrMkoyYThTN8Pnj58/gVXjU7Q9fmmQU4ij
         hc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693109742; x=1693714542;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yt7H9ySicMeQ6CipjH35qj5+nF/2PyaMgGzn05Vybi8=;
        b=MkKY1MQppnZ/gPklYulRl2HYwOqKqX638cTAriesR8Dy5fD1uK0prZ0kAbWefZjm+i
         ie6ausSd68yjbi76WN73cnAFX51wN/3KdFfSns6FJGtrkjH+IVK7DC2O+Pflqg1b19Af
         Zc4oopuaw1fvHwRPEzmLFQe7mXRd5l1f0EbAya/ZqnrQd5WG9QW/6gQs6xit8+cAePsn
         Qrt66dPQH8MjHy9l/Getm+lR8XXG/AczJmRbzx9BdmFX2SxynxI2cP3NQXYZ+/vH8gyX
         BJghFl/XIThajZ8of4ssZhqMEH5HqBXYawgzVHy7TELYB+vQm2WzCOm/8SfdOIcKolul
         z7kw==
X-Gm-Message-State: AOJu0YyfUKoy/lmJfgkeH1sqPSz3DS+zUfhIqpRxkt+Qp27nrTDWR5eB
        4ljl+nCYVfOFL0Qm/F/cRhmPersUgahVhtpUYQc=
X-Google-Smtp-Source: AGHT+IEoUvPk6fAL1zO2iNnHtZ/RsuPPopD1xHzzPzFvrD7UL4pz6gUMFIOeL8dZvsFYOgbLk6j47OuViMRaG+7y5H8=
X-Received: by 2002:a05:6870:d60c:b0:1ba:caf2:acc3 with SMTP id
 a12-20020a056870d60c00b001bacaf2acc3mr7407554oaq.5.1693109741964; Sat, 26 Aug
 2023 21:15:41 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 26 Aug 2023 23:15:30 -0500
Message-ID: <CAHCN7xKQ549ExO83Yur=_MPv3aYFdR0nfzUSuEXO74OddAr5gQ@mail.gmail.com>
Subject: Question about simple-audio-card with dummy CODEC
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to use a PDM microphone on a variety of i.MX8M (Mini/Nano/Plus)
boards with the simple-audio-card driver.  I can get this device to
enumerate when I use "fsl,imx-audio-card" and it appears that it
connects to a dummy codec:

sysdefault:CARD=imxaudiomicfil
    imx-audio-micfil, micfil hifi snd-soc-dummy-dai-0
    Default Audio Device

When I attempt to use "simple-audio-card" with just the
simple-audio-card,cpu  sound-dai node pointing to the micfil cpu
without a codec node, nothing appears in arecord -L, and I don't see
errors.

I am guessing the simple-audio-card driver is expecting a CODEC, so
hacked soc-utils.c to give soc_dummy_driver an of_match_table and
assigned it a corresponding 'compatible' name. I then routed the codec
node on the simple-audio-card to the dummy CODEC and it enumerated
just like it did with the custom fsl,imx-audio-card driver:

sysdefault:CARD=soundpdm
    sound-pdm, 30ca0000.audio-controller-snd-soc-dummy-dai snd-soc-dummy-dai-0
    Default Audio Device

I am asking what is the best way to let simple-audio-card  use a dummy
codec?  If the dummy codec is the better option, what compatible name
should I use?

adam
