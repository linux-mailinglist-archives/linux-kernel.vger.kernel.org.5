Return-Path: <linux-kernel+bounces-120691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF8088DB80
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0C5B220E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286674F21F;
	Wed, 27 Mar 2024 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIYUd44L"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF1E1D53C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536379; cv=none; b=XRoCwMyknqXsS24Urs5zJB0blIF9LVUDnOpQBAp8H6hTWRScI8z6sG24zqREylnExnxqilJx3hSfA8jtR9tLpHTb7GGldyB5MQFKlfZ1W1T6lF4K/NHJxOivUFKGxTo+xtX08mcREK7rsS4jJKFCfIo7Xp6dsW/rqlBX2T0fifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536379; c=relaxed/simple;
	bh=4qNhZd6In4W6BpD2cTnvRVSY7sZSE1eUcfTuvPhG4us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLlR4BXtVVwL1XKhRtBIh8Udbc3fkoaGRtnbEVL2rpVnm5N536NO95RzlylW1CJrVBCI0X/wc8XHKFZcOmhk1EEvPcNUwsdEuTAwwlE1ZARvOgLlzXSFlL9++ECHFyM1TYl2iWWyxxGv3X3RlV4Fa9JOtoYubNwrZaPmYIyBtPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lIYUd44L; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4751063318so440319166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711536376; x=1712141176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7bMAFuTzgkVK2W2ZWS18PceZ7VDbzSyIzk2OmuZlF/o=;
        b=lIYUd44L7tpV6w2WQj0VJu5eNTxXDSby2RebM/7tvaxpEipdXAO8TJqU+Qs6qHGpR4
         nHHbj0yYmWHtSEh8ed6ZDeSa/NivDDhLCDvUkCRWj40WLGjtWS6WP643tTnQaZ/q1ge2
         x3hsvWlDIRLi9p8vP4Jb29RUZK0YY5l8oEyT4Bwhyub9v9PBj8XKFCGeg/jH7XsYtZHE
         Xe961vDu+L9a+Yad/CJUwEtvtm+XebwWdl72AzV4BOFdwo6/1jdM8QwK0jkZSeylsuN3
         PEGYkjIlVxKCQfRW4smy/dqT+bfGzHVTU0dRFOwCktlP6H0R+vH6iwDHVDoHaB2xS7lJ
         MmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711536376; x=1712141176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bMAFuTzgkVK2W2ZWS18PceZ7VDbzSyIzk2OmuZlF/o=;
        b=BdpqbfYOSHG5z9I0fsOERXMQUSuRU/byTRBDr8Cz/L5sUhB/jiklD7ITR3kL1etPki
         xzkazkQsq9XG0PPv2jhS1yoWIQjOqUiYUzzJsN8DRqKdxmP6b9kTT7bhvh2vmu0lFDiH
         ZhSuxMtp6giPrHEPQWnBS0C5ky9JYkJQ8o/l8MOUcTW2P7/ycEnao8/8TZ7Rt8mFaAxc
         OXetTBiMn7s/4gMKf0g/AWko1m9K+osecf7VrPcpmghw2qcqRsMi3gIb1GxcDUiH+4CI
         P5RdOS8vRV0P2UVcVDLiWed1UQ07Wd9x2Cf7yzd4IsgpREHpAGnQntQGBuf0sNlU/GGm
         j3YA==
X-Forwarded-Encrypted: i=1; AJvYcCXTV1nhUSvlNm82UtHw2AD7z/3cBSHgjxR+mwHpr2NrQQLsbIDYkxJrbX6ggVP533g/bNraHk/zu2LCEh3Y7a3IfKlD/IOxtGokauqe
X-Gm-Message-State: AOJu0Yzk9BaYe/rrCAeEEHpgGIE0swSRmjy/LVoYH9NMFo7OlXwcmZFd
	X5Pbx5U/aiM+D/1sxK4Ym5Ch2r9pgnzr+wPHy4HhsvQN1whNEEPGdLrTGJQSaAM=
X-Google-Smtp-Source: AGHT+IGqXcP4a7y/1sAfahWl3DUL7IV+aXO1Cv/OupNWGZLq9Wf7bfIgd7Fmu5SqyGqlldsHQezFoA==
X-Received: by 2002:a17:906:f594:b0:a4e:9d3:cc8b with SMTP id cm20-20020a170906f59400b00a4e09d3cc8bmr698757ejd.40.1711536375884;
        Wed, 27 Mar 2024 03:46:15 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906774900b00a46a2ac0dbasm5268238ejn.197.2024.03.27.03.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 03:46:15 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:46:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <4879ad5d-165c-4118-81f7-8f6348a5a5d4@moroto.mountain>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>

Looks really nice.  Just a few small comments below.

On Sat, Mar 23, 2024 at 08:15:16PM +0800, Peng Fan (OSS) wrote:
> +
> +struct scmi_msg_func_set {
> +	__le32 identifier;
> +	__le32 function_id;
> +	__le32 flags;
> +};

This scmi_msg_func_set struct is unused.  Delete.

> +static void
> +iter_pinctrl_settings_get_prepare_message(void *message, u32 desc_index,
> +					  const void *priv)
> +{
> +	struct scmi_msg_settings_get *msg = message;
> +	const struct scmi_settings_get_ipriv *p = priv;
> +	u32 attributes;
> +
> +	attributes = FIELD_PREP(CONFIG_FLAG_MASK, p->flag) |
> +		     FIELD_PREP(SELECTOR_MASK, p->type);
> +
> +	if (p->flag == 1)
> +		attributes |= FIELD_PREP(SKIP_CONFIGS_MASK, desc_index);
> +	else if (!p->flag)

This is a nit-pick but could you change these !p->flag conditions to
p->flag == 0?  It's a number zero, not a bool.

> +		attributes |= FIELD_PREP(CONFIG_TYPE_MASK, p->config_types[0]);
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
> +	if (p->flag == 1) {
> +		st->num_returned = le32_get_bits(r->num_configs, GENMASK(7, 0));
> +		st->num_remaining = le32_get_bits(r->num_configs,
> +						  GENMASK(31, 24));
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
> +				       const void *response,
> +				       struct scmi_iterator_state *st,
> +				       void *priv)
> +{
> +	const struct scmi_resp_settings_get *r = response;
> +	struct scmi_settings_get_ipriv *p = priv;
> +
> +	if (!p->flag) {


if (p->flag == 0) {

> +		if (p->config_types[0] !=
> +		    le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0)))
> +			return -EINVAL;
> +	} else if (p->flag == 1) {
> +		p->config_types[st->desc_index + st->loop_idx] =
> +			le32_get_bits(r->configs[st->loop_idx * 2],
> +				      GENMASK(7, 0));
> +	} else if (p->flag == 2) {
> +		return 0;
> +	}
> +
> +	p->config_values[st->desc_index + st->loop_idx] =
> +		le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
> +
> +	return 0;
> +}
> +
> +static int
> +scmi_pinctrl_settings_get(const struct scmi_protocol_handle *ph, u32 selector,
> +			  enum scmi_pinctrl_selector_type type,
> +			  enum scmi_pinctrl_conf_type config_type,
> +			  u32 *config_value)
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
> +		.flag = 0,

->flag should be 0-2.

> +		.config_types = &config_type,
> +		.config_values = config_value,
> +	};
> +
> +	if (!config_value || type == FUNCTION_TYPE)
             ^^^^^^^^^^^^
config_value should be optional for flag == 2.

regards,
dan carpenter

> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	iter = ph->hops->iter_response_init(ph, &ops, 1, PINCTRL_SETTINGS_GET,
> +					    sizeof(struct scmi_msg_settings_get),
> +					    &ipriv);
> +
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +
> +	return ph->hops->iter_response_run(iter);
> +}
> +


