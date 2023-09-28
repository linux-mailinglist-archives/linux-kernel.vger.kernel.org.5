Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF77B1372
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjI1G7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1G7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:59:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06B2B7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:59:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40566f8a093so95203035e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695884353; x=1696489153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxtdkWUQyRUGTWll+i5PkjZHj3/ZutnR3Ko0Ft8Vpf4=;
        b=cHWb7Q0X2rRfjh4LpqywXlpBBmOLku5nUK8F9Kk+CJyt5yfE7i4Qv4q/6/ITe87EeJ
         8civ/5e2ldG7bCHJMdzJyc6yoVohBt5UpOIiJADA24NaQA+5sClB3rztOAYn3iS7XHD6
         sfiUQDZ+agai70UpFpbjPBc13ojMT1sb2dRZE2r5a0oJOV6HHco8pueFAu97MYCRPehO
         4UhtZUF2MdjwkaHF9pxjD9nojkZmvFNi2bNaBkEPgaEEFZqjbnlkkw7u66cjLbXDeKQe
         wId9Ckxe9Xc0cvwmR7j2sa02Q+LLC7WvaJZIFL+b0CWjxilj4eR4nEvLv4gLk5ZKSwS4
         yv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695884353; x=1696489153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxtdkWUQyRUGTWll+i5PkjZHj3/ZutnR3Ko0Ft8Vpf4=;
        b=c5VkBxT5GLLxjsTmx5LSI942/LbaavUmMdZ2aJCDVgh5CdSNopPq2Rglww0+stNSyM
         UpYcs17HmO3w4YL6gmlGKBNSe9RRHBSpCloV/8mgXidi26FYPGE4hMkspxEmkrVVr5fB
         O6rYSUV+hq8xm8wsSbCkg9xh3BBAB8kQ1gMw4wI1swTi5XrEvNAb3sqSX8I8fmrudb4y
         u/vLow/t1XLnabNGjrwj7dCUigGM9d1dtEFwLt5VSDi0NsHsfROqCXJ+su2HjwJb7rwv
         11FXaRykBw9xWozehiBw7kBi8s6mKKySziNAr2IwuBIh0oiVIj8j03p8EzjnJGhe12h/
         34qQ==
X-Gm-Message-State: AOJu0Yz5EgEVLan22jd5l4ZYL5bLeytdXZkMS5t1m7NGJgL5TiWkn+aC
        elB/2l1UakRnjNAhmW73Jh32WQ==
X-Google-Smtp-Source: AGHT+IGKeFwM5Om0OMVfRkBh1YdUioiRAuzKQMZJEqVhiuiiZ7tZD589pp+o//kNbzitL+JePrtmtw==
X-Received: by 2002:a05:600c:3b22:b0:406:5303:9be2 with SMTP id m34-20020a05600c3b2200b0040653039be2mr304954wms.0.1695884353220;
        Wed, 27 Sep 2023 23:59:13 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c220400b003fe61c33df5sm6326296wml.3.2023.09.27.23.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 23:59:12 -0700 (PDT)
Date:   Thu, 28 Sep 2023 09:59:10 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     wangweidong.a@awinic.com
Cc:     13916275206@139.com, alsa-devel@alsa-project.org, arnd@arndb.de,
        broonie@kernel.org, ckeepax@opensource.cirrus.com,
        colin.i.king@gmail.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, doug@schmorgal.com, fido_max@inbox.ru,
        harshit.m.mogalapalli@oracle.com, herve.codina@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        liweilei@awinic.com, perex@perex.cz, rf@opensource.cirrus.com,
        robh+dt@kernel.org, ryans.lee@analog.com, shumingf@realtek.com,
        tiwai@suse.com, trix@redhat.com, u.kleine-koenig@pengutronix.de,
        yang.lee@linux.alibaba.com, yijiangtao@awinic.com
Subject: Re: [PATCH V5 8/8] ASoC: codecs: Add aw87390 amplifier driver
Message-ID: <71f6bff0-c173-4de2-aed0-38ed2c15ec59@kadam.mountain>
References: <464ada20-072d-48f8-a270-155dfd4a06b9@kadam.mountain>
 <20230928064330.104265-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928064330.104265-1-wangweidong.a@awinic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 02:43:30PM +0800, wangweidong.a@awinic.com wrote:
> Thank you very much for your review, but I have some questions
> I would like to discuss with you
> 
> > On Wed, Sep 27, 2023 at 08:16:34PM +0800, wangweidong.a@awinic.com wrote:
> >> @@ -668,6 +668,17 @@ config SND_SOC_AW88261
> >>  	  boost converter can be adjusted smartly according to
> >>  	  the input amplitude.
> >>  
> >> +config SND_SOC_AW87390
> >> +	tristate "Soc Audio for awinic aw87390"
> 
> > Capitalize A in Awinic.
> 
> Thank you very much, but our company prefers to 
> use awinic rather than Awinic

Ah.  Fine.  I did Google the company name but hadn't scrolled down
far enough.

regards,
dan carpenter

