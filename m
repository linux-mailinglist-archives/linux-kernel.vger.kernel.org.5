Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925477B1EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjI1NrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjI1Nq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:46:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97790194
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:46:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D4DC433C8;
        Thu, 28 Sep 2023 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695908816;
        bh=2YzCsfGuDcZbmNxF5WFR5C/acVLmd3czOOew5lOaKXI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=F3fTfiijmvTNwSJoN0cRtKn6x3aVUf9jkb6SkGiaxnd36Hwziyc2mewjk1CSWjl98
         2xqfk8hbRCfGyfHgLOwXXZCu0/faKZW7oBk4Yf0uCghd02mW03BH5W0FNjbySPwUc3
         Kl7IIKb7fH2JYzk8kYT/8YJYs/IiUBjzd2Zzood7dy8pG5yP+N6X85wzFDOWVlbdHp
         QppAHqUrxLSj+PV0/rMJWugnBwrKrzT8eDxTME4RoILzWQPHkylmlHid8gHdYztMkq
         PQJZzADxr1H3jlLem28O3sv93EveD3UFk2xsMGVPsXu4hT8Xg9s03TWDMr9ue+XtDp
         1lsZOYM9oC7lw==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <uwu@icenowy.me>, Mark Brown <broonie@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shengyu Qu <wiagn233@outlook.com>,
        Martin Botka <martin.botka1@gmail.com>,
        Matthew Croughan <matthew.croughan@nix.how>,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230919103913.463156-2-andre.przywara@arm.com>
References: <20230919103913.463156-1-andre.przywara@arm.com>
 <20230919103913.463156-2-andre.przywara@arm.com>
Subject: Re: (subset) [PATCH v3 1/2] dt-bindings: mfd: x-powers,axp152:
 make interrupt optional for more chips
Message-Id: <169590881296.1610191.10475308941086886340.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 14:46:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 11:39:12 +0100, Andre Przywara wrote:
> All X-Powers PMICs described by this binding have an IRQ pin, and so
> far (almost) all boards connected this to some NMI pin or GPIO on the SoC
> they are connected to.
> However we start to see boards that omit this connection, and technically
> the IRQ pin is not essential to the basic PMIC operation.
> 
> The existing Linux driver allows skipping the IRQ pin setup for two chips
> already, so update the binding to also make the DT property optional for
> the missing chip. And while we are at it, add the AXP313a to that list,
> as they are actually boards out there not connecting the IRQ pin.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: x-powers,axp152: make interrupt optional for more chips
      commit: cf71329eb3a37f90c8ddec0651dc7b3fa76036c1

--
Lee Jones [李琼斯]

