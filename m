Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C464080E7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346050AbjLLJfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjLLJfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:35:09 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C81FDB;
        Tue, 12 Dec 2023 01:35:15 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC70GcA016663;
        Tue, 12 Dec 2023 03:35:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=75G6b+827uYHMO0
        0ZmcSTAjr7pIn63myPK48OyBOHsA=; b=cKGwXTZYQxQwXWYVEEXQjJb1ZkGgsOh
        LJJ/sKFmjCC/yif3yLcM4RE2Tgqz1Q1LURIT6hqiSZ/u+/zxqVCzKDwbyhJcHiqU
        I7x/QqtEu26ZQ6BsQGndf7C6EZEe+0XVbbRIiGqFJwNubm+/G363EV7u7BYeVdvq
        l2b/3PTHvQvJaXTnOUlQYh26NTJQUy2MVI0nhNemgh+0/H/+M4dGBJwdRL0gyiGj
        CxiJl968GLMCGrka7LKtUhsKsJklqYsBYP/mKuEFbiKI4OH9UYBbN/CFjNj1rrHq
        wfN1n/0vZm+aIHSCVxEKUAWp0ie2xVaqrL5+LUKvgpvsd11gIoHigCQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3uvnhpjxsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 03:35:03 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Dec
 2023 09:35:02 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Tue, 12 Dec 2023 09:35:02 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1B21F468;
        Tue, 12 Dec 2023 09:35:02 +0000 (UTC)
Date:   Tue, 12 Dec 2023 09:35:02 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20231212093502.GW14858@ediswmail.ad.cirrus.com>
References: <20231212111625.2b9cf396@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212111625.2b9cf396@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: LGc9cVkf1D_G27hJKIBvQ7hblcugw1ij
X-Proofpoint-ORIG-GUID: LGc9cVkf1D_G27hJKIBvQ7hblcugw1ij
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:16:25AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the sound-asoc tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> sound/soc/codecs/cs42l43.c:142:6: warning: no previous prototype for 'cs42l43_hp_ilimit_clear_work' [-Wmissing-prototypes]
>   142 | void cs42l43_hp_ilimit_clear_work(struct work_struct *work)
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/codecs/cs42l43.c:159:6: warning: no previous prototype for 'cs42l43_hp_ilimit_work' [-Wmissing-prototypes]
>   159 | void cs42l43_hp_ilimit_work(struct work_struct *work)
>       |      ^~~~~~~~~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   bbbc18d8c27c ("ASoC: cs42l43: Allow HP amp to cool off after current limit")
> 
> Maybe they should just be static?
> 

Yeah they should be static sorry, will send a patch today.

Thanks,
Charles
