Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42C779CCAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjILKAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjILKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:00:15 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03CA1BB;
        Tue, 12 Sep 2023 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=kP4dqT07qSwPxY6iatQf4nzJ14CfYPt8epUu4xmkyS0=; b=RCEM8skxSiDKiA7WjvDFhfVFYR
        HWy/XSdRzWKPeviAnX9rwJoXquVOyUNny8ch7oLYIg7oovORreTTaRMWyiMplREXzaMQfw594sMkm
        m3qq9A4wmiR+GrHsy+mXVYCe9rtUclCSqcl9Umf/8tBHQgJBG8YRAjjqcUgQyNpAc4aI875sPSxCn
        MfpNOVkU004ItL50KSru24X51j/9/gASgfmEhs4+4spbu6JFF6QE9d+F4fSHB/nKWOa0mMIVL3nng
        VJX7AJaqdTErRLXIvdUCwGDskoZQtj80sxmZjr9tExWyUia7z1k5wGh59PyDASoeBDvSHzhmCUlBX
        Dbn9XAlQ==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qfzsp-0030Ws-0b;
        Tue, 12 Sep 2023 11:40:35 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 12 Sep 2023 11:40:17 +0200
Subject: [PATCH 3/4] dt-bindings: cpufreq: qcom-nvmem: Document MSM8909
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-msm8909-cpufreq-v1-3-767ce66b544b@kernkonzept.com>
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

Document that MSM8909 is used with qcom-cpufreq-nvmem for voltage
scaling and to restrict the maximum frequency based on the speedbin
encoded in the nvmem cells.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 7e1bb992ce90..09315a1d8fc1 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -29,6 +29,7 @@ select:
           - qcom,apq8096
           - qcom,ipq8064
           - qcom,ipq8074
+          - qcom,msm8909
           - qcom,msm8939
           - qcom,msm8960
           - qcom,msm8974

-- 
2.39.2

