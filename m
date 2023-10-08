Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DA47BCBE9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 05:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344350AbjJHDax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 23:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344300AbjJHDav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 23:30:51 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5586BBD;
        Sat,  7 Oct 2023 20:30:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-564b6276941so2564434a12.3;
        Sat, 07 Oct 2023 20:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696735850; x=1697340650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Po8IwO3ZNX4Frjy8MjMqPcYZOoaeDikNFLkcWX7OJPI=;
        b=aG6fKP51RMfTWAlgvxtKXhpBNXmpkCPIiuCMoxFA2hB3X8qijRIxng5ThY8bwaSgrI
         m7fWe90kAv131Yli09x0WeiLkSLietgcPEnf6Pah8Wpt0Ru6mtvD7gCOE3LB4n+HF79A
         fvaOwwPxZrVrOgqtrEHEmF+qppyGpdwQ1v+DjmeLLU2JNDLAifKxxRhAWnN7DqIT6N4K
         kFw+W8sNxgLGNJ/LCdcaQHy5Fg/BEFAAUgyOfMCuoOuN0Mr08hZonJlvvcoZkWb1VOiM
         M8t06f0zXWM3UUJvdJPTzyPxAASXbjmfAENkcI1MSEqbkw0p3eOMA7Kp7o5pwP3F3i+p
         z3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696735850; x=1697340650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Po8IwO3ZNX4Frjy8MjMqPcYZOoaeDikNFLkcWX7OJPI=;
        b=PC1KClDuKo8gt1UqoAa0cxmkru30O2hltg65cR6fS2k3MGWfRn0ibBHpuFurJzoIww
         uDqNmmKEmHZEG396T7tK2ttUAvp/otRpHTdKH35IVCnOtq316lB31jXrO3hgfw6CO2Om
         9ZfQgFUGPoS4FQROHMAbLKpP4gku3RPTo2yVPFdM31bTExvFtOC0IUbU07I3sEjRcYsx
         Xje+qcMiZpGIZAV5A6pgTwsd+MvYq2oHJXk+jTbe+FNDUk7Iw6lyhZHtJmpGURRQZKZo
         KjXl9HMQ3QwMNQ/kOz5mMG0o5J8j4XeygKULi0wROIKTQ7icc/xz2aHFPQUwbTGvCjgr
         mgew==
X-Gm-Message-State: AOJu0YyxkB5SCvWAIHJ2odr93IR3r95ntMBVUm5GVBUmUyFt0D7WHLHW
        xIWvjZvqY9Duv3yHi+iCxL2U3n9c6LZZBxNqJ8A=
X-Google-Smtp-Source: AGHT+IHu0m1BG7YctYVYzTTaRMvMvVrKlnV6do4IhJbTtREHvtRDSndFewmonfv7LypGWBoeuyRfvI4GrwV0RDkFj1M=
X-Received: by 2002:a05:6a20:6a1a:b0:154:fb34:5f09 with SMTP id
 p26-20020a056a206a1a00b00154fb345f09mr14826314pzk.15.1696735849741; Sat, 07
 Oct 2023 20:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <1695891619-32393-1-git-send-email-shengjiu.wang@nxp.com>
 <1695891619-32393-2-git-send-email-shengjiu.wang@nxp.com> <7af54654-d4d5-498e-bd53-78ad54e6d818@sirena.org.uk>
In-Reply-To: <7af54654-d4d5-498e-bd53-78ad54e6d818@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sun, 8 Oct 2023 11:30:38 +0800
Message-ID: <CAA+D8AOyDD9Wd0pHFW=jwY9FKqY0OA2UMmDRrB_UnSPN4FJSZA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 01/11] ASoC: fsl_asrc: define functions for memory
 to memory usage
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl,
        sakari.ailus@iki.fi, tfiga@chromium.org, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com,
        festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
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

Hi

On Mon, Oct 2, 2023 at 11:08=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, Sep 28, 2023 at 05:00:09PM +0800, Shengjiu Wang wrote:
>
> > m2m_start_part_one: first part of the start steps
> > m2m_start_part_two: second part of the start steps
> > m2m_stop_part_one: first part of stop steps
> > m2m_stop_part_two: second part of stop steps, optional
>
> The part_one/two naming isn't amazing here.  Looking at the rest of the
> code it looks like this is a prepare/trigger type distinction where the
> first part is configuring things prior to DMA setup and the second part
> is actually starting the transfer.  Perhaps _config()/_start() instead?

Ok, I will use m2m_prepare/m2m_unprepare to replace
m2m_start_part_one/m2m_stop_part_one,  and use m2m_start/m2m_stop
to replace  m2m_start_part_two/m2m_stop_part_two.

Best regards
Wang shengjiu
