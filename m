Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D807A65CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjISNzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjISNzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:55:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF30C9E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:55:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8C1C433C7;
        Tue, 19 Sep 2023 13:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695131745;
        bh=QF/AP/89bBr/qqXTaeqtJsd27sAduRxWczz+mUKffoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJZABjBznpJIT24jQjbTR065N12T0J2HyVmb0heC6Uj1lZeJ9FaVkJoATs8bUdw1u
         LckZmrx8rZySHcEmxBcpHYag4XPGvNOMgF1NN/Wz3J4DgU1j8yZoz8aRlanscMS2Kv
         uwgW1DBwTLV9nWYMvUltOkNDMGOyuhWrW29k+TXXMtQSUM1G1+KHNMnhYCfYDJAEUk
         9fT6FalKxg5jwUl7NdOFMnwhlfRWIBGBeLBpCl7wOwVVuXPlLTT5CcNv7ULcsgkUg7
         N+Ggc+e8BSiAGzTOiwLTT7SxnGW0NmI1VMSjRskWs7Ndo5Pf2svAUBdt9XTGOTYLwt
         FlQCcSf3EesjQ==
Date:   Tue, 19 Sep 2023 14:55:39 +0100
From:   Lee Jones <lee@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 10/12] regulator: mt6358: Add missing regulators for
 MT6366
Message-ID: <20230919135539.GR13143@google.com>
References: <20230919104357.3971512-1-wenst@chromium.org>
 <20230919104357.3971512-11-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919104357.3971512-11-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023, Chen-Yu Tsai wrote:

> When support for the MT6366 PMIC regulators was added, it was assumed
> that it had the same functionality as MT6358. In reality there are
> differences. A few regulators have different ranges, or were renamed
> and repurposed, or removed altogether.
> 
> Add the 3 regulators that were missing from the original submission.
> These are added for completeness. VSRAM_CORE is not used in existing
> projects. VM18 and VMDDR feed DRAM related consumers, and are not used
> in-kernel.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v2:
> - Linear range selector values fixed
> 
> Angelo's reviewed-by was dropped.
> 
>  drivers/regulator/mt6358-regulator.c       | 20 ++++++++++++++++++++

>  include/linux/mfd/mt6358/registers.h       | 17 +++++++++++++++++

Acked-by: Lee Jones <lee@kernel.org>

>  include/linux/regulator/mt6358-regulator.h |  3 +++
>  3 files changed, 40 insertions(+)

[...]

-- 
Lee Jones [李琼斯]
