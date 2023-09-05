Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8A07929BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352471AbjIEQ13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344389AbjIEDbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 23:31:20 -0400
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC04CC7;
        Mon,  4 Sep 2023 20:31:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08675569|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00885644-0.00013455-0.991009;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.UXm5SLO_1693884663;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.UXm5SLO_1693884663)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 11:31:11 +0800
From:   wangweidong.a@awinic.com
To:     krzysztof.kozlowski@linaro.org
Cc:     13916275206@139.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, ckeepax@opensource.cirrus.com,
        colin.i.king@gmail.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, herve.codina@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        liweilei@awinic.com, perex@perex.cz, rdunlap@infradead.org,
        rf@opensource.cirrus.com, robh+dt@kernel.org, ryans.lee@analog.com,
        shumingf@realtek.com, tiwai@suse.com, trix@redhat.com,
        wangweidong.a@awinic.com, yijiangtao@awinic.com,
        zhangjianming@awinic.com
Subject: Re: [PATCH V1 1/3] ASoC: dt-bindings: Add schema for "awinic,aw87390"
Date:   Tue,  5 Sep 2023 11:31:03 +0800
Message-ID: <20230905033103.15343-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <a3ada071-4c8e-f65d-ad75-655370ba2c55@linaro.org>
References: <a3ada071-4c8e-f65d-ad75-655370ba2c55@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your review. 
I would like to discuss something with you

On 04/09/2023 12:14, krzysztof.kozlowski@linaro.org wrote:
> On 04/09/2023 13:46, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 
>> Add a DT schema for describing awinic aw87390 audio amplifiers.
>> They are controlled using I2C.

> Thank you for your patch. There is something to discuss/improve.

>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: awinic,aw87390
>> +
>> +  reg:
>> +    maxItems: 1

> No reset-gpios? Shouldn't this be just merged with awinic,aw88395 bindings?

Yes, this chip does not have reset-gpios, and the i2c address of 
this chip is different from the aw88395 chip.So I didn't 
merge it with awinic, aw88395.

> Missing sound-dai-cells (const: 0 or 1)

Thank you very much. I'll add #sound-dai-cells

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        audio-codec@58 {
>> +            compatible = "awinic,aw87390";
>> +            reg = <0x58>;

> Please add sound-dai-cells for the example to be complete.

Thank you very much, I will modify it in patch v2

Best regards,
Weidong Wang
