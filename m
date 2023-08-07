Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A872F7730E5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjHGVFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHGVFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:05:41 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8531AE5B;
        Mon,  7 Aug 2023 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1691442339;
  x=1722978339;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=1FvuxzF3ZTN5rBRW6KTbc1oYiX1RSTxjshmVaXjenfs=;
  b=Y1ZJxGSlonVBr4Axqb+lPT+irzDjg5AbZYFee2Qye/9KbbUcI5zwPJs3
   g31VoHd1V+oTz7hH5vUI2IZMwE7a2c2FlrZhaMKu57uuh0UkwHnm3xn3D
   Ne7oy/KYuDsO3mWYQweKfwkl2SQIqH3stppD7+TTS7kPh/nDaDOnKbNIc
   Qfkf7xx28n8k42H2vPI4F/+6hios0/gxZqacWCv3MojPKEqhfQtkIryE/
   6XmtdtdcM0bCrhegP9FxJB77p/Kb5ooZVyUaKrOnbJfdOX55ZYslpS0Tr
   51uGXsxQI+VMeeSCF4DIpDFYD9WC/zYs4S2Ul+QA7gCarwsBtDWlgx1XD
   Q==;
References: <cover.1691158774.git.waqar.hameed@axis.com>
 <864b398918e99773f6cbd5ffe5b1f0dc33e4d6d1.1691158774.git.waqar.hameed@axis.com>
 <ad4dfefc-f18a-5462-eb6d-fdee161f87b3@linaro.org>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <kernel@axis.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: Add Epson RX8111
Date:   Mon, 7 Aug 2023 23:02:13 +0200
In-Reply-To: <ad4dfefc-f18a-5462-eb6d-fdee161f87b3@linaro.org>
Message-ID: <pndpm3ybm1s.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 22:28 +0200 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 04/08/2023 16:19, Waqar Hameed wrote:
>> Epson RX8111 is an RTC with timestamp functionality. Add devicetree
>> bindings requiring the compatible string and I2C slave address (reg).
>
>
>> +
>> +maintainers:
>> +  - Waqar Hameed <waqar.hameed@axis.com>
>> +
>> +description: |
>> +  RTC with timestamp functionality.
>> +
>> +  https://support.epson.biz/td/api/doc_check.php?dl=app_RX8111CE&lang=en
>> +
>> +properties:
>> +  compatible:
>> +    const: epson,rx8111
>> +
>> +  reg:
>> +    const: 0x32
>> +
>> +required:
>> +  - compatible
>> +  - reg
>
> Just add it to trivial-rtc.yaml. You miss here more things than trivial
> is providing, so...

Oh, I wasn't even aware of that file. I'll add it there instead!
