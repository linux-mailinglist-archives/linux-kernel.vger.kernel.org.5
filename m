Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022F87D6A65
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjJYLvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjJYLvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:51:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC36612A;
        Wed, 25 Oct 2023 04:51:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E73C433C7;
        Wed, 25 Oct 2023 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698234676;
        bh=ccDEHLyNQ55/aoYnEMt5UuSrpWflucLNjB+nH26h8ME=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UuwBQ0eD9mjom9pz/LhHpyRrz5f531lApbW1EF/aM6aaDejxnTdKjzlZF7CDjEYCf
         b9hMFfW6oLpIR5/1C72TCD3poRCxa61b8N6TuqFi7KcVGCuitO4yN4Drn+02KOUoUj
         lPsRqh2TjVk2UrohokTCD4Usm8r9rFqKc8jm8o+nlWWTResKtEaz55Z6EUeBlIgK6s
         WZ1CqKNAUxR6uuO9Wz+rdvof05n0YPg0d9pPe5T4oZSt7EhYys7E3NoUfTEfw10hd1
         uoXxUuXWOqdtO8T82hfUvWYNC1cv1r9gGnRk7YKwClZDySVVaInW6EW7aQDuvWdwTL
         M4eHhQb0EkETQ==
From:   Lee Jones <lee@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20231020142252.3113716-2-robh@kernel.org>
References: <20231020142252.3113716-2-robh@kernel.org>
Subject: Re: (subset) [RESEND PATCH v2] dt-bindings: mfd: armltd: Move Arm
 board syscon's to separate schema
Message-Id: <169823467391.712087.1077897635437160110.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 12:51:13 +0100
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

On Fri, 20 Oct 2023 09:22:51 -0500, Rob Herring wrote:
> The Arm Ltd board bindings are a bit unusual in that they define child
> nodes for various syscon's. The schemas are also incomplete as they lack
> constraints on having additional properties and some properties are
> missing. As the bindings for the different platforms only vary by
> compatibles, combine them into a single schema doc.
> 
> Add the "arm,im-pd1-syscon" compatible which was not documented. Add
> "ranges", "#address-cells", and "#size-cells properties which were
> missing.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: armltd: Move Arm board syscon's to separate schema
      commit: 2bad5bd2552a34b27dce2bbc3ab1bb50d85f5869

--
Lee Jones [李琼斯]

