Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E6379CB88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjILJVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbjILJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:20:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4339310DA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:20:08 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38C7U1QU025512;
        Tue, 12 Sep 2023 04:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=3842lPQ3i0eYHtp
        hxkwXTnHk43pagi8qo0tmHBx87V0=; b=h31q5+dZJV24i7yPKRvahiKVBS7uc9e
        MPPsp58G4nT6OOycUCauPjhPhLVQ+zah3VFF/nQXUR80r5yZQpxgfIiQdYqmS7TG
        YqSjt8HLMdSX2Tq8sCULNTkKuJXlZr7uwQR/U75w1D2sgujCD6tNuUuaK4vggA3i
        ZUn3Tj4a8uqLX9aJbVfwNh4+Zo8ur8cu183DB7ePWix4EmcH1Imph6ZwyaswZxOK
        +KPIeQsvwhMf/9K7A5bx8U2ONx9lZHrBKRU/JVPgVZzN5u81+TmW4Rxv14nGT1wa
        7KnprnuUYAfQdLRLs8ipC2j1llPLjGJmjCzrDAGsoocT1ND1dDLRwHg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t0n4jau22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 04:19:55 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 12 Sep
 2023 10:19:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 12 Sep 2023 10:19:54 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 38C943560;
        Tue, 12 Sep 2023 09:19:54 +0000 (UTC)
Date:   Tue, 12 Sep 2023 09:19:54 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     kernel test robot <lkp@intel.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Lee Jones <lee@kernel.org>
Subject: Re: cs42l43.c:undefined reference to `devm_regmap_add_irq_chip'
Message-ID: <20230912091954.GQ103419@ediswmail.ad.cirrus.com>
References: <202309120614.y7xm6iqp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202309120614.y7xm6iqp-lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: Ag_oE9TnNfyc6BAu10hfPa0KBb4vqNzM
X-Proofpoint-GUID: Ag_oE9TnNfyc6BAu10hfPa0KBb4vqNzM
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 06:29:42AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> commit: ace6d14481386ec6c1b63cc2b24c71433a583dc2 mfd: cs42l43: Add support for cs42l43 core driver
> date:   4 weeks ago
> config: nios2-randconfig-r013-20230912 (https://download.01.org/0day-ci/archive/20230912/202309120614.y7xm6iqp-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309120614.y7xm6iqp-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309120614.y7xm6iqp-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    nios2-linux-ld: drivers/mfd/cs42l43.o: in function `cs42l43_boot_work':
> >> cs42l43.c:(.text+0x614): undefined reference to `devm_regmap_add_irq_chip'
>    cs42l43.c:(.text+0x614): relocation truncated to fit: R_NIOS2_CALL26 against `devm_regmap_add_irq_chip'
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

This should be fixed by this patch:

https://lore.kernel.org/lkml/20230905133406.GM103419@ediswmail.ad.cirrus.com/T/

Thanks,
Charles
