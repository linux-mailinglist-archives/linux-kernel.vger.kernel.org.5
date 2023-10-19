Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFDA7CFBA9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345816AbjJSNum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345827AbjJSNuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:50:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5396D187
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:50:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD39AC433C7;
        Thu, 19 Oct 2023 13:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697723437;
        bh=oy5VzoMhN6wZ1Vzq3Eg71Tf23vyezgeMhkqlIYLuizA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFF8kYkzoGiHfBO8gNfdHBGk9gOgif60Km8M2iB03XtUdc6uHtDmf5vch03FprWdc
         yhVh/N+yb+Pm0KNYibkrM6iaSM2u+TrYGIz6KNUJxjhFptHdUebiyy/0Xhjos7K3D1
         JMvrWlF+/h5bXX3zcZtPwYYqRJgUmCrMPlRkl6DWlRnFS30Dr6oFJbcLUTbPx7cwng
         w4xcUZEnmyyJO9eZ2T/oJcLM2kRaFoK+q4hhiREhKHhMSmbVoMLYZHiR1TajPCh9Da
         Z9FJmAwdAuQUbXoKMscFYa8eHOfishbBQxbev7NGteePpsFG7NgP+d3ioEEZ8Wi7wU
         giqLMnCi0bZhw==
Date:   Thu, 19 Oct 2023 14:50:32 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: rk8xx: Deprecate
 rockchip,system-power-controller
Message-ID: <20231019135032.GD2424087@google.com>
References: <20231010174138.1888396-1-megi@xff.cz>
 <20231010174138.1888396-2-megi@xff.cz>
 <20231019102945.GA2424087@google.com>
 <a7b6115e-9490-47cf-8054-ac616dea62fd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7b6115e-9490-47cf-8054-ac616dea62fd@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023, Krzysztof Kozlowski wrote:

> On 19/10/2023 12:29, Lee Jones wrote:
> > On Tue, 10 Oct 2023, Ondřej Jirman wrote:
> > 
> >> From: Ondrej Jirman <megi@xff.cz>
> >>
> >> Deprecate support for this property in favor of standard
> >> system-power-controller one.
> >>
> >> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> >> ---
> >>  Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml | 3 +++
> >>  Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml | 3 +++
> >>  Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 3 +++
> >>  Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 3 +++
> >>  Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml | 3 +++
> >>  5 files changed, 15 insertions(+)
> > 
> > I don't see anything wrong with it.
> > 
> > It would be nice to have a DT Ack though.
> 
> Rob gave review on 12th Oct.

This new version was submitted on the 10th Oct.

-- 
Lee Jones [李琼斯]
