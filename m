Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5271479BA01
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347764AbjIKVZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237648AbjIKNFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:05:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B37DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:05:03 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38BBmDlB032392;
        Mon, 11 Sep 2023 08:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=t9rLgJyqGBBWmI5mVTftAC82FZUKd++pMb8l16x//Is=; b=
        JGhJozYkAgX5SttnFoUGkzWkwwwCbjZQA6EaSEC50bqZvb+WLRktIYcUUKf8XxXm
        I9szVhBHU6CW7qKzjNP0imMhup+e+G9gJwoSfdbgbFB7C3krBZJ2oQA28sdOSVD1
        FCvcEMffegOa8uQbCs9uuaWkpI+f+ATFIWWkBQRMCnzeR2gvPCq9oGfdVjkRnOwh
        gqJbzGuXm03QcvO1w83vTjRS5ipYcyVf5YmhRqAFVrDUBL82Bi9Ojv+goPiA6ugw
        QA5VEbgHkEuTOBRIDgGdOJiHgw3lPTf0KBtm80UKD8J7YhYwHNvliad/uMvywM3F
        YY5IJzakOiRBE2PpXhvvRg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t0p3xj4jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 08:04:48 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 11 Sep
 2023 14:04:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 11 Sep 2023 14:04:43 +0100
Received: from [198.90.251.125] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4C83C11AA;
        Mon, 11 Sep 2023 13:04:43 +0000 (UTC)
Message-ID: <f03eac55-04ac-b99f-f545-ef8bb7e80f42@opensource.cirrus.com>
Date:   Mon, 11 Sep 2023 14:04:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mtd: cs42l43: use modern PM macro helpers
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Lee Jones" <lee@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
References: <20230911111623.705640-1-arnd@kernel.org>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20230911111623.705640-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qehUIOxXHOmuDR3xb9R94T1SvScaXpGn
X-Proofpoint-GUID: qehUIOxXHOmuDR3xb9R94T1SvScaXpGn
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 12:16, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The old SET_SYSTEM_SLEEP_PM_OPS/SET_RUNTIME_PM_OPS macros required enclosing
> the function definitions in an #ifdef or marking them __maybe_unused:
> 
<SNIP>

>   
>   EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
> -	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> -	SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> +	RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
>   };

Charles already sent a patch for this. We're waiting for Lee to merge it.
https://lore.kernel.org/all/20230822114914.340359-1-ckeepax@opensource.cirrus.com/
