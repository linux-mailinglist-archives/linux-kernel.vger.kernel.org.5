Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88278C05A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjH2If6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjH2If1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:35:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF258FC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:35:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso7755655ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693298124; x=1693902924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pXu9S/AlFix/yXovuYXYyWown8pXs4G9/o2rQqvLXEc=;
        b=xtn+f9n7JkMpbNlw4BvM8/pHcGCB155ZgJFUvAof5g6dcnmc/DSKGPEe6Un/c4vdIP
         F39yXeIGWaAXk0/DcXkWJhWR+ODo1Ru90pEjpbOMBbf1VpMCUOaJi5iLKjkLGsjgGfnW
         aavuN1+jhiB/nETrdD61Qvyi1y7eTiyvdwVL4AwrzC7/ah9ae82rqY/4+pr55zvAp0eN
         kWxBZUq7YbnHgAcpg/Z+P7ToN3dQKrOBfBrss0K1pG8460L9RkuyQJB2+1VGkk0YqoGA
         MFtKVy3zqLwRZJ0VP5HbdegC0s18xCza7pQD1PE1eilTjeQL4agYg3+ReLDov1lYLaZv
         SD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693298124; x=1693902924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXu9S/AlFix/yXovuYXYyWown8pXs4G9/o2rQqvLXEc=;
        b=bHcExJeECPQb9PZMxBzdX2jCVtBqI+PdsRYebXnenUCbXSxh5WtEgI7M1yUfysuiUY
         UQswrBnRuna0GB5PP0ruritZ+w9xinHpLiDOEaqPNOe/x8+LNYzyNPSLPSkOdqGdselk
         +ePsQtPaVlIa0ukqLVssxdR95O/TQJht6Y1ucUjVzoubQt2z2fzecX7jx3QOgN9G3dwg
         1eMAQXx0IrnmBUqNZgg0BJPIAsJqFdCFBpJ8jzpV/CGXy9fccDnJP9W482CATUv4evfS
         KGGQzXPNkZHKmid3/xzobjA+Nsw6Y09dQgk0OsUocP5nTPhbmzMnlWcBlHCDDTlBeqdf
         PjJQ==
X-Gm-Message-State: AOJu0YymHEur6xkigRhCydWzM3hNTExBdjv7SXgKsIaOl5sdOX3D4cOX
        mER88Pr5OpWfYroYN53etXOSwQ==
X-Google-Smtp-Source: AGHT+IG5T83K0W6KstE98X3Y5HO7B5EQWBAbQkIAQDRtjvXz0qrzINfcG76M1L2nByrIYzfZ1/0sDg==
X-Received: by 2002:a17:902:e88f:b0:1c0:afdb:1e6c with SMTP id w15-20020a170902e88f00b001c0afdb1e6cmr20688639plg.8.1693298124327;
        Tue, 29 Aug 2023 01:35:24 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709029b8100b001b86492d724sm4331852plp.223.2023.08.29.01.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:35:23 -0700 (PDT)
Date:   Tue, 29 Aug 2023 14:05:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chun-Jen Tseng =?utf-8?B?KOabvuS/iuS7gSk=?= 
        <Chun-Jen.Tseng@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sumitg@nvidia.com" <sumitg@nvidia.com>,
        "sanjayc@nvidia.com" <sanjayc@nvidia.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] cpufreq: mediatek: change transition delay for MT8186
Message-ID: <20230829083521.trec3rjjmscqp2dw@vireshk-i7>
References: <20230818020616.4748-1-chun-jen.tseng@mediatek.com>
 <20230828063904.r7huxclehlblkkjx@vireshk-i7>
 <86f49ce84f32941185c961da8a5c671e7aed46b1.camel@mediatek.com>
 <20230829071022.n7wubb2dhbt3ukyk@vireshk-i7>
 <d0745e1cee9fae33252bb8d3db741c2a463983d6.camel@mediatek.com>
 <20230829083154.27ckyuwnqk4zpejs@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829083154.27ckyuwnqk4zpejs@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-08-23, 14:01, Viresh Kumar wrote:
> Why exactly does the kernel crash here ? Any idea ?

Also note that cpufreq core has enough locking in place to make sure
two ->target_index() function calls don't run in parallel for the same
policy.

What may be happening in your case is that you are configuring a
common entity (CCI) from both the policies and there is no locking in
place to take care of the races.

-- 
viresh
