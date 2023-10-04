Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00597B7B58
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbjJDJLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242006AbjJDJLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:11:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1E0A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:11:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804A6C433C8;
        Wed,  4 Oct 2023 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696410688;
        bh=3tcd15/ZhZ377CKHNn8APJe8bHeAciTOTOhoUjvaohg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DxSpJYyVREb2yGfKKnw9XSQ1b8/PfzDDLw1n0AfAWJpbDxN5aeF8+GwUULbrMkUgH
         OTYTGKvD9ba9vCfGfHV/aEOrTNxwhtl/O8OABpQABMAs5FeM3+KQXz5I2RPk9b9flc
         wkSZcKKx2DnIhFcaKgCjwVwezihs8unE9xmAOWGilJIloCd5P/qWQjHr/TxxfTfQua
         jWcbgEjvR2M/TCB28g8Z0+FI7lrSHPsiMqsf9jRUghMqKqj5NI6yKqBZODV0D3DHJH
         gsJLlCAtLQIRIuduqECIQElhZszhdkr0VExwQN2Xz+dEF58YZVBizNAUpZBSI5JGxT
         q8VeZop7iehGQ==
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Lee Jones <lee@kernel.org>, Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230928085537.3246669-2-wenst@chromium.org>
References: <20230928085537.3246669-1-wenst@chromium.org>
 <20230928085537.3246669-2-wenst@chromium.org>
Subject: Re: (subset) [PATCH v4 01/12] dt-bindings: mfd: mt6397: Split out
 compatible for MediaTek MT6366 PMIC
Message-Id: <169641068524.66814.2537584517055836452.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 10:11:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 16:55:24 +0800, Chen-Yu Tsai wrote:
> The MT6366 PMIC is mostly, but not fully, compatible with MT6358. It has
> a different set of regulators. Specifically, it lacks the camera related
> VCAM* LDOs and VLDO28, but has additional VM18, VMDDR, and VSRAM_CORE LDOs.
> 
> The PMICs contain a chip ID register that can be used to detect which
> exact model is preset, so it is possible to share a common base
> compatible string.
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: mfd: mt6397: Split out compatible for MediaTek MT6366 PMIC
        commit: 9e2a2fd1ca0555bd0c278cd4061cc4bd9c8d0f7f

--
Lee Jones [李琼斯]

