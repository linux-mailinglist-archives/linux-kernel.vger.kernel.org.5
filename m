Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82367C01BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjJJQeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjJJQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:34:03 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929F39D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:33:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c186ea81c7so75815851fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696955636; x=1697560436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXgMbtQ30IMvVzvJ3cAQCAXyb8GEmNBTLVRPEsln6kw=;
        b=Nd5RPLV5ptrXnsWQP+VThclwRYQ1puUYCEK2wlz8Q2SaYbrnYM6h2RgFQC19DKwC8D
         6poYCG4XgLMFSi6ZITU5mGFv/sJ4Sr07BpLzPn9b6roHCaM+YYxKuQ5XdOh3xo5xt5GM
         SdUwKt6mJcnWm8XY4DNfPTr9mEqRy3PFUirYCKvmnbSNYzhXeOQvu4o/demCTjMyzOWK
         JoFm1bthGBbriLfhOrD191FpQi/z8ID39UkoqfmMRD1lfAhBfDIJH7Nuisa5uOXkF07n
         oVSFIU1e5zK5OICvvh/CFa8uC5vixFEngjVhra2DsiOoyTrgKsUZ0aje+E00DCe2/y+y
         vm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696955636; x=1697560436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXgMbtQ30IMvVzvJ3cAQCAXyb8GEmNBTLVRPEsln6kw=;
        b=GO4TSU8vVoH3gJosz3TGxrCxLj1V/IcSwfopJwd0p1QI67qkbcUfDfmFt08F3OfdeJ
         C8Rqs3aFVh7cNOfvwv1ZhROGIFJtqMnZxLzevJoNyaXzam67El6CODFu6AIORvCLeWyl
         b50p1EgcZ0qE0q/2QtVnhsqzFwhoF10RYcg16c+A0hvlsEsNhRtB99w6Vvla9e3uf5DN
         QCWtooe9fWbPpUwJz/QMfRCh9WBIznAUK8km1+J/lAWvn2FzdT617kXvjYgsnt46Fwxw
         FpBuSWVNkS6FpA/237sCB7ij6X8iKLQUVWHkEU5egctAoZlc3pyPFoY70PuwfFkhFZjK
         2p0w==
X-Gm-Message-State: AOJu0YxOLY4GmgyFObDXIt/1JfwgWRwYy8TWdDX+z40SCfR4itUYM2hA
        Uro6JKlQt28CHDs9UJ9zCeObpg==
X-Google-Smtp-Source: AGHT+IESpyT1izX4PfA0LwaqoijzKYBsw71W/205De2O5PI8KaLqN4jdxF7iKF2LBA+HTl5dZmIgPw==
X-Received: by 2002:a05:6512:ac5:b0:503:2eaf:1659 with SMTP id n5-20020a0565120ac500b005032eaf1659mr20896855lfu.41.1696955634875;
        Tue, 10 Oct 2023 09:33:54 -0700 (PDT)
Received: from [172.30.204.182] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b10-20020ac2410a000000b004fe432108absm1877755lfi.182.2023.10.10.09.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 09:33:54 -0700 (PDT)
Message-ID: <e6d22992-e3aa-480c-8def-00a447951a02@linaro.org>
Date:   Tue, 10 Oct 2023 18:33:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: qcom: Enable ASPM for platforms supporting
 1.9.0 ops
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andersson@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20231010155914.9516-1-manivannan.sadhasivam@linaro.org>
 <20231010155914.9516-3-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231010155914.9516-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 17:59, Manivannan Sadhasivam wrote:
> ASPM is supported by Qcom host controllers/bridges on most of the recent
> platforms and so the devices tested so far. But for enabling ASPM by
> default (without Kconfig/cmdline/sysfs), BIOS has to enable ASPM on both
> host bridge and downstream devices during boot. Unfortunately, none of the
> BIOS available on Qcom platforms enables ASPM. Due to this, the platforms
> making use of Qcom SoCs draw high power during runtime.
> 
> To fix this power issue, users/distros have to enable ASPM using configs
> such as (Kconfig/cmdline/sysfs) or the BIOS has to start enabling ASPM.
> The latter may happen in the future, but that won't address the issue on
> current platforms. Also, asking users/distros to enable a feature to get
> the power management right would provide an unpleasant out-of-the-box
> experience.
> 
> So the apt solution is to enable ASPM in the controller driver itself. And
> this is being accomplished by calling pci_enable_link_state() in the newly
> introduced host_post_init() callback for all the devices connected to the
> bus. This function enables all supported link low power states for both
> host bridge and the downstream devices.
> 
> Due to limited testing, ASPM is only enabled for platforms making use of
> ops_1_9_0 callbacks.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
[...]

> +static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
> +{
> +	/* Downstream devices need to be in D0 state before enabling PCI PM substates */
> +	pci_set_power_state(pdev, PCI_D0);
> +	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
Do we not care about retval here?

> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
post_init_enable_aspm?

Konrad
