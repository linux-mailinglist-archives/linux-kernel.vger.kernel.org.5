Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18119805C77
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345141AbjLERCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLERCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:02:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760CC83
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:02:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE16FC433C7;
        Tue,  5 Dec 2023 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795740;
        bh=6eqzdlbd2wRbilXyM8br8k9jCk9NPFOASbrV1lTKof0=;
        h=Date:From:To:Subject:In-Reply-To:From;
        b=rrYEZ6mDeh47zil4efVVC3txYOSi3rtzc6BqQyBLELxK0D/OYbcop4/aMyi9qyW/f
         8jxcOmxzxRzfvPxNByuPLgS/aZI8iJ7htUrK96g5D6/KFghAQTzPvMuAZaC0/E8RK+
         I+bWsBKRNSQMZjLsUPpE4C8b+/FE38MZ6Jn9GaOBN5UvMt0qMIVarFGu/pQNUjIF+B
         S4vlHyGARZ1IssLp0lh2IAZVHWHG8VhcQwlSjBucgsUhWjWrre/J6zG6A+2RGPwCoK
         EHBa1CSNYQnFrXoZ/gtIChK7DVQBBFQiQKGJVn64K5xD7y78QFCWZjsl2OeozApwgS
         qVGFWeFfjIScg==
Date:   Tue, 5 Dec 2023 11:02:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v11 0/20] Refactoring Microchip PCIe driver and add
 StarFive PCIe
Message-ID: <20231205170218.GA679691@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW7q1LEvEpVxoI4l@fedora>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:18:12AM +0100, Damian Tometzki wrote:
> > On Sat, Dec 02, 2023 at 09:17:24PM +0800, Minda Chen wrote:
> > > ...
> > > Please check this configuation.
> > > CONFIG_PHY_STARFIVE_JH7110_PCIE=y
> > > CONFIG_PINCTRL_STARFIVE_JH7110=y
> > > CONFIG_PINCTRL_STARFIVE_JH7110_SYS=y
> > > CONFIG_PINCTRL_STARFIVE_JH7110_AON=y
> ...

> Hello together,
> the main problemwas was  to find the rquired CONFIG_* options for StarFive
> Board. It would be great to have an CONFIG_ Options with all required
> Dependencies.

I didn't follow all the discussion here so I don't know all the
symptoms and what the resulting working config was, but it sounds like
the Kconfig needs to be simplified somehow so other users don't have
to repeat this struggle.

Bjorn
