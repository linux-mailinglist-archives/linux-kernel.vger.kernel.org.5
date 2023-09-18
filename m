Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07557A545B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjIRUsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRUsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:48:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9178910D;
        Mon, 18 Sep 2023 13:48:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67386C433C8;
        Mon, 18 Sep 2023 20:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695070114;
        bh=Bo+bZhZuj9bWW94JFZSXNjfJwa6uMxx0LXt2pIQ+Fzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CodZ8P7WHzDqXcSxW2bOFAkrXOgbSARbKSWfTdbrirhlxJAYY+FY+0phDJZyxamo4
         /eQOCL5OKCXxLDCszEbx9XZP+cNKgyHYgCik72ahpXNJcMZhdnBHtASrJMFNJHILbq
         RzPR35YlvzgQxQsoseW3xLzYXWn3lcQGjI+ZusgyiRLfGC5rYtB5eZO9GKce5bVoUO
         ahdpZ0B/N/ykm20GizHNPDiY9sFYm5l8Bs3WlK9vk4TFJVfT5fNqNMvtjNvAr+3Iue
         9z9s59mZ1TKIGGUUYzDhYcyxaV1QFA5pWBe3z8FTdPzD35uh5ehgtZuinGDRDGhmAA
         FQ558CDgHX/hQ==
Received: (nullmailer pid 1743079 invoked by uid 1000);
        Mon, 18 Sep 2023 20:48:31 -0000
Date:   Mon, 18 Sep 2023 15:48:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        erkin.bozoglu@xeront.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: mtmips: add deprecated
 ralink,rt2880-pinmux
Message-ID: <169507011071.1743029.15067549858483442.robh@kernel.org>
References: <20230917162837.277405-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230917162837.277405-1-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Sep 2023 19:28:36 +0300, Arınç ÜNAL wrote:
> The "ralink,rt2880-pinmux" compatible string applies to all MediaTek MTMIPS
> SoC pin controllers. Add it as a deprecated compatible string.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml | 5 ++++-
>  .../devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml | 5 ++++-
>  .../devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml | 5 ++++-
>  .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml   | 5 ++++-
>  .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml   | 5 ++++-
>  .../devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml   | 5 ++++-
>  .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml   | 5 ++++-
>  .../devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml   | 5 ++++-
>  8 files changed, 32 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

