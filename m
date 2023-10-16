Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158EB7CA38C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJPJIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJPJIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:08:10 -0400
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB89AAB;
        Mon, 16 Oct 2023 02:08:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06892163|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.023128-0.00177961-0.975092;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=26;RT=26;SR=0;TI=SMTPD_---.V08HDja_1697447275;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.V08HDja_1697447275)
          by smtp.aliyun-inc.com;
          Mon, 16 Oct 2023 17:08:03 +0800
From:   wangweidong.a@awinic.com
To:     wangweidong.a@awinic.com
Cc:     13916275206@139.com, alsa-devel@alsa-project.org, arnd@arndb.de,
        broonie@kernel.org, ckeepax@opensource.cirrus.com,
        colin.i.king@gmail.com, conor+dt@kernel.org,
        dan.carpenter@linaro.org, devicetree@vger.kernel.org,
        fido_max@inbox.ru, herve.codina@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        liweilei@awinic.com, perex@perex.cz, rf@opensource.cirrus.com,
        robh+dt@kernel.org, ryans.lee@analog.com,
        sebastian.reichel@collabora.com, shumingf@realtek.com,
        tiwai@suse.com, trix@redhat.com, yijiangtao@awinic.com
Subject: Re: [PATCH V1 3/3] ASoC: codecs: Add aw88399 amplifier driver
Date:   Mon, 16 Oct 2023 17:07:54 +0800
Message-ID: <20231016090754.64363-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016081017.46963-1-wangweidong.a@awinic.com>
References: <20231016081017.46963-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm very sorry that I misunderstood my last comment, correct it here.=0D
Thank you again for you hard review.=0D
=0D
On Mon, Oct 16, 2023 at 16:10:17 +0800, wangweidong.a@awinic.com wrote=0D
> On Fri, Oct 13, 2023 at 03:10:56 PM +0100, broonie@kernel.org wrote:=0D
>> On Fri, Oct 13, 2023 at 06:42:20PM +0800, wangweidong.a@awinic.com wrote=
:=0D
=0D
>> This looks good - some *very* minor comments below.=0D
=0D
=0D
>>> +static int aw_dev_dsp_update_container(struct aw_device *aw_dev,=0D
>>> +			unsigned char *data, unsigned int len, unsigned short base)=0D
>>> +{=0D
>>> +	int i, ret;=0D
>>> +=0D
>>> +#ifdef AW88399_DSP_I2C_WRITES=0D
>>> +	u32 tmp_len;=0D
=0D
>> This looks like debug code which can hopefully be removed in favour of=0D
>> the regmap implementation?=0D
=0D
> Thank you very much, but this is not a debugging statement, This is desig=
ned=0D
> to be compatible with different platforms that may not support continuous=
=0D
> writing.=0D
=0D
I found "use_single_write" in regmap, I will remove "AW88399_DSP_I2C_WRITES=
".=0D
=0D
Best regards,=0D
Weidong Wang=0D
