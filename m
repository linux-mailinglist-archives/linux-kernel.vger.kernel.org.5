Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEEC7D856A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjJZPAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjJZPAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:00:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3414B187
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:00:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BC1C433CA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698332428;
        bh=E3TbXSZFtJIGay/zBzgKcMrSIq3nyoCPzTNhBTttaRQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QbbYOA4AIKe0PnNSEeCqrmoVWRqyCIz0kV0G4d9xPHm9AMTEJvReFhew+PSQx5nW0
         piNEx1+bAoU163+rZmDCr9/GnmZ2h4E2ZqRWuSrn+XMduMFGjU3qR+6O5A4oPitp0A
         2lwcnsvG7LKpQXXfanqUQzNfkTtuA48JTfJxEEarPf+Lr6dmRZkZDIJD69rWI9FFxh
         H3gm42BFLOIF7N2QdI8qoJ11HuWbMy5N9r8OcEKnWt2JOV3xC4tFiACns0PABq7PUh
         kamqIIbMFMSqf29fWWXj9WSasHJkN/V28DKdyzNzuFBIi5Qz17tNxYRjYaGttETWU8
         BPN/jZt/zyUkg==
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so549911a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:00:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YxjOTWwiwH1+g1O8w5a3xhN68w7+GTraboo1XByGoUNjm6tdLmg
        6vnK8PLLG7dPyQdyhKiMqJyPhTpm/ElUUnPjCGo=
X-Google-Smtp-Source: AGHT+IFf/g3FdqTRlgRtfXQqdXPHTJRFWHub3LPFf7a501CHy+ga2wMn592H/yQa+gSLyAOqZ9Ydut0bLJAcDbwMk14=
X-Received: by 2002:a17:90b:fd2:b0:27d:30d5:c0f8 with SMTP id
 gd18-20020a17090b0fd200b0027d30d5c0f8mr17665525pjb.43.1698332428375; Thu, 26
 Oct 2023 08:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
 <edeebfab-e26c-4c18-8126-190c3e834521@kernel.org> <12c8c0f3-8364-4f25-976e-8cca29b5e17f@amd.com>
In-Reply-To: <12c8c0f3-8364-4f25-976e-8cca29b5e17f@amd.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 26 Oct 2023 17:00:17 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe+kSgxDFjrk+-ycsiyjp1r_SNNrFyy2B_-UDuqDV07XQ@mail.gmail.com>
Message-ID: <CAJKOXPe+kSgxDFjrk+-ycsiyjp1r_SNNrFyy2B_-UDuqDV07XQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] ASoC: amd: acp: Add acp6.3 pci legacy driver support
To:     syed saba kareem <ssabakar@amd.com>
Cc:     Syed Saba Kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        mario.limonciello@amd.com, venkataprasad.potturu@amd.com,
        arungopal.kondaveeti@amd.com, mastan.katragadda@amd.com,
        juan.martinez@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 at 12:09, syed saba kareem <ssabakar@amd.com> wrote:
> +
> +module_platform_driver(acp63_driver);
> +
> +MODULE_DESCRIPTION("AMD ACP acp63 Driver");
> +MODULE_IMPORT_NS(SND_SOC_ACP_COMMON);
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_ALIAS("platform:" DRV_NAME);
>
> You should not need MODULE_ALIAS() in normal cases. If you need it,
> usually it means your device ID table is wrong.
>
> It is platform driver ,for auto loading MODULE_ALIAS() is required.

Hm, not really. platform_driver does not need MODULE_ALIAS(). At least
99% of them do not need it. Please help us understand what is broken
here that this one platform driver needs alias.

BR,
Krzysztof
