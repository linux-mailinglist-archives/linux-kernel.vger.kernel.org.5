Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6287D63D9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjJYHqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjJYHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:46:02 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64CB44B5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:36:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9b7c234a7so46119165ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219397; x=1698824197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1AcdXM2oNG7X6kDVrsLsHOjBP4fqbkgPzfufbyu9xI=;
        b=Cgh2T62mCUAEsjgnHL5w/47TYSdmGtb18N/ii8XieIUVr7j4iG0Uygj5QW2DbvQsBi
         WoGhXW2trTiA73V6+4iuHa4rYFGS17AzcRcH5iVD/wyErLmFYGPT9mGfpKTicSJLuQ//
         V0mg+QjRFyCrxKwll0pKC4Z5FyyrKdLAg/cCtkHOZuZj7zknnYJu1Y9DOlfbSF6QZA3X
         Iedqjz758oY7Jo2lwkSKLP4H+MuZ8mjb9hkYwtCIeZIKlsAz5WVBbzjQG4NVXi1rnA/O
         GxACI7IcB1Ib661O97A4TQCWvEOs1xy4M9AhFg8LTL4I0NI/uyKMzdwydUxUayNzGO6s
         yXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219397; x=1698824197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1AcdXM2oNG7X6kDVrsLsHOjBP4fqbkgPzfufbyu9xI=;
        b=K3sJVHfp2W0ijOQQ/7e6sLonTKjeD7Zr5iahgdVDhPsAgv3CWLUbf1d865h8XzXDWe
         yjP3q+5SV8QyPodKwhLHh968cUZc1CXOOW6PfCOuVcerG3TsuyxqWktkfkeee1O3KYpl
         b8crVw678O1g1kkY4iDwrg24XdTAAjcahiysa4/cR9je3wyCukxgrFpbmzFmj2fadbeR
         KqfFLBhCRy19ETxmO4LukN6KHECnbuisUHVNd7lOMga10KqpQVU0DthCvISPmwCCAr2O
         6p5xhsv6ZPG6ipssNn5E5Wzoe+eHzbB+rR0ftq7kVFDR+rHpVN+8de0ae1w+zHW+tA44
         /i5Q==
X-Gm-Message-State: AOJu0YyQxeUyFeqaw969VyMnM7N3wTCPiSrj6C1c3vN9iuS1nkZI4NHB
        UvYIox1dXgZ2TZJ/zSG1XP3oig==
X-Google-Smtp-Source: AGHT+IHrPalOGQnO0qrnM1HDI5pCl2wHNaqB4SbcwK8tc0cKTXy+rc6GnBuGwOzuYwSivPX7/g5HDQ==
X-Received: by 2002:a17:902:cf47:b0:1c0:ecbb:182f with SMTP id e7-20020a170902cf4700b001c0ecbb182fmr12511654plg.5.1698219397035;
        Wed, 25 Oct 2023 00:36:37 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090300d200b001bd62419744sm8647760plc.147.2023.10.25.00.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:36:36 -0700 (PDT)
Date:   Wed, 25 Oct 2023 13:06:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Call dev_pm_opp_set_opp() for required OPPs
Message-ID: <20231025073634.4et5epfog25o2pxf@vireshk-i7>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <6de4fcb5bb943a131d0cdf0a858bd35af02a2f88.1697710527.git.viresh.kumar@linaro.org>
 <ZTeoGiMQZ-OoYJBG@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTeoGiMQZ-OoYJBG@kernkonzept.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for taking this up, really appreciate it Stephan.

On 24-10-23, 13:18, Stephan Gerhold wrote:
> Unfortunately this patch breaks scaling the performance state of the
> virtual genpd devices completely. As far as I can tell it just keeps
> setting level = 0 for every OPP switch (this is on MSM8909 with [1],
> a single "perf" power domain attached to the CPU):
> 
> [  457.252255] cpu cpu0: _set_opp: switching OPP: Freq 998400000 -> 799999804 Hz, Level 0 -> 0, Bw 3200000 -> 1600000
> [  457.253739] genpd genpd:1:cpu0: _set_opp: switching OPP: Freq 998400000 -> 799999804 Hz, Level 0 -> 0, Bw 3200000 -> 1600000

The thing I was more worried about worked fine it seems (recursively calling
dev_pm_opp_set_opp() i.e.).

> [  457.304581] cpu cpu0: _set_opp: switching OPP: Freq 799999804 -> 533333202 Hz, Level 0 -> 0, Bw 1600000 -> 1600000
> [  457.306091] genpd genpd:1:cpu0: _set_opp: switching OPP: Freq 799999804 -> 533333202 Hz, Level 0 -> 0, Bw 1600000 -> 1600000
> [  457.323489] cpu cpu0: _set_opp: switching OPP: Freq 533333202 -> 399999902 Hz, Level 0 -> 0, Bw 1600000 -> 800000
> [  457.352792] genpd genpd:1:cpu0: _set_opp: switching OPP: Freq 533333202 -> 399999902 Hz, Level 0 -> 0, Bw 1600000 -> 800000
> [  457.353056] cpu cpu0: _set_opp: switching OPP: Freq 399999902 -> 199999951 Hz, Level 0 -> 0, Bw 800000 -> 800000
> [  457.355285] genpd genpd:1:cpu0: _set_opp: switching OPP: Freq 399999902 -> 199999951 Hz, Level 0 -> 0, Bw 800000 -> 800000
> 
> Where do you handle setting the pstate specified in the "required-opps"
> of the OPP table with this patch? I've looked at your changes for some
> time but must admit I haven't really understood how it is supposed to
> work. :-)

Thanks for the debug print, they helped me find the issue.

> [  457.304581] cpu cpu0: _set_opp: switching OPP: Freq 799999804 -> 533333202 Hz, Level 0 -> 0, Bw 1600000 -> 1600000
> [  457.306091] genpd genpd:1:cpu0: _set_opp: switching OPP: Freq 799999804 -> 533333202 Hz, Level 0 -> 0, Bw 1600000 -> 1600000

The second line shouldn't have had freq/bw/etc, but just level. Hopefully this
will fix it. Pushed to my branch too. Thanks. Please try again.

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 056b51abc501..cb2b353129c6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1070,7 +1070,7 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,

        while (index != target) {
                if (devs[index]) {
-                       ret = dev_pm_opp_set_opp(devs[index], opp);
+                       ret = dev_pm_opp_set_opp(devs[index], opp->required_opps[index]);
                        if (ret)
                                return ret;
                }

-- 
viresh
