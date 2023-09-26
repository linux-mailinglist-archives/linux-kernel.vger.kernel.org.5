Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E627AE667
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjIZHFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjIZHE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:04:59 -0400
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34296FB;
        Tue, 26 Sep 2023 00:04:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1404606|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0212173-0.00065658-0.978126;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.UogDhTS_1695711876;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.UogDhTS_1695711876)
          by smtp.aliyun-inc.com;
          Tue, 26 Sep 2023 15:04:45 +0800
From:   wangweidong.a@awinic.com
To:     broonie@kernel.org
Cc:     13916275206@139.com, alsa-devel@alsa-project.org, arnd@arndb.de,
        ckeepax@opensource.cirrus.com, colin.i.king@gmail.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        harshit.m.mogalapalli@oracle.com, herve.codina@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        liweilei@awinic.com, perex@perex.cz, povik+lin@cutebit.org,
        rf@opensource.cirrus.com, robh+dt@kernel.org, ryans.lee@analog.com,
        shumingf@realtek.com, tiwai@suse.com, trix@redhat.com,
        u.kleine-koenig@pengutronix.de, wangweidong.a@awinic.com,
        yang.lee@linux.alibaba.com, yijiangtao@awinic.com
Subject: Re: [PATCH V4 4/7] ASoC: codecs: Add code for bin parsing compatible with aw87390
Date:   Tue, 26 Sep 2023 15:04:30 +0800
Message-ID: <20230926070436.486530-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZRGT2oLQaJBVVYFH@finisterre.sirena.org.uk>
References: <ZRGT2oLQaJBVVYFH@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your review, but there's something I'd like to discuss with you

On Mon, Sep 25, 2023 at 16:06:18 +0200, broonie@kernel.org wrote:
> On Tue, Sep 19, 2023 at 06:57:21PM +0800, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 
>> Add aw87390 compatible code to the aw88395_lib.c file
>> so that it can parse aw87390's bin file
>> Modify the function return value

> This breaks an x86 allmodconfig build:

> /build/stage/linux/sound/soc/codecs/aw88395/aw88395.c: In function ‘aw88395_prof
> ile_info’:
> /build/stage/linux/sound/soc/codecs/aw88395/aw88395.c:199:21: error: too few arg
> uments to function ‘aw88395_dev_get_prof_name’
>  199 |         prof_name = aw88395_dev_get_prof_name(aw88395->aw_pa, count);
>      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /build/stage/linux/sound/soc/codecs/aw88395/aw88395.c:17:
> /build/stage/linux/sound/soc/codecs/aw88395/aw88395_device.h:184:5: note: declar
> ed here
>  184 | int aw88395_dev_get_prof_name(struct aw_device *aw_dev, int index, char 
> **prof_name);
>      |     ^~~~~~~~~~~~~~~~~~~~~~~~~

I did not get this error when compiling base on "2cf0f715623872823a72e451243bbf555d10d032"
and the changes to this function are already in [patch V4 3/7]
Can you tell me how to modify it?

Best regards,
Weidong Wang

