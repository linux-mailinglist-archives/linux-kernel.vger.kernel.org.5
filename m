Return-Path: <linux-kernel+bounces-127728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B81989500F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17249284C3D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C3E5C90F;
	Tue,  2 Apr 2024 10:29:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C655914D;
	Tue,  2 Apr 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053749; cv=none; b=bCZFmJFWQnj2KNMt7DZOftfeMZLAL3A2r4bRATj8F2ppVrSlLUlDNk6pTiPr1dFYZP0cQo8tZn3FiwUvdoUgSRB5edvtAvkDTnjJjgF8u3PUoCmdjbj8qCocnG5d3tdot61zgVirN/9/Kat2VjrZRA15fH6yVCC7Sxjrb+bNkXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053749; c=relaxed/simple;
	bh=rHe9zTeLCUNpEv2T8ZyDtYvDoeBuaQwap25Ev7nWSH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4nLCd1lu9b9P9T0d+pIIQtw3XaBNAly2G9eSqaDBLFVlLdy8LbbQd0sT/nP5E6ZdWTBMLxZ0Fr8ox6UinB0dj46SiFt1emgcZfVV0juAEoAeEB8H9iDX4Wrce5C54sbzy85MQJJLSb0XUHxUmWn+XAMFKRBCRbgsqVk6gJ7eH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B7EBFEC;
	Tue,  2 Apr 2024 03:29:39 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E0AB3F766;
	Tue,  2 Apr 2024 03:29:05 -0700 (PDT)
Date: Tue, 2 Apr 2024 11:29:02 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v7 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <Zgvd7npz1jdJSu-b@pluto>
References: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
 <20240402-pinctrl-scmi-v7-3-3ea519d12cf7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-pinctrl-scmi-v7-3-3ea519d12cf7@nxp.com>

On Tue, Apr 02, 2024 at 10:22:23AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add basic implementation of the SCMI v3.2 pincontrol protocol.
> 

Hi,


> Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

[snip]


> +struct scmi_settings_get_ipriv {
> +	u32 selector;
> +	enum scmi_pinctrl_selector_type type;
> +	bool get_all;
> +	enum scmi_pinctrl_conf_type *config_types;
> +	u32 *config_values;
> +};
> +
> +static void
> +iter_pinctrl_settings_get_prepare_message(void *message, u32 desc_index,
> +					  const void *priv)
> +{
> +	struct scmi_msg_settings_get *msg = message;
> +	const struct scmi_settings_get_ipriv *p = priv;
> +	u32 attributes;
> +
> +	attributes = FIELD_PREP(SELECTOR_MASK, p->type);
> +
> +	if (p->get_all) {
> +		attributes |= FIELD_PREP(CONFIG_FLAG_MASK, 1) |
> +			FIELD_PREP(SKIP_CONFIGS_MASK, desc_index);
> +	} else {
> +		attributes |= FIELD_PREP(CONFIG_TYPE_MASK, p->config_types[0]);
> +	}
> +
> +	msg->attributes = cpu_to_le32(attributes);
> +	msg->identifier = cpu_to_le32(p->selector);
> +}
> +
> +static int
> +iter_pinctrl_settings_get_update_state(struct scmi_iterator_state *st,
> +				       const void *response, void *priv)
> +{
> +	const struct scmi_resp_settings_get *r = response;
> +	struct scmi_settings_get_ipriv *p = priv;
> +
> +	if (p->get_all) {
> +		st->num_returned = le32_get_bits(r->num_configs, GENMASK(7, 0));
> +		st->num_remaining = le32_get_bits(r->num_configs, GENMASK(31, 24));
> +	} else {
> +		st->num_returned = 1;
> +		st->num_remaining = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +iter_pinctrl_settings_get_process_response(const struct scmi_protocol_handle *ph,
> +					   const void *response,
> +					   struct scmi_iterator_state *st,
> +					   void *priv)
> +{
> +	const struct scmi_resp_settings_get *r = response;
> +	struct scmi_settings_get_ipriv *p = priv;
> +	u32 type = le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0));
> +	u32 val = le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
> +
> +	if (p->get_all) {
> +		p->config_types[st->desc_index + st->loop_idx] = type;
> +	} else {
> +		if (p->config_types[0] != type)
> +			return -EINVAL;
> +	}
> +
> +	p->config_values[st->desc_index + st->loop_idx] = val;
> +
> +	return 0;
> +}
> +
> +static int
> +scmi_pinctrl_settings_get(const struct scmi_protocol_handle *ph, u32 selector,
> +			  enum scmi_pinctrl_selector_type type,
> +			  enum scmi_pinctrl_conf_type config_type,
> +			  u32 *config_value, bool get_all)
> +{
> +	int ret;
> +	void *iter;
> +	struct scmi_iterator_ops ops = {
> +		.prepare_message = iter_pinctrl_settings_get_prepare_message,
> +		.update_state = iter_pinctrl_settings_get_update_state,
> +		.process_response = iter_pinctrl_settings_get_process_response,
> +	};
> +	struct scmi_settings_get_ipriv ipriv = {
> +		.selector = selector,
> +		.type = type,
> +		.get_all = get_all,
> +		.config_types = &config_type,
> +		.config_values = config_value,
> +	};
> +
> +	if (!config_value || type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	iter = ph->hops->iter_response_init(ph, &ops, SCMI_PIN_OEM_END,
> +					    PINCTRL_SETTINGS_GET,
> +					    sizeof(struct scmi_msg_settings_get),
> +					    &ipriv);
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +
> +	return ph->hops->iter_response_run(iter);
> +}
> +
> +static int scmi_pinctrl_settings_get_one(const struct scmi_protocol_handle *ph,
> +					 u32 selector,
> +					 enum scmi_pinctrl_selector_type type,
> +					 enum scmi_pinctrl_conf_type config_type,
> +					 u32 *config_value)
> +{
> +	return scmi_pinctrl_settings_get(ph, selector, type, config_type,
> +					 config_value, false);
> +}
> +
> +static int scmi_pinctrl_settings_get_all(const struct scmi_protocol_handle *ph,
> +					 u32 selector,
> +					 enum scmi_pinctrl_selector_type type,
> +					 enum scmi_pinctrl_conf_type config_type,
> +					 u32 *config_value)
> +{
> +	return scmi_pinctrl_settings_get(ph, selector, type, config_type,
> +					 config_value, true);
> +}
> +

If you generalize the scmi_pinctrl_settings_get() and reintroduce a
settings_get_all() ops (even though unused by pinctrl driver, I am fine
with this..), you should take care to pass as an input parameter NOT only
the array of config_values BUT also an array of config_types since you could
get back up to 256 OEM types: for this reason you will need also to pass to
scmi_pinctrl_settings_get() an input param that specifies the sizes of the
2 array input params (in order to avoid oveflows) AND use that same inout
param also as an output param to report at the end how many OEM types were
effectively found and returned....

IOW, I did this on top of your V7 to make the settings_get_all work:

---8<---
diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
index b75af1dd75fa..f4937af66c4d 100644
--- a/drivers/firmware/arm_scmi/pinctrl.c
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -317,6 +317,7 @@ struct scmi_settings_get_ipriv {
 	u32 selector;
 	enum scmi_pinctrl_selector_type type;
 	bool get_all;
+	unsigned int *nr_configs;
 	enum scmi_pinctrl_conf_type *config_types;
 	u32 *config_values;
 };
@@ -379,6 +380,7 @@ iter_pinctrl_settings_get_process_response(const struct scmi_protocol_handle *ph
 	}
 
 	p->config_values[st->desc_index + st->loop_idx] = val;
+	++*p->nr_configs;
 
 	return 0;
 }
@@ -386,11 +388,13 @@ iter_pinctrl_settings_get_process_response(const struct scmi_protocol_handle *ph
 static int
 scmi_pinctrl_settings_get(const struct scmi_protocol_handle *ph, u32 selector,
 			  enum scmi_pinctrl_selector_type type,
-			  enum scmi_pinctrl_conf_type config_type,
-			  u32 *config_value, bool get_all)
+			  unsigned int *nr_configs,
+			  enum scmi_pinctrl_conf_type *config_types,
+			  u32 *config_values)
 {
 	int ret;
 	void *iter;
+	unsigned int max_configs = *nr_configs;
 	struct scmi_iterator_ops ops = {
 		.prepare_message = iter_pinctrl_settings_get_prepare_message,
 		.update_state = iter_pinctrl_settings_get_update_state,
@@ -399,19 +403,22 @@ scmi_pinctrl_settings_get(const struct scmi_protocol_handle *ph, u32 selector,
 	struct scmi_settings_get_ipriv ipriv = {
 		.selector = selector,
 		.type = type,
-		.get_all = get_all,
-		.config_types = &config_type,
-		.config_values = config_value,
+		.get_all = (max_configs > 1),
+		.nr_configs = nr_configs,
+		.config_types = config_types,
+		.config_values = config_values,
 	};
 
-	if (!config_value || type == FUNCTION_TYPE)
+	if (!config_types || !config_values || type == FUNCTION_TYPE)
 		return -EINVAL;
 
 	ret = scmi_pinctrl_validate_id(ph, selector, type);
 	if (ret)
 		return ret;
 
-	iter = ph->hops->iter_response_init(ph, &ops, SCMI_PIN_OEM_END,
+	/* Prepare to count returned configs */
+	*nr_configs = 0;
+	iter = ph->hops->iter_response_init(ph, &ops, max_configs,
 					    PINCTRL_SETTINGS_GET,
 					    sizeof(struct scmi_msg_settings_get),
 					    &ipriv);
@@ -427,18 +434,24 @@ static int scmi_pinctrl_settings_get_one(const struct scmi_protocol_handle *ph,
 					 enum scmi_pinctrl_conf_type config_type,
 					 u32 *config_value)
 {
-	return scmi_pinctrl_settings_get(ph, selector, type, config_type,
-					 config_value, false);
+	unsigned int nr_configs = 1;
+
+	return scmi_pinctrl_settings_get(ph, selector, type, &nr_configs,
+					 &config_type, config_value);
 }
 
 static int scmi_pinctrl_settings_get_all(const struct scmi_protocol_handle *ph,
 					 u32 selector,
 					 enum scmi_pinctrl_selector_type type,
-					 enum scmi_pinctrl_conf_type config_type,
-					 u32 *config_value)
+					 unsigned int *nr_configs,
+					 enum scmi_pinctrl_conf_type *config_types,
+					 u32 *config_values)
 {
-	return scmi_pinctrl_settings_get(ph, selector, type, config_type,
-					 config_value, true);
+	if (!nr_configs || *nr_configs == 0)
+		return -EINVAL;
+
+	return scmi_pinctrl_settings_get(ph, selector, type, nr_configs,
+					 config_types, config_values);
 }
 
 static int
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index abaf6122ea37..7915792efd81 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -882,8 +882,9 @@ struct scmi_pinctrl_proto_ops {
 	int (*settings_get_all)(const struct scmi_protocol_handle *ph,
 				u32 selector,
 				enum scmi_pinctrl_selector_type type,
-				enum scmi_pinctrl_conf_type config_type,
-				u32 *config_value);
+				unsigned int *nr_configs,
+				enum scmi_pinctrl_conf_type *config_types,
+				u32 *config_values);
 	int (*settings_conf)(const struct scmi_protocol_handle *ph,
 			     u32 selector, enum scmi_pinctrl_selector_type type,
 			     unsigned int nr_configs,
--->8-----

Please check if this addition sounds good to you and integrate into v8
eventually...

Thanks,
Cristian

