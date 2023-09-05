Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B4B7929F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355343AbjIEQat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354288AbjIEKen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:34:43 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DD1E8;
        Tue,  5 Sep 2023 03:34:40 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 3CC0840901;
        Tue,  5 Sep 2023 15:34:38 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1693910078; bh=9VYUgC5g7FgxX8kAuIVj9vcg8DOd3TL1apx/ALOG51w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HElwKZ5LJA4CJXPqyDHEbvxK5dVVt+bvK0uZeEWUdRrDJQ46jU/P9+v8zlrVjsi60
         T29yZeYTWNfa4bWLGTPMux3qrfGJ1AyeVGHH+s5WSTRhGD+lVvD2Y+pJJRHmdmlnP+
         hQoU/W/Is/5/OKrz5o1n3l+pQDMNxuEpAGg0a863MGgVbClPU7GQwwmMM0O+z44ggX
         R+aCV+SFhjKycx5gVRDlVHG7KkAuBVg5WcRXfKWedrmbXV6+ghYnJGxqA434nyVGbk
         JiCPuyxU8AmoS0ezHDhoR+vjxedrX3pFgHtKZOeoiEu0pg9FofEmF3CPm6gYRkKePq
         mu68bJE10ofnw==
MIME-Version: 1.0
Date:   Tue, 05 Sep 2023 15:34:37 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc7180: Add ADSP
In-Reply-To: <7d0200c6-0a87-54fd-5909-e4076dfc0a0e@linaro.org>
References: <20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru>
 <20230905-sc7180-adsp-rproc-v1-4-dfea7699da7b@trvn.ru>
 <7d0200c6-0a87-54fd-5909-e4076dfc0a0e@linaro.org>
Message-ID: <e3821dbd9d1e8d4178ec2ef0b4efcb7b@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski писал(а) 05.09.2023 12:12:
> On 05/09/2023 07:47, Nikita Travkin wrote:
>> +				apr {
>> +					compatible = "qcom,apr-v2";
>> +					qcom,glink-channels = "apr_audio_svc";
>> +					qcom,apr-domain = <APR_DOMAIN_ADSP>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					apr-service@3 {
> 
> Except missing tests, few more things to fix

Will rename the services to fit the schema

> 
>> +						reg = <APR_SVC_ADSP_CORE>;
>> +						compatible = "qcom,q6core";
> 
> compatible is always the first property.
> 

Ack, missed that

>> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
>> +					};
>> +
>> +					q6afe: apr-service@4 {
>> +						compatible = "qcom,q6afe";
>> +						reg = <APR_SVC_AFE>;
>> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
>> +
>> +						q6afedai: dais {
>> +							compatible = "qcom,q6afe-dais";
>> +							#address-cells = <1>;
>> +							#size-cells = <0>;
> 
> You do not have any children, so drop these two. I will fix the binding.
> 

As you have already pointed out, the children will be in the board.
Will keep the sizes for this and the next one.

Nikita

>> +							#sound-dai-cells = <1>;
>> +						};
>> +
>> +						q6afecc: cc {
>> +							compatible = "qcom,q6afe-clocks";
>> +							#clock-cells = <2>;
>> +						};
>> +					};
>> +
>> +					q6asm: apr-service@7 {
>> +						compatible = "qcom,q6asm";
>> +						reg = <APR_SVC_ASM>;
>> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
>> +
>> +						q6asmdai: dais {
>> +							compatible = "qcom,q6asm-dais";
>> +							#address-cells = <1>;
>> +							#size-cells = <0>;
> 
> Ditto
> 
>> +							#sound-dai-cells = <1>;
>> +							iommus = <&apps_smmu 0x1001 0x0>;
>> +						};
>> +					};
>> +
>> +					q6adm: apr-service@8 {
>> +						compatible = "qcom,q6adm";
>> +						reg = <APR_SVC_ADM>;
>> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
>> +
>> +						q6routing: routing {
>> +							compatible = "qcom,q6adm-routing";
>> +							#sound-dai-cells = <0>;
>> +						};
>> +					};
>> +				};
> 
> 
> Best regards,
> Krzysztof
