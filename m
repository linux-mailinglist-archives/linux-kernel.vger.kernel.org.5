Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504A67F091A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 22:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjKSVNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 16:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjKSVNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 16:13:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD78E0;
        Sun, 19 Nov 2023 13:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700428412; x=1731964412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zpvcNPT2dQhT6/8aFXx0UZ9y0EBRO4b8OkktezR++f0=;
  b=VbZiV5g2lI3AejmoBlX3rnTtkaoW7g0aP4WMUz8xeCslMXfg3DaITe3X
   +t/hEJ7HeIoweZ6/ZBzU+wQ+kMfgRHSh1cTSjZq6p0hG4AThCNwQ7WGS5
   JWQKRbcRkmLugHihGdziKGmvHpjZrDsBRD3kMdDvM6M2z73cIO3mZ+VD0
   C8TIUTyRcu4B+36VxgefeQVYVL8arnnqDEHF3CKb6UyRFq6MvwCVqXyjx
   24mCmks676p0AsU2JecWsFhb9djg5gi/mE6pqjFGpYawpsI9BieQ9TiSh
   NbIlaXDmgeNHMkXeVWx2oOHRXUNhVUKJJtfOhhUdTGyimucZ3pQEtLoy7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="4694614"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="4694614"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 13:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="759641618"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="759641618"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Nov 2023 13:13:27 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4p6a-0005YI-2q;
        Sun, 19 Nov 2023 21:13:24 +0000
Date:   Mon, 20 Nov 2023 05:12:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] media: qcom: camss: Flag VFE-lites to support
 more VFEs
Message-ID: <202311200405.h6G4L9oe-lkp@intel.com>
References: <20231118-b4-camss-named-power-domains-v5-6-55eb0f35a30a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118-b4-camss-named-power-domains-v5-6-55eb0f35a30a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 48016737a9af47328dd321df4dd3479ed5e2041d]

url:    https://github.com/intel-lab-lkp/linux/commits/Bryan-O-Donoghue/media-qcom-camss-Flag-which-VFEs-require-a-power-domain/20231118-201456
base:   48016737a9af47328dd321df4dd3479ed5e2041d
patch link:    https://lore.kernel.org/r/20231118-b4-camss-named-power-domains-v5-6-55eb0f35a30a%40linaro.org
patch subject: [PATCH v5 6/7] media: qcom: camss: Flag VFE-lites to support more VFEs
config: powerpc-randconfig-r111-20231119 (https://download.01.org/0day-ci/archive/20231120/202311200405.h6G4L9oe-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231120/202311200405.h6G4L9oe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311200405.h6G4L9oe-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/media/platform/qcom/camss/camss-vfe-480.c: note: in included file (through drivers/media/platform/qcom/camss/camss.h):
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition
>> drivers/media/platform/qcom/camss/camss-vfe.h:237:24: sparse: sparse: marked inline, but without a definition

vim +237 drivers/media/platform/qcom/camss/camss-vfe.h

   228	
   229	/*
   230	 * vfe_is_lite - Return if VFE is VFE lite.
   231	 * @vfe: VFE Device
   232	 *
   233	 * Some VFE lites have a different register layout.
   234	 *
   235	 * Return whether VFE is VFE lite
   236	 */
 > 237	inline bool vfe_is_lite(struct vfe_device *vfe);
   238	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
