Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC27A490D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbjIRMAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241933AbjIRL76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:59:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3048ACE3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:58:47 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38I4SDXm011029;
        Mon, 18 Sep 2023 06:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=6D1hNWb0NwMrs+h
        MpvEy1DKtRWavZMCve85QMiFW5p0=; b=W5bI63EN5Nuqr72LhdB+zLkXRHVxQmd
        47CkcjnTNJcx6eSL88s+eOtmZnWJysVoFu2kyGbCFOM+RqehhpQS7r3FuIKs1s9L
        o4n5PrW21yfxuqEUJxVI7hmmwhtKgljvqmeEe0w7crmm1C5lnb2G5yZURZoqVOar
        UA50DmUWK3rtxsZJuon24TsLE/UnSWT3gxtxPKA1uOLimg79TDLkC8bIjxeQmNEK
        B1246Nx4yIDftIJMi+bmBy1phEJuVa822YPkYzpNlHpRgkg2TkRW3gd0I65d5yGa
        qWW/PYPtBz4TR9CF5cgS7kGJRFLu2Os4OW3m8aKFEp0fb6hZZDjm0GA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t59ry28ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 06:58:38 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 18 Sep
 2023 12:58:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Mon, 18 Sep 2023 12:58:35 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B0B4111AB;
        Mon, 18 Sep 2023 11:58:35 +0000 (UTC)
Date:   Mon, 18 Sep 2023 11:58:35 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soundwire: bus: Add explicit include for irqdomain.h
Message-ID: <20230918115835.GY103419@ediswmail.ad.cirrus.com>
References: <20230915142900.34498-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230915142900.34498-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 6plhEUYbEd_fsI-DZNUiCBDqbXjByfl2
X-Proofpoint-ORIG-GUID: 6plhEUYbEd_fsI-DZNUiCBDqbXjByfl2
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:29:00PM +0100, Charles Keepax wrote:
> This header should be explicitly included, to make sure it is included
> for all Kconfigs.
> 
> Fixes: 12a95123bfe1 ("soundwire: bus: Allow SoundWire peripherals to register IRQ handlers")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309150522.MoKeF4jx-lkp@intel.com/
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

This doesn't quite fix the issue let me respin.

Thanks,
Charles
