Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD1C797CFE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbjIGTuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjIGTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:50:04 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61BBCE9;
        Thu,  7 Sep 2023 12:50:00 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 387F7qxN020114;
        Thu, 7 Sep 2023 14:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        content-type:mime-version:subject:from:in-reply-to:date:cc
        :content-transfer-encoding:message-id:references:to; s=
        PODMain02222019; bh=Db0NqmTGuh52sxm5Jkky1R2+22W8xh7Z98LTGOLaCj8=; b=
        QnGFebaoLc7aoJtnat6cJLSJTAmmDrvOtSVfgDOBXTR3DmC6f56uw+zp32TZTAFl
        VX8rJDUZaJI8MFUXE92oXvUbdvtubq3vzinCwQiHIVGZIk1g5X9xJIGa29qoKUKp
        5gdXdTFuZKGr06CjzCfautU3hknle3L2UwMPvZ4PuZe8QDVgrAWQzRRTpgKQlSgz
        zWqwtJyP3BMI6Ay5MG6SgvruiNs5KNvv2Vt1SZJD76Sbk/AWj1YJx1UUqiZ1q+NC
        SHm0VV05VhELqAPJHUsiGyBPmVldeBPyn6Qq31GxgcZEQJh2tNDJs1CsSO/zdX7c
        E3MzQt7KfMrbYGPPUKBglw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sv2ex766c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 14:49:43 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 7 Sep
 2023 20:49:40 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 7 Sep 2023 20:49:40 +0100
Received: from smtpclient.apple (macC02FN0GLMD6T.ad.cirrus.com [141.131.156.171])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B5841458;
        Thu,  7 Sep 2023 19:49:38 +0000 (UTC)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3 4/4] ASoC: cs35l45: Add AMP Enable Switch control
From:   "Rivera-Matos, Ricardo" <rriveram@opensource.cirrus.com>
In-Reply-To: <20230901085039.GC103419@ediswmail.ad.cirrus.com>
Date:   Thu, 7 Sep 2023 14:49:28 -0500
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
Message-ID: <199C31E4-1154-4C60-A846-6B8D12598D8D@opensource.cirrus.com>
References: <20230831162042.471801-1-vkarpovi@opensource.cirrus.com>
 <20230831162042.471801-4-vkarpovi@opensource.cirrus.com>
 <20230901085039.GC103419@ediswmail.ad.cirrus.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Proofpoint-ORIG-GUID: mNrc0qiF602fbNMlKB0D6J6hgn5SWA31
X-Proofpoint-GUID: mNrc0qiF602fbNMlKB0D6J6hgn5SWA31
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 1, 2023, at 3:50 AM, Charles Keepax =
<ckeepax@opensource.cirrus.com> wrote:
>=20
> On Thu, Aug 31, 2023 at 11:20:42AM -0500, Vlad Karpovich wrote:
>> The "AMP Enable Switch" is useful in systems with multiple
>> amplifiers connected to the same audio bus
>> but not all of them are needed for all use cases.
>>=20
>> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
>> ---
>=20
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>=20
> Thanks,
> Charles

Acked-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>=
