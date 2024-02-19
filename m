Return-Path: <linux-kernel+bounces-71852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4793B85ABC8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A239CB21E03
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4F84F5FF;
	Mon, 19 Feb 2024 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atM/CvQ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA74F1F5;
	Mon, 19 Feb 2024 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369710; cv=none; b=K2tPTbCe90WDMT/Sf0+Xxk9C0I7Ww/x3ntW8jvte4/pEqR5P+GmL3qw07v2AzHlXq3nwuT6jAItimxb6hEtvibo5Oul+kOGrpPxrXjR6B3Yyj+FKsODeC6dVRqc+Fp2JfaeWZuuHzmYOJplzDfFioDw0U6J6tOfdhZBcZc98f+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369710; c=relaxed/simple;
	bh=Qgm4yRczBnXgjpxAD+i1bsbP2xXCEc56/SoGjrcpzPo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=IhsQqn8nJfn+/YdX3uuVkUY1Pscs9ttCr9naf3/GLoKglfjPCogc1hfwgjxFNVC/3DsMyD07xjFg+pIW/ffEIJMNqhQiHtZvK2OWJ0HccfgdZk0lroOjn7HQbdVXB1CJXdYcVBrqdCs+7mRW5iYrCwaYL2PxXOxrUsJsGzflh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atM/CvQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE033C433C7;
	Mon, 19 Feb 2024 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708369709;
	bh=Qgm4yRczBnXgjpxAD+i1bsbP2xXCEc56/SoGjrcpzPo=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=atM/CvQ3iM2Anizb1lzybkxvKx4jL0MqzynEc9xfeXYO4jST8XRzcHkXWB1rVSoXm
	 QzyUkIxjMCH9R5YY/PaB5tsF3NM1FDm8ykl4d3vXKA5asaVD7k3T/dyEoh1VZZzkjV
	 kIr74/S+E61h0sUkZdHfsYrdNzab1k3HMtQZRRFEGMUr+2ET8tOcs0ZuNnfT1ZRisK
	 aGWGhy6Ua4SklPFh8q/0UhO+nzJXgQ6wsbcSkaoqa5RFwR1fvwJmxCB+5UNPA+m8me
	 VnACdEWHC3NqCsBvhJZUamXJbuuKbNyTaBxaPGys8l0JPiznLYdaSAmdLDp4bqSWW0
	 hCsk3eP26kWrw==
Message-ID: <e760847bd911671f1e364271888481fd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <02461595-16b3-4fea-a029-54190e10e6f5@linaro.org>
References: <20240208163710.512733-1-krzysztof.kozlowski@linaro.org> <38e7e80f61f7c67c984735cf55c3dfb3.sboyd@kernel.org> <02461595-16b3-4fea-a029-54190e10e6f5@linaro.org>
Subject: Re: [PATCH] clk: constify the of_phandle_args argument of of_clk_provider
From: Stephen Boyd <sboyd@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Jonathan Hunter <jonathanh@nvidia.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Turquette <mturquette@baylibre.com>, NXP Linux Team <linux-imx@nxp.com>, Nishanth Menon <nm@ti.com>, Peng Fan <peng.fan@nxp.com>, Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>, Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-phy@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, patches@opensource.cirrus.com
Date: Mon, 19 Feb 2024 11:08:27 -0800
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-02-15 23:12:29)
> On 16/02/2024 00:12, Stephen Boyd wrote:
> > Quoting Krzysztof Kozlowski (2024-02-08 08:37:10)
> >> None of the implementations of the get() and get_hw() callbacks of
> >> "struct of_clk_provider" modify the contents of received of_phandle_ar=
gs
> >> pointer.  They treat it as read-only variable used to find the clock to
> >> return.  Make obvious that implementations are not supposed to modify
> >> the of_phandle_args, by making it a pointer to const.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >=20
> > This will almost certainly break the build once it is merged to
> > linux-next. What's your plan to merge this?
>=20
> First problem is that it might not apply... I prepared it on next to be
> sure all subsystems are updated.
>=20
> The idea is to get reviews and acks and then:
> 1. Maybe it applies cleanly to your tree meaning there will be no
> conflicts with other trees,
> 2. If not, then I can keep rebasing it and it should be applied after rc1.
>=20

The struct clk based version is probably not going to be used in any new
code. If you split the patch up and converted the struct clk based ones
first then that would probably apply without breaking anything, because
new code should only be using the struct clk_hw version.

The struct clk_hw version could be done in two steps. Introduce another
get_hw callback with the const signature, and then update the world to
use that callback, finally remove the old callback. We could call this
callback 'get_clk_hw'. This is probably more work than it's worth
though, but at least this way we don't have to worry about applying
after rc1.

Or perhaps we need to cast everything and use macros? It would be bad if
the callback actually did something with the clkspec and we cast it to
const, but your patch shows that nobody is doing that. We would get rid
of this macro garbage once everything is converted.

---8<---
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2253c154a824..8e5ed16a97a0 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4818,7 +4818,7 @@ struct of_clk_provider {
 	struct list_head link;
=20
 	struct device_node *node;
-	struct clk *(*get)(struct of_phandle_args *clkspec, void *data);
+	struct clk *(*get)(const struct of_phandle_args *clkspec, void *data);
 	struct clk_hw *(*get_hw)(struct of_phandle_args *clkspec, void *data);
 	void *data;
 };
@@ -4880,8 +4880,8 @@ EXPORT_SYMBOL_GPL(of_clk_hw_onecell_get);
  *
  * This function is *deprecated*. Use of_clk_add_hw_provider() instead.
  */
-int of_clk_add_provider(struct device_node *np,
-			struct clk *(*clk_src_get)(struct of_phandle_args *clkspec,
+int _of_clk_add_provider(struct device_node *np,
+			struct clk *(*clk_src_get)(const struct of_phandle_args *clkspec,
 						   void *data),
 			void *data)
 {
@@ -4914,7 +4914,7 @@ int of_clk_add_provider(struct device_node *np,
=20
 	return ret;
 }
-EXPORT_SYMBOL_GPL(of_clk_add_provider);
+EXPORT_SYMBOL_GPL(_of_clk_add_provider);
=20
 /**
  * of_clk_add_hw_provider() - Register a clock provider for a node
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1293c38ddb7f..bfc660fa7c8f 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1531,10 +1531,11 @@ struct clk_hw_onecell_data {
 	}
=20
 #ifdef CONFIG_OF
-int of_clk_add_provider(struct device_node *np,
-			struct clk *(*clk_src_get)(struct of_phandle_args *args,
+int _of_clk_add_provider(struct device_node *np,
+			struct clk *(*clk_src_get)(const struct of_phandle_args *args,
 						   void *data),
 			void *data);
+
 int of_clk_add_hw_provider(struct device_node *np,
 			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
 						 void *data),
@@ -1559,8 +1560,8 @@ int of_clk_detect_critical(struct device_node *np, in=
t index,
=20
 #else /* !CONFIG_OF */
=20
-static inline int of_clk_add_provider(struct device_node *np,
-			struct clk *(*clk_src_get)(struct of_phandle_args *args,
+static inline int _of_clk_add_provider(struct device_node *np,
+			struct clk *(*clk_src_get)(const struct of_phandle_args *args,
 						   void *data),
 			void *data)
 {
@@ -1614,6 +1615,12 @@ static inline int of_clk_detect_critical(struct devi=
ce_node *np, int index,
 }
 #endif /* CONFIG_OF */
=20
+typedef struct clk *(*clk_src_get_fn)(const struct of_phandle_args *args, =
void *data);
+
+#define of_clk_add_provider(np, get, data) ({				\
+		_of_clk_add_provider(np, (clk_src_get_fn)(get), data);		\
+})
+
 void clk_gate_restore_context(struct clk_hw *hw);
=20
 #endif /* CLK_PROVIDER_H */

