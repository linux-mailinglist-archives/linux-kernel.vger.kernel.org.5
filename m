Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516DF7C6ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347225AbjJLNLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347205AbjJLNLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:11:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1968FBA;
        Thu, 12 Oct 2023 06:11:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 26A01660734A;
        Thu, 12 Oct 2023 14:11:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697116264;
        bh=8TGPKtAK3pMPkVljBf/J5sPx4RaW1Xn2qBY/TA8G2Lg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AjKwI03lrIrJJKAeT8zI3uJoBYB5+g1ZHXTClSak9O8YFF6mEUnsdrsh/EYVfmKow
         /T8MEzzKj7tqHn/0bB3O//UhozGa6XJNexAzoYig7HMAB1HMvPU0zgeVk9mzzyxNxS
         37VybFuIN2R44AmchDNO1DQQ/H4XtJnUi1VtV2xU56AwbSrn8pVzmPlZqzhwsplbTU
         brv7P9LLmRq6WQEE7WNdwyI/uSGB3JWPLhRG+JgrpF121emZUQyr/jZcULhTMfZf/H
         avZquwgMYXVhuiWPvGwCqxXeAIhX8IUcCMinbBYeQgRFt2ayfk7164AZ2xWIYmqj3V
         Up5vGhu/403tg==
Message-ID: <592a17cf-b612-bfba-8bac-ff4322448409@collabora.com>
Date:   Thu, 12 Oct 2023 15:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v7 00/12] add support MDP3 on MT8195 platform
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231012091206.20165-1-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231012091206.20165-1-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/10/23 11:11, Moudy Ho ha scritto:
> Changes since v6:
> - Rebase on v6.6-rc5.
> - Dependent dtsi files:
>    https://patchwork.kernel.org/project/linux-mediatek/list/?series=792079
> - Dependent bindings:
>    https://patchwork.kernel.org/project/linux-mediatek/list/?series=792477
> - Move the patch that fixes compile warnings from this series and
>    create a separate standalone patch.

You forgot to mention that moving that patch added a dependency of this series
on .. that patch, at [1].

[1]: https://lore.kernel.org/r/20231012091206.20165-1-moudy.ho@mediatek.com

Cheers,
Angelo

