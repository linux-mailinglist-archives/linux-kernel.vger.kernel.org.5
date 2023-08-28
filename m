Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B178A760
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjH1IQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjH1IQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:16:18 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038F7A2;
        Mon, 28 Aug 2023 01:16:15 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37S7wBFL017474;
        Mon, 28 Aug 2023 03:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=q+P9b1QMfW35u28
        TTe3u7YP50byQwJa/sFU9i122ndc=; b=MkPZHa+VYE8Av+8SGBytweRjBg2VCTm
        omq4iV0+A/AHJjRJ0chDhms1NMIYgaG3XTxC61AP0lcQ+6thUC99Q1P8KC7GupW7
        COqPNDNalQACmVnqXUr5gPLe5VudRKJvQQSE2kYFxMs8DfzrHCjliR9Ukmh2BZ42
        0i4MBNI/6iYg7Qvx8wh03FWehROF+0nDg4w+yaPSB9CNNsRxmMIl238QBWZwheEM
        BDsf6ckoXVVYjgsWa8YkRbn8AS6XwuLq0ufwvS1YmlPN6ltPyWc8gf0eQ7sPTYYP
        kUIITPgnWPPT2katMryEeaBNu/uWekw55/64mnNUylNLXGS1YvYutsQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sqdtj1hgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 03:16:06 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 28 Aug
 2023 09:16:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 28 Aug 2023 09:16:04 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7A58811AA;
        Mon, 28 Aug 2023 08:16:04 +0000 (UTC)
Date:   Mon, 28 Aug 2023 08:16:04 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <alexandre.belloni@bootlin.com>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        <patches@opensource.cirrus.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rtc: wm8350: remove unnecessary messages
Message-ID: <20230828081604.GI103419@ediswmail.ad.cirrus.com>
References: <20230827221643.544259-1-alexandre.belloni@bootlin.com>
 <20230827221643.544259-3-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230827221643.544259-3-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: JiOia3lQeezZCj-wOAixdCiZ2IaT-I7o
X-Proofpoint-GUID: JiOia3lQeezZCj-wOAixdCiZ2IaT-I7o
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:16:42AM +0200, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> The RTC core already prints a message when the RTC is registered and when
> registering fails, it is not necessary to have more in the driver.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
