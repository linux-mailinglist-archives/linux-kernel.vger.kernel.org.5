Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AEA75C087
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjGUH4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGUH4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:56:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D7819AD;
        Fri, 21 Jul 2023 00:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 317656159C;
        Fri, 21 Jul 2023 07:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7F8C43395;
        Fri, 21 Jul 2023 07:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689926158;
        bh=uIQ8q7XSnF8hoWoQCg3GFFGmD657fExNIBt1fiMAPaw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SE9P4icIE0VBim2cgG9RpUwM3JoSWh/zzU4yPJNunSKyEyW0gXC3ez8X4kTQ4z+NY
         5f1D1REkn8OjifY3N+CTj2AQrZ6yh8lk7IHCcZSyBSvMIufqcEucn/jxveOE7RUT6O
         E3hsNcLGqHaCwe8Z6Z7UV8kJdw8EmB/5K4jp9qrsLRwJWbZYtQOXPMrGMrYMwv+UZP
         Ik3VQeAAsHFHv3OU8uqplhmkoiUbtSszn5lEZJ0rgPcGCDkeBg5jG1VZvPJ5PxggIW
         eaXVJa8vWo3zJGwieOKx4OKu/F2ePu9MFRG0s5pyRvdvbu/y+YdRWCYbj13RdZQrTR
         5hMY89qArpteQ==
From:   Lee Jones <lee@kernel.org>
To:     broonie@kernel.org, lee@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        vkoul@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, conor+dt@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230619095623.1987742-1-ckeepax@opensource.cirrus.com>
References: <20230619095623.1987742-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v5 0/6] Add cs42l43 PC focused SoundWire CODEC
Message-Id: <168992615492.1924396.13464534208592126033.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 08:55:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 10:56:17 +0100, Charles Keepax wrote:
> This patch chain adds support for the Cirrus Logic cs42l43 PC focused
> SoundWire CODEC. The chain is currently based of Lee's for-mfd-next
> branch.
> 
> Thanks,
> Charles
> 
> [...]

Applied, thanks!

[2/6] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
      commit: e62ba8443b11f12b45c61444249458a2f8c2f4ef
[3/6] mfd: cs42l43: Add support for cs42l43 core driver
      commit: 843079209e1506c94fde797fc0ff914e2c9e6645
[4/6] pinctrl: cs42l43: Add support for the cs42l43
      commit: 85f034dd7ff0a66aded653cc91dbc406fba7cf1a

--
Lee Jones [李琼斯]

