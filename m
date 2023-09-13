Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561FA79E195
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbjIMIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjIMIHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:07:06 -0400
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AEF199F;
        Wed, 13 Sep 2023 01:07:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09614743|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.110075-0.000808817-0.889117;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.Ue3VeMa_1694592409;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Ue3VeMa_1694592409)
          by smtp.aliyun-inc.com;
          Wed, 13 Sep 2023 16:06:58 +0800
From:   wangweidong.a@awinic.com
To:     robh@kernel.org
Cc:     13916275206@139.com, alsa-devel@alsa-project.org, arnd@arndb.de,
        broonie@kernel.org, ckeepax@opensource.cirrus.com,
        colin.i.king@gmail.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, fido_max@inbox.ru,
        harshit.m.mogalapalli@oracle.com, herve.codina@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        liweilei@awinic.com, perex@perex.cz, povik+lin@cutebit.org,
        rf@opensource.cirrus.com, ryans.lee@analog.com,
        sebastian.reichel@collabora.com, shumingf@realtek.com,
        tiwai@suse.com, trix@redhat.com, wangweidong.a@awinic.com,
        yijiangtao@awinic.com
Subject: Re: [PATCH V2 1/5] ASoC: dt-bindings: Adds properties to "awinic,aw88395"
Date:   Wed, 13 Sep 2023 16:06:48 +0800
Message-ID: <20230913080648.364569-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912162122.GA880119-robh@kernel.org>
References: <20230912162122.GA880119-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your advice, and I will modify it in the next patch.

On Tue, Sep 12, 2023 at 11:21:22PM -0500, robh@kernel.org wrote:
> On Tue, Sep 12, 2023 at 02:58:48PM +0800, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>

> The subject is still pretty generic. Ideally, we'd never have the same 
> subject twice. I'd do something like this:

> ASoC: dt-bindings: awinic,aw88395: Add properties for multiple PA support

Thank you very much. I will modify according to your suggestion in the next patch

>> 
>> Adds properties to "awinic,aw88395" to make files more complete

> Complete in what way? multiple PAs, right. It's not really clear 
> to me though how these properties enable support for multiple PAs.

Thank you very much. I will change the following content in the next patch:
Add two properties, the "awinic,audio-channel" property and the
"awinic,sync-flag". The "awinic,audio-channel" is used to make 
different PA load different configurations, the "awinic,sync-flag"
is used to synchronize the phases of multiple PA. These two properties 
will be read by the corresponding driver, so that the multi-PA to 
achieve better playback effect.

>> 
>> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
>> ---
>>  .../bindings/sound/awinic,aw88395.yaml        | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
>> index 4051c2538caf..4965aa4a5370 100644
>> --- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
>> +++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
>> @@ -32,11 +32,28 @@ properties:
>>    reset-gpios:
>>      maxItems: 1
>>  
>> +  awinic,audio-channel:
>> +    description:
>> +      It is used to distinguish multiple PA devices, so that different
>> +      configurations can be loaded to different PA devices
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 7
>> +
>> +  awinic,sync-flag:
>> +    description:
>> +      Flag bit used to keep the phase synchronized in the case of multiple PA
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 1
>> +
>>  required:
>>    - compatible
>>    - reg
>>    - '#sound-dai-cells'
>>    - reset-gpios
>> +  - awinic,audio-channel
>> +  - awinic,sync-flag
>>  
>>  unevaluatedProperties: false
>>  
>> @@ -51,5 +68,7 @@ examples:
>>              reg = <0x34>;
>>              #sound-dai-cells = <0>;
>>              reset-gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
>> +            awinic,audio-channel = <0>;
>> +            awinic,sync-flag = <0>;
>>          };
>>      };
>> -- 
>> 2.41.0
>>
