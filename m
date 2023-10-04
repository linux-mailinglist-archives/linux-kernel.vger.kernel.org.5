Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E4E7B7752
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 07:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbjJDFEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 01:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjJDFEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 01:04:36 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E189A9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 22:04:33 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57bc2c2f13dso958612eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 22:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696395872; x=1697000672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3bM6BmB8wAop4fny1ZIpU594pRuUpRgSdB0G5Toy4g=;
        b=q9wtgqhTh18IJ5CuiCtKf6oGiVQAArD9A33ybLLlpgdG3vz1BnYL53VlFTKPztU4RM
         jgmJrDnMylOWqerQSIHl3UuaJMdlFk6wAM0y8AVFRyCaxVkzygANqfLB4dkdf6BgNo9G
         AUJElCyuBrb+tuNgD+C0VfapVZ/W/5Ivr89KMuPPiiT5yfD7xw9wfbVH1dZYEoTs/bDZ
         mld8VQF/oRJxDMpBLDvFK5SFzlO/Kn8Hnl8t2nYGgxzoKhMj/6v+Kp3i0uvRD7DmQOch
         8crVNNQ4iUYnRXsHPC0meGYJDKH+VnmwNUHZsAV4yMvPFhlaxbfc3XE8WYVNEd/1vGal
         Ztog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696395872; x=1697000672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3bM6BmB8wAop4fny1ZIpU594pRuUpRgSdB0G5Toy4g=;
        b=A42F9Nv+cERVOCGl3J2CZSFno9gyrZVFm/WBBBUHz56JDIAp2QkyorHZ5CTFlubC+f
         iHhK1bo4AdOCVfLikggclJMyBb9E3y4dKDAZAczOLhmhU/pp+65+2YjPxAhyBpa7ErS0
         7jp3eS315id3/fY1/+XK1nKBwDs8ISMGMRBWhNj3+wYqQFvGTtro55PItzwHVfPmE1oo
         eNUTYIu3o0xWs6M1QiuxGZXl9pjsQEjDjm3M3aXAC0q+YGQN62IseA9Da84L8S35+QqC
         ZP9pWxcp4qadsB8h5JpZTAW0s651q9LIOjDXgGY4DmKGaFXoYLFOLDcfjbgC1Lz1K4Ec
         c+Qw==
X-Gm-Message-State: AOJu0YwOQCqfQvpxSlJ3bCuobwyf0BJB8af8JLvRHDG6WVoa3/7gBCIj
        e+46rGb9VRkmYK/RXY79Agt3mw==
X-Google-Smtp-Source: AGHT+IF23zh9SbVmd0VAAnw6RBISSm2ywZgi1InnMQWlvBzNdoiIsiLQlTKM6OKPmbvX/SzgVROxCw==
X-Received: by 2002:a05:6358:3408:b0:14f:852b:4362 with SMTP id h8-20020a056358340800b0014f852b4362mr1453217rwd.19.1696395872289;
        Tue, 03 Oct 2023 22:04:32 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id b18-20020a637152000000b005789cbd2cacsm2327910pgn.20.2023.10.03.22.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 22:04:31 -0700 (PDT)
Date:   Wed, 4 Oct 2023 10:34:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] OPP: Extend support for the opp-level beyond
 required-opps
Message-ID: <20231004050427.e3aalotrtpvld6rk@vireshk-i7>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
 <20230925131715.138411-7-ulf.hansson@linaro.org>
 <CAPDyKFo+XCEtTSNqtA1SeajWo4tuRroA4GrRegta5TsqSGd4eQ@mail.gmail.com>
 <20231003082322.cmok766jxzftsgrg@vireshk-i7>
 <CAPDyKForAJfdqqpkAP0vwZFAtSAtGMyqChLVr96v7PDWRj2qzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKForAJfdqqpkAP0vwZFAtSAtGMyqChLVr96v7PDWRj2qzw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-10-23, 14:36, Ulf Hansson wrote:
> Can you please explain further on this. Rafael has acked those
> patches, so it should be perfectly fine for you to pick them via your
> tree too. There is no need to defer them.

Ahh, then it is fine.

> > I will then push out a branch and you can
> > rebase your patches on top of it ? And then probably Sudeep or someone else can
> > apply everything ?
> 
> Or are you suggesting to just take one of the patches from my series,
> and then I will re-base everything on top?
> 
> Just trying to understand the way forward. :-)

Applied patches 1-6/9 and the fixed routine looks like this now:

+static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
+                         struct dev_pm_opp *opp)
+{
+       unsigned int level = 0;
+       int ret = 0;
+
+       if (opp) {
+               if (!opp->level)
+                       return 0;
+
+               level = opp->level;
+       }
+
+       /* Request a new performance state through the device's PM domain. */
+       ret = dev_pm_domain_set_performance_state(dev, level);
+       if (ret)
+               dev_err(dev, "Failed to set performance state %u (%d)\n", level,
+                       ret);
+
+       return ret;
+}

Does it look okay now ?

-- 
viresh
