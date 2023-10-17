Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB657CC887
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjJQQOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJQQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:14:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725D8F0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:14:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so56215445e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697559249; x=1698164049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKmQY7BLgBndXsxrNKxMvIo95aL00rRTN4PkHuTiB8Q=;
        b=jDPFaQj81Cg+o3/JqhA2Fjvipk6Qi9gIAUB0qDnPFsNldAL/h4vp7C6B02d98kO+2p
         Xcnom30EmF9EGdCWVk3op4GX1E712IOfSXLgFGKNBpAL+YPC/j3wsVImHWGOI3H+hOB7
         eadExD/JejqnECMLUE6RWnfihC5KLVbiAcwI+g4H1LbrSt8ZbVvQECQwPrVyBEeWzv60
         mRV0+5xSkHiBKt5orZZbu+spPWXlfE/XskZp96DWpTYwL1pKjoClS9Qhexv6SR8qXWYb
         jeVPThbzCTcSpuQReUHkFebutfMF2HUbcuagqryP32fvFNw06KnwrLEQ3sOuIfuSScPd
         BfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697559249; x=1698164049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKmQY7BLgBndXsxrNKxMvIo95aL00rRTN4PkHuTiB8Q=;
        b=NaM2GORMB+n9kvbQD8xCokBYU1pIoLSUj2OCeMYnPnqg8gwPANqO0vANEnb+lOZDRO
         RMddWhitxZD+Ec6WBqG0TLPBOF5xEuGQSsoSj8NMcFvDoPcEh97bSVXnYtq20iJG0ZTs
         1KnEvYGTWEyIuO0ujQzg40BW7m92POSaqR2c/c2S01iSeZbdzGUd/KGuARx9v5t5NZAF
         UxLvNheWjYriEMToC53Nj2mAttgsrV28C0CnA1ouDK0cqDG3gWzL/s1Y+BjD361yw03R
         NsG1lS0pRN3RI1rhRjgoi/C+UMtyMVYx1+zKR8FpP31lDHUBvwq++1+7vMRJ9rxje4Ju
         qB4A==
X-Gm-Message-State: AOJu0YwQcl95BwUP8mPXM7hfMRZXNlEXKJqEEpeMIqVVnwtOJIE5Xolr
        zdgWCL5ilNJ4ndiS0w/WvP5wBA==
X-Google-Smtp-Source: AGHT+IHwbJv6j6ptrNMYA09wWv9S10K/f+EjOxDnfiiQo8bvQ8vYVhH6fnAwUJNi9K2IWSbOMWqomA==
X-Received: by 2002:a05:600c:6021:b0:407:536d:47ae with SMTP id az33-20020a05600c602100b00407536d47aemr2085070wmb.38.1697559248879;
        Tue, 17 Oct 2023 09:14:08 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q28-20020adfab1c000000b003248a490e3asm101189wrc.39.2023.10.17.09.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:14:08 -0700 (PDT)
Message-ID: <013b76ea-82d1-4bb2-9842-b47cc4ccfc55@linaro.org>
Date:   Tue, 17 Oct 2023 18:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] usb: dwc3: Override end of dwc3 memory resource
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-5-ab4a84165470@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231016-dwc3-refactor-v1-5-ab4a84165470@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/23 05:11, Bjorn Andersson wrote:
> In the case that the dwc3 core driver is instantiated from the same
> memory resource information as the glue driver, the dwc_res memory
> region will overlap with the memory region already mapped by the glue.
> 
> As the DWC3 core driver already does math on the passed memory region to
> exclude the XHCI region, also adjust the end address, to avoid having to
> pass an adjusted region from the glue explicitly.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
