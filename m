Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B2E771737
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 01:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjHFXEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 19:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjHFXEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 19:04:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE2170B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 16:04:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-267fcd6985cso2783080a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 16:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691363043; x=1691967843;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JUlUeVUC5StFr1+uAYzg+P/QF0FcI+bk5VzEE447slQ=;
        b=ErSAgGPvjUhLEGa61Q7MlM2pAugzQK2gvE0bEmDLgraoxjgu9TQBexPIuTnc3LoBjF
         jgq2xtLn1Ay//oE+jqrpMUk3nWEKGK6udZqYmywb9MrsjM7SJDjaVWG4TF1prpN6VT7u
         Q9i710tKnl/V5UoBiA72LHcHdBfMMdPDmumHFQzjGgXS9OmiHvSvFnpO+QlwBE0CajQL
         DgQsl4YvE42GV2UGJumIIoK5w4q8tS0CDP4B2x//FsQx278Yj4mPeb+YUQi4Ng10qsXg
         6hSc2YB/yiuTxIprV7B2uaT25ifxrU/7HnCHLGYOHrYOioGR+Ymar4zI3tngkov0TFmh
         xaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691363043; x=1691967843;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUlUeVUC5StFr1+uAYzg+P/QF0FcI+bk5VzEE447slQ=;
        b=lDQhyojhN24BBYIBKO2lb7wfzzIKwmXF2BNNSlMiodLfEbfXWV4zmnfqSKNG0LjuFE
         ZLtVSm010hkNDY5Mn47Pw05rmKHggFTXqbeiCsPmnNKQDAweraNINRpqSK/91/4LEDWK
         cMYUiFI5tV25M7GyiBs04GZ7TwFlb3B6AmJ8IZnPqsRsNQ9N0SnZICWVS75Nwp88uh27
         /hgN4YM8Bwy1Aba8lHd3ssWP/aFo7f61+5dkRX0yUhWcD/h9bdm2gEjexrlgloT0uuo+
         nzYRamjLYaSTNud3i3XA6X6lxlY4Dt+1GQZ/BCEj7/aY+qOc475QF6Vap9bMr+n8HuBn
         rbeA==
X-Gm-Message-State: AOJu0YxarzK/o5EaIacyFBHFshXJGx6aOXZ0eSX5qN5vvN8+cVHgu2cK
        BLRrCgqvx68BBhzFGfCvJE9EY+/tZB09aqgZXNQ0/N4JK8k=
X-Google-Smtp-Source: AGHT+IF7ypcb/mZ48cMRvYOr7EafMgkZbxtRfjeev5cwO6ymbzVcsUSfYa5jNXDAOZSln+sZrSuQAD6DpA2VLDdz1vk=
X-Received: by 2002:a17:90a:dc06:b0:261:2a59:dc38 with SMTP id
 i6-20020a17090adc0600b002612a59dc38mr8193088pjv.25.1691363043082; Sun, 06 Aug
 2023 16:04:03 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 6 Aug 2023 18:03:51 -0500
Message-ID: <CAHCN7xKW3vvRUAaf1DvkPpOTeP9JbtDZxnU70+-fWEOao+V4WA@mail.gmail.com>
Subject: Possible regression from "arm64: dts: imx8mp: don't initialize audio
 clocks from CCM node"
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
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

Lucas,

I can't find the original e-mail or I would have replied to that, so
my apologies.

This patch removed the clock configurations for AUDIO_PLL1 and PLL2,
but it went beyond just that by also removing the clock parenting for
IMX8MP_CLK_AUDIO_AHB, and IMX8MP_CLK_AUDIO_AXI_SRC which are tied into
the SDMA2/3 systems.

With this parenting removed, the SDMA2 and SDMA3 clocks are slowed to 24MHz.
Per the TRM, "The SDMA2/3 target frequency is 400MHz IPG and 400MHz
AHB, always 1:1 mode, to make sure there is enough throughput for all
the audio use cases."

With the parenting and clock rates restored for  IMX8MP_CLK_AUDIO_AHB,
and IMX8MP_CLK_AUDIO_AXI_SRC, it appears the SDMA2 and SDMA3 run at
400MHz.

This also matches the NXP downstream kernel.

Any objections if I partially revert your patch so
IMX8MP_CLK_AUDIO_AHB and IMX8MP_CLK_AUDIO_AXI_SRC return to their
previous condition? If you don't like it on the clk node, we could
move the clock-parenting and rate setting to the audio_blk_ctrl node
since the sdma2 and sdma3 both reference these clocks.  It just needs
to be set somewhere before the clocks are turned on or we cannot
reparent them.  I won't plan to revert the Audio_PLL1 or AUDIO_PLL2
clock stuff as that is board specific, but I would like to fix
16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks from
CCM node")

Let me know your thoughts.

thanks,

adam
