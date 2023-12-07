Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F51808ED6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjLGRVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLGRVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:21:07 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5B8A3;
        Thu,  7 Dec 2023 09:21:10 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 7083440553;
        Thu,  7 Dec 2023 22:21:08 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1701969668; bh=csNYLoNvFdpytXF+d1G6KwIPWhy/V0IKFboDTjA7drY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YuHV1/DCifDodLTuMKOqUXOLRRv/Y7T+WHNA2ZgDObQ3TBVVPQOkWWGfTglwH8cyp
         r/EASpDtslGEYXempqdWyhFv1Lx/palwuRqEHrPZIAhPOPKo14x4lRA/cl912ZXfBG
         6xDfxBBzVOWkIKCNfXWhEeDyKCYhuijIkr74wa2THb4Absk0yKjxnJv5fi9RVLqaE/
         SCBBHSqRFl0hTrclINwGuC3px1M8CC4txRwwhQM2zQGZane/1f9QgTNvUHutoaCo70
         Z0AO9k7Wa8FBjX3T47mxxba2O+Xn+CZWsljE2iPDXSjAmVRL3IxHLmdaMelcPfS8P+
         9BOvzB1zoKI9w==
MIME-Version: 1.0
Date:   Thu, 07 Dec 2023 22:21:07 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: Add Acer Aspire 1 EC
In-Reply-To: <75c9fe9f-a014-4ad9-a773-91555309c883@linaro.org>
References: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
 <20231207-aspire1-ec-v1-1-ba9e1c227007@trvn.ru>
 <75c9fe9f-a014-4ad9-a773-91555309c883@linaro.org>
Message-ID: <642d0317cf8d7375759269a333ad8e69@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski писал(а) 07.12.2023 21:56:
> On 07/12/2023 12:20, Nikita Travkin wrote:
>> Add binding for the EC found in the Acer Aspire 1 laptop.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>  .../bindings/power/supply/acer,aspire1-ec.yaml     | 73 ++++++++++++++++++++++
>>  1 file changed, 73 insertions(+)
>>
> 
> 
>> +
>> +  acer,media-keys-on-top:
>> +    description: Configure the keyboard layout to use media features of
>> +      the fn row when the fn key is not pressed. The firmware may choose
>> +      to add this property when user selects the fn mode in the firmware
>> +      setup utility.
>> +    type: boolean
>> +
>> +  connector:
>> +    $ref: /schemas/connector/usb-connector.yaml#
>> +
>> +    properties:
>> +      reg:
>> +        maxItems: 1
> 
> You cannot have it... Add it to the example and see the results.
> 

Gah, I had connector@0 at first with all the num-cells etc,
later simplified it, but missed this part...

>> +
>> +    unevaluatedProperties: false
> 
> It should be fine to drop this as well, so you don't need anything else
> than $ref.
> 

Will drop this too then.

Thanks!
Nikita

> 
> 
> Best regards,
> Krzysztof
