Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8406D785C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbjHWPqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjHWPqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:46:11 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7551715
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:45:33 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d776e1f181bso2417986276.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692805520; x=1693410320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iKbrG16XTWsUCbJWiS608T9PjV3Jt5yTK3FHBeUP24=;
        b=IPf20cyi0FZ0c6UuhQ3+JLKk55ADO1l+45wsHSpTLlTvq3ckWIrXbhNUR7JZa7Zamb
         t01XQZM5BtWc68ovUcTiC2t7hwvC2EZco3jb3ds0twWrfv6GiIeBcOGF5pUwoNDvvozx
         pigreBr3dq8AJmQym1mSGdasy6dEhXldyJtap5wiAcP0JaD0/cIDcU+EYLpTy/Aet7Z4
         XhwoQua5mXMe3TytcNplOBUZWXQ9WUnR4rjan6WN8YnEPaPeI4Tmp3wZG6kluH33Aumc
         XUBBW/u0MfT/rePeVVsciTPQPyvqkH2ZqhEdhUt66aNK/Hhxo4YbAGXit3PH/Mf/Au4N
         vB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692805520; x=1693410320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iKbrG16XTWsUCbJWiS608T9PjV3Jt5yTK3FHBeUP24=;
        b=hCONWYHMwQjvAGXks5qYKDEfD/5C/nYnEnVjQn6HAo/wLw2MVg7V5cnHXwpteJY/3M
         gVlFCMH+R8KXSpQ66+NzZKdQiCj1yOuxzqCaEK2bQOQmj4a641W+TssFcFn5Stx5HXMR
         6PiwzgisFBOv3cOweATkGTIc17Bcpp9+HLFdtyDb3gJqkRaIwWEXd+bNqoV5U+FNz14x
         /Im0g8mchBDoOkRztOHHRwjPREtD03GdT2QjkwtRSgz/kut2n/yOYQbVmidoDxjbLvUB
         ehx0o+O6B1FB1lNpFTB5n33VZh6AqgJNfmqR7IV07kNNdBjpCOOL+tcsOuu6zB2Dl70+
         2YJQ==
X-Gm-Message-State: AOJu0Yzmk71xvzDJvmY2NLjttCu42hCCtcmRVjT/S1XMJFfbqfD9Em78
        UfSqcNAZHsdoHSxHNQD0+BXc6Jj3IFiTlv0l11Qwlg==
X-Google-Smtp-Source: AGHT+IGby702gDui1jmV96AnJZ9nLoHS+SoEbHAh56x6IqrEiZQrO5jwJZucjzv3wNLoQqDHphe+yvFHz/qPdPo1RL8=
X-Received: by 2002:a25:ae01:0:b0:d63:1d3b:9416 with SMTP id
 a1-20020a25ae01000000b00d631d3b9416mr12797135ybj.2.1692805520687; Wed, 23 Aug
 2023 08:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230823040755.2217942-1-ajye_huang@compal.corp-partner.google.com>
 <dd6d51b0-cc60-4fb7-932d-1117143d1715@sirena.org.uk>
In-Reply-To: <dd6d51b0-cc60-4fb7-932d-1117143d1715@sirena.org.uk>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Wed, 23 Aug 2023 23:45:09 +0800
Message-ID: <CALprXBYxrwBW6HLP5MwYhFh1_Skei+pLbXd7yNAEuhLTQJLVPg@mail.gmail.com>
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

On Wed, Aug 23, 2023 at 8:01=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
> 6b8b6892e434 is not applied?
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Dear Mark,
Please allow me to explain in more detail.
The 6b8b6892e434 should not be applied into file0yZ50U branch of broonie/ci=
.git.
Because the original commit 273bc8bf2227 ("ASoC: Intel: Add
rpl_nau8318_8825 driver") was applied on 2023-08-14.
But two days ago, 6b8b6892e434 tried to commit THE SAME patch again on
2023-08-21, but it just only added a little part content from original
273bc8bf2227.
+static const struct snd_soc_acpi_codecs rpl_nau8318_amp =3D {
+ .num_codecs =3D 1,
+ .codecs =3D {"NVTN2012"}
+};
+
It caused "rpl_nau8318_amp" to be redefined.
This condition only happens at broonie/ci.git's file0yZ50U branch.

Could you check this one again?  thanks.
