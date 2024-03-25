Return-Path: <linux-kernel+bounces-117183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3271288A860
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26B41F2983F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7556F13AD09;
	Mon, 25 Mar 2024 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhqjWlr4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F07413B28E;
	Mon, 25 Mar 2024 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374942; cv=none; b=J/NniX6vAUnHhDvKYAsbglezFjXdr7n3Hu8HC+GrRSj8yUnep69Ze0vQqXmOYwjwKzt3EFyQe2gUkgJd6hhN3OcBRUwkNw88im1dxmba+3yd18RYjCaq2enR9jKwqgQ4xM7idnc2Otz8utjGspnrbRPUsyrDTNHvkQKpDGj5SKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374942; c=relaxed/simple;
	bh=QL7wUNDnrbeyCC7mBUbeWx4JQtVi0fU2KEQRQK5eHrI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Op8Kf1j49Scv9S098FNW0NGwnm5f9COmdn/Q9wnBMUFJjg1eJqYl2eq/fnWmdKXAAMB0pMrMSSkYA+1btK6AzhbVFRwqKN7DMFTSEzOchRi+R6LBnDdMBDELPdpAl6Qe+hn4y4SblA1C3BMFmG7kbr3+DZrsPLOq78TnF45JVpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhqjWlr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0781C43394;
	Mon, 25 Mar 2024 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711374942;
	bh=QL7wUNDnrbeyCC7mBUbeWx4JQtVi0fU2KEQRQK5eHrI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UhqjWlr4LFfcTm44jPOF1M8GJw5fLJsxXxKUokM/9dqQ1yd1rBFRHi1Sxatisz26W
	 kV1yYFTrUKbK1SmYlJsrp06OpS0ltgvyW3GygQ2W6mHLiLHAJxtkS2TlT/bqgPimY5
	 OOa5I1IrJ1ybPbkqxs0+jGe2BAQHxsNuf9g46P1B4Po06J6PteiyTBuGY7kip7S7Je
	 2UZStAwcDB1/sF474BBACQXYdV8Sj1yWSdtT9wOIbI/fYdyM7PZTyGnBGZxN4vtodR
	 Q8LEa44BfIWjI07koUP9GvSsbLrovRyVWV6r248F/G2h8++wZJ2uo3PgyaI1XCw2jU
	 eelnVg1M953sw==
Date: Mon, 25 Mar 2024 08:55:40 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 heiko@sntech.de, linux-clk@vger.kernel.org, 
 Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <1711340191-69588-2-git-send-email-sugar.zhang@rock-chips.com>
References: <1711340191-69588-1-git-send-email-sugar.zhang@rock-chips.com>
 <1711340191-69588-2-git-send-email-sugar.zhang@rock-chips.com>
Message-Id: <171137493890.3270008.6436971958233040222.robh@kernel.org>
Subject: Re: [PATCH v1 2/2] dt-bindings: clock: rockchip: Add support for
 clk input / output switch


On Mon, 25 Mar 2024 12:16:30 +0800, Sugar Zhang wrote:
> This patch add support switch for clk-bidirection which located
> at GRF, such as SAIx_MCLK_{IN OUT} which share the same pin.
> and these config maybe located in many pieces of GRF,
> which hard to addressed in one single clk driver. so, we add
> this simple helper driver to address this situation.
> 
> In order to simplify implement and usage, and also for safety
> clk usage (avoid high freq glitch), we set all clk out as disabled
> (which means Input default for clk-bidrection) in the pre-stage,
> such boot-loader or init by HW default. And then set a safety freq
> before enable clk-out, such as "assign-clock-rates" or clk_set_rate
> in drivers.
> 
> e.g.
> 
> 1. mclk{out,in}_sai0 define:
> 
>   mclkin_sai0: mclkin-sai0 {
>       compatible = "fixed-clock";
>       #clock-cells = <0>;
>       clock-frequency = <12288000>;
>       clock-output-names = "mclk_sai0_from_io";
>   };
> 
>   mclkout_sai0: mclkout-sai0@ff040070 {
>       compatible = "rockchip,clk-out";
>       reg = <0 0xff040070 0 0x4>;
>       clocks = <&cru MCLK_SAI0_OUT2IO>;
>       #clock-cells = <0>;
>       clock-output-names = "mclk_sai0_to_io";
>       rockchip,bit-shift = <4>;
>       //example with PD if reg access needed
>       power-domains = <&power RK3562_PD_VO>;
>   };
> 
> Note:
> 
> clock-output-names of mclkin_sai0 should equal to strings in drivers. such as:
> 
> drivers/clk/rockchip/clk-rk3562.c:
> PNAME(clk_sai0_p) = { "clk_sai0_src", "clk_sai0_frac", "xin_osc0_half", "mclk_sai0_from_io" };
> 
> 2. mclkout_sai0 usage:
> 
>   &ext_codec {
>       clocks = <&mclkout_sai0>;
>       clock-names = "mclk";
>       assigned-clocks = <&mclkout_sai0>;
>       assigned-clock-rates = <12288000>;
>       pinctrl-names = "default";
>       pinctrl-0 = <&i2s0m0_mclk>;
>   };
> 
>   clk_summary on sai0 work:
> 
>   cat /sys/kernel/debug/clk/clk_summary | egrep "pll|sai0"
> 
>   clk_sai0_src                1        1        0  1188000000          0     0  50000
>     clk_sai0_frac             1        1        0    12288000          0     0  50000
>       clk_sai0                1        1        0    12288000          0     0  50000
>         mclk_sai0             1        1        0    12288000          0     0  50000
>           mclk_sai0_out2io    1        1        0    12288000          0     0  50000
>             mclk_sai0_to_io   1        1        0    12288000          0     0  50000
> 
>   example with PD if reg access needed:
> 
>   * PD status when mclk_sai0_to_io on:
> 
>   cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> 
>   domain                          status          children
>     /device                                                runtime status
>   ----------------------------------------------------------------------
>   ...
> 
>   vo                              on
>     /devices/platform/clocks/ff040070.mclkout-sai0         active
>   ...
> 
>   * PD status when mclk_sai0_to_io off:
> 
>   cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> 
>   domain                          status          children
>     /device                                                runtime status
>   ----------------------------------------------------------------------
>   ...
> 
>   vo                              off-0
>     /devices/platform/clocks/ff040070.mclkout-sai0         suspended
>   ...
> 
> 3. mclkin_sai0 usage:
> 
>   please override freq of mclkin as the real external clkin, such as:
> 
>   &mclkin_sai0 {
>       clock-frequency = <24576000>;
>   }
> 
>   &ext_codec {
>       clocks = <&mclkin_sai0>;
>       clock-names = "mclk";
>       assigned-clocks = <&cru CLK_SAI0>;
>       assigned-clock-parents = <&mclkin_sai0>;
>       pinctrl-names = "default";
>       pinctrl-0 = <&i2s0m0_mclk>;
>   };
> 
>   clk_summary on sai0 work:
> 
>   cat /sys/kernel/debug/clk/clk_summary | egrep "pll|sai0"
> 
>   mclk_sai0_from_io          1        1        0    12288000          0     0  50000
>     clk_sai0                 1        1        0    12288000          0     0  50000
>       mclk_sai0              1        1        0    12288000          0     0  50000
>         mclk_sai0_out2io     0        0        0    12288000          0     0  50000
>           mclk_sai0_to_io    0        0        0    12288000          0     0  50000
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  .../bindings/clock/rockchip,clk-out.yaml           | 107 +++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,clk-out.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/rockchip,clk-out.yaml: title: 'Rockchip Clock Out Control Module Binding' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
Error: Documentation/devicetree/bindings/clock/rockchip,clk-out.example.dts:28.28-29 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:427: Documentation/devicetree/bindings/clock/rockchip,clk-out.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1711340191-69588-2-git-send-email-sugar.zhang@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


