Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40C979E156
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbjIMIAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbjIMIAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:00:35 -0400
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4414B1992;
        Wed, 13 Sep 2023 01:00:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1324828|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00210616-0.000271328-0.997623;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=28;RT=28;SR=0;TI=SMTPD_---.Ue3l8iB_1694592017;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Ue3l8iB_1694592017)
          by smtp.aliyun-inc.com;
          Wed, 13 Sep 2023 16:00:26 +0800
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
Subject: Re: [PATCH V2 4/5] ASoC: codecs: Change the aw88261 variable name and i2c driver name
Date:   Wed, 13 Sep 2023 16:00:17 +0800
Message-ID: <20230913080017.364430-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <3ee11823-a441-b646-bdd7-aedd3a3a55e5@linaro.org>
References: <3ee11823-a441-b646-bdd7-aedd3a3a55e5@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your review.=0D
=0D
On 13/09/2023 09:03, krzysztof.kozlowski@linaro.org wrote:=0D
> On 12/09/2023 08:58, wangweidong.a@awinic.com wrote:=0D
>> From: Weidong Wang <wangweidong.a@awinic.com>=0D
>> =0D
>> Change "sound-channel" to "awinic,audio-channel"=0D
>> Change "aw88261_smartpa" to "aw88261"=0D
=0D
I'll add "This change is for consistency with yaml properties" to the commi=
t message.=0D
=0D
>> -	prof_name =3D aw88261_dev_get_prof_name(aw88261->aw_pa, count);=0D
>> -	if (!prof_name) {=0D
>> +	ret =3D aw88261_dev_get_prof_name(aw88261->aw_pa, count, &prof_name);=
=0D
>> +	if (ret) {=0D
>>  		strscpy(uinfo->value.enumerated.name, "null",=0D
>>  						strlen("null") + 1);=0D
>>  		return 0;=0D
>> @@ -1189,7 +1190,7 @@ static void aw88261_parse_channel_dt(struct aw8826=
1 *aw88261)=0D
>>  	u32 channel_value =3D AW88261_DEV_DEFAULT_CH;=0D
>>  	u32 sync_enable =3D false;=0D
>>  =0D
>> -	of_property_read_u32(np, "sound-channel", &channel_value);=0D
>> +	of_property_read_u32(np, "awinic,audio-channel", &channel_value);=0D
>>  	of_property_read_u32(np, "sync-flag", &sync_enable);=0D
=0D
> What about this?=0D
=0D
This change is to be consistent with the name in the yaml file=0D
=0D
Best regards,=0D
Weidong Wang=
