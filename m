Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E537B5B4E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbjJBT0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbjJBT0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:26:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D768BAC;
        Mon,  2 Oct 2023 12:26:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19A1C433C7;
        Mon,  2 Oct 2023 19:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696274779;
        bh=/VXK0Doi2ugIAsDtjX5XrQhNXO4ojTZSscjv1xrbOgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TtMPJxUtQO0dOH9Uvp6l6vEzpDyAKTrN8TNJlla6L305ICOCwsVaKVnsOwLo+JV7b
         X2sMBl5PXWCISRXb/a2dMeaiK/hag/v7pOpat7R1JK2UG78soGgVMez0BCkvxAYO8i
         9r0znZgdgG7iYlNUFp5OGwVW14epjuvc7MgQcwzAaw49U2+7B98H+uFxddpabod7o3
         TZh8qMATF6IsSsNHQ3A9qas+IwJs2BLElmgnifE+s8gsgYHuMBlB20sS1MsZyaNM2r
         MlW1aCmOK4wRy3RCBG9tc1AxVU9WBvNVh/cNLf814vdrGaMnkoDoIGgTqwDgCZkkV5
         IlfNyT6hNKItw==
Received: (nullmailer pid 2386735 invoked by uid 1000);
        Mon, 02 Oct 2023 19:26:17 -0000
Date:   Mon, 2 Oct 2023 14:26:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: power: mfd: max8925: Convert to DT
 schema format
Message-ID: <169627477713.2386676.2358148175794895273.robh@kernel.org>
References: <20230930202743.214631-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930202743.214631-1-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 30 Sep 2023 22:27:43 +0200, Sebastian Reichel wrote:
> Convert the binding to DT schema format.
> 
> The sub-functions of this MFD device do not have their own compatible
> string and are thus described directly in the MFD binding document
> after being converted to YAML.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Changes since PATCHv2:
>  * https://lore.kernel.org/all/20230922233142.1479677-1-sebastian.reichel@collabora.com/
>  * Add unevaluatedProperties: false to regulators subnode (Krzysztof Kozlowski)
>  * Use "pmic" for nodename (Krzysztof Kozlowski)
> 
> Changes since PATCHv1:
>  * https://lore.kernel.org/all/20210413153407.GA1707829@robh.at.kernel.org/
>  * Update License to GPL OR BSD
>  * Add missing type references pointed out by Rob
> ---
>  .../leds/backlight/max8925-backlight.txt      |  10 --
>  .../devicetree/bindings/mfd/max8925.txt       |  64 --------
>  .../bindings/mfd/maxim,max8925.yaml           | 145 ++++++++++++++++++
>  .../bindings/power/supply/max8925_battery.txt |  18 ---
>  4 files changed, 145 insertions(+), 92 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/backlight/max8925-backlight.txt
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max8925.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max8925.yaml
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/max8925_battery.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

