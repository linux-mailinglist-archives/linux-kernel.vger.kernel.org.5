Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2727797CFA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbjIGTtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjIGTtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:49:14 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF2BCE9;
        Thu,  7 Sep 2023 12:49:10 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 387IfbE1028366;
        Thu, 7 Sep 2023 14:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        content-type:mime-version:subject:from:in-reply-to:date:cc
        :content-transfer-encoding:message-id:references:to; s=
        PODMain02222019; bh=wpcCB1XXiTxtp4A/yEkAREYNKjUpf9GsXoBRPflBxIs=; b=
        GwXEOP0IuPbWhv8WisKYsokLHxAgdmsLEa1aTSvBOl5U8cbcnXnW/xN3IoxeuADs
        27EnghnKGLjSchLLllPFe2Xd1xL7+skhzkxZMJsBpf9+UZ9+jVQ9GmTv5sPr5eqr
        JudN1bpzFH4CtQRVvxe6nQCseHq0chmUEBTg7fva9H5trc/x2Ol/oeyaAxFxREBR
        /4Ulc7f8roVFZHU6BreyXviCEJSfCiH8a160eYGreIStNBFGMnKrHuR9+BVuxFiX
        divc9im+WVpgOTTbqjrufJJYBZ+aYnK+Wc7+BdcbK9xJv1ABg6ECxN35TBn6+DR4
        m9mpcpY3g3T8o/sojKeSuw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sv1fhx3mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 14:48:49 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 7 Sep
 2023 20:48:48 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 7 Sep 2023 20:48:48 +0100
Received: from smtpclient.apple (macC02FN0GLMD6T.ad.cirrus.com [141.131.156.171])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1FEDE458;
        Thu,  7 Sep 2023 19:48:46 +0000 (UTC)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3 3/4] ASoC: cs35l45: Connect DSP to the monitoring
 signals
From:   "Rivera-Matos, Ricardo" <rriveram@opensource.cirrus.com>
In-Reply-To: <20230901085025.GB103419@ediswmail.ad.cirrus.com>
Date:   Thu, 7 Sep 2023 14:48:35 -0500
CC:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-ID: <3EEF7D10-C220-4D23-856B-249994084CF3@opensource.cirrus.com>
References: <20230831162042.471801-1-vkarpovi@opensource.cirrus.com>
 <20230831162042.471801-3-vkarpovi@opensource.cirrus.com>
 <20230901085025.GB103419@ediswmail.ad.cirrus.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Proofpoint-ORIG-GUID: tP_D_MR_2ZRWMl8uKWjmus0j1vMGtdA9
X-Proofpoint-GUID: tP_D_MR_2ZRWMl8uKWjmus0j1vMGtdA9
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 1, 2023, at 3:50 AM, Charles Keepax =
<ckeepax@opensource.cirrus.com> wrote:
>=20
> On Thu, Aug 31, 2023 at 11:20:41AM -0500, Vlad Karpovich wrote:
>> Link VMON, IMON, TEMPMON, VDD_BSTMON and VDD_BATTMON
>> to DSP1. The CSPL firmware uses them for the speaker calibration
>> and monitoring.
>>=20
>> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
>> ---
>=20
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>=20
> Thanks,
> Charles

Acked-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>=
