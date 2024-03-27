Return-Path: <linux-kernel+bounces-120741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A54088DC62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC93C2A2823
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C3359B63;
	Wed, 27 Mar 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPn0cnQa"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763C55917B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538431; cv=none; b=nWmC5L/sJDBfXN9nhguDFJyJ+dBXX9eysG3K6cUkf1ejYJcLxaHz/ndUt6TPPgH+MNtySlwhJVeMOLXlvv4eb0rXZKNe2rOTkYH28YhuFamUK2oEllaljiqrhUxnqJ/EffzlS0lI8EL9Ifq5gEmGhwiacoJ9vm/xtW7ATvl7YDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538431; c=relaxed/simple;
	bh=sLGilc1NTQU/20JtIzlYYh9ER3iVh8O5ZE4v4dpJ9gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZiSOZfjdGIyWdtvDQGuXZhtbw/q40KOQm0bkHyheQFE7daiLKErdlvoA2g8nZM1tbWJ5bO70q9SXF9VviB9LJr0OMKHGprb/WFG7ks5DOolOFJ3ODNkTs99Rm/npMJuPe2SYuceBqdwXNwqcITTIw0xIkAwpwwNHfMWVSCF7jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yPn0cnQa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a466a27d30aso810561166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711538428; x=1712143228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+rLYEsrATiPL/v2vO8QHboqtuHAhSql0Vcajen2fdC0=;
        b=yPn0cnQay92fwD0uKnNOLyV7j/xVNYtUzIqoKMnnIcDT6hGSGGMmBOZD53t+8Kt3bC
         Nzzz8l4E6dSM2RNQchTHB4XFk25X6WbM2gNbc+IfjfE6u8NJ2oQfoTiAi2kb6Eh6/lKV
         MGkDvo1AM83bsBAb4Y6OkxDCKVoKNsh/xIMV6qMUYrHbwDrfsUNoocR3Ak0iNlVhksKN
         9YGtsWu0E82S41gdu9SHmIwg8854RLSau+s2RF5KhF7/mJOrDbyCsJSjaXbavL/2fV8d
         oWYzT6rFbe1avXAkJ8GSI0Ru8cjC5esyAh9hNJ96AbW0YADpPMU4oe9RhzsFGxB3Rtt4
         /GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711538428; x=1712143228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rLYEsrATiPL/v2vO8QHboqtuHAhSql0Vcajen2fdC0=;
        b=vmtdLU0jbpzIgHbXRfSozkvdHmOGTjXyylHp0v6/jOL7hrYvxMdDzWQ077ji0yG/li
         wALhuf9De64ddrxYF6B1UzwB6Bq8Lu/emgHqfOyWmHuMiOnvjR1ImzbwuK80H6CAUmBX
         77CDpBl47x/8ApusEq+gSe3hCplRCbBGIMqMaWr1TOdkhwH37ttmdvt0QXKwXqhriuAM
         a86ChcV0KP7eB0J/VGA4zV0vo2kRcLGJf2b4AcSU+DKyk4tCOUoHLDwXuULBqSOOSJ62
         DFP3s+EDugULqh/pAAZJo4/4dM8/xraVthe6dCiGqqLfNcDv3cPoGgewRoaxOQcVgnWc
         dLng==
X-Forwarded-Encrypted: i=1; AJvYcCVLOx+4LtqasNxhxGrB/zBgMWdIovgEQAQ8VrpxpYCYbx9NYSO8eTzAUaTbNGFKQVsi6LvBfLuEHO78JrI6zp6OPIc3B9ayjJVWbRbz
X-Gm-Message-State: AOJu0Yy7bXVjZTiSoz8Mo1ZFLl7knFUSPdw82EEKIcu7XSy7Yxgm1dgN
	t0Cf5Gg4fRuPvDhQ4d9HYQ6KgLhFuzhwGJ4N8h02ueHLtJ0Hs+lg0rUgDoBCZlo=
X-Google-Smtp-Source: AGHT+IGeBgEp7hvEv/ZVJCOrCyHMMCcPPW3O1khQf6wm+VqzRsO348+zMqvIj69jGo7U7jADPphm8g==
X-Received: by 2002:a17:906:3747:b0:a45:ad29:725c with SMTP id e7-20020a170906374700b00a45ad29725cmr670356ejc.62.1711538427605;
        Wed, 27 Mar 2024 04:20:27 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090612d300b00a46cffe6d06sm5307387ejb.42.2024.03.27.04.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 04:20:27 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:20:22 +0300
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
Subject: Re: [PATCH v6 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <66e34e4a-82e1-4c52-843e-019daeaf4768@moroto.mountain>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-4-a895243257c0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-pinctrl-scmi-v6-4-a895243257c0@nxp.com>

On Sat, Mar 23, 2024 at 08:15:17PM +0800, Peng Fan (OSS) wrote:
> diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
> index 87d9b89cab13..0ecefe855432 100644
> --- a/drivers/firmware/arm_scmi/pinctrl.c
> +++ b/drivers/firmware/arm_scmi/pinctrl.c
> @@ -465,6 +465,7 @@ scmi_pinctrl_settings_conf(const struct scmi_protocol_handle *ph,
>  
>  		tx = t->tx.buf;
>  		tx->identifier = cpu_to_le32(selector);
> +		tx->function_id = cpu_to_le32(0xFFFFFFFF);
>  		attributes = FIELD_PREP(GENMASK(1, 0), type) |
>  			FIELD_PREP(GENMASK(9, 2), chunk);
>  		tx->attributes = cpu_to_le32(attributes);

This should have been done in patch 3.

regards,
dan carpenter

> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index d45657aa986a..4e6f65cf0e76 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -450,6 +450,17 @@ config PINCTRL_ROCKCHIP


