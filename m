Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD3766B91
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjG1LTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjG1LTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:19:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4790513E;
        Fri, 28 Jul 2023 04:19:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEFBF62005;
        Fri, 28 Jul 2023 11:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA656C433C8;
        Fri, 28 Jul 2023 11:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690543188;
        bh=A+kMGP5XBUEK/js9vxBBi+9xCO8IUT5dAfe86qUVntM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iYQtTVQCCNaBv1nTH9V1Qy1DMjl8v0mnrfeidxVDT7X91ewgVRIeI/SRqcpx26/Df
         rnJBkqrNku0/+/bRXHvSTr6PpCZNnLdtB2TMRfpla84b1QuDtKTk6nF5NBUEgCT8yI
         keyyHlm+J/wuworM5Bnslm038rFQYqJp5uSeQ70E3FUmL8zMBwJT0dzO4J2jiiDoJ9
         MhgBBWKmUwx/jZeNHOLKNKZM4yJhQV/y4jCJ04qBY8NvV9QAXobx0FjKpJwvyKVMaV
         rZwafc7B0QYbU+vXGwIECm33QO33o7enlf0ZVe6AmHQOZz77VH9HIj65isNwbGtkWM
         2oKrI9CWX4VSg==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20230726033554.174365-1-robh@kernel.org>
References: <20230726033554.174365-1-robh@kernel.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: allwinner: prcm: Simplify
 conditional schemas
Message-Id: <169054318538.349489.13231831699309127969.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 12:19:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 21:35:54 -0600, Rob Herring wrote:
> There's no need for 'additionalProperties' in the if/then schema as there's
> already 'unevaluatedProperties' in the parent schema. With
> 'additionalProperties' dropped, 'compatible' and 'phandle' don't need
> to be listed in the conditional schemas as 'compatible' is already in
> the main section and 'phandle' will be implicitly added.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: allwinner: prcm: Simplify conditional schemas
      commit: 67b8e8658577b117ea33b83c6c176ecd39caf1ca

--
Lee Jones [李琼斯]

