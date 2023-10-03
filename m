Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6377B6B3A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbjJCOTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbjJCOTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:19:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3AF93;
        Tue,  3 Oct 2023 07:19:13 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F247B6602173;
        Tue,  3 Oct 2023 15:19:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696342752;
        bh=q6jgdWgYtCodntH6FjQOzCy+S7+AILl2Cw4hES9RQ0U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FLO8B/Vwmx7echaV3lF2IjVCIDU1CjzmdAz0AeYvC5GpQUlZWjoT9bzbhHgOA9Hmy
         52gumfRL635Rtvk2l7mifzo9xq0FnuQR8VLdEmuwvJwjYaiezAElUD7O0hU8TDCvP7
         5tEoQsSlxjgUNP73jOAeHkmVf5hRTWJkcVmHBMhSj1gICpX498LMRH7k54U4NLYHDw
         PZ+FYPbdhVrsJtlCueBp9T5BM9bUt8wRHylZCD/0TR2Vh6s3/FANL82tWfBKfWdS3r
         OGiBsODXe1TyIuc1kMQuf+3mzEcfayhrxjuaNXHKMOrc1K/6h2cF+ZfmwxWJMRxsz8
         uTx/2u0VwzO0A==
Message-ID: <80597973-3afa-1cba-be0a-3ff63b305f9d@collabora.com>
Date:   Tue, 3 Oct 2023 16:19:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/5] MediaTek: Update MAINTAINERS and dts fixes for v6.7
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Jieyy Yang <jieyy.yang@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>, soc@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20231003-mediatek-fixes-v6-7-v1-0-dad7cd62a8ff@collabora.com>
 <ZRwM06dwpF/7wEs5@sashalap>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ZRwM06dwpF/7wEs5@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/10/23 14:45, Sasha Levin ha scritto:
> On Tue, Oct 03, 2023 at 01:13:42PM +0200, AngeloGioacchino Del Regno wrote:
>> Hello SoC maintainers,
>>
>> As suggested by Arnd in [1], I am sending an update to the MAINTAINERS
>> file, adding myself to the MediaTek SoC maintainers, and some urgent
>> bugfixes for MediaTek devicetrees.
> 
> Just curious: if it's urgent, and there are patches cc'ed to stable, why
> wait for 6.7 rather than one of the 6.6 -rc cycles?
> 

I may have misunderstood what Arnd said - in that case, I'm sorry.
As for the fixes, I would be happier if those could land in v6.6-rcX.

Regards,
Angelo
