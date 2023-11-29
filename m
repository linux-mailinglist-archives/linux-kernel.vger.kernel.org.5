Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8BD7FD3F4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjK2KTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjK2KTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:19:37 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E81210C8;
        Wed, 29 Nov 2023 02:19:44 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 9FD92603F4;
        Wed, 29 Nov 2023 10:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701253183;
        bh=vmbye+7xTc5TAprv8bGCBpYs5zBBQ4aAAXZTaK7F9vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DBRmCOu0DUrEn4TChU4oz1IFOZzm06cbvip6fGUF5tC+rzfjrlz4OXrApxJVGmZZv
         f5+mWJIjJ1knMo9A1y8fd9oC6dupwm1vbMEdNKMLnqT8q35G4bUOf9jqodxX53ljKP
         sXFkd5bfzPBqO9HettROaMgTKrRgeYgV/b93M8F300ujW9wXft+E3zDA7kKMwGDdKI
         03Jbpntz462NEJqXnZibC2puUH71cA0jZ1fG0mRV2xNK5Z5ix3jZCB8e+WGYx1VNji
         uRWP9JYMmEnjNUKcUYTUML+iT9t263OU63TXn8v9fAsTACflk4TAzQgV4UCIoo/ID1
         SCKrSZ2KrYQhA==
Date:   Wed, 29 Nov 2023 12:19:05 +0200
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
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j7200: use ti,j7200-padconf
 compatible
Message-ID: <20231129101905.GY5169@atomide.com>
References: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
 <20231128-j7200-pinctrl-s2r-v1-3-704e7dc24460@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128-j7200-pinctrl-s2r-v1-3-704e7dc24460@bootlin.com>
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
> For suspend to ram on j7200, use ti,j7200-padconf compatible to save and
> restore pinctrl contexts.

Hmm are the mcu registers lost too? Anyways presumably you looked at it:

Reviewed-by: Tony Lindgren <tony@atomide.com>
