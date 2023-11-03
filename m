Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D5D7E01D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346409AbjKCKlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjKCKlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:41:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141D31BF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 03:41:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40839807e82so11902655e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 03:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699008097; x=1699612897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qowZcZFtENqdS6RDrZcslmrzRycaDyxxB19iWvX3pwg=;
        b=kwxXzDgEHUufQx6+WHj008hWYewIqAs0ex/GP3sTjG9huQAinA6s8EVtk8Dh/6nIa5
         jF0Vt/SmmZKTCs2RKQGDH3106jl0RiO718NxMih6NECj49pl9H0yBNaAaJzI/xEDq0Dz
         IUp6CGpXOIU5PM6y5Un4BTA0VknDAzvHfPufQN4bxumrItnFdMQCS0rl9mzvjECVSmOZ
         FB+NbYSZxb8pdwmRg1yUP3CHQUEJcM7jS3mDoOki4GD24XYUr3OPZHiLzyiyUN/wBF/f
         KXUJ371UA7cc4YxtuadtVN/AjtAYDC3kckHp59M5he2/ABn62NTb4tPzx5yVgGtbAre+
         jJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699008097; x=1699612897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qowZcZFtENqdS6RDrZcslmrzRycaDyxxB19iWvX3pwg=;
        b=fZ3pfBaEkyvQ6cLqgodc0Q5KNCaR9siEoOD3zEbgt3dni4OAcGg56UW2i6t/oBBwJ7
         i8WhFtj4EeiV8HOrbagKtXYlzt55ws8pAHyLi+XxJ65ztwk6BWcB8XYv0zpWWKpZa+5+
         6Kun2hWvtepfJ+hSXJ3JqYyNEhUgCPjr/d9NN/XOa+5cpZipDEzhsYpPcrqOzZZecUmZ
         2iwZy3UlZ3W4ozQ4dFCyFYEuYx9xHGVqQ4PqzdOUHTbOwck4Urv0teeWCOdMlLWJOOrn
         MRS0+2zrcgpC2Qppuv1iH6EzAv2h54pqefEmskuJGV9RVoLHgU6T0f713Hq5tlR7rZMk
         iPwg==
X-Gm-Message-State: AOJu0YzBEsWoxiLqsVBmKHs7Og6lFumGD2zBaZlvD2JvxrMvpbQXgyR1
        Xl6iguz1eeZ+x5ts8g+WY1m33A==
X-Google-Smtp-Source: AGHT+IEToQcPtMKfYeWsIZl8aMA6w2QZy/uwZAJbZrx8hV9i58pExpzf2x3D7/ECD0OCAdKY5D2kWA==
X-Received: by 2002:a05:600c:358f:b0:405:19dd:ad82 with SMTP id p15-20020a05600c358f00b0040519ddad82mr2800252wmq.16.1699008097331;
        Fri, 03 Nov 2023 03:41:37 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ha7-20020a05600c860700b004080f0376a0sm1950311wmb.42.2023.11.03.03.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 03:41:36 -0700 (PDT)
Date:   Fri, 3 Nov 2023 11:41:35 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     "SongJinJian@hotmail.com" <SongJinJian@hotmail.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "chandrashekar.devegowda@intel.com" 
        <chandrashekar.devegowda@intel.com>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "chiranjeevi.rapolu@linux.intel.com" 
        <chiranjeevi.rapolu@linux.intel.com>,
        "haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
        "m.chetan.kumar@linux.intel.com" <m.chetan.kumar@linux.intel.com>,
        "ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nmarupaka@google.com" <nmarupaka@google.com>,
        "vsankar@lenovo.com" <vsankar@lenovo.com>,
        "danielwinkler@google.com" <danielwinkler@google.com>
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
Message-ID: <ZUTOX0oSCPpdtjJV@nanopsycho>
References: <MEYP282MB2697B33940B6E9F3BA802729BBFBA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB2697B33940B6E9F3BA802729BBFBA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Sep 18, 2023 at 08:56:26AM CEST, SongJinJian@hotmail.com wrote:
>Tue, Sep 12, 2023 at 11:48:40AM CEST, songjinjian@hotmail.com wrote:
>>>Adds support for t7xx wwan device firmware flashing & coredump 
>>>collection using devlink.
>
>>I don't believe that use of devlink is correct here. It seems like a misfit. IIUC, what you need is to communicate with the modem. Basically a communication channel to modem. The other wwan drivers implement these channels in _ctrl.c files, using multiple protocols. Why can't you do something similar and let devlink out of this please?
>
>>Until you put in arguments why you really need devlink and why is it a good fit, I'm against this. Please don't send any other versions of this patchset that use devlink.
>
> Yes, t7xx driver need communicate with modem with a communication channel to modem. 
> I took a look at the _ctrl.c files under wwan directory, it seemed the implementation can be well integrated with QualCommon's modem, if we do like this, I think we need modem firmware change, maybe not be suitable for current MTK modem directly.
> Except for Qualcomm modem driver, there is also an Intel wwan driver 'iosm' and it use devlink to implement firmware flash(https://www.kernel.org/doc/html/latest/networking/devlink/iosm.html), Intel and MTK design and use devlink to do this work on

If that exists, I made a mistake as a gatekeeper. That usage looks
wrong.


> 'mtk_t7xx' driver and I continue to do this work.
>
> I think devlink framework can support this scene and if we use devlink we don't need to develop other flash tools or other user space applications, use upstream devlink commands directly. 

Please don't.


> 
> Thanks.
>>NACK.
