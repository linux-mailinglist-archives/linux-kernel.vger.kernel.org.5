Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F347A44C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbjIRIdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbjIRIcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:32:46 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FD69D;
        Mon, 18 Sep 2023 01:32:40 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38I7O8XX001877;
        Mon, 18 Sep 2023 03:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=HsckZib0kFdqRd8
        2p0LZ8kH9k0yEhEP6k9JatP9VGes=; b=m7M9Ucu/STqmjERe1LoG4Xbu5nIM/k4
        YEhzWc147R16dKfspSF7QbKjyjXtjGFbqilfOJ/bEdaGO7ol3P/oShqD2TvjCtKR
        kt6TGurIW2BD4UPPUIJc277bh5/APPsSvBzKcf2FOMODkpBBRhZf7JK/VO+h/FP6
        S/VxspiY5D9LJVEReP+WpjB4c31UZA6pERILpH1UHlTgOvSyFpMmj3UYs813zd0C
        MXDTsgbVJ18Yu3MEFViDNgq8dlAB8yv58nBr9WktW0RJQeOKxXmka72DtpVP0TbS
        WiyfyjR0kX7bGR2OrGLxBwf5SKeT7BZqNGIbweRz2AISvnIks5SDWVw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t58shsk2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 03:32:09 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 18 Sep
 2023 09:32:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Mon, 18 Sep 2023 09:32:07 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 31AF711AA;
        Mon, 18 Sep 2023 08:32:07 +0000 (UTC)
Date:   Mon, 18 Sep 2023 08:32:07 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     John Watts <contact@jookia.org>
CC:     <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] ASoC: wm8782: Use wlf,fsampen device tree property
Message-ID: <20230918083207.GW103419@ediswmail.ad.cirrus.com>
References: <20230917173726.1916439-1-contact@jookia.org>
 <20230917173726.1916439-3-contact@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230917173726.1916439-3-contact@jookia.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: KkdlL0r5u1LbZqE6Pn15FkmZ0gVSsQWs
X-Proofpoint-ORIG-GUID: KkdlL0r5u1LbZqE6Pn15FkmZ0gVSsQWs
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 03:37:25AM +1000, John Watts wrote:
> The wm8782 supports rates 96kHz and 192kHz as long as the hardware
> is configured properly. Allow this to be specified in the device tree.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
