Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483EC810EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjLMKq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjLMKqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:46:55 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903C799;
        Wed, 13 Dec 2023 02:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702464420;
        bh=S1PKbsocAj5/bpOzgd6MxBRKB+aWSCTCeiTPSJMpSa0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=2/yVxpy8OsJfCUWCpd5FQ5ZeAPQBrG/zSCYIAQfVJMD+rPPz/8/p59lvS7v/m8XUJ
         RZN2LNHYpGln10/4CUz0Q1AVFQ+lFGgNWIletVvgj+mzbj9tMnm3PU4fxElhEHwcFF
         QkX/6skHgv+pG+g0OR3EfgbwmhPCDlBH6WUScUOUU6zTivbNJjyMMpsT6t5+czWtcZ
         eiQ8xE1l1R7qjpUiDzTdpYAWjopLnXq8L4PDSrAGg9Vdbj8MmZGgKyl1KEohB2IBAv
         x3NWCbGccW1KuIM5u4088261qpXH93e/MPk/rHwCwYeyONdrifRcTKfP/mhIp4J6cy
         5oVFlG+QAAeMA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 387B73781453;
        Wed, 13 Dec 2023 10:46:59 +0000 (UTC)
Message-ID: <bbc6d09b-c472-4334-ba67-1072e94a89e9@collabora.com>
Date:   Wed, 13 Dec 2023 11:46:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v9 3/4] ASoC: mediatek: mt8188-mt6359: add es8326 support
Content-Language: en-US
To:     Rui Zhou <zhourui@huaqin.corp-partner.google.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
        trevor.wu@mediatek.com, allen-kh.cheng@mediatek.com,
        kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20231212123050.4080083-1-zhourui@huaqin.corp-partner.google.com>
 <20231212123050.4080083-4-zhourui@huaqin.corp-partner.google.com>
 <25ec0476-0ee3-4f2a-b0e6-ee33580159ab@collabora.com>
 <CABRjgztKkpE8KOBfj47Bdt_EXFiXA8+6eh6+=WMyPHW2UOF-oA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CABRjgztKkpE8KOBfj47Bdt_EXFiXA8+6eh6+=WMyPHW2UOF-oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/12/23 02:48, Rui Zhou ha scritto:
> Hi Angelo,
> Thank you for your review.
> I'm so sorry, but the person I added was obtained through the command
> ./scripts/get_maintainer.pl. Do you mean that the order of my TO/CC people
> is out of order? For example, it should be TO but CC is used.
> Or maybe I added less people to my email. In your spare time, could you
> please help check it out?
> Thank you very much!
> 
> ./scripts/get_maintainer.pl 00*.patch
> ./scripts/get_maintainer.pl: file '0000-cover-letter.patch' doesn't appear
> to be a patch.  Add -f to options?
> Liam Girdwood <lgirdwood@gmail.com> (supporter:SOUND - SOC LAYER / DYNAMIC
> AUDIO POWER MANAGEM...)
> Mark Brown <broonie@kernel.org> (supporter:SOUND - SOC LAYER / DYNAMIC
> AUDIO POWER MANAGEM...,commit_signer:10/11=91%,commit_signer:16/19=84%)
> Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS,authored:1/19=5%)
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS)
> Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC
> support)
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> (maintainer:ARM/Mediatek SoC
> support,commit_signer:4/11=36%,commit_signer:11/19=58%,authored:4/19=21%,removed_lines:41/157=26%)
> Jaroslav Kysela <perex@perex.cz> (maintainer:SOUND)
> Takashi Iwai <tiwai@suse.com> (maintainer:SOUND,removed_lines:11/157=7%)
> Trevor Wu <trevor.wu@mediatek.com>
> (commit_signer:5/11=45%,authored:3/11=27%,added_lines:27/54=50%,commit_signer:10/19=53%,authored:7/19=37%,added_lines:1401/1640=85%,removed_lines:26/157=17%,in
> file)
> xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
> (commit_signer:2/11=18%,authored:2/11=18%,added_lines:120/1640=7%)
> Maso Huang <maso.huang@mediatek.com>
> (commit_signer:2/11=18%,authored:2/11=18%,added_lines:20/54=37%)
> Arnd Bergmann <arnd@arndb.de> (authored:1/11=9%)
> Rui Zhou <zhourui@huaqin.corp-partner.google.com>
> (authored:1/11=9%,commit_signer:3/19=16%,authored:3/19=16%,removed_lines:64/157=41%)
> Allen-KH Cheng <allen-kh.cheng@mediatek.com> (removed_lines:1/1=100%)
> Alexandre Mergnat <amergnat@baylibre.com> (commit_signer:7/19=37%)
> Dan Carpenter <dan.carpenter@linaro.org> (authored:1/19=5%)
> Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> (removed_lines:11/157=7%)


> linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO
> POWER MANAGEM...)

^^^^ You forgot to add this one :-)

Regards,
Angelo


