Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3277A8676
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjITOYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjITOYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:24:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE24188
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:24:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a65f9147ccso907819766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695219871; x=1695824671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNbD5JZlT85L92cZjusJkHp4jtK/JZ5bz82Z9IIMDbo=;
        b=jIE/8psk4CmBDHStB71z+WVxaf2b18lsxtGcXwjhAqusN5SJ6rnp/lusEio7gTE8KQ
         4QD8JIBzeEka05rgShfU99gul/qai2hJADGxdH8tE15IW9ZRbHeBihgs22wUPKZ1qiPM
         J9p5eu68R4o1uNFafB+yDfZ79b50WiGNs/PqGVDkbbiGmgAv4KszyaMm+vVjZYx8r0aw
         MTkKMdrXEH7kpYkqcGfT5l1MQ7qjED2OC/bvX/ZTE0dWQuYpNdlFlGJ5+/kfRyXFpV1R
         A0peqV0bwpnt7TlSIDN9qgVhvlGq92Jbh+lrHiwaoEdnuWfIUTMWz3mgz1/jD66jo254
         SWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695219871; x=1695824671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNbD5JZlT85L92cZjusJkHp4jtK/JZ5bz82Z9IIMDbo=;
        b=N6hYwqlsxF/SlA7eWXFH09JGPbF/wreFVg60uIAARgLkZxIvPZyvAyNK0FjJ+gNLPq
         fVxGzgKgnh9HfKHpoHiQN+88Cu86mN22aW7AsbNPqv7GmomI1Jc8GFVrVDuo3amjpkA9
         omzzDhVUJa5bm3fihJHPs1nK3N+rq2SvekG50nHW3+OOEdrlVCMPDfp4bzj1HEuBbPNp
         IhRvh3JsO8zaDQ803ODUJxDbzjdog5O/4bm3Wu9BuO64E3qEXgp8yXWUJPl3R/bpeUyw
         p2vt39bS3HNgwkjsQGcL0O3JpJn7YpafV/if7/uZp+VI3hYWVfqiYN+PRjcr1g4a8vGb
         JW7g==
X-Gm-Message-State: AOJu0YxnHIptEmkY54xosOf30zy8d9KsuhDtfwUpQEH7vCH9mqruGOQL
        0/6GhRjsSMze7fy1GP1/65+rFA==
X-Google-Smtp-Source: AGHT+IEWeR4ibVo/0lBYIQnbCIzA4Q1ZL7a5w7fDqs/tLyxpyOxPFsZtH1PIFFFFdedlS+oRgvhRMw==
X-Received: by 2002:a17:906:225b:b0:9ae:541e:7310 with SMTP id 27-20020a170906225b00b009ae541e7310mr477368ejr.33.1695219871576;
        Wed, 20 Sep 2023 07:24:31 -0700 (PDT)
Received: from [172.20.86.172] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id lg13-20020a170906f88d00b009ad88839665sm9435005ejb.70.2023.09.20.07.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 07:24:31 -0700 (PDT)
Message-ID: <4b20d3bb-d2d2-0864-013f-104e26ae558c@linaro.org>
Date:   Wed, 20 Sep 2023 16:24:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/5] PCI: qcom-ep: Add support for SA8775P SoC
Content-Language: en-US
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
References: <1695218113-31198-1-git-send-email-quic_msarkar@quicinc.com>
 <1695218113-31198-3-git-send-email-quic_msarkar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1695218113-31198-3-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 15:55, Mrinmay Sarkar wrote:
> Add support for SA8775P SoC to the Qualcomm PCIe Endpoint Controller
> driver.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
This compatible does not bring anything new to the table
on its own. Please create a fallback compatible, document it
in the bindings and use that. See [1] and [2] for example.

Konrad

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml?h=next-20230920

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/pm7550ba.dtsi?h=next-20230920#n65
