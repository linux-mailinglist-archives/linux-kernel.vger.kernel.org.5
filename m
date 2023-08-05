Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DFE7711D1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 21:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjHETin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 15:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjHETik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 15:38:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83981BCA
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 12:38:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe426b8583so25587615e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691264317; x=1691869117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udk/H8ZgKjfvJwnE+xho4EfEOftvGT0VCYsBYpwRNHo=;
        b=yD2hT0N3zrlPlop4QxmCW16DXc/kWC/8YNFcGOeKehecVojM3ba0Zd39mtHn989C3X
         R7oqj1lpmK9PjbFsklJF8XvKM9o8RwvldDEqrpxtJrh3IquXPVxUqYEGuiDzMB7BhQHr
         up6Glj+7T9fB3Pt3eOshXohaxyb02FtrVfrHOLLU5gIXEGoEjg4cC53wOPQaez0p8EDf
         2L/1awLEnbUYyc2mft6VCHoN7EkruHhgoiWAUX9d0eVHEKjE77AIX/0pbvPjiK1JFvEj
         365QLUclpMw2AZrOh5OHpPnyul9NRliEfYwFpGcgw/OK9XH7zq9pzgZrGfIEg0bsiRG1
         Wjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691264317; x=1691869117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udk/H8ZgKjfvJwnE+xho4EfEOftvGT0VCYsBYpwRNHo=;
        b=U/ZyywJbJwa8xN0ZDCudFQ0lDD3N50ypG6lg1nYeTuu7Gh01Ha1XEbmLMFbSpev3Ul
         7RsHyxuSqQt84Nt3us/rrAYDiTOGuodeksSR3qn+6JQDLOmcD8MgkcDFuhX7Tl+lHD1H
         bIQSWo1RFlj+MvE4abp+JayKkOGPsoeSjF8W9y3WaKMrK94y52RwMMA1RvI9Vzv22V45
         I3CK6RIcvzbXvApr1Ib5yJQx5bviNXN4IDAOWmAvkm8DSm7wgdnoX4netnrThnI00ZMD
         ESR48pnkahPupBeV3EBeC5016EuIYh5b/bMKEbM5jplUirpwtElfwgaAiwSWZAZSAIMO
         LP5g==
X-Gm-Message-State: AOJu0YwsQwHuGqAPQQpHVia8QAx9JziFWOPBy92OZshg6n2zu+kLh7mO
        z5MCnrG5cU3n4pr3Eb5FDFkJOg==
X-Google-Smtp-Source: AGHT+IGvrlUd0YfuF3G0qhIxdGb5wiPGOR1jc4ZfaV/DTwfKyUOEYr8f52aMWDJdfJaCv83Yo1cWYQ==
X-Received: by 2002:a1c:4b0e:0:b0:3fb:b530:a4e4 with SMTP id y14-20020a1c4b0e000000b003fbb530a4e4mr4361705wma.8.1691264317315;
        Sat, 05 Aug 2023 12:38:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id z12-20020a05600c220c00b003fe1ca92151sm5752252wml.26.2023.08.05.12.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 12:38:36 -0700 (PDT)
Message-ID: <ceddbbfb-a178-2b7e-ea17-0a37f33224ab@linaro.org>
Date:   Sat, 5 Aug 2023 21:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/2] dt-bindings: cpufreq: add bindings for virtual
 cpufreq
Content-Language: en-US
To:     David Dai <davidai@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
References: <20230731174613.4133167-1-davidai@google.com>
 <20230731174613.4133167-2-davidai@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230731174613.4133167-2-davidai@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 19:46, David Dai wrote:
> Adding bindings to represent a virtual cpufreq device.
> 
> Virtual machines may expose MMIO regions for a virtual cpufreq device for
> guests to read frequency information or to request frequency selection. The
> virtual cpufreq device has an individual controller for each CPU.

A nit, subject: drop second/last, redundant "bindings for". The
"dt-bindings" prefix is already stating that these are bindings.

> 
> Co-developed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: David Dai <davidai@google.com>
> ---
>  .../bindings/cpufreq/cpufreq-virtual.yaml     | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-virtual.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-virtual.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-virtual.yaml
> new file mode 100644
> index 000000000000..f377cfc972ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-virtual.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/cpufreq-virtual.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yamll#
> +
> +title: Virtual CPUFreq
> +
> +maintainers:
> +  - David Dai <davidai@google.com>
> +  - Saravana Kannan <saravanak@google.com>
> +
> +description:
> +  Virtual CPUFreq is a virtualized driver in guest kernels that sends frequency
> +  selection of its vCPUs as a hint to the host through MMIO regions. The host
> +  uses the hint to schedule vCPU threads and select physical CPU frequency. It
> +  enables accurate Per-Entity Load Tracking for tasks running in the guest by
> +  querying host CPU frequency unless a virtualized FIE (ex. AMU) exists.

Why do you need DT for this? You control hypervisor, thus control the
interface to the guest. I think Rob made it pretty clear that
discoverable usecases (which is yours) are not for DT.

Incomplete style-review follows:

> +
> +properties:
> +  compatible:
> +    const: virtual,cpufreq

Missing blank line.

> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cpus {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      cpu@0 {
> +        compatible = "arm,arm-v8";
> +        device_type = "cpu";
> +        reg = <0x0>;
> +        operating-points-v2 = <&opp_table0>;
> +      };
> +
> +      cpu@1 {
> +        compatible = "arm,arm-v8";
> +        device_type = "cpu";
> +        reg = <0x0>;
> +        operating-points-v2 = <&opp_table1>;
> +      };
> +    };
> +
> +    opp_table0: opp-table-0 {
> +      compatible = "operating-points-v2";
> +
> +      opp1098000000 {
> +        opp-hz = /bits/ 64 <1098000000>;
> +        opp-level = <1>;
> +      };
> +
> +      opp1197000000 {
> +        opp-hz = /bits/ 64 <1197000000>;
> +        opp-level = <2>;
> +      };
> +    };
> +
> +    opp_table1: opp-table-1 {
> +      compatible = "operating-points-v2";
> +
> +      opp1106000000 {
> +        opp-hz = /bits/ 64 <1106000000>;
> +        opp-level = <1>;
> +      };
> +
> +      opp1277000000 {
> +        opp-hz = /bits/ 64 <1277000000>;
> +        opp-level = <2>;
> +      };
> +    };
> +
> +    soc {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      cpufreq {

Missing unit address

> +        reg = <0x1040000 0x10>;
> +        compatible = "virtual,cpufreq";

compatible is always the first property.

Also, you did not test it...


Best regards,
Krzysztof

