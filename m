Return-Path: <linux-kernel+bounces-110176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A01885B22
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147FB1C215FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C511485955;
	Thu, 21 Mar 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSBDnCTF"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24E2CCA3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032421; cv=none; b=rtA8BQKTYsopFd2BuWPAQJp/A1GKrVZe12BqjTgkASueTmPlx2TW7f3oTAdutgLykCoG/i/Rhh7th6HiBmh/VVZ/Sno3ZVKAZ81CXnxS6ixNfTbPfw4AImBXN629A7NlFVx6Cs30vlSbQA7MONDZ+jIk97+KpOmocH2FN85tkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032421; c=relaxed/simple;
	bh=llYZX8Vl06P5c584RK2OPZBrLHRSgxPJegX38T4GB3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgFDjAEt4RK1+oQmk8heiSYsVOxZ4rkjqOxwOMOq0bFFepFhlQX0cAJ7Gz1xfFCneP1zZzxYNRZZIbkhFaP8o5zpSJvNM1PlcCi75tvmEVHPxnD8mLOYJUK63l9Vn8S3Ux05oFV4lg8HcKXGEJTf1njiEbSmvt8Ntz+MvgLGdcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VSBDnCTF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ec8f13c62so734963f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711032418; x=1711637218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdJRKQkpHq/YxzYas4fiwyUxsBkDgVSnKvrwtVatzEg=;
        b=VSBDnCTF/AkcJVBQiNxmNKQn6lKMYm90FR5hRSt8ak+FHbO5fDNetY1sjFbnJy2ge4
         7jDnoawPwfZ4ZzytLu9PKou2GLxvvgoVJcYL6lTuVvreryl5D6KMuRp9pOsMUowcn1Ad
         gUszo1dgUIJuNtF4RSNJLU5CZMUfFc2xikuIx0FOIn+wdFe9yIoeQiDczvYOY/2mBz83
         BOiNWSp+sVkBRmf+W+uLV1ieFxgTjIZuXpkrrTr3BKCUAiptqX0WUw0XBKgdxFKhb9k+
         YgTWiy1C7VYpBb/fkDh7wad0Fjdlf8DfS5L0uWk/d9qqJIdm/qq5k+4VKEmKBA3RtqZl
         jl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711032418; x=1711637218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdJRKQkpHq/YxzYas4fiwyUxsBkDgVSnKvrwtVatzEg=;
        b=qNVlISTqUkV+hoDetj25PBOLA7Tg3vJyxB0Msw2ug5cimZyxkKaIlmDl5nVQ0ltCiI
         AZV1AX/KT5dlFnJrIVz88K781MCwqG1ff5scMtyUnsSCwNjUXXuZMghO/zuSENxSPx/o
         nm9T6465JZ8CMvLLLmMr7dhT/DW5XP4h5mk8thNPMCDhmNWNT5bTUyfGG8lNb2/eb3Iw
         Lk/Ilsu00skvccTLbxyo+gao2qQGM8WxKkGsbhKNcJXlx1Ga4GmUXAQuLo+Q6AIOJJXf
         Hm1cOJuNMWmuSCNi5j15+B5/NLaP8NbC7XEICx49mgv/aXqy+genuMht2dw3NZyfhf5b
         qZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbVdbDH84d5Jsb09c4S6aZxUaVB9RPdZiFoQnw4/5mfGRxXPEumUEjRZxw/+jzGYFcQt78p74tPQIVNxiK24Jf98BFPdvbsGoaqN6w
X-Gm-Message-State: AOJu0YyGthcIGKHs9olLtm54M91gmeo8vNeRo9TK61a47m0UjMKJsqXm
	X3MHaim+0eCQ6FVmyLrMZP08AD1pJZtOQsHK73X21SvUD6Sysap7mew7qUYsOQQ=
X-Google-Smtp-Source: AGHT+IH04y0b0igFcDFoi4qlbIk3SgKxtpe4cx0nnRjzZKbl25rVbNghBibtyOWy/RsfJoVtiUlNEA==
X-Received: by 2002:a5d:4d43:0:b0:33d:7e99:babc with SMTP id a3-20020a5d4d43000000b0033d7e99babcmr1645482wru.50.1711032418202;
        Thu, 21 Mar 2024 07:46:58 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ba29-20020a0560001c1d00b0033ec8b3b3e4sm14638421wrb.79.2024.03.21.07.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:46:57 -0700 (PDT)
Date: Thu, 21 Mar 2024 17:46:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v5 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <7a4a8287-1f86-4ac4-acdf-c02339ba5e1e@moroto.mountain>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
 <20240314-pinctrl-scmi-v5-3-b19576e557f2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pinctrl-scmi-v5-3-b19576e557f2@nxp.com>

On Thu, Mar 14, 2024 at 09:35:20PM +0800, Peng Fan (OSS) wrote:
> +enum scmi_pinctrl_protocol_cmd {
> +	PINCTRL_ATTRIBUTES = 0x3,
> +	PINCTRL_LIST_ASSOCIATIONS = 0x4,
> +	PINCTRL_CONFIG_GET = 0x5,
> +	PINCTRL_CONFIG_SET = 0x6,
> +	PINCTRL_FUNCTION_SELECT = 0x7,

PINCTRL_FUNCTION_SELECT was removed from the spec so the other cmds were
renumbered.  I'm still going through and reviewing this file.  I'll
hopefully be done tomorrow.

> +	PINCTRL_REQUEST = 0x8,
> +	PINCTRL_RELEASE = 0x9,
> +	PINCTRL_NAME_GET = 0xa,
> +	PINCTRL_SET_PERMISSIONS = 0xb
> +};
> +

[ snip ]

> +static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
> +				   enum scmi_pinctrl_selector_type type,
> +				   u32 selector, char *name,
> +				   unsigned int *n_elems)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_pinctrl_attributes *tx;
> +	struct scmi_resp_pinctrl_attributes *rx;
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx),
> +				      sizeof(*rx), &t);
> +	if (ret)
> +		return ret;
> +
> +	tx = t->tx.buf;
> +	rx = t->rx.buf;
> +	tx->identifier = cpu_to_le32(selector);
> +	tx->flags = cpu_to_le32(type);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		if (n_elems)
> +			*n_elems = NUM_ELEMS(rx->attributes);
> +
> +		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	/*
> +	 * If supported overwrite short name with the extended one;
> +	 * on error just carry on and use already provided short name.
> +	 */
> +	if (!ret && EXT_NAME_FLAG(rx->attributes))
                                  ^^^^
Dereferencing "rx" after the ph->xops->xfer_put() is a use after free
(racy).

> +		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
> +					    (u32 *)&type, name,
> +					    SCMI_MAX_STR_SIZE);
> +	return ret;
> +}

[ snip ]

> +static int scmi_pinctrl_request(const struct scmi_protocol_handle *ph,
> +				u32 identifier,
> +				enum scmi_pinctrl_selector_type type)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_request *tx;
> +
> +	if (type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, identifier, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_REQUEST, sizeof(*tx), 0, &t);

Missing error check.

	if (ret)
		return ret;

> +
> +	tx = t->tx.buf;
> +	tx->identifier = cpu_to_le32(identifier);
> +	tx->flags = cpu_to_le32(type);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_pinctrl_pin_request(const struct scmi_protocol_handle *ph,
> +				    u32 pin)
> +{
> +	return scmi_pinctrl_request(ph, pin, PIN_TYPE);
> +}
> +
> +static int scmi_pinctrl_free(const struct scmi_protocol_handle *ph,
> +			     u32 identifier,
> +			     enum scmi_pinctrl_selector_type type)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_request *tx;
> +
> +	if (type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, identifier, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_RELEASE, sizeof(*tx), 0, &t);

	if (ret)
		return ret;

> +
> +	tx = t->tx.buf;
> +	tx->identifier = cpu_to_le32(identifier);
> +	tx->flags = cpu_to_le32(type);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}

[ snip ]

> +enum scmi_pinctrl_conf_type {
> +	SCMI_PIN_NONE = 0x0,

This is SCMI_PIN_DEFAULT now.

> +	SCMI_PIN_BIAS_BUS_HOLD = 0x1,
> +	SCMI_PIN_BIAS_DISABLE = 0x2,
> +	SCMI_PIN_BIAS_HIGH_IMPEDANCE = 0x3,
> +	SCMI_PIN_BIAS_PULL_UP = 0x4,
> +	SCMI_PIN_BIAS_PULL_DEFAULT = 0x5,
> +	SCMI_PIN_BIAS_PULL_DOWN = 0x6,
> +	SCMI_PIN_DRIVE_OPEN_DRAIN = 0x7,
> +	SCMI_PIN_DRIVE_OPEN_SOURCE = 0x8,
> +	SCMI_PIN_DRIVE_PUSH_PULL = 0x9,
> +	SCMI_PIN_DRIVE_STRENGTH = 0xA,
> +	SCMI_PIN_INPUT_DEBOUNCE = 0xB,
> +	SCMI_PIN_INPUT_MODE = 0xC,
> +	SCMI_PIN_PULL_MODE = 0xD,
> +	SCMI_PIN_INPUT_VALUE = 0xE,
> +	SCMI_PIN_INPUT_SCHMITT = 0xF,
> +	SCMI_PIN_LOW_POWER_MODE = 0x10,
> +	SCMI_PIN_OUTPUT_MODE = 0x11,
> +	SCMI_PIN_OUTPUT_VALUE = 0x12,
> +	SCMI_PIN_POWER_SOURCE = 0x13,
> +	SCMI_PIN_SLEW_RATE = 0x20,
                             ^^^^
This is a decimal vs hex bug.  It should 0x14.  I think this enum would
be more readable in decimal anyway.

> +	SCMI_PIN_OEM_START = 0xC0,
> +	SCMI_PIN_OEM_END = 0xFF,
> +};

But I'm still trying to review the code so I'll probably respond more
tomorrow.

regards,
dan carpenter


