Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652E77F1085
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjKTKja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjKTKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:39:29 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F3AA0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:39:25 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AK6U49h003527;
        Mon, 20 Nov 2023 04:39:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=vgy4RExMtajujOH
        lo7gbpekIg4EZ0HKJHesi6P+psGA=; b=jwWdwG6ZImi9zGof5MyLp1JPHPWKHmD
        6Nse1ljQ6QyVjsmi85TQUwJQWjb3MCgD77nlUvCG6n+0NZBIH+GdaZG9DyeeKMlo
        YfIX/t3g+GZ4W/5ZxKaLaK91ZPErlj6jRIwU3NfjHB3IMbR5Hqj9L8gq+8M+QDuM
        nVNkZ9uHqbSiuTXclG4iky83yGw1dzIbwxKMYRCJwIci2gb94UQPKWeRdOD9SSsQ
        Yag+0BX9BZdOuSpWb6incK5fS5AIYbFGwVUbrEsuIpmqmbQcbi5oq6kVUDFIJ9Nd
        5KA7gE2CLatzUwtFIv7XmlYPH4ZvP+yGESjfRPrXUjWjC6qQg/B6grA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3uetjp9pk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 04:39:22 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 20 Nov
 2023 10:39:21 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Mon, 20 Nov 2023 10:39:21 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ECA0AB12;
        Mon, 20 Nov 2023 10:39:20 +0000 (UTC)
Date:   Mon, 20 Nov 2023 10:39:20 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
CC:     Lee Jones <lee@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: wm831x: Remove redundant forever while loop
Message-ID: <20231120103920.GI32655@ediswmail.ad.cirrus.com>
References: <20231120102259.74210-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231120102259.74210-1-mstrozek@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 5e4ZMP_VwQ-YDl-qV3GQCxvfPWgVL-aP
X-Proofpoint-ORIG-GUID: 5e4ZMP_VwQ-YDl-qV3GQCxvfPWgVL-aP
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:22:59AM +0000, Maciej Strozek wrote:
> Current code excutes only once despite the while loop, so remove the
> loop. Also msleep(1) will likely result in a larger sleep, so increase
> its value for clarity while keeping the same behaviour.
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
