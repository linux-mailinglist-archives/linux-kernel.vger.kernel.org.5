Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359F77C0253
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjJJRNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjJJRNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:13:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4073F97
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:13:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2145C433C8;
        Tue, 10 Oct 2023 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696957994;
        bh=CpRi1qWIPg1zI8cNlGAKUvwmbroDRNWSt7h1XCOInNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uU+4dcVj7euRRCf/2o4v/4SBVoKBPj+tUGSsLawdSANa7lZyo7nthdv4WZbEeXlLa
         ptTRCLPGDW9v7EdysZ8o3NrPBT6FN4VfmhYsvpudfVTt/q2rDfons9zHVvRSyrNtjE
         n5QOHcvL2c6cqluwD4tiQoKujA0hCEdwOLteX9/u16i7J8hGLd8Bqej6hvInuannUP
         wXSxnOtzxBnL6wgnHGRkwNMMnkqDpPAGLay3P0vh+iSDNDG8B7W0cHHvKynAtPN/zx
         ynmA7pa6bgoFna7SpzNKM/qFHT6SA7E5BMqp/UW6lWRK+Y/df5R3P0jdePxKCOUVEz
         FBD/0I1wS5/Ig==
Received: (nullmailer pid 1067723 invoked by uid 1000);
        Tue, 10 Oct 2023 17:13:13 -0000
Date:   Tue, 10 Oct 2023 12:13:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: rk806: Allow
 rockchip,system-power-controller property
Message-ID: <20231010171313.GA1065385-robh@kernel.org>
References: <20231010074826.1791942-1-megi@xff.cz>
 <20231010074826.1791942-2-megi@xff.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010074826.1791942-2-megi@xff.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:48:20AM +0200, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> Declare support for this property.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>  Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> index cf2500f2e9a0..e8c9f17f6ea8 100644
> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> @@ -29,6 +29,11 @@ properties:
>    '#gpio-cells':
>      const: 2
>  
> +  rockchip,system-power-controller:
> +    type: boolean
> +    description:
> +      Telling whether or not this PMIC is controlling the system power.

New users should use the common 'system-power-controller'.

Feel free to mark rockchip,system-power-controller deprecated and add 
'system-power-controller' on the existing Rockchip PMIC bindings.

> +
>    vcc1-supply:
>      description:
>        The input supply for dcdc-reg1.
> -- 
> 2.42.0
> 
