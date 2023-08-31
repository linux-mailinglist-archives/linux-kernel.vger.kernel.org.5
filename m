Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183CE78E957
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbjHaJZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbjHaJZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:25:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D6B194
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1693473911; x=1694078711; i=frank-w@public-files.de;
 bh=sNBKAl7OOapdevNUf8Jzx/GBxqHRBQX6rJ48nK4n720=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=hfS08G04dqW7hfdus+6vSBieAIMid0sikGcUKaFEvxTcQgOpG64Jgeh3/eRN9WyDvn+C22K
 tJteN7j9n7DPfQV7P7kTXeaUtNfs/pFU+BsC+SaolKc+M0Jq4oFi9lBohaVqYWaA8UTRwMpTY
 yNTxSUoDmBDOYEDeKjIaYVj4sF/1XeT8yj28y+mm5aBY6BQVSfa9Un+wHbQmsrXiUmvoPkQMe
 EPD1qEoKqAtd+gVffFP/MlVvnYpzmRSn8ZSDKcSn7A96NE0FRUR+lAaawAk6yMw9qpzGm3Koz
 xzKBqRAUJieO0SOTduXD0TWsXW480zZUQIVjksZgujNtjxYMVP8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.156.102] ([217.61.156.102]) by web-mail.gmx.net
 (3c-app-gmx-bs12.server.lan [172.19.170.63]) (via HTTP); Thu, 31 Aug 2023
 11:25:11 +0200
MIME-Version: 1.0
Message-ID: <trinity-6713557b-fe0a-4dae-84aa-1aa86f7619fa-1693473911557@3c-app-gmx-bs12>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Riabchenko <d3adme4t@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: regression with 33140e668b10 thermal/drivers/mediatek: Control
 buffer enablement tweaks
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 31 Aug 2023 11:25:11 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:R3eilsBxaSYuZUiP7U6vkF0RfEeb0noEWsA6CEAJr70od0u0dalua4leiu4u1uW3DCsTa
 nzE3EdAv7fa5FYtTWg9MhuZREI/GJuQdDmAiZ6dSkdj+h16jVl3GOfl34oRE4tqVHbb6/Owk1t/R
 0uEnukVCojLfQ4inmZqIMoJwliqPukrgvO7gORQlILGziHkufUMKkWKWEtOSL2lwop9o/QyF9DXa
 xtorP5ym4Kx0ZtFLDblmHxUbRX79pY733xBiV5EuJ0VOgsa+zGKVlFalmEaYJXAoaOZ+D6+poSnv
 K4=
UI-OutboundReport: notjunk:1;M01:P0:c/R6z86VHUs=;4PInPeHMuhXaEVxk6mtDONAOTCN
 4q0LHjLgPqIwRU2cGfiTNIcHz30VmauXMIqJAUH5qxNpPu/SigIPcqRAZro5K8W4P554l9lxz
 zjSsdVNX22QAN+Xm1Sf48zgEGHyv0GFWcURnsnSZFihqY32U9ft1UzuSXy4ae7/7271fnf6so
 wGAU4XCUeT+XbWZx0J7DRkVCox0dqJeXAUidcSHiCNBeMu8xsG234TzI6CLKrK9HHEBtxltrx
 aN1K5vLehmzjEO+i7oDZZi+d5WwCIyxNKXIW9fIW0pABkyMAhb2irhL8TmTlJ5L9Zqv/aEf1j
 jgr2oQPjdgP40vke/fcqZ3uzImGw84ot8r5Ub/4QwXYcSovvLfeyw/qDYqcwXvLl74uPXkBAu
 v65GMgLuEQVuS3n54kYVhJfYBPzs2+sVwX+Fb16RXPhkdwYqKWc+T+2mXfsd1aJA6Wy4qamo1
 4RzaabDE8n7cMTZj+Qlys+7329f+pF/XYr6BbdhE+2KzSx/blp+NyeQTgfoCW0H7AF+8ZspzV
 oKpemF8QJ/EduS3Et1wSvvvG7/Ubg9I8ughlrLvhXq0WanbeqMwz+qU9hSdrDnk9wc1N3boAn
 d5vmcHOlR9Zer1G5b5/6guQz9WUaZkNXrEY2/vezn00U/wZk4gu57WjEU6KKdeHe99mr6fVsC
 vlR8nbRkgDEeT+hhQ5TfbsLyzRQNquFrHatfhe6k/hv1HtZcXSRYrldKyrw12juOIhFkQiMq5
 C1hJhV1Zny8IduNbs2kWGBvp19Zxhmee63bPXx9cAJDwpiyTcFxIPyZcPyFlLkWlmS0jZafLA
 kdF8isexpaqraxSlz7zQLVAHu4j+DC4Hlxb4uTmrRn6PM=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The commit 33140e668b10 "thermal/drivers/mediatek: Control buffer enableme=
nt tweaks" is merged between 6.3 and 6.4 and causes a regression where tem=
perature cannot be read correctly at least for mt7986/Bpi-R3.

bpi-r3 ~ # cat /sys/class/thermal/thermal_zone0/temp
-274000

after reverting the commit and fixing some build-errors in 6.5-rc7 because=
 new members used in mt8365_thermal_data too, we can read temperature on m=
t7986 again.

i guess reverting the commit is not the right way, so i ask here for a bet=
ter solution

regards Frank

