Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CFC7FD3DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjK2KRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjK2KRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:17:02 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D0F10D3;
        Wed, 29 Nov 2023 02:17:08 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 5B9DE603F4;
        Wed, 29 Nov 2023 10:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701253028;
        bh=oE6jtE7oqWTbaOtDsTUgJOlpNSzODuybOTXGW1q0Bjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWn81cRxuDVWr9BFGszsg6po1qA7R1aHSxuehDs1p/KU8diPTJdmvAW5h/tWZD3ui
         RDmI6YvWHfQjYT1dErR4L96OhDXAJ7z/5uD+e7XCLthnFoD8UCuPzyk7Neh+RxEJFW
         HpwQw9Zeo2LGJrI7iUgEHy7k2eA8nFmcMWNz5qDvz1mzsjMAiPPnccRhGRrfJdx7n9
         EhHenmYviEa/kPhyXd4uIr55itrraZAWdCeMAl0KQIthYDNrP1GM7Skl9DluhYEZFq
         mub3F5p4uU93rOZHBDTkTfaxcmOny2wTtkI7sG+CjPv3thX2/vh6vtUwBXL959wqfu
         F1IJB7umUSJzg==
Date:   Wed, 29 Nov 2023 12:16:29 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        theo.lebrun@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH 2/3] pinctrl: pinctrl-single: add ti,j7200-padconf
 compatible
Message-ID: <20231129101629.GX5169@atomide.com>
References: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
 <20231128-j7200-pinctrl-s2r-v1-2-704e7dc24460@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128-j7200-pinctrl-s2r-v1-2-704e7dc24460@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Richard <thomas.richard@bootlin.com> [231128 15:35]:
> On j7200, during suspend to ram pinctrl contexts are lost. To save and
> restore contexts during suspend/resume, the flag PCS_CONTEXT_LOSS_OFF
> shall be set.

Reviewed-by: Tony Lindgren <tony@atomide.com>
