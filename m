Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EEF797CE5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbjIGTlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjIGTlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:41:01 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D6DCE9;
        Thu,  7 Sep 2023 12:40:58 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3879g1s5014439;
        Thu, 7 Sep 2023 14:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        content-type:mime-version:subject:from:in-reply-to:date:cc
        :content-transfer-encoding:message-id:references:to; s=
        PODMain02222019; bh=8Q2FE7o81owhXFer2OtaRJ0nbORoYwm42s7QqzBNa2g=; b=
        cJjtMPvc/eIjFhvmY1wmb1dUxfYlHe1JKhmIChukcma7gx3qfahNLrrhwn9S+Ppd
        dFcOwFeY4ZIaHhajB4xs/qHLZ5ZlnTKkYvhldu69rKAcHjqJ4ULbAtV/+9u7bivP
        av9GmHcmGDwyDE14MZfMr6/+y4EIw9SJUKFyzotoSQX8jb/cyp5wxX8hRHMEaCGK
        IaG7tWDaK8xykz8Lwi9r4IffvMiKcgROTRdkFgsqnlPoeaQamegG2sX/Xo9r0ANO
        5oNzku2pmIOO5r5ny61IgmY3j5qtqlSpW0SX9Cd+B+4m5ghX4QGQ0NlBGkF/Wt6t
        8GusLv5gwWWi767Eh7+I0w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sv2ex75w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 14:40:29 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 7 Sep
 2023 20:40:27 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 7 Sep 2023 20:40:27 +0100
Received: from smtpclient.apple (macC02FN0GLMD6T.ad.cirrus.com [141.131.156.171])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2277715B4;
        Thu,  7 Sep 2023 19:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3 1/4] ASoC: cs35l45: Checks index of cs35l45_irqs[]
From:   "Rivera-Matos, Ricardo" <rriveram@opensource.cirrus.com>
In-Reply-To: <20230901084843.GZ103419@ediswmail.ad.cirrus.com>
Date:   Thu, 7 Sep 2023 14:40:14 -0500
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
Message-ID: <0FA27CCC-83F1-4358-B914-35C0FF135A06@opensource.cirrus.com>
References: <20230831162042.471801-1-vkarpovi@opensource.cirrus.com>
 <20230901084843.GZ103419@ediswmail.ad.cirrus.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Proofpoint-ORIG-GUID: mfOg2b6W0M_x268ezV1Q3O3bEITlMAXH
X-Proofpoint-GUID: mfOg2b6W0M_x268ezV1Q3O3bEITlMAXH
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 1, 2023, at 3:48 AM, Charles Keepax =
<ckeepax@opensource.cirrus.com> wrote:
>=20
> On Thu, Aug 31, 2023 at 11:20:39AM -0500, Vlad Karpovich wrote:
>> From: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
>>=20
>> Checks the index computed by the virq offset before printing the
>> error condition in cs35l45_spk_safe_err() handler.
>>=20
>> Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
>> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
>> ---
>> sound/soc/codecs/cs35l45.c | 5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
>> index 2ac4612402eb..02b1172d2647 100644
>> --- a/sound/soc/codecs/cs35l45.c
>> +++ b/sound/soc/codecs/cs35l45.c
>> @@ -1023,7 +1023,10 @@ static irqreturn_t cs35l45_spk_safe_err(int =
irq, void *data)
>>=20
>> i =3D irq - regmap_irq_get_virq(cs35l45->irq_data, 0);
>>=20
>> - dev_err(cs35l45->dev, "%s condition detected!\n", =
cs35l45_irqs[i].name);
>> + if (i < 0 || i >=3D ARRAY_SIZE(cs35l45_irqs))
>=20
> I am happy enough for this to be merged, since it clearly does
> no harm. So:
>=20
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>=20
> But I do still have a slight reservation of what is the point
> of this error check?  This handler is static and can only be
> called from within cs35l45.c and the only code that registers
> IRQs goes through the cs35l45_irqs array and registers IRQs
> from there, so how does this ever end up with i being out of
> bounds?
>=20
> And whilst I would not add this to this patch. I do also think
> perhaps Ricardo had a point in his email, the IRQ handler
> should probably be renamed, since it handles more than just
> the spk_safe_err's, perhaps something like cs35l45_report_err.
> On why the watchdog and global error call this as well, that
> was a review comment on an earlier patch since the handlers for
> those errors only printed a message, they might as well be
> combined with the spk_safe error that also only printed a
> message. If at some point separate handling is added for them
> they can be split out.

Thanks Charles, I had missed that comment. It=E2=80=99s clear to me now.
>=20
> Thanks,
> Charles

Acked-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com =
<mailto:rriveram@opensource.cirrus.com>>

