Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B2878BF6D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjH2HnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjH2Hmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:42:33 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96423139
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:42:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99cdb0fd093so527454266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693294949; x=1693899749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZidkGWNPi5BjyVLjLVMFpv4YzU60iSJ/Ecori1AkQ0=;
        b=i5va1TsUR/sivxWYmTNw0ts25LKsB6R7S9P3dyzzTC+Fh7W68bccjTByx/vLozPCD7
         It7sG2Ds7/CWT2/M7z8KA6r0Zx5v+Lqj0ks1AHc2YuE2LIFYmOyqdNSFemEYsWB6gd6v
         dzAoiFpNymOG7WMSmamobMgoHU7JfXgdMmHXuDqKieR1cFTu6Fg4SonCIH6An8oTxsnQ
         RqIL6KjiHnVgEEK3qiD/20g2v2VcSQkg25MLPb/ioLLr5TcP1rqanOpbrBeaRmA8PbAV
         IQDFriKYp3OMel93CxJxtaaOwpESEjrNGmC0bs45BksGbVMWvgsiZEWgFeZHhTkn6X8R
         eIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693294949; x=1693899749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZidkGWNPi5BjyVLjLVMFpv4YzU60iSJ/Ecori1AkQ0=;
        b=H+XlaxZIEnwiQwlkDfmOm6PdTXnNA3Xjzu7zrRYugh/jk9Ls1muO5fReIi3nxwex+W
         tgoBsTOzML2P+hxIvts6sjW8rR+aZKGc3tyX7LXkNMmdL5DPv0DEgASdhgM5/8z5zkwF
         RjyPD36IbYBgVjc71IgYmDPDUuot/CECkle45Fct77kODsSFViikv6ZB5c6JQ74Wr/98
         LJY3DM8YXHu0NTMkG6JCDzIqy3fA98kbtuhlclteSWG3Rc13M6PaBQwnIbTr5oZwrJ/l
         fU62mIL3EHMgY8WPlpHbYlG2wt9VbaxG01lwoWW+A7tSrdiEhTbMsETcWtFw4VlDlJ7I
         630Q==
X-Gm-Message-State: AOJu0YwN/d+8burIYZeXYj07lReHRlwd2c1NI/k1rO3PlUd2OJ+I7iEG
        BwJoxljjLs9LyiXBj6Hf2BwuVg==
X-Google-Smtp-Source: AGHT+IEWQr3QZ34jpK/5hL3ExGpvkPxLMtK2asR6mbFflpZ3LI8Ub6Apso9Cl+apOGcp3MwFMSZd6g==
X-Received: by 2002:a17:906:2243:b0:9a1:8a39:c62d with SMTP id 3-20020a170906224300b009a18a39c62dmr20024316ejr.38.1693294948996;
        Tue, 29 Aug 2023 00:42:28 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906354b00b00992bea2e9d2sm5615023eja.62.2023.08.29.00.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 00:42:28 -0700 (PDT)
Message-ID: <e2b2f268-182a-5ba4-2541-f0a401eda1c8@linaro.org>
Date:   Tue, 29 Aug 2023 09:42:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 11/28] dt-bindings: usb: dwc3: Add
 snps,num-hc-interrupters definition
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, gregkh@linuxfoundation.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-12-quic_wcheng@quicinc.com>
 <20230311134008.GA20831-robh@kernel.org>
 <f7bd1ae7-fc38-0f29-546b-9ea4a323f42f@quicinc.com>
 <73655c17-5246-2c96-d415-6a30497966c3@linaro.org>
 <9d31db9c-4e58-767a-15c5-65f7c04bd989@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9d31db9c-4e58-767a-15c5-65f7c04bd989@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 09:19, Wesley Cheng wrote:
>>>
>>> This is a XHCI feature, but the DWC3 design is built in a way that DWC3
>>> host initializes the XHCI device and populates the properties associated
>>> to XHCI dev.
>>
>> You speak about driver now, not bindings. If driver has limitations,
>> change it. Not really problem of bindings.
>>
> 
> Its the limitation of the HW.  Depending on how the SNPS DWC3 controller 
> was implemented the vendor it can support less than the value mentioned 
> in the Synopsys databook.

Then what is "XHCI dev"? A Linux device? Then a driver topic. What is
"populates the properties" - what or whose properties? Of Linux device?
Then a driver topic...

Best regards,
Krzysztof

