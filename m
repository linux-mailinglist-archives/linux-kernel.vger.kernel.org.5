Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D92879B2A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358911AbjIKWOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbjIKMy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:54:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB7CEB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:54:52 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38BCKOc4019530;
        Mon, 11 Sep 2023 07:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=vVHlWkZCeiO7mNNZwEblnDDlwUUCr2etvJOYkCcHdDE=; b=
        k6HL8vZyH+oAI55pQGJBKvxq2Ms68q6LzddXdaP42GdLXVBrGNCCq79jsTzClfEz
        MzKx0jCUWYIkKatoWTnKUYt22agTmWEpcSw6sEm/RYRGddhJcNByvmloKrdgNnXf
        6cs5dXQDZuLbeugRtoYo3xkR/OIB/8Wt4LNX8D9pR9qfPnw1Veh4J/vvivIs1b31
        l0GlEkGcdkXYwwv1y5XS+AynBT2QXnAMlvp2SUfPhF0XytD+/yDwa27so1yGNe8h
        P7qUBrMzKHcKvdjivdtlwkMk2mjzvc6zWIixHdCyThkv/JIxEHCQuU/+IESs61Yy
        bcY1oY1kxeLyfyQ78dAciw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t0n4j9rwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 07:54:38 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 11 Sep
 2023 13:54:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 11 Sep 2023 13:54:36 +0100
Received: from [198.90.251.125] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 367DD11AA;
        Mon, 11 Sep 2023 12:54:36 +0000 (UTC)
Message-ID: <2e7c77bb-2f9b-50a0-334f-ff4351364761@opensource.cirrus.com>
Date:   Mon, 11 Sep 2023 13:54:36 +0100
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
X-Proofpoint-ORIG-GUID: JZDG-pKbYJFxtZ4CBBEspERNqh8xXIXh
X-Proofpoint-GUID: JZDG-pKbYJFxtZ4CBBEspERNqh8xXIXh
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
> drivers/mfd/cs42l43.c:1138:12: error: 'cs42l43_runtime_resume' defined but not used [-Werror=unused-function]
>   1138 | static int cs42l43_runtime_resume(struct device *dev)

Commit title has typo. mtd should be mfd.
