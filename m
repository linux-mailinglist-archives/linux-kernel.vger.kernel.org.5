Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934097AB3FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjIVOpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjIVOpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:45:01 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95186C6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:44:55 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38M71ctN016438;
        Fri, 22 Sep 2023 09:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:references:in-reply-to:subject:date:message-id
        :mime-version:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=XJqRG5xI5bhaWjmEpLSFVPWC2U94D2ZplOTSDb1L+QY=; b=
        UB14mOzOmBVaA+jPLL0P/g3SYikUVcYEK5aqq+uvViKyqKHCeGuIQE/IJ0MVYPwa
        UkHn2as5a/1ZL40E+eSzE7nAMVaFqQ5+sMqFE+sFnU6i+AX7R5vPiDu+9YNDXg7I
        bmmDnQTxu5oRtRsQdKdNQqE2QpalWAhslLABgqVm26plWBmpk8ekNnwM3pAP5EVs
        3TYaAk7zQ6yMGwdu7r47adtT4vJObS35K7lC5lzsqZ/i69PbP8NKeRTO57mrpG2Q
        ygeqewPdOIZqh6oMidoyTQ6joT+DMoyNCTUKmCAbaGXDuJcXsk8VOVY0Gp7KDCCV
        i5gd9TF0qny0emCt1/10Xg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t8tvhsan3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 09:44:32 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 22 Sep
 2023 15:44:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Fri, 22 Sep 2023 15:44:30 +0100
Received: from LONN2DGDQ73 (LONN2DGDQ73.ad.cirrus.com [198.61.65.157])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7D4B815B9;
        Fri, 22 Sep 2023 14:44:30 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     'Takashi Iwai' <tiwai@suse.de>
CC:     'Mark Brown' <broonie@kernel.org>,
        'Jaroslav Kysela' <perex@perex.cz>,
        'Takashi Iwai' <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230922142818.2021103-1-sbinding@opensource.cirrus.com> <87a5tecm2m.wl-tiwai@suse.de>
In-Reply-To: <87a5tecm2m.wl-tiwai@suse.de>
Subject: RE: [PATCH v1 0/2] ALSA: cs35l41: prevent old firmwares using unsupported commands
Date:   Fri, 22 Sep 2023 15:44:30 +0100
Message-ID: <005e01d9ed63$4b605550$e220fff0$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK3Dt8Nv883/5uOfTFCurOQPlFa6QMKDBpDrlRXuLA=
Content-Language: en-gb
X-Proofpoint-ORIG-GUID: ovuDJwJ7rBXnOnHp7tW06c-LVZ-Rwdoo
X-Proofpoint-GUID: ovuDJwJ7rBXnOnHp7tW06c-LVZ-Rwdoo
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Friday, September 22, 2023 3:36 PM
> To: Stefan Binding <sbinding@opensource.cirrus.com>
> Cc: Mark Brown <broonie@kernel.org>; Jaroslav Kysela
> <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; alsa-devel@alsa-
> project.org; linux-kernel@vger.kernel.org;
> patches@opensource.cirrus.com
> Subject: Re: [PATCH v1 0/2] ALSA: cs35l41: prevent old firmwares
using
> unsupported commands
> 
> On Fri, 22 Sep 2023 16:28:16 +0200,
> Stefan Binding wrote:
> >
> > Some systems use older firmware which does not support newer
> commands
> > which are used to enable external boost. For those systems, we can
> > workaround this by writing the registers directly.
> >
> > We can use the firmware version, stored inside cs_dsp, to
determine
> > whether or not the command is supported.
> > To achieve this, it requires a cleanup in the api, to pass the
cs_dsp
> > struct into the function.
> >
> > We can also remove the redundant boolean firmware_running from the
> HDA
> > driver, and use the equivalent state inside cs_dsp.
> 
> So those are fixes needed for 6.6 kernel?  Or they are something
new?

These are to fix the issue that was reported on the Lenovo Legion 7
16ACHg6,
which was introduced after the fixes to CS35L41 HDA System Suspend.

Thanks,
Stefan

> 
> > This chain is based on Mark's branch, since the api change was
made to
> > the function in sound/soc/codecs/cs35l41-lib.c.
> 
> I'd need a PR from Mark before applying those, then.
> 
> 
> thanks,
> 
> Takashi

