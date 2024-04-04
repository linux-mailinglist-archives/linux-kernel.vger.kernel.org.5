Return-Path: <linux-kernel+bounces-130766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801C0897CE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2973428C029
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7799E525E;
	Thu,  4 Apr 2024 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="krCXRW0s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rDtnrsjr"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF54689;
	Thu,  4 Apr 2024 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189835; cv=none; b=RJcFeKkahuw1UFNYastrA4FQMf5YTPIb+mzObGE5INz01AjfyPA9v3Ja3NfI3fH20qVtt0VO0UPUKCVlXRG1LjHTxJaJ6q++NWpE5J6/ziG/F0BrHxDyZntAujGeGxKPRzEHTl7wslHbhXdWLu90sys5BZEOjbpqOiFIAl5/XQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189835; c=relaxed/simple;
	bh=rRBy78XJkXwKq481LTr0KBcVt2ywwY9zR5Us2F6/UNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+C4A0KktlXwigw+UGGszglfHbFOfytQNDVPkVcwjBUPNWVzB2G1MV7qrCrvCR2tLrVj3DajCWfbyxxADSc/Yrj4VpfaAVX68rHEHln4dcvziQMRBrm0r5qVJLqFRijSUuC8+h4VAUDyr9tg6diba/wu063x3FY1hA0oe8Qx2J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=krCXRW0s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rDtnrsjr; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 6B8CE1C000F7;
	Wed,  3 Apr 2024 20:17:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 03 Apr 2024 20:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712189831;
	 x=1712276231; bh=p9FSwkCbMAz+HXaWekWfWscMDEXU3+ZywSKVQIvHfE4=; b=
	krCXRW0sVY/5ZcAeKOyq02mndGLKtJn2bJh1pUBoCVTXu3QwsVAuYTBgVWPf7GoV
	BJ7B2SFZY8rTCCPNNR9hnCoQc9JKlSOj4IPMK/1Nyckbgw+Wf9SnjuYnSsStCZdj
	1XCVbSTLA59aCV0r9otJWKQjiUzj3spOluAxlHHxYTqrx0s/o7lMFpV6sIPwYAM3
	9hWFdTdGygevg+SeH2lZU244Yb00r0TucmMPhxDsP3AkWjukC9EKIZjAuCM3I0mz
	f7EKI+RL4iXDt5HqK14KEvOTIxPeyHe78iYDBn3+bIgXAVnS8kkcmDknrNr+u47p
	w64e0sO4/+m1kxVNVCwC6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712189831; x=
	1712276231; bh=p9FSwkCbMAz+HXaWekWfWscMDEXU3+ZywSKVQIvHfE4=; b=r
	Dtnrsjr5m+ncljyNktgceuh+CvjbzQniz02mwztnF1wK9VsnflrU//ZDyigZcBM5
	aoF45RqIpl4RTRF2A7dLcwekMFVCv8V9XdS3jn/cdWLMcHGi+c81E2tTLG0De2gC
	oWqdOHMO7QtRkNAbMzNqlDb5BDXcFC4Lo2sO1rdFMLiJY+qD95SrHqjoR2BN7oO7
	O5S9Z/KuLj8/yamG6Jh2F7z1VcUOZsTAKkrWE2KWYDrGzpUPaahWsbsMl9qV8clx
	IqgPEFXjpSVW2QK60K5dAh8B177oCrZ7p/YMA18P/ggvyLF0jJwzb1CbdS+RVRmD
	oF8k/k+67OCfe+nSRNZxQ==
X-ME-Sender: <xms:h_ENZix-nRl5k3CrNU1dW3lRQoDo-1Nc-MZShFw9rW4-mb5S6efmfg>
    <xme:h_ENZuRc8Ce2yUzWU7t9dreTL1ncB3vzYtZbHCXksNWm6emKKV5xOsAju7M3qSpRD
    GmqTpEp4VW5GtDZFXo>
X-ME-Received: <xmr:h_ENZkW9XEb3z0CTCoppO2POT8lApLrNHtSs-M-GlLPIgnKgkh0xr48r6bi3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:h_ENZogACN61UFXHfg0dk6earE-KVPZYIXN62RJKycTZ6ILfbS59Kw>
    <xmx:h_ENZkAuhmOf-06eC3qDvwKWUZT280Z6hnav_sJCkAchz5FOixHR5A>
    <xmx:h_ENZpLNlZEu_dScWWOb_HUJ6RtqInfQ4qyOW5hFE-Z1UfNzghzRyg>
    <xmx:h_ENZrBEryTL_jEaSHfiaZuQKm8rjFoLUp5pil6nW2F1Rd7E6CF-Vw>
    <xmx:h_ENZm3GVhNib1YgLUtXJqAI0NDkiyYA4FAzhuA_Rx08hQySUL-ieDTs>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 20:17:09 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 2/9] platform/x86: asus-wmi: add support for Vivobook GPU MUX
Date: Thu,  4 Apr 2024 13:16:45 +1300
Message-ID: <20240404001652.86207-3-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404001652.86207-1-luke@ljones.dev>
References: <20240404001652.86207-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the Vivobook dgpu MUX available on the ASUS Viviobook
and some of the other ranges (Zen).

This MUX functions exactly the same as the existing ROG MUX support so
the existing functionality now detects which MUX is available and uses
that for control.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 22 +++++++++++++---------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index aa2a3b402e33..1ab4380e9771 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -270,7 +270,7 @@ struct asus_wmi {
 	bool egpu_enable_available;
 	bool egpu_connect_available;
 	bool dgpu_disable_available;
-	bool gpu_mux_mode_available;
+	u32 gpu_mux_dev;
 
 	/* Tunables provided by ASUS for gaming laptops */
 	bool ppt_pl2_sppt_available;
@@ -693,8 +693,8 @@ static ssize_t dgpu_disable_store(struct device *dev,
 	if (disable > 1)
 		return -EINVAL;
 
-	if (asus->gpu_mux_mode_available) {
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+	if (asus->gpu_mux_dev) {
+		result = asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
 		if (result < 0)
 			/* An error here may signal greater failure of GPU handling */
 			return result;
@@ -759,8 +759,8 @@ static ssize_t egpu_enable_store(struct device *dev,
 		return err;
 	}
 
-	if (asus->gpu_mux_mode_available) {
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+	if (asus->gpu_mux_dev) {
+		result = asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
 		if (result < 0) {
 			/* An error here may signal greater failure of GPU handling */
 			pr_warn("Failed to get gpu mux status: %d\n", result);
@@ -813,7 +813,7 @@ static ssize_t gpu_mux_mode_show(struct device *dev,
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result;
 
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+	result = asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
 	if (result < 0)
 		return result;
 
@@ -859,7 +859,7 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
 		}
 	}
 
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
+	err = asus_wmi_set_devstate(asus->gpu_mux_dev, optimus, &result);
 	if (err) {
 		dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
 		return err;
@@ -4239,7 +4239,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_gpu_mux_mode.attr)
-		ok = asus->gpu_mux_mode_available;
+		ok = asus->gpu_mux_dev != 0;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -4505,7 +4505,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
-	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
 	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->ppt_pl2_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL2_SPPT);
@@ -4524,6 +4523,11 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE2))
 		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE2;
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX))
+		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX;
+	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX_VIVO))
+		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX_VIVO;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 9cadce10ad9a..b48b024dd844 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -128,6 +128,7 @@
 
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
 #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
+#define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026
 
 /* TUF laptop RGB modes/colours */
 #define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
-- 
2.44.0


