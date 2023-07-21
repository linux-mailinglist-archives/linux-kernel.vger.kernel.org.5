Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2255175C215
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjGUIyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjGUIx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:53:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0370B3592;
        Fri, 21 Jul 2023 01:53:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6190D6606FD8;
        Fri, 21 Jul 2023 09:53:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689929629;
        bh=lfQjN+0bzeNpjfaFx7yJbIo4ezDGeSh0p2XNZ9xwwz4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O600G5w7nJqUVqoros/i3dGBDw3jROy94Zwx+9aAzLkY5THYq7F/xjZwT3LclQTMP
         jSwwdgzE2rmW8VN1rLo1/A3q77287WfMwv0n7EqFdPYocYP4sya9G0VjFTXItfBOOn
         0guWDaMkG8xZtLRQMkYq/4Iy7zbMNDeQ9adbMB5qUBrDYeWqlgYw8lTrztFBntPP2b
         rbXdpd9j1hnOE4/hQvfUDQMVpSx7MvOQny3wO6GHBh1CfzxDw/SYxKOLS/klq7Eyvn
         DHV3fsoShCe4l5NEgwU0zZIPh1+Mib6mcOI9NehUk9hbpvZrxlkhivDtEkkauHk1/j
         An2ZrpBhM76uw==
Message-ID: <176141a9-bcf2-d91f-0447-7a2aabd4b602@collabora.com>
Date:   Fri, 21 Jul 2023 10:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v2 7/7] arm64: dts: mediatek: mt6358: Merge
 ldo_vcn33_* regulators
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230721082903.2038975-1-wenst@chromium.org>
 <20230721082903.2038975-8-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230721082903.2038975-8-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/07/23 10:28, Chen-Yu Tsai ha scritto:
> The ldo_vcn33_bt and ldo_vcn33_wifi regulators are actually the same
> regulator, having the same voltage setting and output pin. There are
> simply two enable bits that are ORed together to enable the regulator.
> 
> Having two regulators representing the same output pin is misleading
> from a design matching standpoint, and also error-prone in driver
> implementations.
> 
> Now that the bindings have these two merged, merge them in the device
> tree as well. Neither vcn33 regulators are referenced in upstream
> device trees. As far as hardware designs go, none of the Chromebooks
> using MT8183 w/ MT6358 use this output.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


