Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961E0768F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjGaHnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjGaHnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:43:14 -0400
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F7583;
        Mon, 31 Jul 2023 00:43:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0779505|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0237288-0.000924996-0.975346;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=26;RT=26;SR=0;TI=SMTPD_---.U4fOa9R_1690789380;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.U4fOa9R_1690789380)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 15:43:03 +0800
From:   wangweidong.a@awinic.com
To:     krzysztof.kozlowski@linaro.org
Cc:     13916275206@139.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, ckeepax@opensource.cirrus.com,
        colin.i.king@gmail.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, doug@schmorgal.com, fido_max@inbox.ru,
        herve.codina@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        liweilei@awinic.com, perex@perex.cz, povik+lin@cutebit.org,
        rf@opensource.cirrus.com, robh+dt@kernel.org, ryans.lee@analog.com,
        shumingf@realtek.com, tiwai@suse.com, trix@redhat.com,
        wangweidong.a@awinic.com, yijiangtao@awinic.com,
        zhangjianming@awinic.com
Subject: Re: [PATCH V3 4/5] ASoC: codecs: aw88261 device related operation functions
Date:   Mon, 31 Jul 2023 15:43:00 +0800
Message-ID: <20230731074300.6200-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <be25dead-89f0-8859-d182-84754ad8bfc0@linaro.org>
References: <be25dead-89f0-8859-d182-84754ad8bfc0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your advice

On 31/07/2023 08:51, krzysztof.kozlowski@linaro.org wrote:
> On 31/07/2023 08:41, wangweidong.a@awinic.com wrote:
>> 
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int aw88261_dev_init(struct aw88261_device *aw_dev, struct aw_container *aw_cfg)
>> 
>>> You already used this function in patch #3, so your order of patches is
>>> confusing.
>> 
>> Do I need to change the order of patch? 
>> Do I neeed to put aw88261_device.c aw88261_device.h in patch #3 and 
>> put aw88261.c aw88261.h in patch #4?
>> Is that how you change the order?

> Your patchset should be logically ordered, so first you add bindings
> (because it must be before their users), then you one piece, then other
> etc. I understand that only the last patch will make everything
> buildable, but still code should be added before its user/caller.

Thank you very much for your suggestion. 
Do I need to keep the Makefile and kconfig files in a separate patch?

...

>> 
>>>> +
>>>> +	switch (chip_id) {
>>>> +	case AW88261_CHIP_ID:
>>>> +		ret = aw_dev_init((*aw_dev));
>>>> +		break;
>>>> +	default:
>>>> +		ret = -EINVAL;
>>>> +		dev_err((*aw_dev)->dev, "unsupported device");
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +MODULE_DESCRIPTION("AW88261 device");
>>>> +MODULE_LICENSE("GPL v2");
>> 
>>> Wait, is this a module? Does not look complete. I already saw one
>>> module, so what is this for? For which module?
>> 
>> Can it be changed to MODULE_DESCRIPTION("AW88261 device lib")?

> If this is a module, then it can. If this is not a module, then why
> would you ever like to do it?

>> The function in the aw88261_device.c file, which I used in the aw88261.c file.

> Functions are not modules.

Thank you very much for your suggestion. 
I will delete MODULE_DESCRIPTION and MODULE_LICENSE

Best regards,
Weidong Wang
