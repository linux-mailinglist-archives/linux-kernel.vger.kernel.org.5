Return-Path: <linux-kernel+bounces-32560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018EC835D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61D1281491
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0C33C488;
	Mon, 22 Jan 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEHTI7hd"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9603B795
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913249; cv=none; b=FnFMe3nFw2+zt2CPY8IdVqbzgFdZGKMblJ8VQQwpBKU4Sn3A78cfDryIhaU15LxsUVg6wpVIZy0A+a0jCpdn8ppNAPtAIgq4Hllb1h9itYZQZqawVMmFfl5h/35dwJ4nBcovcP8bHq+tmfe96CW0PSgz7vXOffsDffxTph6Ygws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913249; c=relaxed/simple;
	bh=UXb/zhUic36XW61Rcjli8pQ0rP4sJES/Ouz5+0kZwOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dyN+w1qHJ5/Nr/YnTiUUhmTRiUNITPII5o2Lq/oPa5SAwy1e0fXOXtZ1gN7alJGumTjreTa8oBL5vSQ0EuJ8q9Nf1GEvzgy7fKHZbyss2zTyXSHa5sLHXuNsZ1MYUMFoil4s1mXFVIUcWKO25juagSKTkCqgiP0tfYxfqMP9eqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gEHTI7hd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so2903102f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705913246; x=1706518046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcRJMFQZwuV0Tapr3h2EIPICdXVTao3gMwX1jt7rgns=;
        b=gEHTI7hdaIulGQDji76af2RiSqGN07s9VZjn4POowwHhVhqdvDyDFAbC99rxyVjy7z
         uIw7thcJBJKSD9kjY+ijQpC5yoGmL40sHFeTECojHJkU8huf2X4K08UEn0eHXfm5vfpB
         XY+YtBe0b0Y/DhkaxbcUIWlzHykVEf0vWxjW1OB1ce0LovkMIsP+RGcxTv49EAg5T0eW
         J90DTir+6ykHSAz5NSer3Igx3wtnib7TToOrIlubSVXPwkoVxHQ1TaXdXxERCQK21d+U
         9O1m0Y2tYbN3BpOINKVwwWjhXVN8eAMjbLh9GiGjqfnoAJP+bbEZE2k8aBjHB+Pbiv7J
         a+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705913246; x=1706518046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcRJMFQZwuV0Tapr3h2EIPICdXVTao3gMwX1jt7rgns=;
        b=YTMj1gfFH6rsCvq98MRfg/A0PIVLJ4eaNEjfiPQ3mEr9koW6QdI1ntqQaCANJfiO+z
         jHrrU5dADFyEfLY6mgsmMbvrWKkfk8BhnadVo7Bc5XDVoMoGfZlo7zrwcXcB1V2tFQg6
         3Nk0LPXwUlOeLpTW3hsr1WIdkhQtj7UqMSo0DZje2/gIhCQ+g0WPy6JmsPOus/2ZSnYo
         VyCIpnDGlv548Bx6btm6CagFO+UhUsatJgy0mo3aYWfZNelu81gHlaK1SSTgv98lFFFz
         yDzMZfBTidqMPu56J1q+MHfzSLU4esp+LAMcskFZ768N6ruzkjNTt72ujFpUH10wlKDc
         qI8A==
X-Gm-Message-State: AOJu0YxU4kcGhO1/4f4pqhpa0hPNiHGuk6fUHUbYLJt6tl/suWqKzGBS
	RjcML1HU6ilmFr7uwKtLrzLsVvDV8/rvsh5PViCUqqm7XwvNE1330g5PQCc8iW8=
X-Google-Smtp-Source: AGHT+IF0r9bLTQ+dQGxBguGSfAgVW/Fw5dT1SwFylYwJoF5qHNQoL2tc2eRB2IbELINhoVkVHIMJbg==
X-Received: by 2002:a05:600c:4f96:b0:40e:4800:c91f with SMTP id n22-20020a05600c4f9600b0040e4800c91fmr2158579wmq.9.1705913245888;
        Mon, 22 Jan 2024 00:47:25 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090630d500b00a2c4c23cd12sm13075462ejb.217.2024.01.22.00.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:47:25 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 22 Jan 2024 10:47:03 +0200
Subject: [PATCH v4 3/5] clk: qcom: gdsc: Add set and get hwmode callbacks
 to switch GDSC mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-gdsc-hwctrl-v4-3-9061e8a7aa07@linaro.org>
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
In-Reply-To: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-media@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3441; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=yFQug82ouDh7n9fo6dz4SaANMbWja9vZYjYKARImC8I=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlriuSQCCTGaF/pibhxYWO74SJJuCHfzr0HrkOn
 I/X3EewY96JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZa4rkgAKCRAbX0TJAJUV
 VlvjD/sGWHCathvHXRq0Py3o28RU3KmbxNBAQgGF6R1ucKEF4rXyU+u9djEnWK6kx+RLwUrfW4O
 jlp559Xhrg7toBjLrDu0bo6rvEobnOCtkLtUpWyfS/cfI8xKE+rqkyNaRGkDJ8d8ZywRzI0qpad
 OtLANlXACdfcDskAaDZUyDoeZKOuOzu+6Bz9+L+RfMz3LwqOBL5hMM1ZbFsqyKMmh5figAUpo7+
 dZJQA0kkDqGOIiAFZLDCTPb85/QGuFnNEcHVBnT1qhVMyQFNtTwT6h0tJ1pwkmrJQRiPP51PW+T
 9pbueC0r3s/53En7uakqgvQ4z1bUyPzA0nkLhoRqy+k/9xnbwhiG2QEYyH70lx1k7Mo2gc9x/AJ
 cptH000+sowRAOKm2X8o95/mfkrb0SLOH/VzMLN7occryxVTEhDrhBIcdqPnADgrz0FL2WS1iBv
 ZoTyQ6hFD4x28HncVLs0G8wrO6WZePeWoni+wuMlO58laFlD1/DwEFbXHRbClnMzNvZNQ65BryH
 cwMfnmiep7BA3S9Rmh2t73ph34MWQgT8vY8/jWC5phozpmZJuVos40orf4O+rztEeoInDFm4AA3
 1JW5ftuUiavXGbTdZ0khgUSF/yfAF2rn6K9RiQ43yHQBwj8mOU7c41Lk8fLAm3+xBxjuiEjzsWG
 s8NGjP0PBZhGzgw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Jagadeesh Kona <quic_jkona@quicinc.com>

Add support for set and get hwmode callbacks to switch the GDSC between
SW and HW modes. Currently, the GDSC is moved to HW control mode
using HW_CTRL flag and if this flag is present, GDSC is moved to HW
mode as part of GDSC enable itself. The intention is to keep the
HW_CTRL flag functionality as is, since many older chipsets still use
this flag.

But consumer drivers also require the GDSC mode to be switched dynamically
at runtime based on requirement for certain usecases. Some of these
usecases are switching the GDSC to SW mode to keep it ON during the
enablement of clocks that are dependent on GDSC and while programming
certain configurations that require GDSC to be ON. Introduce a new
HW_CTRL_TRIGGER flag to register the set_hwmode_dev and get_hwmode_dev
callbacks which allows the consumer drivers to switch the GDSC back and
forth between HW/SW modes dynamically at runtime using new
dev_pm_genpd_set_hwmode API.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  1 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 5358e28122ab..71626eb20101 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -363,6 +363,56 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	return 0;
 }
 
+static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct device *dev, bool mode)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	u32 val;
+	int ret;
+
+	if (sc->rsupply && !regulator_is_enabled(sc->rsupply)) {
+		pr_err("Cannot set mode while parent is disabled\n");
+		return -EIO;
+	}
+
+	ret = gdsc_hwctrl(sc, mode);
+	if (ret)
+		return ret;
+
+	/* Wait for 1usec for mode transition to properly complete */
+	udelay(1);
+
+	if (!mode) {
+		ret = regmap_read(sc->regmap, sc->gdscr, &val);
+		if (ret)
+			return ret;
+
+		/*
+		 * While switching from HW to SW mode, if GDSC is in enabled
+		 * state, poll for GDSC to complete the power up.
+		 */
+		if (!(val & SW_COLLAPSE_MASK))
+			return gdsc_poll_status(sc, GDSC_ON);
+	}
+
+	return 0;
+}
+
+static bool gdsc_get_hwmode(struct generic_pm_domain *domain, struct device *dev)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(sc->regmap, sc->gdscr, &val);
+	if (ret)
+		return ret;
+
+	if (val & HW_CONTROL_MASK)
+		return true;
+
+	return false;
+}
+
 static int gdsc_init(struct gdsc *sc)
 {
 	u32 mask, val;
@@ -451,6 +501,10 @@ static int gdsc_init(struct gdsc *sc)
 		sc->pd.power_off = gdsc_disable;
 	if (!sc->pd.power_on)
 		sc->pd.power_on = gdsc_enable;
+	if (sc->flags & HW_CTRL_TRIGGER) {
+		sc->pd.set_hwmode_dev = gdsc_set_hwmode;
+		sc->pd.get_hwmode_dev = gdsc_get_hwmode;
+	}
 
 	ret = pm_genpd_init(&sc->pd, NULL, !on);
 	if (ret)
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 803512688336..1e2779b823d1 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -67,6 +67,7 @@ struct gdsc {
 #define ALWAYS_ON	BIT(6)
 #define RETAIN_FF_ENABLE	BIT(7)
 #define NO_RET_PERIPH	BIT(8)
+#define HW_CTRL_TRIGGER	BIT(9)
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;

-- 
2.34.1


