Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963027927BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbjIEQKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353685AbjIEHOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:14:09 -0400
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EBBCC2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:14:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1722883|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00741336-0.000123443-0.992463;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.UXwp7q2_1693898037;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.UXwp7q2_1693898037)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 15:14:00 +0800
From:   wangweidong.a@awinic.com
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, perex@perex.cz,
        tiwai@suse.com, wangweidong.a@awinic.com, yijiangtao@awinic.com
Subject: Re: [PATCH 3/3] ASoC: aw88395: drop undocumented and unused sound-channel property
Date:   Tue,  5 Sep 2023 15:13:56 +0800
Message-ID: <20230905071356.18301-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <3ff94d4b-7585-d7ed-9736-ba4c02b3fcff@linaro.org>
References: <3ff94d4b-7585-d7ed-9736-ba4c02b3fcff@linaro.org>
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

Thank you very much for your reply.=0D
=0D
On 05/09/2023 15:05, krzysztof.kozlowski@linaro.org wrote:=0D
> On 05/09/2023 04:46, wangweidong.a@awinic.com wrote:=0D
=0D
>>> Even though it does not look like from the diff, the property is not=0D
>>> actually used by the driver, because once set, it is read only in loops=
=0D
>>> depending on ddt_num (prof_hdr->ddt_num, cfg_hdr->ddt_num).  The=0D
>>> variable ddt_num is never set and is always 0, so the loops do not have=
=0D
>>> any iteration.  Dropping sound-channel and ddt_num-related loops allows=
=0D
>>> to drop empty functions which in turn drop quite a lot of code.  This=0D
>>> entire code was not possible to execute. =0D
>> =0D
>> The ddt_num variable is not always 0, this variable is defined=0D
>> in the configuration file. The "prof_hdr" variable is assigned by =0D
>> the "cfg_hdr" variable. The "cfg_hdr" variable is assigned by "aw_cfg"=0D
>> aw_cfg is the data obtained through request_firmware.The specific =0D
>> process is as follows:=0D
>> =0D
>> request_firmware ---> cont->data ---> aw_cfg->data --> cfg_hdr --> prof_=
hdr=0D
=0D
> Hm. So you load user-space provided file and assign it directly, without=
=0D
> any validation (aw88395_dev_load_acf_check() checks only for magic), to=0D
> a kernel structure. Sounds bullet-proof. Why using known kernel=0D
> interfaces, better to implement some conf-file-parsing.=0D
=0D
Could you please tell me what known kernel interfaces =0D
can be used to parse files? =0D
Thank you very much=0D
=0D
Best regards,=0D
Weidong Wang=
