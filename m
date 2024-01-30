Return-Path: <linux-kernel+bounces-44497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3A68422D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FAD1C21A50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F426BB50;
	Tue, 30 Jan 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DGLz/eeY"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74206BB34;
	Tue, 30 Jan 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613588; cv=none; b=h6keGb3pQ2xtTVI0Pl+wJ1cXg+aA7+xrXjZDjBMpXkrV7dGMTZt4F/sfqsFk86nFTfIKimb1nlHwohSDdAhIzlcL1CI3C6QGot5unktkBror4/AlR1lXsuqiIkKqfYzF5r5VeNJ83oHLD+aX5Qhiwo/1hR5aALhk71iJ5ApSto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613588; c=relaxed/simple;
	bh=eVKTN5aZD14ysRn5DdnFUUMpDWXE/AboMcyV1o2Xpbc=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ApNTNDBmNWiyE3Fvc5nG3b4nfWil/D/+QhlaL7FzTbAyZNPsqet6SSFJZyAH0wqsD/CGFeRw0+9E+cgKbZn6rAZj3TBXNeW30Pj/dybDODdaz3CuxjqiuD4gQxkPCyeqy6L7O7y/94WyoMf0zBiG4Xrq37ZuYagfwY+eQBi9K24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DGLz/eeY; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U5tDAh019737;
	Tue, 30 Jan 2024 05:19:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:references:in-reply-to:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=1md0/+DFGXhuMmn6zyLi7ooEyZ2b5ftMM6ksvLmC2To=; b=
	DGLz/eeY5rCTJkdzi5q+jBvaQSoWVMx3Wwm+a7LXEGppX1VSabD0AAk2OXr10cM5
	26YVJ3fjGbXF1Ri4Gdi+KVeZknYyUM7WHuv5Gzpg450WgQ46ikcYxqk8MCO8lZWM
	kbPD5QcKYzjHr/wDOt3R6HstuVwwdX+Hrc3SXK4MReNeFY4bo1IgtxRTLF43SF+K
	7pwfd/eHq1u9M/ros7DpRm+SPJbEkgyqKTLLBNp4Wcp7XfCOtj+ZaNTaPnJL3Dim
	WWPRp9p0hNWT2MoK9F4nkxl+kDuwHa8ITDWtLs/zBWyK20Z61azJctzyjJBQkHBC
	6rTUBTF3O0rvF+5VfTOA/Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nu8bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 05:19:38 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 11:19:37 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Tue, 30 Jan 2024 11:19:37 +0000
Received: from LONN2DGDQ73 (LONN2DGDQ73.ad.cirrus.com [198.61.65.148])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1279B820241;
	Tue, 30 Jan 2024 11:19:37 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: 'Takashi Iwai' <tiwai@suse.de>, 'Chhayly Leang' <clw.leang@gmail.com>
CC: 'Takashi Iwai' <tiwai@suse.com>, <patches@opensource.cirrus.com>,
        "'James
 Schulman'" <james.schulman@cirrus.com>,
        'David Rhodes'
	<david.rhodes@cirrus.com>,
        'Richard Fitzgerald' <rf@opensource.cirrus.com>,
        'Jaroslav Kysela' <perex@perex.cz>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240126080912.87422-1-clw.leang@gmail.com> <87il3b3wub.wl-tiwai@suse.de>
In-Reply-To: <87il3b3wub.wl-tiwai@suse.de>
Subject: RE: [PATCH] ALSA: hda: cs35l41: Support ASUS Zenbook UM3402YAR
Date: Tue, 30 Jan 2024 11:19:36 +0000
Message-ID: <001601da536e$35a56270$a0f02750$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQJ251DEbDtU4Ub6108ES0yN5WkQpgKO1N6zr6SXE5A=
X-Proofpoint-ORIG-GUID: qHlTe7WycikxKQhWyfkSCMseqP5ak77C
X-Proofpoint-GUID: qHlTe7WycikxKQhWyfkSCMseqP5ak77C
X-Proofpoint-Spam-Reason: safe

Hi,

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, January 30, 2024 11:06 AM
> To: Chhayly Leang <clw.leang@gmail.com>
> Cc: Stefan Binding <sbinding@opensource.cirrus.com>; Takashi Iwai
> <tiwai@suse.com>; patches@opensource.cirrus.com; James Schulman
> <james.schulman@cirrus.com>; David Rhodes
> <david.rhodes@cirrus.com>; Richard Fitzgerald
> <rf@opensource.cirrus.com>; Jaroslav Kysela <perex@perex.cz>; linux-
> sound@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ALSA: hda: cs35l41: Support ASUS Zenbook
> UM3402YAR
> 
> On Fri, 26 Jan 2024 09:09:12 +0100,
> Chhayly Leang wrote:
> >
> > Adds sound support for ASUS Zenbook UM3402YAR with missing DSD
> >
> > Signed-off-by: Chhayly Leang <clw.leang@gmail.com>
> 
> Yet another missing entry; can Cirrus people review this before I
> merge?

Looks good to me.

Thanks,
Stefan

> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  sound/pci/hda/cs35l41_hda_property.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/sound/pci/hda/cs35l41_hda_property.c
> b/sound/pci/hda/cs35l41_hda_property.c
> > index 35277ce890a..2af083183d8 100644
> > --- a/sound/pci/hda/cs35l41_hda_property.c
> > +++ b/sound/pci/hda/cs35l41_hda_property.c
> > @@ -76,6 +76,7 @@ static const struct cs35l41_config
> cs35l41_config_table[] = {
> >  	{ "10431533", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 0, 1, -1, 1000, 4500, 24 },
> >  	{ "10431573", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 1, 2, 0, 1000, 4500, 24 },
> >  	{ "10431663", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 1, -1, 0, 1000, 4500, 24 },
> > +	{ "10431683", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 0, 1, -1, 0, 0, 0 },
> >  	{ "104316D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 1, 2, 0, 0, 0, 0 },
> >  	{ "104316F3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 1, 2, 0, 0, 0, 0 },
> >  	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 0, 1, -1, 1000, 4500, 24 },
> > @@ -410,6 +411,7 @@ static const struct cs35l41_prop_model
> cs35l41_prop_model_table[] = {
> >  	{ "CSC3551", "10431533", generic_dsd_config },
> >  	{ "CSC3551", "10431573", generic_dsd_config },
> >  	{ "CSC3551", "10431663", generic_dsd_config },
> > +	{ "CSC3551", "10431683", generic_dsd_config },
> >  	{ "CSC3551", "104316D3", generic_dsd_config },
> >  	{ "CSC3551", "104316F3", generic_dsd_config },
> >  	{ "CSC3551", "104317F3", generic_dsd_config },
> > --
> > 2.42.0
> >



