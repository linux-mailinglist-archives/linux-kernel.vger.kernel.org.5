Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFF47B16C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjI1I6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjI1I57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:57:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665DDAC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:57:57 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38S5dcWb014061;
        Thu, 28 Sep 2023 03:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=fmf7E4P+dNZC9Uv
        eMLjyWvKeWz5XnkPtF0Zvjo4B//I=; b=rGtMtAYUz1S8OuhMKPljDwQxy0TFr90
        okxzBbswvkrc1j36UyyyZAbNfaXmjDWrlSNWG9DKcsNObg7wCg6eD4RI286C8/Vp
        oGQgNjiOSm7MaGG12yWeDrdje/hC+ZU+0qo5eQP1bFBzyDV92FtTpSwdISEmOThv
        zNHCXiOiQKy3pTQfY41Kjcvra9EEPqFL88Bs/BQJkFyO38xXBuxkLl5CwCSnJ3pr
        B61y1/eBJ038BVBDBa6x/G+ft4W0RXSzq1HPxPve3eo+rkWubEvYb2uz484U+XHl
        TpCw7a9oD5zO94EIc2DMqagUqn1bDymC3cx9ZFlK3jPHV+4TxCS6+Nw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t9vejdubs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 03:57:27 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 28 Sep
 2023 09:57:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 28 Sep 2023 09:57:25 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 861033561;
        Thu, 28 Sep 2023 08:57:25 +0000 (UTC)
Date:   Thu, 28 Sep 2023 08:57:25 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <rf@opensource.cirrus.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: cs42l43: Remove useless else
Message-ID: <20230928085725.GL103419@ediswmail.ad.cirrus.com>
References: <20230928085200.48635-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230928085200.48635-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: aOvJ5rKary-NUFxN2XQMKnI-OXJ5d3aC
X-Proofpoint-ORIG-GUID: aOvJ5rKary-NUFxN2XQMKnI-OXJ5d3aC
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 04:52:00PM +0800, Jiapeng Chong wrote:
> The assignment of the else and if branches is the same, so the else
> here is redundant, so we remove it.
> 
> ./sound/soc/codecs/cs42l43-sdw.c:35:1-3: WARNING: possible condition with no effect (if == else).
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6712
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
