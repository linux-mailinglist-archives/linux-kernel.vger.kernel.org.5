Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5851C7B0261
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjI0LFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjI0LFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:05:16 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AAFFC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:05:15 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57bb6b1f764so3899691eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695812715; x=1696417515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vetR3GnlwFXT3zkdDS+aeE4yPjMJRiiW2xyPGx6ftZ0=;
        b=YsTRGPIeNPauywYApr00uy8zPE63fxP+8B6xt0rp3KUBEmp66LwYy1yy8qr3fXhvf7
         GhyYeqZ0rf6Q1BSaxjbT975OyOYmETYqMMh+7h4coh7hUSr3AnBM4HhXYE76mKM5Z3Pv
         zm83TK1XZ90/9WNDwjOmZKxGtA3ImvBYHeWZCcpagIrQ4l44141emPTIJXGiWLYTXdvR
         zLXX1Er4BADHvWfS/Jz5+TFU5j4x5lwcDLhgB/s6Pa4q2x5rA/0/4r82fZ11ggDkdTmg
         Je8ct2VJCiugs/zfonqId2N83Cll1moLDYXNzi8VXB9LXq1xyQuReCvgt+vJYwKJHKf5
         AVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812715; x=1696417515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vetR3GnlwFXT3zkdDS+aeE4yPjMJRiiW2xyPGx6ftZ0=;
        b=t2HeSrwbP7kP1wnsX6T0xZ/5fdSOuq2ceQ3lm47krLOv1BPNq29Nvj3UiGzUllUGJW
         upSfok7lLmGehkgKahiAwyEt3ksY3/IpvMas2biTHZwlguadOMsKMWbpCxkCNEAYVE45
         o2pfWnX0uWxfAvb1ddqe0N24hhOlciQboUeBR3AQHBh93jCKCucqsl0j8uZjYZASpKCn
         /BSTO0Glugtk2pBfB31SV1YeY49pod/+/7/OLhGKDvX1uwPFJFt86DlsfD7nmr8cP4Dj
         v4f9mAo+8iVG1GMVDM4slfqmzzW/mPUY9cj0uMwysG5EjDs6WWyYP/yiWJFGULfdf/aF
         QNOQ==
X-Gm-Message-State: AOJu0YzgotjKvD6xqOMj2Fhr/US4u7k7lN98OpV3D1x0PcvHkAxdCvpJ
        +YRfI7xH3q9AXVluAzdblyYHPQ==
X-Google-Smtp-Source: AGHT+IH33pd389pOJmt1++lTT1g7TKrnAgOO3Sd5QaIebHmN4PEVtfqxMEzdG/doEVybvDTQII3XWQ==
X-Received: by 2002:a05:6358:9917:b0:133:428:35dc with SMTP id w23-20020a056358991700b00133042835dcmr2360041rwa.11.1695812714657;
        Wed, 27 Sep 2023 04:05:14 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id k7-20020aa78207000000b00690f622d3cdsm2537790pfi.126.2023.09.27.04.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:05:14 -0700 (PDT)
Date:   Wed, 27 Sep 2023 16:35:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: drivers/opp/core.c:2113: warning: Function parameter or member
 'opp_table' not described in '_opp_set_regulators'
Message-ID: <20230927110512.3ihludnoqj5vugu2@vireshk-i7>
References: <202309091728.siozDgSB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309091728.siozDgSB-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-23, 17:34, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
> commit: b0ec09428621daee5101130c307634a390b0213b OPP: Migrate set-regulators API to use set-config helpers
> date:   1 year, 2 months ago
> config: csky-defconfig (https://download.01.org/0day-ci/archive/20230909/202309091728.siozDgSB-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309091728.siozDgSB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309091728.siozDgSB-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/opp/core.c:2113: warning: Function parameter or member 'opp_table' not described in '_opp_set_regulators'
> >> drivers/opp/core.c:2113: warning: Excess function parameter 'count' description in '_opp_set_regulators'
>    drivers/opp/core.c:2756: warning: Function parameter or member 'token' not described in 'dev_pm_opp_clear_config'
>    drivers/opp/core.c:2756: warning: Excess function parameter 'opp_table' description in 'dev_pm_opp_clear_config'

I have sent patches to fix all warnings related to OPP core:

https://lore.kernel.org/all/0484680a9c7bb66cf1fb583a5178e753dd763afd.1695812634.git.viresh.kumar@linaro.org/

-- 
viresh
