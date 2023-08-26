Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665BE789938
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 23:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjHZVNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 17:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjHZVNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 17:13:09 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301C010A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:13:05 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id a0abqZrV1DlJea0abq57Aj; Sat, 26 Aug 2023 23:13:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693084382;
        bh=xbL88xDGbRjdox9sHNbVsz1K4Rs691eTCqMLK3X/0TM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PFyw5u66DNtz1PsMVVwmdocS8cfwl/siahnsEKJUckSHqVKKdYNRNrc41bEO9uqHg
         VNYvksCW4Gr7/pzvgUqxVsEcNciyDcN/h7/y42PnSyxtGWMiws95s/Skk2Bjfs4LHZ
         iGi4SPGwr6pxEH0LI4+uQPAzaFisKYjxZahl1alkokiGgg8FGpU+Fy5MGRDI1D5Oma
         pGFg8Hfxa5u5QI6CFtxVv445f2/CB4G/jDbLkhif5c0UvarTYfwCn+CRgTsuEz5MZg
         JeRWj/E4KL9WZ8ZbENGxPxcEmfxPEVgn23jwRKOAFgKrmJpSZFGJSYp4aMMrLlXPg+
         9Nz0sq+zeIqUg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Aug 2023 23:13:02 +0200
X-ME-IP: 86.243.2.178
Message-ID: <b35c9f99-bdbc-6d7c-e7bd-0971fe72ccf2@wanadoo.fr>
Date:   Sat, 26 Aug 2023 23:13:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] HID: nvidia-shield: Introduce thunderstrike_destroy()
Content-Language: fr
To:     kernel test robot <lkp@intel.com>, rrameshbabu@nvidia.com,
        jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <4c9a8c7f6b4eb879dd7ef4d44bb6a80b3f126d25.1693070958.git.christophe.jaillet@wanadoo.fr>
 <202308270307.EDe7t62T-lkp@intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <202308270307.EDe7t62T-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/08/2023 à 22:00, kernel test robot a écrit :
> Hi Christophe,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on linux-next/master]
> [cannot apply to linus/master v6.5-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-JAILLET/HID-nvidia-shield-Fix-a-missing-led_classdev_unregister-in-the-probe-error-handling-path/20230827-014602
> base:   linux-next/master
> patch link:    https://lore.kernel.org/r/4c9a8c7f6b4eb879dd7ef4d44bb6a80b3f126d25.1693070958.git.christophe.jaillet%40wanadoo.fr
> patch subject: [PATCH 3/3] HID: nvidia-shield: Introduce thunderstrike_destroy()
> config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230827/202308270307.EDe7t62T-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 13.2.0

On x86_64, gcc 12.3.0 does not complain. :(

Let see first if there is some comment on the serie, then I'll send a v2 
to fix the warning.

CJ

> reproduce: (https://download.01.org/0day-ci/archive/20230827/202308270307.EDe7t62T-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308270307.EDe7t62T-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     drivers/hid/hid-nvidia-shield.c: In function 'shield_probe':
>>> drivers/hid/hid-nvidia-shield.c:1046:31: warning: variable 'ts' set but not used [-Wunused-but-set-variable]
>      1046 |         struct thunderstrike *ts;
>           |                               ^~
> 
> 
> vim +/ts +1046 drivers/hid/hid-nvidia-shield.c
> 
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1042
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1043  static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1044  {
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1045  	struct shield_device *shield_dev = NULL;
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08 @1046  	struct thunderstrike *ts;
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1047  	int ret;
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1048
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1049  	ret = hid_parse(hdev);
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1050  	if (ret) {
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1051  		hid_err(hdev, "Parse failed\n");
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1052  		return ret;
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1053  	}
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1054
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1055  	switch (id->product) {
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1056  	case USB_DEVICE_ID_NVIDIA_THUNDERSTRIKE_CONTROLLER:
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1057  		shield_dev = thunderstrike_create(hdev);
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1058  		break;
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1059  	}
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1060
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1061  	if (unlikely(!shield_dev)) {
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1062  		hid_err(hdev, "Failed to identify SHIELD device\n");
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1063  		return -ENODEV;
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1064  	}
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1065  	if (IS_ERR(shield_dev)) {
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1066  		hid_err(hdev, "Failed to create SHIELD device\n");
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1067  		return PTR_ERR(shield_dev);
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1068  	}
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1069
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1070  	ts = container_of(shield_dev, struct thunderstrike, base);
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1071
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1072  	ret = hid_hw_start(hdev, HID_CONNECT_HIDINPUT);
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1073  	if (ret) {
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1074  		hid_err(hdev, "Failed to start HID device\n");
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1075  		goto err_haptics;
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1076  	}
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1077
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1078  	ret = hid_hw_open(hdev);
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1079  	if (ret) {
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1080  		hid_err(hdev, "Failed to open HID device\n");
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1081  		goto err_stop;
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1082  	}
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1083
> 3ab196f882377ed Rahul Rameshbabu   2023-08-07  1084  	thunderstrike_device_init_info(shield_dev);
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1085
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1086  	return ret;
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1087
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1088  err_stop:
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1089  	hid_hw_stop(hdev);
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1090  err_haptics:
> 2cc4637842495c6 Christophe JAILLET 2023-08-26  1091  	thunderstrike_destroy(hdev);
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1092  	return ret;
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1093  }
> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1094
> 

