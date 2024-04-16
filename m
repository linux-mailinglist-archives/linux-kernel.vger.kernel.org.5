Return-Path: <linux-kernel+bounces-147366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B798A72FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D080B1F217A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE24136649;
	Tue, 16 Apr 2024 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fyg4MVEb"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C410A14
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291621; cv=none; b=ryZ9jQWHtL/ZbsVS3mYGneAQsfTXr6EANCwT4jFrwEAqwX5gl89m9aGrU8m4tyL10KIf0U+C987Z67Zh7by+lGr5QgobfIdPU9lTsxeR62B/3hyBkfQ3qnlJQiREtncZAENWcNTO19SqVyYuxCXMVtricTKl+mvGrtUBS/7Bv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291621; c=relaxed/simple;
	bh=J7nUs4Rfj55fuHNvurg0yldD2Cii+ZfFJaDPt10pkV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHy3KXqMd/epryjOfcbn1i5ntdlBIxfcaa60aL8HPVzxYnS8os9wgSCp//2b2xlY0bXOIH53CDZaSP7zNtUITXHsyKTxu1C9qE2sMCyQDG9EGcWPimu5+p4bnpToApGbokvUg13OJuWeSZFYIe4dKsWzaXBeu8a1hWQDHjZjmVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fyg4MVEb; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso6231452a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713291616; x=1713896416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LiZoFre+EEvabWrIaMGE+RnIgnE08Xi8rFbTEN0hiU4=;
        b=fyg4MVEbD9pejP2uIVotcF6eLNGpHlaUVMEwbzVt8yoaOK9OUUum4tkV52nQheXgUn
         hBCRCpg605Xyl5U6KKXycFlIyeUt5EOgepR+IhRtl+dtUFGvQAw1pKFAMT0HRcz6G4nY
         YapLp2Gh9GzmKJ2LZcvv4dPoDxoKIN/SZ8lJjsSQWgiM6Tx8cyKrxB6QC65m66+1sgPH
         OzurHeCanvw8KdT6W7OLWDO9UG0yCGvuMueGRdWcfCt65ICgnJxx5cearncle3W+N2K9
         ntkXFsmDp/hF/302XH1919KAsdYnkl5rEnMr0MpQebeavfz8QyO2WRmSHbxonAC7+Vrb
         8fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713291616; x=1713896416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiZoFre+EEvabWrIaMGE+RnIgnE08Xi8rFbTEN0hiU4=;
        b=nfKzUPxjiVTlhAaiTj/UVocmu2g9xRpZF7nNTr+r++T/GEpmKKhg7+aT62H2pXY7eB
         CYfjfqle8ekBbeTM+clmmQHrPjsDGte2tlh+AwmD5Z5NQRY/nqt/By2dP+NsjnzvPH1z
         KvTU1j6OoKXd7JYRoxJvgG6OJv+5kpIVzAYO/UAsLgnVGuUgHyswKyk3EtEkoPawFFgO
         Xp4AA8K84BY0/+cMFGz1mZZtSGNnKhNxfVy8/kkCx29cJj9O9bgOgO4/Tt3nnRnFo9R5
         B+ZvR+xilvE4/YScMuEfknqpBxJ6i3Du3ZYqiawFZOvTpYBVa4nud1IBlCdJ9zKP2IUE
         V3WA==
X-Forwarded-Encrypted: i=1; AJvYcCWmaRfeN0iIbVU6HnuY76xBQ11WEJmEZUy6zMFp/xs6s30FQBa812T59N4WT4Bvn0d7nFDkelVEM69cPRfGF9mTZn5ROCw56iOljTjd
X-Gm-Message-State: AOJu0YxUlpIqlw0a1B7W2XgkqKWON3m168m/J9uS2ups3UH9sl2zsXNl
	BJYOjk/dH+ry1K+0RQqpJVX3lD6wBmpy8wzkCHuayApxzG87kkm4PhlLJpy6au0=
X-Google-Smtp-Source: AGHT+IFZwq6l2AcJ1KK82U+CiB1zqh+Plqpd5qrQkIit5NN7rI1eBA5ieSH+2EC/GhdndnlKEBkgKQ==
X-Received: by 2002:a17:907:360d:b0:a52:5a04:faff with SMTP id bk13-20020a170907360d00b00a525a04faffmr6845924ejc.8.1713291616151;
        Tue, 16 Apr 2024 11:20:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090611c700b00a4672fb2a03sm7229104eja.10.2024.04.16.11.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:20:15 -0700 (PDT)
Date: Tue, 16 Apr 2024 21:20:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v10 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <6c652af8-151e-4d8b-9587-8eae1254a4fe@moroto.mountain>
References: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com>

I'm trying to re-base AKASHI Takahiro's gpio driver on top of your scmi
pinctrl driver.
https://lore.kernel.org/all/20231005025843.508689-1-takahiro.akashi@linaro.org/
I need to do something like this below to save the gpio information.

So now, great, I have the information but I'm not sure how to export it
from the scmi pinctrl driver to the gpio driver...  (This is a probably
a stupid question but I am real newbie with regards to gpio).

The other thing is that the SCMI spec says:

    4.11.2.7
    PINCTRL_SETTINGS_GET

    This command can be used by an agent to get the pin or group
    configuration, and the function selected to be enabled. It can also
    be used to read the value of a pin when it is set to GPIO mode.

What does that mean?  Is that right, or is it something left over from a
previous revision of the spec.

regards,
dan carpenter

diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
index a2a7f880d6a3..f803be8a223f 100644
--- a/drivers/firmware/arm_scmi/pinctrl.c
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -26,6 +26,7 @@
 #define GET_PINS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
 #define GET_FUNCTIONS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
 
+#define IS_GPIO_FUNC(x)		le32_get_bits((x), BIT(17))
 #define EXT_NAME_FLAG(x)	le32_get_bits((x), BIT(31))
 #define NUM_ELEMS(x)		le32_get_bits((x), GENMASK(15, 0))
 
@@ -107,6 +108,7 @@ struct scmi_group_info {
 struct scmi_function_info {
 	char name[SCMI_MAX_STR_SIZE];
 	bool present;
+	bool gpio;
 	u32 *groups;
 	u32 nr_groups;
 };
@@ -189,7 +191,7 @@ static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle *ph,
 
 static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
 				   enum scmi_pinctrl_selector_type type,
-				   u32 selector, char *name,
+				   u32 selector, char *name, bool *gpio,
 				   u32 *n_elems)
 {
 	int ret;
@@ -216,17 +218,20 @@ static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
 	tx->flags = cpu_to_le32(type);
 
 	ret = ph->xops->do_xfer(ph, t);
-	if (!ret) {
-		if (n_elems)
-			*n_elems = NUM_ELEMS(rx->attributes);
+	if (ret)
+		goto xfer_put;
 
-		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
+	if (n_elems)
+		*n_elems = NUM_ELEMS(rx->attributes);
 
-		ext_name_flag = !!EXT_NAME_FLAG(rx->attributes);
-	}
+	if (type == FUNCTION_TYPE && gpio)
+		*gpio = !!IS_GPIO_FUNC(rx->attributes);
 
-	ph->xops->xfer_put(ph, t);
+	strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
+	ext_name_flag = !!EXT_NAME_FLAG(rx->attributes);
 
+xfer_put:
+	ph->xops->xfer_put(ph, t);
 	if (ret)
 		return ret;
 	/*
@@ -602,7 +607,7 @@ static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
 	int ret;
 
 	ret = scmi_pinctrl_attributes(ph, GROUP_TYPE, selector, group->name,
-				      &group->nr_pins);
+				      NULL, &group->nr_pins);
 	if (ret)
 		return ret;
 
@@ -687,7 +692,7 @@ static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
 	int ret;
 
 	ret = scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector, func->name,
-				      &func->nr_groups);
+				      &func->gpio, &func->nr_groups);
 	if (ret)
 		return ret;
 
@@ -778,7 +783,8 @@ static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph,
 	if (!pin)
 		return -EINVAL;
 
-	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector, pin->name, NULL);
+	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector, pin->name, NULL,
+				      NULL);
 	if (ret)
 		return ret;
 

