Return-Path: <linux-kernel+bounces-95701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABB1875178
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF669B218AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C891130AC2;
	Thu,  7 Mar 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GZOlYJno"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0C12FB0D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820479; cv=none; b=dC4hbvk5HnzVVyTM4l3FSnGPmjcJhgYsU1tDX1IwgLqZPMXMuHhxw0EHwa6VDH38Rua6SpExcrKN/N09BmlkxuEMelq9yPag8+nG3a410p1aSFekxg3R3bInCOCMThM3CgcRpAdJJsvoUXXaa1NcnI1NNbkF62UfJEhVp6IXo4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820479; c=relaxed/simple;
	bh=L+1AbybCmvh1GOrujPGlJFa8Gfp2Xm8koQGYtSACEIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BuHWlUeL3m+tsvvK3kJsJ3yhnQUpXYu9KHfoB3WiwlEP4EmBJI+e+fuw3/0YizOeUSBNTHeUg7eykWuBqh5+PqEmn+IKzfbO0e/++cfU+u2RxgIuorrqa11Ikk0O2OlDuTNYAYn+cvFG50Duws3Lo4RF4D6iHzzmimps8MOwU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GZOlYJno; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a458eb7db13so138655566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709820475; x=1710425275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TffQuSYkryRAhxKGFElNbwpIpSecvUP4Rk1ADeA+Hmo=;
        b=GZOlYJnoY70rSsY54nDxVso/Vz5id2OO81mNvHXo54jJwKdzurkbwWXYFu2H0B8cxs
         w8rUR1e5ReDa6eMft37AuOnnGhy8hBXh5TnrdY+2iAd2HdHI3CzuNf585ane4QleNjlg
         ETk4tp2v5M2YTYFXUsjgFSk5ydXk3N3Ihi4CJa95JyE5I7qXPZfQ/DyrGya273zsYHYF
         nHGMIxylbBYMYu3gcB9lgex++puf21+6hbztk7plEkv7tjKGm5K79ZjOH6TFEmhejg6u
         uW4IKudX2ajuIARe9t2X9lAhpBI4EyDnKCUicNOZ3JxMGuAcsBBY14UnwcvPytAh/6xr
         bk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820475; x=1710425275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TffQuSYkryRAhxKGFElNbwpIpSecvUP4Rk1ADeA+Hmo=;
        b=cBkxewHXZdMJYbFFpxTd1jHXlqkrgnMYZVLm0o+p+DlidsRJ/aLg+a2ilJ6JzDxaO0
         ErcvVKXlFUcpCUISead4MOK9NWUub4ovTvY4IN1dX+H24x36r22zebdeuJ7I69TRL7U6
         J26jT6UEzmgNcaBnq45Umr1QGbTlU2iU0bW1xFmSGbcDRKGonX+vgrqEhyueZXetzgUY
         r6FTHbxKhl6QAIUFcIx8vCXTP2pPIP3u79ZIiW6/Ogk4Cu7VhdYfp7JORS/XxFxZ5s0/
         vE8QeXwRF+h/e7dZmc4F/y+VTtegMXUcr8byvPEJtlBDkOhrT7P75PfgR9x8wEHboKkW
         s3kg==
X-Forwarded-Encrypted: i=1; AJvYcCUEDovx0fovZEtAJCqh9275G+lZYZ+DoBb9G5b141v1hwyi1/hpaUdO494yVhvYuXQ8gilES8nCPEdf1PQUI0pAVch0s6H0aA7MROC6
X-Gm-Message-State: AOJu0YyhU4yCOFc9ulSHfeKCmPao++6T58kTOvn5UcyBOR+Ebq2uy7ez
	N5SKGZj9ISA+axItWn0LlDK4OURiYWOP8j2u/wBvOel7l0HHZdDdc6oahTA8ZOE=
X-Google-Smtp-Source: AGHT+IFh1VS2BZY8lImCmuIq+YK2nlthCRxUGx7k/SKpOS9VKF1kX8mLwHhKugtFBkdFT1l5qP7ZEA==
X-Received: by 2002:a17:906:340e:b0:a45:baeb:3b3f with SMTP id c14-20020a170906340e00b00a45baeb3b3fmr3482194ejb.25.1709820474485;
        Thu, 07 Mar 2024 06:07:54 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b00a42ee62b634sm8200648ejo.106.2024.03.07.06.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 06:07:54 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 06/10] clk: renesas: rzg2l: Extend power domain support
Date: Thu,  7 Mar 2024 16:07:24 +0200
Message-Id: <20240307140728.190184-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

RZ/{G2L, V2L, G3S}-based CPG versions have support for saving extra
power when clocks are disabled by activating module standby. This is done
through MSTOP-specific registers that are part of CPG. Each individual
module has one or more bits associated with one MSTOP register (see table
"Registers for Module Standby Mode" from HW manuals). Hardware manual
associates modules' clocks with one or more MSTOP bits. There are 3
mappings available (identified by researching RZ/G2L, RZ/G3S, RZ/V2L HW
manuals):

case 1: N clocks mapped to N MSTOP bits (with N={0, ..., X})
case 2: N clocks mapped to 1 MSTOP bit  (with N={0, ..., X})
case 3: N clocks mapped to M MSTOP bits (with N={0, ..., X}, M={0, ..., Y})

Case 3 has been currently identified on RZ/V2L for the VCPL4 module.

To cover all three cases, the individual platform drivers will provide to
clock driver MSTOP register offset and associated bits in this register
as a bitmask and the clock driver will apply this bitmask to proper
MSTOP register.

Apart from MSTOP support, RZ/G3S can save more power by powering down the
individual IPs (after MSTOP has been set) if proper bits in
CPG_PWRDN_IP{1,2} registers are set.

The MSTOP and IP power down support were implemented through power
domains. Platform-specific clock drivers will register an array of
type struct rzg2l_cpg_pm_domain_init_data, which will be used to
instantiate properly the power domains.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- called pm_genpd_init() with proper value for is_off argument
- fixed typos
- used flexible array for struct rzg2l_cpg_pm_domains::domains member
- moved genpd member of struct rzg2l_cpg_pd at the beginning of struct
- didn't initialize the parent variable in rzg2l_cpg_add_pm_domains()
  as it is already initialized in the for block from
  rzg2l_cpg_add_pm_domains() and that initialization should be enough
- dropped RZG2L_PD_F_PARENT flag
- used datasheet naming for all MSTOP registers
- added all MSTOP registers to rzg2l-cpg.h
- reworked the code that initializes the register offset and bits for domains
- dropped MSTOP*(), PWRDN*() macros and introduced struct rzg2l_cpg_reg_conf
  and DEF_REG_CONF() for domain description
- constified the 1st argument of rzg2l_cpg_pm_domain_xlate()
- used dev instead of priv->dev where possible
- dropped RZG2L_PD_F_PARENT
- added RZG2L_PD_F_NONE for better description of domains in platform
  specific clock drivers

 drivers/clk/renesas/rzg2l-cpg.c | 213 +++++++++++++++++++++++++++++---
 drivers/clk/renesas/rzg2l-cpg.h |  77 ++++++++++++
 2 files changed, 276 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 3d2daa4ba2a4..b36700f4a9f5 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -139,7 +139,6 @@ struct rzg2l_pll5_mux_dsi_div_param {
  * @num_resets: Number of Module Resets in info->resets[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
  * @info: Pointer to platform data
- * @genpd: PM domain
  * @mux_dsi_div_params: pll5 mux and dsi div parameters
  */
 struct rzg2l_cpg_priv {
@@ -156,8 +155,6 @@ struct rzg2l_cpg_priv {
 
 	const struct rzg2l_cpg_info *info;
 
-	struct generic_pm_domain genpd;
-
 	struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
 };
 
@@ -1559,9 +1556,34 @@ static bool rzg2l_cpg_is_pm_clk(struct rzg2l_cpg_priv *priv,
 	return true;
 }
 
+/**
+ * struct rzg2l_cpg_pm_domains - RZ/G2L PM domains data structure
+ * @onecell_data: cell data
+ * @domains: generic PM domains
+ */
+struct rzg2l_cpg_pm_domains {
+	struct genpd_onecell_data onecell_data;
+	struct generic_pm_domain *domains[];
+};
+
+/**
+ * struct rzg2l_cpg_pd - RZ/G2L power domain data structure
+ * @genpd: generic PM domain
+ * @priv: pointer to CPG private data structure
+ * @conf: CPG PM domain configuration info
+ * @id: RZ/G2L power domain ID
+ */
+struct rzg2l_cpg_pd {
+	struct generic_pm_domain genpd;
+	struct rzg2l_cpg_priv *priv;
+	struct rzg2l_cpg_pm_domain_conf conf;
+	u16 id;
+};
+
 static int rzg2l_cpg_attach_dev(struct generic_pm_domain *domain, struct device *dev)
 {
-	struct rzg2l_cpg_priv *priv = container_of(domain, struct rzg2l_cpg_priv, genpd);
+	struct rzg2l_cpg_pd *pd = container_of(domain, struct rzg2l_cpg_pd, genpd);
+	struct rzg2l_cpg_priv *priv = pd->priv;
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args clkspec;
 	bool once = true;
@@ -1617,31 +1639,194 @@ static void rzg2l_cpg_detach_dev(struct generic_pm_domain *unused, struct device
 }
 
 static void rzg2l_cpg_genpd_remove(void *data)
+{
+	struct genpd_onecell_data *celldata = data;
+
+	for (unsigned int i = 0; i < celldata->num_domains; i++)
+		pm_genpd_remove(celldata->domains[i]);
+}
+
+static void rzg2l_cpg_genpd_remove_simple(void *data)
 {
 	pm_genpd_remove(data);
 }
 
+static int rzg2l_cpg_power_on(struct generic_pm_domain *domain)
+{
+	struct rzg2l_cpg_pd *pd = container_of(domain, struct rzg2l_cpg_pd, genpd);
+	struct rzg2l_cpg_reg_conf mstop = pd->conf.mstop;
+	struct rzg2l_cpg_reg_conf pwrdn = pd->conf.pwrdn;
+	struct rzg2l_cpg_priv *priv = pd->priv;
+
+	/* Set PWRDN. */
+	if (pwrdn.mask)
+		writel(pwrdn.mask << 16, priv->base + pwrdn.off);
+
+	/* Set MSTOP. */
+	if (mstop.mask)
+		writel(mstop.mask << 16, priv->base + mstop.off);
+
+	return 0;
+}
+
+static int rzg2l_cpg_power_off(struct generic_pm_domain *domain)
+{
+	struct rzg2l_cpg_pd *pd = container_of(domain, struct rzg2l_cpg_pd, genpd);
+	struct rzg2l_cpg_reg_conf mstop = pd->conf.mstop;
+	struct rzg2l_cpg_reg_conf pwrdn = pd->conf.pwrdn;
+	struct rzg2l_cpg_priv *priv = pd->priv;
+
+	/* Set MSTOP. */
+	if (mstop.mask)
+		writel(mstop.mask | (mstop.mask << 16), priv->base + mstop.off);
+
+	/* Set PWRDN. */
+	if (pwrdn.mask)
+		writel(pwrdn.mask | (pwrdn.mask << 16), priv->base + pwrdn.off);
+
+	return 0;
+}
+
+static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, bool always_on)
+{
+	struct dev_power_governor *governor;
+
+	pd->genpd.flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
+	pd->genpd.attach_dev = rzg2l_cpg_attach_dev;
+	pd->genpd.detach_dev = rzg2l_cpg_detach_dev;
+	if (always_on) {
+		pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
+		governor = &pm_domain_always_on_gov;
+	} else {
+		pd->genpd.power_on = rzg2l_cpg_power_on;
+		pd->genpd.power_off = rzg2l_cpg_power_off;
+		governor = &simple_qos_governor;
+	}
+
+	return pm_genpd_init(&pd->genpd, governor, !always_on);
+}
+
 static int __init rzg2l_cpg_add_clk_domain(struct rzg2l_cpg_priv *priv)
 {
 	struct device *dev = priv->dev;
 	struct device_node *np = dev->of_node;
-	struct generic_pm_domain *genpd = &priv->genpd;
+	struct rzg2l_cpg_pd *pd;
 	int ret;
 
-	genpd->name = np->name;
-	genpd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_ALWAYS_ON |
-		       GENPD_FLAG_ACTIVE_WAKEUP;
-	genpd->attach_dev = rzg2l_cpg_attach_dev;
-	genpd->detach_dev = rzg2l_cpg_detach_dev;
-	ret = pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	pd->genpd.name = np->name;
+	pd->priv = priv;
+	ret = rzg2l_cpg_pd_setup(pd, true);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove, genpd);
+	ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove_simple, &pd->genpd);
 	if (ret)
 		return ret;
 
-	return of_genpd_add_provider_simple(np, genpd);
+	return of_genpd_add_provider_simple(np, &pd->genpd);
+}
+
+static struct generic_pm_domain *
+rzg2l_cpg_pm_domain_xlate(const struct of_phandle_args *spec, void *data)
+{
+	struct generic_pm_domain *domain = ERR_PTR(-ENOENT);
+	struct genpd_onecell_data *genpd = data;
+
+	if (spec->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	for (unsigned int i = 0; i < genpd->num_domains; i++) {
+		struct rzg2l_cpg_pd *pd = container_of(genpd->domains[i], struct rzg2l_cpg_pd,
+						       genpd);
+
+		if (pd->id == spec->args[0]) {
+			domain = &pd->genpd;
+			break;
+		}
+	}
+
+	return domain;
+}
+
+static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
+{
+	const struct rzg2l_cpg_info *info = priv->info;
+	struct device *dev = priv->dev;
+	struct device_node *np = dev->of_node;
+	struct rzg2l_cpg_pm_domains *domains;
+	struct generic_pm_domain *parent;
+	u32 ncells;
+	int ret;
+
+	ret = of_property_read_u32(np, "#power-domain-cells", &ncells);
+	if (ret)
+		return ret;
+
+	/* For backward compatibility. */
+	if (!ncells)
+		return rzg2l_cpg_add_clk_domain(priv);
+
+	domains = devm_kzalloc(dev, struct_size(domains, domains, info->num_pm_domains),
+			       GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	domains->onecell_data.domains = domains->domains;
+	domains->onecell_data.num_domains = info->num_pm_domains;
+	domains->onecell_data.xlate = rzg2l_cpg_pm_domain_xlate;
+
+	ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove, &domains->onecell_data);
+	if (ret)
+		return ret;
+
+	for (unsigned int i = 0; i < info->num_pm_domains; i++) {
+		bool always_on = !!(info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON);
+		struct rzg2l_cpg_pd *pd;
+
+		pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+		if (!pd)
+			return -ENOMEM;
+
+		pd->genpd.name = info->pm_domains[i].name;
+		pd->conf = info->pm_domains[i].conf;
+		pd->id = info->pm_domains[i].id;
+		pd->priv = priv;
+
+		ret = rzg2l_cpg_pd_setup(pd, always_on);
+		if (ret)
+			return ret;
+
+		if (always_on) {
+			ret = rzg2l_cpg_power_on(&pd->genpd);
+			if (ret)
+				return ret;
+		}
+
+		domains->domains[i] = &pd->genpd;
+		/* Parent should be on the very first entry of info->pm_domains[]. */
+		if (!i) {
+			parent = &pd->genpd;
+			continue;
+		}
+
+		ret = pm_genpd_add_subdomain(parent, &pd->genpd);
+		if (ret)
+			return ret;
+	}
+
+	ret = of_genpd_add_provider_onecell(np, &domains->onecell_data);
+	if (ret)
+		return ret;
+
+	/* Prepare for power down the BUSes in power down mode. */
+	if (info->pm_domain_pwrdn_mstop)
+		writel(CPG_PWRDN_MSTOP_ENABLE, priv->base + CPG_PWRDN_MSTOP);
+
+	return 0;
 }
 
 static int __init rzg2l_cpg_probe(struct platform_device *pdev)
@@ -1697,7 +1882,7 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	error = rzg2l_cpg_add_clk_domain(priv);
+	error = rzg2l_cpg_add_pm_domains(priv);
 	if (error)
 		return error;
 
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 6e38c8fc888c..d9a7357c4873 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -27,6 +27,21 @@
 #define CPG_PL6_ETH_SSEL	(0x418)
 #define CPG_PL5_SDIV		(0x420)
 #define CPG_RST_MON		(0x680)
+#define CPG_BUS_ACPU_MSTOP	(0xB60)
+#define CPG_BUS_MCPU1_MSTOP	(0xB64)
+#define CPG_BUS_MCPU2_MSTOP	(0xB68)
+#define CPG_BUS_PERI_COM_MSTOP	(0xB6C)
+#define CPG_BUS_PERI_CPU_MSTOP	(0xB70)
+#define CPG_BUS_PERI_DDR_MSTOP	(0xB74)
+#define CPG_BUS_REG0_MSTOP	(0xB7C)
+#define CPG_BUS_REG1_MSTOP	(0xB80)
+#define CPG_BUS_TZCDDR_MSTOP	(0xB84)
+#define CPG_MHU_MSTOP		(0xB88)
+#define CPG_BUS_MCPU3_MSTOP	(0xB90)
+#define CPG_BUS_PERI_CPU2_MSTOP	(0xB94)
+#define CPG_PWRDN_IP1		(0xBB0)
+#define CPG_PWRDN_IP2		(0xBB4)
+#define CPG_PWRDN_MSTOP		(0xBC0)
 #define CPG_OTHERFUNC1_REG	(0xBE8)
 
 #define CPG_SIPLL5_STBY_RESETB		BIT(0)
@@ -70,6 +85,8 @@
 
 #define EXTAL_FREQ_IN_MEGA_HZ	(24)
 
+#define CPG_PWRDN_MSTOP_ENABLE		(BIT(16) | BIT(0))
+
 /**
  * Definitions of CPG Core Clocks
  *
@@ -234,6 +251,58 @@ struct rzg2l_reset {
 #define DEF_RST(_id, _off, _bit)	\
 	DEF_RST_MON(_id, _off, _bit, -1)
 
+/**
+ * struct rzg2l_cpg_reg_conf - RZ/G2L register configuration data structure
+ * @off: register offset
+ * @mask: register mask
+ */
+struct rzg2l_cpg_reg_conf {
+	u16 off;
+	u16 mask;
+};
+
+#define DEF_REG_CONF(_off, _mask) ((struct rzg2l_cpg_reg_conf) { .off = (_off), .mask = (_mask) })
+
+/**
+ * struct rzg2l_cpg_pm_domain_conf - PM domain configuration data structure
+ * @mstop: MSTOP register configuration
+ * @pwrdn: PWRDN register configuration
+ */
+struct rzg2l_cpg_pm_domain_conf {
+	struct rzg2l_cpg_reg_conf mstop;
+	struct rzg2l_cpg_reg_conf pwrdn;
+};
+
+/**
+ * struct rzg2l_cpg_pm_domain_init_data - PM domain init data
+ * @name: PM domain name
+ * @conf: PM domain configuration
+ * @flags: RZG2L PM domain flags (see RZG2L_PD_F_*)
+ * @id: PM domain ID (similar to the ones defined in
+ *      include/dt-bindings/clock/<soc-id>-cpg.h)
+ */
+struct rzg2l_cpg_pm_domain_init_data {
+	const char * const name;
+	struct rzg2l_cpg_pm_domain_conf conf;
+	u32 flags;
+	u16 id;
+};
+
+#define DEF_PD(_name, _id, _mstop_conf, _pwrdn_conf, _flags) \
+	{ \
+		.name = (_name), \
+		.id = (_id), \
+		.conf = { \
+			.mstop = (_mstop_conf), \
+			.pwrdn = (_pwrdn_conf), \
+		}, \
+		.flags = (_flags), \
+	}
+
+/* Power domain flags. */
+#define RZG2L_PD_F_ALWAYS_ON	BIT(0)
+#define RZG2L_PD_F_NONE		(0)
+
 /**
  * struct rzg2l_cpg_info - SoC-specific CPG Description
  *
@@ -252,6 +321,9 @@ struct rzg2l_reset {
  * @crit_mod_clks: Array with Module Clock IDs of critical clocks that
  *                 should not be disabled without a knowledgeable driver
  * @num_crit_mod_clks: Number of entries in crit_mod_clks[]
+ * @pm_domains: PM domains init data array
+ * @num_pm_domains: Number of PM domains
+ * @pm_domain_pwrdn_mstop: Specifies if PWRDN MSTOP is supported
  * @has_clk_mon_regs: Flag indicating whether the SoC has CLK_MON registers
  */
 struct rzg2l_cpg_info {
@@ -278,6 +350,11 @@ struct rzg2l_cpg_info {
 	const unsigned int *crit_mod_clks;
 	unsigned int num_crit_mod_clks;
 
+	/* Power domain. */
+	const struct rzg2l_cpg_pm_domain_init_data *pm_domains;
+	unsigned int num_pm_domains;
+	bool pm_domain_pwrdn_mstop;
+
 	bool has_clk_mon_regs;
 };
 
-- 
2.39.2


