Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6947806CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358407AbjHRH67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358400AbjHRH6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:58:46 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D243A89
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:58:43 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d743f58050bso287724276.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692345522; x=1692950322;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=igcyBE54FCe4GlK5viSpawwrjs2JcpTaXwROqWjpeCE=;
        b=PCXSKo6gfJjz3PyvYyfmUuKxQV6dGTG0d5umZJoVxgv/3pC1hBNrTcEEDWbhJh9HWv
         Quc91/RP5huv3BAKCwY8PRTwLcTt1SGuXtLF3+cjw1lG8w063AUZfr+BKb13iGaVh49A
         LhNKOjWFc/RvgBpMy3n1dxfB4T546pBVtCSHBW/s0Y2AYmcifYH5CNR+RJnO6OBrx6Ou
         Aa/e6+RJYa46OqBeUW3E5FpfBB6W/lmT0wlEey6bZEV+FZ1j23ujrw88KJ5OcgZXKtyP
         oArROJw62IQxw3NXjiQYXD6RLUEhK5TuhCExF2q8CVV42jytPfm96KNved8aEepkCbgX
         n25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692345522; x=1692950322;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igcyBE54FCe4GlK5viSpawwrjs2JcpTaXwROqWjpeCE=;
        b=f61LgNFWQwAnHm9qeNxn+nlmTGx7hSKG5ZbdqV20uU8bEnrkFUfHTUXs8JKTeaqPm6
         i+f0IIq46gIZHs88PU27mDCI38il/ZdzWj4BJB5n709tZfI/WScYK/kmvUHAQn7WRfJl
         ufHGMPmcw3zlMIXrxKE5AJvGdoQulOU8vCymRXnkcUzensBLZghVeI1E2nA8wJ2XekDZ
         iY1rBVJfqzSicFJmNBkT8NnRREwvRjDqJ+XpCsYQ72p97QcIZoFMpd9mR+yz0azAChGd
         1sPMWnjzRFAA80rCgbhTqKd7XluWOzitvAL96oqsCqPZRDOQWfMjkak87IofBIkfsEtd
         hA8Q==
X-Gm-Message-State: AOJu0YxbXUy4dWSx2T2vD01PN0K/LaMRDgmBdmkhIBaQOh2oSLGnuv8K
        38VKX+ax0q//WXOrKR6DQ2FC/hgHJPP77NLHRTrU6lK6sIpqJQ==
X-Google-Smtp-Source: AGHT+IF7SZTlg1W3WmhN9LjoK0SeT1n6Zc3/k66R8oKVvRyfCT2JOKAFCyx0jRDo5HPrGYUJd0VaEhmno4mj001Hf5c=
X-Received: by 2002:a25:ddc3:0:b0:d39:5e6a:9e6c with SMTP id
 u186-20020a25ddc3000000b00d395e6a9e6cmr1870133ybg.24.1692345522473; Fri, 18
 Aug 2023 00:58:42 -0700 (PDT)
MIME-Version: 1.0
From:   Zhu Ning <zhuning0077@gmail.com>
Date:   Fri, 18 Aug 2023 15:58:31 +0800
Message-ID: <CANPLYpDc8DTN2vkmCDhTpBQnEkOCyPTA5T1LLWO4s3Zdgb06gw@mail.gmail.com>
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables sound
 for systems with a ES8336 codec
To:     posteuca@mutex.one
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, perex@perex.cz,
        tiwai@suse.com, yangxiaohua <yangxiaohua@everest-semi.com>,
        Ning Zhu <zhuning0077@gmail.com>,
        Zhu Ning <zhuning@everest-semi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is saying that the machine driver should disable jack detection
> > over suspend and restart it during resume.  The machine driver should
> > suspend before the rest of the card which should mean that the CODEC
> > gets powered off then.  The core can't tell if jack detection is
> > supposed to work over suspend, it is a standard wake event on systems
> > like phones, but it sounds like on this system the power gets removed
> > from the device so that can't work.
> >
>
> Sorry, I don't understand what you are trying to say here. My intention
> is to find a way to have sound working when suspending/resuming
> with jack inserted by not fudging the jack in the machine driver but
> fixing it in the CODEC.
>
> > I don't understand why that would be expected to help?  The main effect
> > of keeping the bias on all the time would be to consume more power.
>
> I don't fully understand the whole bias thing (I did try hard to
> understand it from the code), but in this specific instance it helps for
> suspending the CODEC. If idle_bias_on is true then idle_bias_off will be
> false, that would mean that during suspend (with jack inserted)
> in snd_soc_suspend() in switch (snd_soc_dapm_get_bias_level(dapm))
> the flow goes in case SND_SOC_BIAS_STANDBY and since dapm->idle_bias_off
> is false it doesn't break from the case but falls through to
> SND_SOC_BIAS_OFF case which in turn calls the CODEC component's suspend
> callback.
>
> The reason the sound stops working with jack inserted is that the CODEC
> suspend callback never gets called. It only gets called when the jack
> is not inserted.

Hi Postevca, I just reproduced the bug on my side. You are right that
when jack inserted,
the codec driver will never enter  SND_SOC_BIAS_OFF or suspend or resume. This
makes sense because the codec needs micbias power to detect button. Problem is
that  ALSA or dapm thought the codec power is on during suspend, but
the system power
is turned off and the registers are reset. The system power is
controlled by EC and neither
dapm or codec driver can do anything about it. The system power is
just turned off.

Disabling the jack detection before suspend is ok because the system
stops working during
suspend anyway. Maybe a detailed comment is needed to explain why?
