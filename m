Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C07D68F6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjJYKiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbjJYKh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:37:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774381727
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:36:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF09C433CA;
        Wed, 25 Oct 2023 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698230203;
        bh=ntDXN6/2qOsCCkilJlaxE0vWMmmPJiupJ7r60b2XmUI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UOiBRPIso13bGcE/dHRWnAAPD3tWDEd3aq+7CdIUQl9qgz4eOAeJcXX58da+eXK2L
         MOPmSPZuyjUhNwXijkmQ2JBWWRjuUFNtlMZQf8FqspwJ2eQmseJ/j2mwTqxEXq9eFv
         hHSL84+cvhIor5HBMmnE2EfcRWT0L/Z0oKlbCNgOHV9ZUIFDQ+/cQ5U28sXxtyee+5
         BnszHdpuEiT9juPV8ztCdaDo6mPmK3HoyL6fGw5KziSN3GPLgZNJ37Fn8oV0F4/lxm
         Tix9njlM952bp0cNwYIMfhust8vdzujhrnFCgXlIyw7reqdsWIgB9bp9FmKmiAYs6g
         DTxkqI0aRGPTA==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231019165732.3818789-1-megi@xff.cz>
References: <20231019165732.3818789-1-megi@xff.cz>
Subject: Re: [PATCH v3 0/4] Add support for poweroff via RK806 PMIC
Message-Id: <169823020128.678899.14014128373986258754.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 11:36:41 +0100
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

On Thu, 19 Oct 2023 18:57:22 +0200, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> The PMIC supports powering off by twiddling some bits in a register. Add support
> for it via pre-existing rockchip,system-power-controller DT property.
> 
> The series was tested against Linux 6.6-rc4.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: mfd: rk8xx: Deprecate rockchip,system-power-controller
      commit: 8b7fb96f861c17443b7e3a5c256897b72d4c205f
[2/4] dt-bindings: mfd: rk806: Allow system-power-controller property
      commit: 517dbecfeafa52c8ada4bd3585d9e8b005f7e542
[3/4] mfd: rk8xx: Add support for standard system-power-controller property
      commit: 4be7cc6f62beb8a56c2c8f9748a7e345a645c914
[4/4] mfd: rk8xx: Add support for RK806 power off
      commit: 8dc3aab3c45eb0fba9202d2d6ad628cc7b59c17d

--
Lee Jones [李琼斯]

