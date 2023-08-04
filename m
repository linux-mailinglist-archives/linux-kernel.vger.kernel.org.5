Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6E176FDAD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjHDJpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjHDJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:45:13 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA62849EC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:45:10 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3749DbxH023497;
        Fri, 4 Aug 2023 04:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=OCofsKAt8Ejf/ZS
        ErfSKkZTlVh+VkY8Gp9t1OATALhU=; b=e87WDpxxvOBWRKRQkJnFWJiJp5FENic
        zXL9c3OJz6TXOoxGGsvqMezw0FwELxewAIx5nh//pzItg5BJ0z0J7BlPHgujB5Rz
        2Tw+1M8KmKgD+7nPE5vrhDkXrFbQwydit7HBaFcDlkLNByue86sn9Y+C9yvk91tz
        VfA0e2hFMjUko00+2RO/NWly31haOkROXpyogiLEX5cDvNbsTPcaEnr0NRVaqSGp
        7MyBp1UXpJ6qLoZKWaQEQU55vx0mqP0cpAII5PF579VP7w9mm8eKfNsDAYWB17yp
        JHc3mFlEkq+bhFDdtFmiNfdykM1q8is0ubvseKAbRFNPe6cJTHOhWvA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s4y6jwjn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 04:45:01 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 4 Aug
 2023 10:45:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Fri, 4 Aug 2023 10:45:00 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F14D33563;
        Fri,  4 Aug 2023 09:44:59 +0000 (UTC)
Date:   Fri, 4 Aug 2023 09:44:59 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <vkoul@kernel.org>,
        <vinod.koul@linaro.org>, <linux-kernel@vger.kernel.org>,
        <pierre-louis.bossart@linux.intel.com>, <bard.liao@intel.com>
Subject: Re: [PATCH 2/2] soundWire: intel_auxdevice: resume 'sdw-master' on
 startup and system resume
Message-ID: <20230804094459.GS103419@ediswmail.ad.cirrus.com>
References: <20230803065220.3823269-1-yung-chuan.liao@linux.intel.com>
 <20230803065220.3823269-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803065220.3823269-3-yung-chuan.liao@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: _2qWJouHkS0ldpw8Pj0ZAC4yyfVIg6Po
X-Proofpoint-ORIG-GUID: _2qWJouHkS0ldpw8Pj0ZAC4yyfVIg6Po
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 02:52:20PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The SoundWire bus is handled with a dedicated device, which is placed
> between the Intel auxiliary device and peripheral devices, e.g.
> 
> soundwire_intel.link.0/sdw-master-0/sdw:0:025d:0711:01
> 
> The functionality of this 'sdw-master' device is limited, specifically
> for pm_runtime the ASoC framework will not rely on
> pm_runtime_get_sync() since it does not register any components. It
> will only change status thanks to the parent-child relationship which
> guarantees that the 'sdw-master' device will be pm_runtime resumed
> before any peripheral device.
> 
> However on startup and system resume it's possible that only the
> auxiliary device is pm_runtime active, and the peripheral will only
> become active during its io_init routine, leading to another
> occurrence of the error reported by the pm_runtime framework:
> 
> rt711 sdw:0:025d:0711:00: runtime PM trying to activate child device
> sdw:0:025d:0711:00 but parent (sdw-master-0) is not active
> 
> This patch suggests aligning the sdw-master device status to that of
> the auxiliary device. The difference between the two is completely
> notional and their pm_status shouldn't be different during the startup
> and system resume steps.
> 
> This problem was exposed by recent changes in the timing of the bus
> reset, but was present in this driver since we introduced pm_runtime
> support.
> 
> Closes: https://github.com/thesofproject/linux/issues/4328
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---

Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
