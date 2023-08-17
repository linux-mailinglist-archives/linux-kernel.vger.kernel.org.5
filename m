Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473A477F4CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350189AbjHQLKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350192AbjHQLKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:10:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB58230D7;
        Thu, 17 Aug 2023 04:09:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7953661113;
        Thu, 17 Aug 2023 11:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC783C433C8;
        Thu, 17 Aug 2023 11:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692270594;
        bh=m+iOFlhLTce7hvaLnYnzvoWQ7/UQ3oXDTw1op5hP3gk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XK+CGoMyEE7Y1Ld3ZPYRnzrkZ7dNkvty8wLkIjZErBzZc1xQvE9T57HY+YVJsFdHu
         8MxBGV+cQE80gnumUUDEHh1LjttEW4B9SoYzPCArpQ8zfer1oIzeU5AnEdw9BhtzHe
         dZzUaFbiHCHid1+hl/I5M65sVoUir2aCdPNfYDCkugI7dWnSslWNTIqF9jyBN/+ads
         PTEFxaE4DAzoX+cujbJPFKmrm4GATRroVZauXaE+NPYZwHsMUGEEz7ykjj02jyoe5I
         9CelBVTmWr0iJdeGc+SHKfGqd5WFenf9YzQROCsE+1KcyyfE1GbhmB9YC+/sFmAgnH
         PtbzyGPf1Gafw==
From:   Lee Jones <lee@kernel.org>
To:     broonie@kernel.org, lee@kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, vkoul@kernel.org,
        lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v7 0/6] Add cs42l43 PC focused SoundWire CODEC
Message-Id: <169227059141.987802.3881975345148652106.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 12:09:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2023 11:45:56 +0100, Charles Keepax wrote:
> This patch chain adds support for the Cirrus Logic cs42l43 PC focused
> SoundWire CODEC. The chain is currently based of Lee's for-mfd-next
> branch.
> 
> This series is mostly just a resend keeping pace with the kernel under
> it, except for a minor fixup in the ASoC stuff.
> 
> [...]

Applied, thanks!

[1/6] soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
      commit: 89e63e62ad14dbe528257882856c08365e5bb337
[2/6] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
      commit: 940cdb69aeb4aa3dde97bd46a5d8422f8a0f1236
[3/6] mfd: cs42l43: Add support for cs42l43 core driver
      commit: c4962e013792df36dceacd692fef0f6803517b3f
[4/6] pinctrl: cs42l43: Add support for the cs42l43
      commit: df393be615ae61993ac0c32edc13dff27b7e925d

--
Lee Jones [李琼斯]

