Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5941579CCA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjILKAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjILKAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:00:04 -0400
X-Greylist: delayed 1164 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 02:59:58 PDT
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B551BB;
        Tue, 12 Sep 2023 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=nkBWy5eh+OpkWLvtd2NRIsXU76BxvUy48xcA0SXZihQ=; b=aWvmLD578BWL4/ssI24eDGqN6A
        eJZjKrhC7SpaM+8Xy8kctMd3vPSeFX2s1C90uO6Wewq6nBVqivSyl4oETjp0StW0ZKmNOnnaHsugY
        DH6ltOSLubsjLo2WvPOKDBJfZKpkGGt8rjebfx5HyHDRSRHnj+Y6pegK/M+KbgLeN0r4V+UUjYiA2
        rWmEILGxApKY8O+eVVN5ZRI+bulnp5gChDVWB+HIhOLMW84Gq2SRvPjpgYL+P5LrOarju6RcbN9ph
        G2TGnqKGyM+hnlDIKw7S7aL8eiDC8OMewZwtbxH6ioQaUW2ctOGCDkFE83bjFr/BMPWVslbZrN/eK
        g424WXbw==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qfzsn-0030Ws-0S;
        Tue, 12 Sep 2023 11:40:33 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 12 Sep 2023 11:40:16 +0200
Subject: [PATCH 2/4] cpufreq: dt: platdev: Add MSM8909 to blocklist
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-msm8909-cpufreq-v1-2-767ce66b544b@kernkonzept.com>
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
In-Reply-To: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8909 uses qcom-cpufreq-nvmem to attach power domains and to parse the
speedbin from NVMEM (for opp-supported-hw).

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index fb2875ce1fdd..984d2ad1a474 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -141,6 +141,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "nvidia,tegra210", },
 	{ .compatible = "nvidia,tegra234", },
 
+	{ .compatible = "qcom,msm8909", },
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
 	{ .compatible = "qcom,msm8998", },

-- 
2.39.2

