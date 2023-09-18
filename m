Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B397A44C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbjIRIck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240859AbjIRIca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:32:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690B794;
        Mon, 18 Sep 2023 01:32:24 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38I4SDOo011029;
        Mon, 18 Sep 2023 03:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=SXnGouhKU9giKLo
        p5w4uYodidnQQJlKtrkLKl4wy8BA=; b=DJ8z/cRmK0XPcVjFWnfxxb4h7xNx5xY
        XGuYWUtqjOcNKZ5lrTfHQvgk8eTeRXkDg8FcaPMgjSLDv75YCwoHeB+0iJUttp+Y
        fRCF289CBvj+zB4UnKmdoQJF9o61oK0t+6a4G0iTjmno2o+A4Do24vxwd/RzlIiT
        xfk1LKI5ig20plUSyzRmLr7qmmE1CWz/Dwy6mMz7tpUSF5xhQXD8HTZJmqFZmDnv
        tFmib55Hys2pTO7zjVfmUwqoseRwga50plyIyIn4oP/jq2xXjqAMnOkclJniGsQ7
        1R7HK4r+D50Bds73QpWwbidneGfGvFlmn8OXzKN3nKHpZMst+smQhKg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t59ry232k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 03:31:42 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 18 Sep
 2023 09:31:40 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 18 Sep 2023 09:31:40 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3ADA43563;
        Mon, 18 Sep 2023 08:31:40 +0000 (UTC)
Date:   Mon, 18 Sep 2023 08:31:40 +0000
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
Subject: Re: [PATCH v3 1/3] ASoC: wm8782: Constrain maximum audio rate at
 runtime
Message-ID: <20230918083140.GV103419@ediswmail.ad.cirrus.com>
References: <20230917173726.1916439-1-contact@jookia.org>
 <20230917173726.1916439-2-contact@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230917173726.1916439-2-contact@jookia.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: b2Vlsqie4lg6Mnt0x56Mb5Y7c1QzJ9tY
X-Proofpoint-ORIG-GUID: b2Vlsqie4lg6Mnt0x56Mb5Y7c1QzJ9tY
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 03:37:24AM +1000, John Watts wrote:
> The wm8782 supports up to 192kHz audio when pins are set correctly.
> Instead of hardcoding which rates are supported constrain them at
> runtime based on a max_rate variable.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
