Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DF179E163
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbjIMIDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbjIMIDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:03:32 -0400
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36469D3;
        Wed, 13 Sep 2023 01:03:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1099867|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0935481-0.000793447-0.905658;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=28;RT=28;SR=0;TI=SMTPD_---.Ue3S9t0_1694592196;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Ue3S9t0_1694592196)
          by smtp.aliyun-inc.com;
          Wed, 13 Sep 2023 16:03:24 +0800
From:   wangweidong.a@awinic.com
To:     krzysztof.kozlowski@linaro.org
Cc:     13916275206@139.com, alsa-devel@alsa-project.org, arnd@arndb.de,
        broonie@kernel.org, ckeepax@opensource.cirrus.com,
        colin.i.king@gmail.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, fido_max@inbox.ru,
        harshit.m.mogalapalli@oracle.com, herve.codina@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        liweilei@awinic.com, perex@perex.cz, povik+lin@cutebit.org,
        rf@opensource.cirrus.com, robh+dt@kernel.org, ryans.lee@analog.com,
        sebastian.reichel@collabora.com, shumingf@realtek.com,
        tiwai@suse.com, trix@redhat.com, wangweidong.a@awinic.com,
        yijiangtao@awinic.com
Subject: Re: [PATCH V2 1/5] ASoC: dt-bindings: Adds properties to "awinic,aw88395"
Date:   Wed, 13 Sep 2023 16:03:10 +0800
Message-ID: <20230913080310.364486-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cc6ad994-a3c3-03d6-6095-14e43f105314@linaro.org>
References: <cc6ad994-a3c3-03d6-6095-14e43f105314@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your review, but I have a question that I would lik=
e to consult=0D
=0D
On 13/09/2023 09:03, krzysztof.kozlowski@linaro.org wrote:=0D
> On 12/09/2023 08:58, wangweidong.a@awinic.com wrote:=0D
>> From: Weidong Wang <wangweidong.a@awinic.com>=0D
>> =0D
>> Adds properties to "awinic,aw88395" to make files more complete=0D
>> =0D
>> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>=0D
>> ---=0D
>>  .../bindings/sound/awinic,aw88395.yaml        | 19 +++++++++++++++++++=
=0D
>>  1 file changed, 19 insertions(+)=0D
>> =0D
>> diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml=
 b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml=0D
>> index 4051c2538caf..4965aa4a5370 100644=0D
>> --- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml=0D
>> +++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml=0D
>> @@ -32,11 +32,28 @@ properties:=0D
>>    reset-gpios:=0D
>>     maxItems: 1=0D
>>  =0D
>> +  awinic,audio-channel:=0D
>> +    description:=0D
>> +      It is used to distinguish multiple PA devices, so that different=
=0D
>> +      configurations can be loaded to different PA devices=0D
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0D
>> +    minimum: 0=0D
>> +    maximum: 7=0D
>> +=0D
>> +  awinic,sync-flag:=0D
>> +    description:=0D
>> +      Flag bit used to keep the phase synchronized in the case of multi=
ple PA=0D
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0D
=0D
> Looks like bool, not uint32. If you made it uint32 for some future=0D
> purpose, then the name "flag" is misleading and anyway what would be the=
=0D
> third option here for sync?=0D
=0D
Thank you very much. Can I Change it to "$ref: /schemas/types.yaml#/definit=
ions/bool"?=0D
=0D
Best regards,=0D
Weidong Wang=
