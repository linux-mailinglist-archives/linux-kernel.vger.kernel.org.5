Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244557A5CED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjISIv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjISIvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:51:25 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B85E6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:51:18 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38J7c9GM005584;
        Tue, 19 Sep 2023 03:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=xUFcITs3ke7Ognj
        8MTOSnt5czIiaUfjbmz3OPrlqamM=; b=fW7di/o4901o1MfIawaTyJMNGFelWq1
        HB4guNxjIYanfzOaIPkv657DdDLyaPJUGbQ/K2gLAk7HxyHfLl9EqnRV9KNILSzC
        3eDw+tgMhnqMjJZDCFkmCFl44y17fzb6wK1aleevlbK951oYtdKYusL+LWRpJr7Y
        LvbIiJRez9t6GF81cyCjFbi+zNq1u6g7lx9FxJQ3ykOTOApih12MXuyMVfx3Io+t
        j9fAhSGHq1BhThEa1Tmw5LZ/0OCr01fkBa7vylIDovzb67/Sg34C6+fI4tj6wOZF
        jcSh8SjZuH+WlDzNF0re1lPJCTsn1yTrOAvr8gaiaEsqrB9YYXZ24eA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t58shttje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 03:50:58 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 19 Sep
 2023 09:50:57 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 19 Sep 2023 09:50:57 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 22B3711AB;
        Tue, 19 Sep 2023 08:50:57 +0000 (UTC)
Date:   Tue, 19 Sep 2023 08:50:57 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] mfd: cs42l43: add REGMAP_IRQ requirement
Message-ID: <20230919085057.GA103419@ediswmail.ad.cirrus.com>
References: <20230918193042.31524-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230918193042.31524-1-rdunlap@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: dH3EzAMkZGZ1vn6yBVZUCQxGxYMD8iK3
X-Proofpoint-ORIG-GUID: dH3EzAMkZGZ1vn6yBVZUCQxGxYMD8iK3
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 12:30:42PM -0700, Randy Dunlap wrote:
> The cs42l43 core uses devm_regmap_add_irq_chip(), so add REGMAP_IRQ
> to what the core driver selects in order to provide this API.
> This fixes a build error:
> 
> aarch64-linux-ld: drivers/mfd/cs42l43.o: in function `cs42l43_boot_work':
> cs42l43.c:(.text+0x19d4): undefined reference to `devm_regmap_add_irq_chip'
> 
> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: James Schulman <james.schulman@cirrus.com>
> Cc: David Rhodes <david.rhodes@cirrus.com>
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: alsa-devel@alsa-project.org
> Cc: patches@opensource.cirrus.com
> Cc: Lee Jones <lee@kernel.org>
> ---

Someone already sent a fix for this, that is awaiting review:

https://lore.kernel.org/lkml/tencent_E54C7156F583E15FFE320E576E3389C39A08@qq.com/

But just incase this one gets picked up:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
