Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003C2792B44
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjIEQu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354688AbjIENeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:34:24 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D589F12A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:34:16 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 385CRBXx032230;
        Tue, 5 Sep 2023 08:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=Ko8J7CzA1dThlOH
        KyFG6OnfclW4o64JlkeVqOHHuy0s=; b=c3k9o2NpQGWp2ItE60nJRwFXuubZ4m1
        nPtHaEihO8lXVXs227L8epFRjR6ADVyhMVT9j0n45bDwVhKzIAFS8bp710t49gUK
        Z+hGxastq0VHgD8kRznZcFFxPARTom48SZHRASmPjEvH8eY2DLqNSWYhaGH3M9dV
        OWLznDtZMk+vzBVyIMVnsBun/JbOHm+GX4s+f6iflJnnWryVXtcr1gcdkofU+6Z4
        7VfyyS69HN4ER2HKnhIdgnX5ztUEvIn+IiagjsGkg5FYD9++4U/1w30U0i11sJTK
        QpfM3pICPQdSt/YR1ASl1sdBnoqH55GW9FChYAAbCfjYFNecY5WFvng==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sv1fhu161-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 08:34:08 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 5 Sep
 2023 14:34:06 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 5 Sep 2023 14:34:06 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9DD9911AA;
        Tue,  5 Sep 2023 13:34:06 +0000 (UTC)
Date:   Tue, 5 Sep 2023 13:34:06 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Woody Zhang <woodylab@foxmail.com>
CC:     Lee Jones <lee@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: cs42l43: Fix Kconfig dependency
Message-ID: <20230905133406.GM103419@ediswmail.ad.cirrus.com>
References: <tencent_E54C7156F583E15FFE320E576E3389C39A08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tencent_E54C7156F583E15FFE320E576E3389C39A08@qq.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: sDR3DNMDOhLSItZC_ju6wADpRa7ke0CG
X-Proofpoint-GUID: sDR3DNMDOhLSItZC_ju6wADpRa7ke0CG
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 07:41:00PM +0800, Woody Zhang wrote:
> MFD_CS42L43 depends on REGMAP_IRQ as it uses devm_regmap_add_irq_chip.
> Otherwise the build may fail with following log.
> 
>   AR      drivers/built-in.a
>   AR      built-in.a
>   AR      vmlinux.a
>   LD      vmlinux.o
>   OBJCOPY modules.builtin.modinfo
>   GEN     modules.builtin
>   MODPOST Module.symvers
> ERROR: modpost: "devm_regmap_add_irq_chip" [drivers/mfd/cs42l43.ko] undefined!
> 
> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> Signed-off-by: Woody Zhang <woodylab@foxmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
