Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B4B77B28A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjHNHdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjHNHc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F0C10D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:32:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 082156128D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9AAC433C7;
        Mon, 14 Aug 2023 07:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691998375;
        bh=t5/MsvFWknOoDFPSV8iv6i5JpN85LvBKxQvGVQF6HFc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m/vD1xO/Sw78K6HNAv3mCQXCpvw2eW9lo1RTk0Gk42Bc65r/mcVB/gc+Q/Ro4u/aw
         jFAIUiwOwHDix/TGZhxebjzKxB9q68Xbvj2EFMVRc7mwy2I+wWxovNvnKZ/1tqVFR9
         ABynLf13vm5Yazy9dy+XNbm5lKiQV/jPrrrpsp3Zj4IQjTTh5C65IRd18pAOeUBC7W
         Hw9kBml592imxrF0hRaT91Pniz4hq9TkPAv+VNe/4L/47QCUbstRoJOqqgkpFjmnIT
         o4vLaCbSEQTHzCjzA6gaj/klvbWZc5O3FX1pRwZwLIYUS2HYxeBZsV1pcADVPOkoKi
         +leV4NlQjXcYg==
Message-ID: <63913396-5661-f73b-728a-2f3801c67f25@kernel.org>
Date:   Mon, 14 Aug 2023 09:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: arm: mediatek: convert audsys to yaml
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@collabora.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230810133602.48024-1-eugen.hristev@collabora.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230810133602.48024-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 15:36, Eugen Hristev wrote:
> Convert the mediatek,audsys binding to YAML.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
> 
> Ref to /schemas/sound/mt2701-afe-pcm.yaml added as informative only because
> that schema has not been converted yet

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.


Best regards,
Krzysztof

