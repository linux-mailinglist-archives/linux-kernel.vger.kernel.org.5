Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C442B76FC1E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjHDIkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjHDIkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:40:03 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5074130E5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:40:02 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3747k7EG019147;
        Fri, 4 Aug 2023 03:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=aIsdQaWLuPcX+1L
        76ID77qS1BLEZPLSxlG5CmEra5QU=; b=Hh4yxmEfKAmAuw9ItkLjWTuCPiBVTD7
        BKrQMqldYAqX0Cu3ypK4vTWO4R7Q+2BZl7rKizguiyUuUR21fAbzN7aSlOu4UxY3
        fOagN915mHrK62711IuZPeGu1wCh9b8qwgwcZaic3yEyMSvuGai3OIA7VPvD64b2
        CDhjTBebTQkYPs4uTKPrDZwNvzEtdA7TVvxKJEw4dgAdK3r/XSIMf4AEkvmcgfFe
        NkWkmxGw2+svhsLRbUrxIKA0ISAQVLnLjh5/b2Jzb5YRI/zm3CFlW4jMVjklgS7+
        3uANUPjzzBolzzJqdqb6r/mtAulkkdUqX3/VodOjJXyoI4+uFQmyFKQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s5gk1y0u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 03:39:51 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 4 Aug
 2023 09:39:49 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Fri, 4 Aug 2023 09:39:49 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 380FA3563;
        Fri,  4 Aug 2023 08:39:49 +0000 (UTC)
Date:   Fri, 4 Aug 2023 08:39:49 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <shengjiu.wang@gmail.com>,
        Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: wlf,wm8960: Describe the power
 supplies
Message-ID: <20230804083949.GQ103419@ediswmail.ad.cirrus.com>
References: <20230803215506.142922-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803215506.142922-1-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 8vKPaGv5q5iDLXPvKzDZlhlz9Gk3_-7V
X-Proofpoint-ORIG-GUID: 8vKPaGv5q5iDLXPvKzDZlhlz9Gk3_-7V
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 06:55:05PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> WM8960 has the following power supplies:
> 
> - AVDD
> - DBVDD
> - DCVDD
> - SPKVDD1
> - SPKVDD1
> 
> Add them to bindings to improve the hardware description.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
