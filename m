Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2426E769FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGaRrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjGaRra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:47:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0010FD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:47:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d10792c7582so3610129276.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690825647; x=1691430447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=29q5zpqm1sVKYKxPJsQaRRpmMiHeYyJj4drlphLmlkQ=;
        b=hwEb13s7+A9pBueuQ3rroSatU3nWY/lO8w09G6GXlc7x3SiqZLJlP2JcyL/IDoJ1MX
         NgYmDilk277H9IKIh5UOL8v74p/ocQzRTC6+rFy4dqxgNljaxXaWMSSdgxH/oJL0/cA/
         GZ1tKxmnRWbX/uLKGhTahYuivm/NfuZY1cYdfvBhJn2VO7LdVeWg+G05tUP+UWRMXtGn
         eHelP8aOiakqz9xlSVRrzk16oXMzDXebxIduGRM3ab1tj5JgcL1M1IAS1jSkiMXd0HO1
         oos96CN7+O7NwQEQc2KjSns0Q+2ZmTQf3VRyvdTgWa0chYzIzgiJhIjNZOn5U7mhxg+L
         egAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690825647; x=1691430447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29q5zpqm1sVKYKxPJsQaRRpmMiHeYyJj4drlphLmlkQ=;
        b=Civpgt6RJPiZABuqSg+tagy0XpSOcP1HoRHqmuKQQMNHatbVc/C9luDozis8DTNy5W
         wbEztJxxxoe7PCcw1COWBbsxmCswYUsGNpyXrBCPZg+NZPuwvfJSF5BzHAqE9oX2WkNw
         +iF0q9NZ0zKjqMgMXXKqStW86BoCdwosVaUYDiQwO9m8KA8cbGFA080ieDLMF++rz8pV
         H3WN1lwkdHb8KMgkyI6gGDXNwyKKE48XnwxvBW1cTnhsHlnpYyO36GYoduzsX3C1xNJs
         dCc3UR5q2dbc2G/BWuHHYSStp4G6semHGve8JXMwYH3Djz10mwCeJTzbPW1iBtfI7hiv
         hkKA==
X-Gm-Message-State: ABy/qLZKOBU7jwP1aDVZ56Y2IHy+LmGCtkwYgr38NhPUhxDpqPOvbAXA
        lADL0QpAVklCJyWJ/vg+UxjPZWSAOmVa
X-Google-Smtp-Source: APBJJlHz42b6PJnJOh48NjPJ5CKFWKtztoQBOqDGPxi3dJJ70RKSFu+5UsyDmMz8pN0M4F4S9Xd7TKEsXtRM
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:4949:e05:91e:bd74])
 (user=davidai job=sendgmr) by 2002:a25:424e:0:b0:d01:60ec:d0e with SMTP id
 p75-20020a25424e000000b00d0160ec0d0emr65044yba.9.1690825647620; Mon, 31 Jul
 2023 10:47:27 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:46:08 -0700
In-Reply-To: <20230731174613.4133167-1-davidai@google.com>
Mime-Version: 1.0
References: <20230731174613.4133167-1-davidai@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731174613.4133167-2-davidai@google.com>
Subject: [PATCH v3 1/2] dt-bindings: cpufreq: add bindings for virtual cpufreq
From:   David Dai <davidai@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        David Dai <davidai@google.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding bindings to represent a virtual cpufreq device.

Virtual machines may expose MMIO regions for a virtual cpufreq device for
guests to read frequency information or to request frequency selection. The
virtual cpufreq device has an individual controller for each CPU.

Co-developed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: David Dai <davidai@google.com>
---
 .../bindings/cpufreq/cpufreq-virtual.yaml     | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-virtual.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-virtual.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-virtual.yaml
new file mode 100644
index 000000000000..f377cfc972ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-virtual.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/cpufreq-virtual.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yamll#
+
+title: Virtual CPUFreq
+
+maintainers:
+  - David Dai <davidai@google.com>
+  - Saravana Kannan <saravanak@google.com>
+
+description:
+  Virtual CPUFreq is a virtualized driver in guest kernels that sends frequency
+  selection of its vCPUs as a hint to the host through MMIO regions. The host
+  uses the hint to schedule vCPU threads and select physical CPU frequency. It
+  enables accurate Per-Entity Load Tracking for tasks running in the guest by
+  querying host CPU frequency unless a virtualized FIE (ex. AMU) exists.
+
+properties:
+  compatible:
+    const: virtual,cpufreq
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    cpus {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cpu@0 {
+        compatible = "arm,arm-v8";
+        device_type = "cpu";
+        reg = <0x0>;
+        operating-points-v2 = <&opp_table0>;
+      };
+
+      cpu@1 {
+        compatible = "arm,arm-v8";
+        device_type = "cpu";
+        reg = <0x0>;
+        operating-points-v2 = <&opp_table1>;
+      };
+    };
+
+    opp_table0: opp-table-0 {
+      compatible = "operating-points-v2";
+
+      opp1098000000 {
+        opp-hz = /bits/ 64 <1098000000>;
+        opp-level = <1>;
+      };
+
+      opp1197000000 {
+        opp-hz = /bits/ 64 <1197000000>;
+        opp-level = <2>;
+      };
+    };
+
+    opp_table1: opp-table-1 {
+      compatible = "operating-points-v2";
+
+      opp1106000000 {
+        opp-hz = /bits/ 64 <1106000000>;
+        opp-level = <1>;
+      };
+
+      opp1277000000 {
+        opp-hz = /bits/ 64 <1277000000>;
+        opp-level = <2>;
+      };
+    };
+
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      cpufreq {
+        reg = <0x1040000 0x10>;
+        compatible = "virtual,cpufreq";
+      };
+    };
-- 
2.41.0.585.gd2178a4bd4-goog

