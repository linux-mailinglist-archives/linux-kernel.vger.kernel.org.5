Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE887EF5B8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjKQPxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQPxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:53:09 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C1D8E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:53:05 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AHFq7dY014871;
        Fri, 17 Nov 2023 09:53:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=dtA6eQ0pm1R/1qh
        TA4hTCxdTnSbvT/fS4I9Saw2l+Ws=; b=jsGH6vhAmELsHDAijH2/c/rtsdTIgNV
        cSrmSM7EQtbtosTxDL7Iz5/Fsuss5mVREf70Gm9wNWw+cF9S/DoX5eOmg/IfHahn
        SOrUxzo8XAB0I1+1+dVoeqdQb2GqomiT4f0F19jgjsUq1Ys1fdccYEALBwP830SV
        nVrHJqiSYEWdnZZ10yhDUUeZr4oiZaeyxCHE7CTZT7yOTpBdNKAptjeo3Ysx9jw6
        hbqaPQLp1T61ZeQ85aM4gECeYGo1Sx4AHyTObRXOrQ+Shy2s7ELhsbgZdU1Prffx
        9wOEzRYYrRQCkjhYp+fUg7E9D43Wk83pUgTgKMZVKbd/oRxh3iVLl9w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ua6wpfpj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:53:01 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 15:52:59 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Fri, 17 Nov 2023 15:52:59 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9475515B9;
        Fri, 17 Nov 2023 15:52:59 +0000 (UTC)
Date:   Fri, 17 Nov 2023 15:52:59 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
CC:     Lee Jones <lee@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: wm831x: Remove redundant forever while loop
Message-ID: <20231117155259.GF32655@ediswmail.ad.cirrus.com>
References: <20231117154037.67676-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231117154037.67676-1-mstrozek@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: jnen6_KisWwonEhwOYjpMlNUo1b9GK9P
X-Proofpoint-ORIG-GUID: jnen6_KisWwonEhwOYjpMlNUo1b9GK9P
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 03:40:37PM +0000, Maciej Strozek wrote:
> Current code excutes only once despite the while loop, so remove the
> loop. Also msleep(1) will likely result in a larger sleep, so increase
> its value for clarity while keeping the same behaviour.
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
