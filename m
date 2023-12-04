Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC5F8040FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjLDV2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDV2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:28:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9642AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:28:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F5AC433C8;
        Mon,  4 Dec 2023 21:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701725289;
        bh=GrS6re0Pnw+uBm1V2qdt1ie4VrYb1sT11XMmUaB1pJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H/J7lopGl2zOh80yIab32Hw2C21PBA9XV4prHzPUMF1TwgbcoRR2/AMyokVQ/WhhK
         +Sz1zOkMRXEtMdG3piW0ZaK77Iew3pWvoZAuQn7G/0yxh9I1t/Y7VqLWSeQEgcN8mQ
         TaHqdg5/yqMAVWNdBGgK9jX98z2cmqTVCR/qUEM6PYLhPC67HaLL2I4OAk3mSajXIi
         7ymuNm1HL5nquwdwPfvJHdckLcZZlJ6VYgompaD+aM/PU79N2QdRRIDSPxZc4um7s9
         K/GvYgYEAOfjFuk/ndFVC8h7ULdXR7jrH8RNexCSfMHtQNm2XJGa3HYlHneNsTtvaH
         2Le+5VdZDX1Ig==
Date:   Mon, 4 Dec 2023 15:28:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>,
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
Message-ID: <20231204212807.GA629695@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4154501-5b93-4eaf-8d2d-690809d26c57@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 09:17:24PM +0800, Minda Chen wrote:
> ...
> Please check this configuation.
> CONFIG_PHY_STARFIVE_JH7110_PCIE=y
> CONFIG_PINCTRL_STARFIVE_JH7110=y
> CONFIG_PINCTRL_STARFIVE_JH7110_SYS=y
> CONFIG_PINCTRL_STARFIVE_JH7110_AON=y
> 
> BTW, Maybe you can reply e-mail to me only.

There's usually no benefit to replying off-list.  The list archives
are very valuable for future maintenance because they help us
understand the reason things were done a certain way.

Bjorn
