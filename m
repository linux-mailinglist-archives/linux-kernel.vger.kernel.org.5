Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F0E7D65D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjJYIwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjJYIwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:52:41 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D9D013A;
        Wed, 25 Oct 2023 01:52:38 -0700 (PDT)
Message-ID: <25a25ec1-e556-4f55-9594-47dc56971091@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1698223956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ofJZ6XdLGKwrLSz5EUPvCUZC2vhnSYrUQdbyfl0jeNs=;
        b=EIheemf7NZtqC6uvrczcwWQB3G3WSfPip1CzH03iB+jhB+QUgkwsWB6FI7W72KyL1HXdu3
        DZb/Wpcgv9BGwA3+0bSxRoSqh7lrtPtvD7NFiZDETU8epArb+2U8ojodESgdtT1RyhGx/k
        M4QCaEYBfxc8DWJA+g9KRBIYRvBiENo=
Date:   Wed, 25 Oct 2023 10:52:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/4] Add samsung-matisselte and common matisse dtsi
Content-Language: sv-SE, en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20231025083952.12367-1-newbyte@postmarketos.org>
 <04fae330-0866-408a-8016-b6f897f9550e@linaro.org>
From:   Stefan Hansson <newbyte@postmarketos.org>
In-Reply-To: <04fae330-0866-408a-8016-b6f897f9550e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-25 10:48, Krzysztof Kozlowski wrote:
> On 25/10/2023 10:37, Stefan Hansson wrote:
>> This series adds a common samsung-matisse dtsi and reworks
>> samsung-matisse-wifi to use it, and introduces samsung-matisselte. I
>> choose matisselte over matisse-lte as this is how most other devices
>> (klte, s3ve3g) do it and it is the codename that Samsung gave the
>> device. See individual commits for more information.
>>
>> ---
>> Changes since v1:
>>
>>   - Rebased on latest linux-next
>>   - Added qcom,msm8226 compatible to matisselte inspired by recent Lumia
>>     830 patch. This is done as in v1, the patch was rejected because I
>>     included the msm8226 dtsi despite not marking matisselte as
>>     compatible with msm8226, and I was not sure how to resolve that. As
>>     such, I'm copying what was done in the Lumia 830 (microsoft-tesla)
>>     patch given that it was accepted.
> 
> One version per day, so you won't ignore tags.

Sorry, I don't understand. Could you clarify what you mean? Thanks in 
advance.

> Best regards,
> Krzysztof
> 
