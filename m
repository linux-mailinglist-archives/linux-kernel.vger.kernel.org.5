Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFBA7C41E6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjJJUwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjJJUwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:52:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A215892
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:52:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50444e756deso8228932e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696971122; x=1697575922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hnx3JDX5ZDhAjkBPyCKtpQ3IeC0k9RIDG/U8xLkFK0A=;
        b=Nmr7WYBfv6a/z8xO4BWH7fh5EcY2ikp2FYZHwy7J7xC/qu1RqV19ZXfljZ1C4bMFGF
         8QzacBVmXCipfD901oeIfi7rBt7B2r6c1MCDpWugDMgiq64WD4F/jnKHGfjH8r46YEpK
         hEGgssS5+KN2y9pC0FgX0GzMRtL/Vx1elz18S/qpTPCWTfPknzA40G/uPDUI7B4/ljhm
         cJZdFcdOV1Gic+Jl5IdpEJxLsi8CeSaDzdirMfjPAak3QlnWm06gZN0CPrh0UCOXOUBF
         7IxFPfHuFkvb1rEBvTr9FC7+eJY26IX322QKwGaDdsoYErmAc1CvkQbynrgj09UtcMPn
         NaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696971122; x=1697575922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hnx3JDX5ZDhAjkBPyCKtpQ3IeC0k9RIDG/U8xLkFK0A=;
        b=KStQq0KOfDqNzfcclLjO+0O4t3io3B5aVtwwRVW74pHf6zNsVeZgYg7EHf5GFmoI2E
         Z4XnMmcV8nY+5ja6L4cF0LEAcgF3bMl99EXuRPSgLeLo6T90nEKYvmrl9QHAr6jgz7Vo
         iGUQRRNkz0kMHKWuPgLEI878EIAQ4IVDUMN6PRzP8GUFrgATNF1L0a2ST73s0SOEfRCo
         5TzVHk9qobtz+lFbzwuNp4fD0ZINa4ouylvwo1r+oQBX1M23nhY1QlDCdb0XXimrHp9z
         73zH3wUi9LFd/5qvI0636khlcWaNnbDre7QPm3X6s4VoYRnO2ik2xVkiNTsMIaj4MoHX
         b6vg==
X-Gm-Message-State: AOJu0Yw5grQ7oVXVI/2ubZQwieNsYTrQLuAu27tV/NgXx+aCyDgEcmAk
        jTeO6mUIWGK06Ks8Nx6h4/Bpaw==
X-Google-Smtp-Source: AGHT+IH4vNLAous4+oa7e4+QWETnqz4scuAP6FYe7JKxOutJ9RQ/6O/qvqqHVmtTKjn83y3KUKWitA==
X-Received: by 2002:a05:6512:2356:b0:4fb:8f79:631 with SMTP id p22-20020a056512235600b004fb8f790631mr18824069lfu.46.1696971121809;
        Tue, 10 Oct 2023 13:52:01 -0700 (PDT)
Received: from ?IPV6:2a00:f41:8004:ab80:24a8:5e5d:e0b2:5884? ([2a00:f41:8004:ab80:24a8:5e5d:e0b2:5884])
        by smtp.gmail.com with ESMTPSA id y18-20020a197512000000b00503f39e6bcesm1946714lfe.95.2023.10.10.13.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 13:52:01 -0700 (PDT)
Message-ID: <537d59b3-0e40-4d4d-80ab-b99028af6ec2@linaro.org>
Date:   Tue, 10 Oct 2023 22:51:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/10] Add multiport support for DWC3 controllers
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231007154806.605-1-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/23 17:47, Krishna Kurapati wrote:
> Currently the DWC3 driver supports only single port controller which
> requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
> DWC3 controller with multiple ports that can operate in host mode.
> Some of the port supports both SS+HS and other port supports only HS
> mode.
> 
> This change primarily refactors the Phy logic in core driver to allow
> multiport support with Generic Phy's.
> 
> Changes have been tested on  QCOM SoC SA8295P which has 4 ports (2
> are HS+SS capable and 2 are HS only capable).
> 
> Changes in v13:
> This series is a subset of patches in v11 as the first 3 patches in v11
> have been mereged into usb-next.
> Moved dr_mode property from platform specific files to common sc8280xp DT.
> Fixed function call wrapping, added comments and replaced #defines with
> enum in dwc3-qcom for identifying IRQ index appropriately.
> Fixed nitpicks pointed out in v11 for suspend-resume handling.
> Added reported-by tag for phy refactoring patch as a compile error was
> found by kernel test bot [1].
"If you fix the issue in a separate patch/commit (i.e. not just a new 
version of
the same patch/commit), kindly add following tags"

the issue your patch resolves is not one that was reported by the kernel 
testing robot, it just pointed out that you need to fix up the next revision

Konrad
