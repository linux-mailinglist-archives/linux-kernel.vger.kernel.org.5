Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027DD7789AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjHKJ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHKJ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:27:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343D1110
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:27:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31963263938so57676f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691746028; x=1692350828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HiiPZRiRzU5z3V6WNTKJi57k653b1q2ga5F/rGJUmkI=;
        b=if/g39PkuJXL4G7+WFtDSsKJJNrNJqnBRZVPr6d/rMRq0YW6QrwXtNDOPn6B76N8GF
         fGBZgMgBY8jskfyACSnAJrm51lyBB2eapCCxKcdV3Rq/gaXFaf2dxIrlxsNAb4wl4VEs
         7EC4t8rh9UrMNN+v3pp5SLrjSoVuq94unUahgK6OhBFwukHkoltKjLvIKEseXI7/t05b
         3wvYpoI3Iu/MkMkhdmBJuppcaKP3NTsxqSs603gw4EVbjqLirqGgAqBF76SJUG8D02wX
         TV74XuD9wpVoWxIBXGay/y3OZcgvrCIkTXrn9iwZzUmRLbkwznDqztY6MVj5elzrmCIj
         9wMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691746028; x=1692350828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiiPZRiRzU5z3V6WNTKJi57k653b1q2ga5F/rGJUmkI=;
        b=QKdrghWrFRgkTryhn4Rs4dvW2BVSdTUM7EUUiRlrz9POKydtueNHDVwbCO6t867jp1
         5BY8YinvKcZK0x57sJQRvLvu6nutUrlHeHUdkU68+VVBicQVBgPKtg3UM7pBxkhHR89L
         aIqVlB3PCPyjT+/kxGiopvWoVHiRNqJYd3WkJRIZHEWGpasdP42k//tYMMJTQdw8pOhK
         z5Jm9WCu0RnvSz5CGjxpo+PBHCnbdqjoxKSf1w1nLrOLmEj4lX66Ak3zbNuNxSTsqvIC
         9xUuGtjaGzq+LvlOHijB4EK+8gebJYhgV3jShGpsWIHybfdDQtjigZdL7Jt9rubFx2rY
         0apA==
X-Gm-Message-State: AOJu0YwiCEyvzUkJDIbOYNizlZiTZlc+dYQOA5LPLkSs1GFHuEHsVfir
        lU4jU3hZt3G/0yZPJ9IdIqYQgg==
X-Google-Smtp-Source: AGHT+IGF4VkLa8vnov8mA5x3rBQPdUG/1weXUzQTvDvE1p5kFCbq/YBqc0nXch2B1oMJKb88hPTA1g==
X-Received: by 2002:adf:fdd0:0:b0:317:576c:285 with SMTP id i16-20020adffdd0000000b00317576c0285mr991576wrs.7.1691746027727;
        Fri, 11 Aug 2023 02:27:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d4d42000000b00317ca89f6c5sm4809507wru.107.2023.08.11.02.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 02:27:07 -0700 (PDT)
Date:   Fri, 11 Aug 2023 12:26:58 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: etm4x: Ensure valid drvdata and clock before
 clk_put()
Message-ID: <201aae70-c555-45ce-9944-f8645feb54f6@kadam.mountain>
References: <20230811062738.1066787-1-anshuman.khandual@arm.com>
 <07b0dabb-5409-9ba8-543f-aeecafe083e9@arm.com>
 <72960b11-9e35-a259-3ea6-bae91ff94838@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72960b11-9e35-a259-3ea6-bae91ff94838@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:09:43AM +0100, Suzuki K Poulose wrote:
> On 11/08/2023 09:39, James Clark wrote:
> > 
> > 
> > On 11/08/2023 07:27, Anshuman Khandual wrote:
> > > This validates 'drvdata' and 'drvdata->pclk' clock before calling clk_put()
> > > in etm4_remove_platform_dev(). The problem was detected using Smatch static
> > > checker as reported.
> > > 
> > > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Cc: James Clark <james.clark@arm.com>
> > > Cc: coresight@lists.linaro.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes: https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/G4N6P4OXELPLLQSNU3GU2MR4LOLRXRMJ/
> > > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > > ---
> > > This applies on coresight-next
> > > 
> > >   drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > index 703b6fcbb6a5..eb412ce302cc 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > @@ -2269,7 +2269,7 @@ static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
> > >   		etm4_remove_dev(drvdata);
> > >   	pm_runtime_disable(&pdev->dev);
> > > -	if (drvdata->pclk)
> > > +	if (drvdata && drvdata->pclk && !IS_ERR(drvdata->pclk))
> > >   		clk_put(drvdata->pclk);
> > >   	return 0;
> > 
> > It could be !IS_ERR_OR_NULL(drvdata->pclk), but I wouldn't bother
> > changing it at this point.
> 
> +1, please could we have that. Someone else will run a code scanner and
> send a patch later. Given this is straight and easy change, lets do it
> in the first place.

drvdata->pclk can't actually be an error pointer.  probe() will
correctly not allow that.  All the IS_ERR(drvdata->pclk) checks should
be removed except for the first check in probe().

There is also no need to check "drvdata->pclk" for NULL because
clk_put() accepts NULL pointers.  (Returning NULL means the clk
subsystem has been disabled deliberately).

Also drvdata can't actually be NULL either.

regards,
dan carpenter

