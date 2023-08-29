Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DCE78C3B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjH2L5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjH2L4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:56:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0353B1A1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:56:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bfcf4c814so557409066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693310202; x=1693915002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/hrHPmS+vFLW0bzna1AjnuCdJkiK6OC4xIL0ZiqXC8=;
        b=UZICjZXYW56uOsvqjyxe406lq7agWTw9s+0AWBaTOCNV5BeSthmBXwdzDwnDK2MqLv
         gtogbG8SADSYxa4EjpllXZNffO5VD0LgBB/pF6KAOzdY1wWA8HnimK5D+RYrf1OWqYXC
         uT/0D28Tw+EVz7PAj6mNipuDR67eQfHoD7GCto06F73S6rU4+zyEUMtJlRA8bNEKZbLE
         67c42wkhfy0Ky74khA9G83AQm3sJwztGByKtV93BAJjtcEK0HehRbVowgBL+kgEap3bb
         3RImErAl8NrLYsdBsgKgbtYCqxET16nsx6uoRQlJjFvPDYGu6jJKZOctRSG82g0OvG2z
         gsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693310202; x=1693915002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/hrHPmS+vFLW0bzna1AjnuCdJkiK6OC4xIL0ZiqXC8=;
        b=BPtzIrnyEBFLGKzaXI14vL8hTJthdTfJmij/eOZvfpLhwNC33wMWQuhOGH53c05oBf
         x3SV11mUT8rAmo3QRjN011iUDCqlUirX1UeTn16BLLPrTSurFia0ZFMvCxZOudNdxG/X
         UymHIJGWuqcXBHiEnDUNAY5PV5KvDs6lCZGcODLjts0edPJFSWmjfGlsc8XaKQGFIvZQ
         9xYTbpUnLCMEB1FlJgBx9QvXjr7AwHW9D5Xor4vK6rEm+Fw1oUM7W62KcvUw9P8kETxy
         4fbZ6olKURLox9D+5sER0XPS7teLL8MWnKnH3M979Hx21chncKHKji3W797+8BxUYDyj
         Fntw==
X-Gm-Message-State: AOJu0YzaMLqu2o601xorQyArSWdW9DW839VPotC7XZk41+SQHPVxPX91
        lW3oknvT2B56S93aVRqLA3C8fw==
X-Google-Smtp-Source: AGHT+IHe9DrUFMaBuINYa2UCCIQrxW+kNPiRtbvEeXCdejgRQh51yG6iMjx9U9zJ2beSNY3FAXt+5g==
X-Received: by 2002:a17:907:77cb:b0:99b:4668:865f with SMTP id kz11-20020a17090777cb00b0099b4668865fmr23046112ejc.10.1693310201800;
        Tue, 29 Aug 2023 04:56:41 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id op5-20020a170906bce500b0099bc2d1429csm5887285ejb.72.2023.08.29.04.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 04:56:41 -0700 (PDT)
Message-ID: <73700e92-2308-3fe0-51b1-c2373be2893e@linaro.org>
Date:   Tue, 29 Aug 2023 13:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v10 0/4] PCI: qcom: ep: Add basic interconnect support
Content-Language: en-US
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com
References: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
 <20230728025648.GC4433@thinkpad>
 <b7f5d32f-6f1a-d584-4cdd-4c5faf08a72e@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b7f5d32f-6f1a-d584-4cdd-4c5faf08a72e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 13:41, Krishna Chaitanya Chundru wrote:
> 
> On 7/28/2023 8:26 AM, Manivannan Sadhasivam wrote:
>> On Wed, Jul 19, 2023 at 12:50:14PM +0530, Krishna chaitanya chundru wrote:
>>> Add basic support for managing "pcie-mem" interconnect path by setting
>>> a low constraint before enabling clocks and updating it after the link
>>> is up based on link speed and width the device got enumerated.
>>>
>> Krzysztof, can this series be merged for 6.6? Bjorn A will pick the dts patches.
>>
>> - Mani
> 
> A Gentle ping
> 

Whom do you ping and why me? If you choose not to use
scripts/get_maintainers.pl, it's your right, but then you might get
maintainers wrong and no surprise patches got not accepted...

Plus, it's merge window, so why pinging now?

Best regards,
Krzysztof

