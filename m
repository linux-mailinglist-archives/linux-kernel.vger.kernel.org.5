Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9422278E688
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbjHaGaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjHaGaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:30:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E11A4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:30:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso503606a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693463400; x=1694068200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUwBGHC5VsjZQFl8xxzGqyyCgwF3lKTjHm0TdmJHFiA=;
        b=haFc70tGz3VgZ/nhUm0F9/wqvr9YwKYVE0PC7hJK8YXRxAcfCKLRtx+AzGfRgStgpp
         uSuxjo0NICpUAQXzeZxY/6cvqNxDngM+yPCMERv6RZBCfNqGTzrwhBiXokjN4O6XUe09
         xdQYBLZi5ZwaWnrzKO7rgFi/GN9hdqJ+wCaKodt8xcVJyGbO614xxJI2XHkLXJuud+/4
         gJT733sABLNzldLyINzRgRngdDREBVQnPO0yayVN4uZfvqSkqVfRzaPrBFziEZidG9wd
         c7SYk5UJKY3L4HQ6wa0CkxfvEYup88HVxMQQS3U4xPE9jssDY7i0bqnZrRocB29ofpm4
         AplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693463400; x=1694068200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUwBGHC5VsjZQFl8xxzGqyyCgwF3lKTjHm0TdmJHFiA=;
        b=OFupceNO26DvD0ckUsxl9+oVG+wBNHsmkBOIghFhPoo+cNK+EWgq3RZLyvVtdBYxCk
         QQ5ZAJuZpXrfH+fDSz5wXYDLIH0fNpznKdTRyMzxyTNgH9yb6nJAhC/mEKMpIBcwrdcE
         HrPeyoEox723lE9cMNzs1Rvrx41XWqDrAuFZS5bZur1Zap8Kpyy55UoxiAZ80+NYSVcs
         cPZuLfj+yyqiqqk5DZk7cUMHGuIPKYDAWueJEaz+WT2nAmAqB8ZKw7pFwSWt1UuHx1Ks
         O4Ab6TpbSCv8d0O6y9tpBJxMHy1L+s0b384ACglY1Pil8Kgjo/ZvW2tDcp310SaH0cFx
         BAjA==
X-Gm-Message-State: AOJu0YwFc5iov6fRoHDulFUTkaGAa29BOYomh4ZiJzPzqZT5I/UIY6oT
        /W3yCgBLoTpLNOo4z3WVOKBoOg==
X-Google-Smtp-Source: AGHT+IHp2w3tyUGuLVWtNA64xNLW9YemH8IoPOq4F/4imyApmLAKS8Dl+HuDQigZxMGX0xl+6mldEA==
X-Received: by 2002:aa7:d7cf:0:b0:523:2df6:396a with SMTP id e15-20020aa7d7cf000000b005232df6396amr3637022eds.37.1693463399750;
        Wed, 30 Aug 2023 23:29:59 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id l26-20020a056402125a00b00525c01f91b0sm405241edw.42.2023.08.30.23.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 23:29:59 -0700 (PDT)
Message-ID: <cea3472a-e9f7-39cb-419c-d042b3bf0682@linaro.org>
Date:   Thu, 31 Aug 2023 08:29:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Elson Serrao <quic_eserrao@quicinc.com>
Cc:     Roger Quadros <rogerq@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <31fa930a-51fb-6a7f-300d-e71f6b399eb1@linaro.org>
 <a0a6c561-6319-00ba-c6db-f1dec9f0f0aa@quicinc.com>
 <5dfae814-7233-eb1f-cae7-f335e54ce1b6@linaro.org>
 <cf0227c8-cd02-81b6-9e13-2e7fe6f505f2@kernel.org>
 <20230826015257.mbogiefsbz5474ft@synopsys.com>
 <afd4843b-427a-8535-78e2-f81879378371@linaro.org>
 <969988f6-f01f-0e31-6a98-7d02c5a3a4ad@quicinc.com>
 <20230830013739.srnh2uyhly66yvu2@synopsys.com>
 <d30a8d6a-236a-b6eb-76d7-115cc9950ce1@quicinc.com>
 <6f70a710-c409-23c0-890b-370ccd23e088@linaro.org>
 <20230831030134.z46fjwyr6edl3t7x@synopsys.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230831030134.z46fjwyr6edl3t7x@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2023 05:01, Thinh Nguyen wrote:
> On Wed, Aug 30, 2023, Krzysztof Kozlowski wrote:
>> On 30/08/2023 06:31, Elson Serrao wrote:
>>>
>>>
>>> On 8/29/2023 6:37 PM, Thinh Nguyen wrote:
>>>> Just want to clarify, there are dwc3 properties and there are dt binding
>>>> properties. Often the case that dt binding matches 1-to-1 with dwc3
>>>> driver property. Now, we need to enhance the checkers so that the dwc3
>>>> driver property to match cases where it is platform specific and through
>>>> compatible string.
>>>>
>>>
>>> Thank you for the clarification Thinh.
>>> To confirm, we would need to modify the driver to parse a new compatible 
>>> string (say "snps,dwc3-ext-wakeup") and add .data field so that the 
>>> driver is aware that this particular platform supports external wakeup 
>>> detection.Right ?
>>
>> No, it's not then platform specific. You said it depends on each
>> platform. Platform is Qualcomm SM8450 for example.
>>
> 
> Hi Elson,
> 
> Use the compatible string of your platform.
> 
> e.g.
> if (dev->of_node) {
> 	struct device_node *parent = of_get_parent(dev->of_node);
> 
> 	dwc->no_disconnect_on_usb_suspend =
> 		of_device_is_compatible(parent, "qcom,your-compatible-string") ||
> 		of_device_is_compatible(parent, "some-other-platform");
> }
> 
> You need to enhance dwc3_get_properties(). This may get big as dwc3 adds
> more properties. Perhaps you can help come up with ideas to keep this
> clean. Perhaps we can separate this out of dwc3 core.c?

This should be a flag or quirk in device ID table match data.

Best regards,
Krzysztof

