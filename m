Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4812B7E3884
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjKGKMN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Nov 2023 05:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjKGKML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:12:11 -0500
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831AEF7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:12:08 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so4774648276.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699351927; x=1699956727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3doRBvs6M5ROo+hysSTR74MqETRZ8K/t4qsZqgMtVs=;
        b=P/QG+iQc8xIqEmusVbxmfBGnsGP+X7D83h41J4anSOY1/YkJxbZ7+kMX8XeK8ZL1CV
         YQFhDXzA92LazZ6WAotyWc9tScICpBHK1uMNb3o5sC0edsGqucNOJz9xIVM6YAkpUnAA
         sBXalk/bEIE4uGdkZJYWf3PuUIkAy/LQb2/NWPuRyhOyg8t+GLu4bxebfsWGDrVZ9D12
         4TEQkeocMEGqrnQ9qv1yJKK8wq0ToNb/H61Dbk50A2izD5C/77mgxz0Zcgzfom8q50dq
         swTWLwoesrUKgo6hlqWbXzbgeUSHkFptm9CuOPmS/4wx5Aeeq4FJlSuH5JEP7rVkicRb
         kZsQ==
X-Gm-Message-State: AOJu0YxsnAxj2n3vwEI/PjjYvZMQlIgEbpvkC03jnMwfb4NG1rdye9/I
        amro0CdITyu2j/RGzOEDH4E1LCxBbhSThg==
X-Google-Smtp-Source: AGHT+IE1NaIE8QK3swsvBn8ccpib7h1sI7oOXD4siAluTma7flbF79dgWwf0RzC3G6k+eKXlVOmBYQ==
X-Received: by 2002:a25:d047:0:b0:da0:3b6c:fc22 with SMTP id h68-20020a25d047000000b00da03b6cfc22mr27417107ybg.31.1699351927505;
        Tue, 07 Nov 2023 02:12:07 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id d135-20020a25688d000000b00d8168e226e6sm5005556ybc.47.2023.11.07.02.12.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 02:12:07 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a82c2eb50cso59688717b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:12:07 -0800 (PST)
X-Received: by 2002:a25:ad11:0:b0:d9b:81a2:b83e with SMTP id
 y17-20020a25ad11000000b00d9b81a2b83emr23604994ybi.46.1699351927036; Tue, 07
 Nov 2023 02:12:07 -0800 (PST)
MIME-Version: 1.0
References: <202311062309.XugQH7AH-lkp@intel.com>
In-Reply-To: <202311062309.XugQH7AH-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Nov 2023 11:11:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUPR2tZmE9AKxa0QWrJJd=tju8=2bPBWQgcPs6_d0sOag@mail.gmail.com>
Message-ID: <CAMuHMdUPR2tZmE9AKxa0QWrJJd=tju8=2bPBWQgcPs6_d0sOag@mail.gmail.com>
Subject: Re: kismet: WARNING: unmet direct dependencies detected for
 SM_GCC_8550 when selected by SM_CAMCC_8550
To:     kernel test robot <lkp@intel.com>
Cc:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robot,

On Mon, Nov 6, 2023 at 4:06 PM kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d2f51b3516dade79269ff45eae2a7668ae711b25
> commit: ccc4e6a061a21d75b96d82fc4b084a8d96df6eb4 clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
> date:   7 weeks ago
> config: arm-kismet-CONFIG_SM_GCC_8550-CONFIG_SM_CAMCC_8550-0-0 (https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/config)
> reproduce: (https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311062309.XugQH7AH-lkp@intel.com/
>
> kismet warnings: (new ones prefixed by >>)
> >> kismet: WARNING: unmet direct dependencies detected for SM_GCC_8550 when selected by SM_CAMCC_8550
>    .config:7280:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Where is this coming from? I have seen this warning in several build
reports (earliest 2023-01-31), but cannot reproduce it with the provided
commit and config.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
