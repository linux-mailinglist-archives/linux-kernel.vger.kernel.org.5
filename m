Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B06E773C0A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjHHP7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjHHP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:58:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0EC5FE7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:44:09 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 378DGsdq021901;
        Tue, 8 Aug 2023 08:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=yX8DnYk3BVeWpcG
        AIMVMRJsotzjWI/Bb34cGaeA99JA=; b=pbE43Jn0xoFFLYef9e+nUmNHCAGMire
        jFowRHZzif1rDo8aS0DpwHjrFFQICuX4BZ6vioXNRmmQ85DuqVLpOsUWIEAEUt7W
        27pbjdTdFKsvUoop24BQ8V5kjzuXd/ehhybhl3TI+4Eg3nnnFQyNFmluTDXmFxRC
        Hxwwb1qxs7P+NAmeR7rxS1/2fRjOru1VTx8QDVuI5l/HWznDsCjkFbvyM0Ps7EK9
        GsNhvk/XibffVcQxaQtowaI/Za22gDbJeNOfRAaWfxSlzWQrYbX8nP6lQq/S0mH0
        M5ZmuQp2T5KCuWucY2cKq0fPK9ctbhphRNtjSEyVPa+Q0Fw1paYbQ7A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhtmap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 08:22:37 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 14:22:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 8 Aug 2023 14:22:35 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 47C2415B4;
        Tue,  8 Aug 2023 13:22:35 +0000 (UTC)
Date:   Tue, 8 Aug 2023 13:22:35 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Zhu Wang <wangzhu9@huawei.com>
CC:     <lee@kernel.org>, <thor.thayer@linux.intel.com>,
        <rf@opensource.cirrus.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 7/8] mfd: lochnagar-i2c: remove redundant
 of_match_ptr()
Message-ID: <20230808132235.GV103419@ediswmail.ad.cirrus.com>
References: <20230808130023.202700-1-wangzhu9@huawei.com>
 <20230808130023.202700-8-wangzhu9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230808130023.202700-8-wangzhu9@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: hop1fWz66tOv6XkO_jQM_jbmIQJI8c8z
X-Proofpoint-ORIG-GUID: hop1fWz66tOv6XkO_jQM_jbmIQJI8c8z
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:00:22PM +0800, Zhu Wang wrote:
> The driver depends on CONFIG_OF, so it is not necessary to use
> of_match_ptr() here. We remove of_match_ptr() here.
> 
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
