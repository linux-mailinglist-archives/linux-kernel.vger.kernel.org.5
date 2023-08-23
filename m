Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF67785CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjHWPzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjHWPzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:55:10 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3943E5F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:55:08 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58ca499456dso62876277b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692806108; x=1693410908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5pfJtYALrOy10ugSYtWsWCb+1mVFN7xrMWbS1+dIm4=;
        b=jTx2Xoca2FNIefIIdk2CZzjW+bIp4mr/uyVEEXrvtSC417hepEwvHBm8tboVAb8D4s
         nvAQavxRZyjuEgGB0uX1maRV3bpfT699xM2sC4tEPIGgoTO9f/fgk/PSUJrv7a9gnHAc
         b/628CUCMFZPE9YQdcMfV4kn9JgJxOT23rIGI8MYv2XQh7jwq8GMG6xGodcrDNBP2uI8
         Z2FCAi2A1nIzCbSpJP/R8kXV4C7lrx2vxmvYJ1GoKz+q6JyDOMUGB0YQMLvz7HPsHc65
         X6KNrMzsvPxPhfzamcdHG/f2yt068mUzvo6VIw/Il2j2xn7HsA+QmV3sQO4OZmJUSwel
         fJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692806108; x=1693410908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5pfJtYALrOy10ugSYtWsWCb+1mVFN7xrMWbS1+dIm4=;
        b=Z8fLB6UXys7t/C/rGg5C1NwMkGOL6514VY+9LDDQ/p0wvKoHYJcaqySEHyOTP5P8zb
         YoPrPFPM8fkCOuSg1JPMQrt7+dEAd58tI8GL5trMjSQ+b+3ykBBKQSdLyyjHvvkZdsqY
         ZOGydqfPsHmzGnVxK2sJ1FloRT5o73bXobwkXXYHbUuYJl9nPHhiZgg5g1h5tZuPWYpQ
         u2AJn15kkRhOoFXY7Gmws4h9TR0yggHYGJIFXF7pezRtU/9sxYhSiSbYH7lLO0CRI0aA
         8UbVDaUiTMRdniOrLTiRM177u6bZkyS4gJQUYrBsAlvT/vA6/XndTwZtvLMx3ATsAmWj
         xZ8g==
X-Gm-Message-State: AOJu0YyNTZNEIThuT8IYxdm7/aIGJqEzOZdeV1F9EBZ5FNbZ4qztBycM
        YIcQFH9wwvAGvUO1cMlpUHZRLO+RensA7hhca8MOtw==
X-Google-Smtp-Source: AGHT+IHPwTFcG8Rs5xra2L8n7+FakwWLs/CKLvB8qkq4zWmOeDPeZ0NHII3jC8pM+SwB+djmNeGRuRx60ihwEoaOA+Q=
X-Received: by 2002:a81:c211:0:b0:579:9cae:e0ee with SMTP id
 z17-20020a81c211000000b005799caee0eemr13494444ywc.20.1692806108154; Wed, 23
 Aug 2023 08:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230823040755.2217942-1-ajye_huang@compal.corp-partner.google.com>
 <dd6d51b0-cc60-4fb7-932d-1117143d1715@sirena.org.uk> <CALprXBYxrwBW6HLP5MwYhFh1_Skei+pLbXd7yNAEuhLTQJLVPg@mail.gmail.com>
 <2ebbcb7a-bc0d-4f62-9f4b-706f0270b71a@sirena.org.uk>
In-Reply-To: <2ebbcb7a-bc0d-4f62-9f4b-706f0270b71a@sirena.org.uk>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Wed, 23 Aug 2023 23:54:56 +0800
Message-ID: <CALprXBYEqAoj5H3n+wszocmhRQ96vLq5d2tYhBOdJnCbs_YY-w@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "ASoC: Intel: Add rpl_nau8318_8825 driver"
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
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
        alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:51=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> That's my CI tree, things in there aren't going anywhere unless they
> pass testing.

Hi, Mark,

Thank you for your explanation.
