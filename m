Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55AE7F1C25
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjKTSTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKTSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:19:37 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3162DB9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:19:34 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40838915cecso18682315e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700504372; x=1701109172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkMvHwzXha8iL76L0Ewto8Z1j8l4Dl9NfZnV40iU1Vk=;
        b=Ix/CFrpMBeaKeodHBwdMN5PTa3F/4Xqxlq7fsUSHlhz4XoZwd2Z/Dd/qposYw1MuaK
         hVDrkthBOtFPdrydWE9xKSUfyZ9UXVOVkJOthlByam1OpOX9kbmZjFAGv1itZg6ubITt
         MfIJx2idWX85lW2l7WamA3jGeiY4JEIA408YoO0ZQQYOMBhInqmUVuXBWZNQQYrcGeRu
         cvFCu6c2c3lBOlvJr7LDrW3oXwVtgJde+k0Uc0k4o5afZotENAn9Hyy1aK1/g0WVU2ei
         L5+TDP5vVLdUNJiMIfOUGCwdU/eh7c4bOOmG3GYZlpcGOkSnAlJPMKK67BAWdOLwurOV
         3rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700504372; x=1701109172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkMvHwzXha8iL76L0Ewto8Z1j8l4Dl9NfZnV40iU1Vk=;
        b=F4V5PoPhYzvnYBAE97yV8NREcu69VPlKdDj0ePJu8d66C2biL2OgMy8qcF4aa23WRW
         ptlKjMZFCaD7xh88nW8cva5UT/PqoEF0ccK+w1L1FOL2iUrgLHrPgy+/37UsyGPhoSMH
         a7+cI6M7FU42nZQUAHgtWU3lpokPRtM1x16SiUVOyWzwsT2Uv24B9mRQazH7gl+juMpW
         1gveBCj93vTi0Dg1tPLDYRaQIDe34N9gFY94w0zE65u4sondX2AKKgWsg0FDDJKKpURe
         sSmjJfC9wToHnaFdYRTf3gjQ6GpUIGyfPCp2cLXpvOLZPCOfe7+SAPoAy2Hlk+FfL1Qn
         4ZrQ==
X-Gm-Message-State: AOJu0YxArwKUOuGDnONqox30fJQhjda4DExaM0PH6ei/3bC99ShIyGnh
        h9gREwZfEnRs1ZevxW/RU1I=
X-Google-Smtp-Source: AGHT+IEnVfPw74ig/4qTXakahTi/NeSKUczI4iDonGWjSgvVpKmp6zO81CICEUiRn86tfO1+c4SfxA==
X-Received: by 2002:a05:600c:4e87:b0:401:bcd9:4871 with SMTP id f7-20020a05600c4e8700b00401bcd94871mr6395663wmq.21.1700504372119;
        Mon, 20 Nov 2023 10:19:32 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c470600b0040a5290dceesm14553760wmo.0.2023.11.20.10.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 10:19:31 -0800 (PST)
Message-ID: <f7500671-812d-42ab-a16e-3325e13324ff@gmail.com>
Date:   Mon, 20 Nov 2023 19:19:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/firmware/qcom/qcom_scm.c:1652:34: warning: unused
 variable 'qcom_scm_qseecom_allowlist'
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     llvm@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
References: <202311191654.S4wlVUrz-lkp@intel.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <202311191654.S4wlVUrz-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/23 10:13, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   037266a5f7239ead1530266f7d7af153d2a867fa
> commit: bdac188ec3c71800dd8419620224ee74ef37732a firmware: qcom: move Qualcomm code into its own directory
> date:   4 weeks ago
> config: s390-randconfig-002-20231119 (https://download.01.org/0day-ci/archive/20231119/202311191654.S4wlVUrz-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311191654.S4wlVUrz-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311191654.S4wlVUrz-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

[...]

>>> drivers/firmware/qcom/qcom_scm.c:1652:34: warning: unused variable 'qcom_scm_qseecom_allowlist' [-Wunused-const-variable]
>      1652 | static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
>           |                                  ^

Any ideas why this is supposedly unused? It should be accessed through
qcom_scm_qseecom_init() and qcom_scm_qseecom_machine_is_allowed().
Especially if CONFIG_QCOM_QSEECOM=y.

>     13 warnings generated.
> 
> 
> vim +/qcom_scm_qseecom_allowlist +1652 drivers/firmware/qcom/qcom_scm.c
> 
> 00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1647
> 00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1648  /*
> 00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1649   * We do not yet support re-entrant calls via the qseecom interface. To prevent
> 00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1650   + any potential issues with this, only allow validated machines for now.
> 00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1651   */
> 00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27 @1652  static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
> 00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1653  	{ .compatible = "lenovo,thinkpad-x13s", },
> 00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1654  	{ }
> 00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1655  };
> 00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1656
> 
> :::::: The code at line 1652 was first introduced by commit
> :::::: 00b1248606ba3979ccae30ed11df8cdc1a84245a firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface
> 
> :::::: TO: Maximilian Luz <luzmaximilian@gmail.com>
> :::::: CC: Bjorn Andersson <andersson@kernel.org>
> 

Regards
Max
