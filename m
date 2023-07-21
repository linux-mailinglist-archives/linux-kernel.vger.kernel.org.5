Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C347F75C194
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGUI1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjGUI1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:27:52 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ABE272D;
        Fri, 21 Jul 2023 01:27:51 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36L6lJk1006552;
        Fri, 21 Jul 2023 03:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=TigA1hY1Lp5dH2f
        /AfywKcjJbfyrqtGA9PlhZpcqZG0=; b=nVL5zMcOd5WBpNgxVuyBhfKt948VOiU
        jqxO8lP+vlbPvbPsGiXxvESXQt1eUBGWYLMcyodW4nnEQ+P4wwpNx5pFMI+ORLII
        3iwS43SO3qOVFbTW4EJaLCt3i1JVGJSueZt85AYIgiPzUuL1ERQ7b2tWdUBBroRR
        0rvSVVfiyfpxeIqV9dN4WF1ZklKETAKq9HEctUWZjM6sHX8IIaf4J/PjBMgJq8n9
        eXIq2rfjUmBQaAQVX5RNvbHow+K6Afg/ax7zZp4gF81KFcXAMchZrqDCmeHy+uQd
        dg8507KSYsaEq7IxteO4BniTXffNe822AH+n3Z0jG2IzcVGAeHuPPig==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gy9c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 03:27:34 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 09:27:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Fri, 21 Jul 2023 09:27:32 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C586445;
        Fri, 21 Jul 2023 08:27:32 +0000 (UTC)
Date:   Fri, 21 Jul 2023 08:27:32 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee@kernel.org>, <vkoul@kernel.org>
CC:     <broonie@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <conor+dt@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH v5 0/6] Add cs42l43 PC focused SoundWire CODEC
Message-ID: <20230721082732.GJ103419@ediswmail.ad.cirrus.com>
References: <20230619095623.1987742-1-ckeepax@opensource.cirrus.com>
 <168992615492.1924396.13464534208592126033.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168992615492.1924396.13464534208592126033.b4-ty@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: yt4HPd4fkRFLiLXN7DRn-CNz-muYc-e7
X-Proofpoint-GUID: yt4HPd4fkRFLiLXN7DRn-CNz-muYc-e7
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 08:55:54AM +0100, Lee Jones wrote:
> On Mon, 19 Jun 2023 10:56:17 +0100, Charles Keepax wrote:
> > This patch chain adds support for the Cirrus Logic cs42l43 PC focused
> > SoundWire CODEC. The chain is currently based of Lee's for-mfd-next
> > branch.
> > 
> > Thanks,
> > Charles
> > 
> > [...]
> 
> Applied, thanks!
> 
> [2/6] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
>       commit: e62ba8443b11f12b45c61444249458a2f8c2f4ef
> [3/6] mfd: cs42l43: Add support for cs42l43 core driver
>       commit: 843079209e1506c94fde797fc0ff914e2c9e6645
> [4/6] pinctrl: cs42l43: Add support for the cs42l43
>       commit: 85f034dd7ff0a66aded653cc91dbc406fba7cf1a
> 

Only slight hiccup here is there is a build dependency between
the MFD and SoundWire patch. So without the SoundWire patch
the SoundWire part of the MFD won't build.

Vinod, would be really good if you could have a look at the
SoundWire patch would be great to get this moving, this part is
seeing a fair amount of deployment at the moment so getting this
into mainline would be very helpful.

Thanks,
Charles
