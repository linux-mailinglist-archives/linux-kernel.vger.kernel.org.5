Return-Path: <linux-kernel+bounces-42892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80631840830
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300921F26672
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F39C65BBB;
	Mon, 29 Jan 2024 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pIvpz/tM"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F1657D6;
	Mon, 29 Jan 2024 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538213; cv=none; b=SAZJrd5d8l2Tx7P1X5rv6KrUCPLQ487fY40mAugfm9TcC81yjzkAyZ0kWXSOVJiblPWlwfS4CHNJTQZObKDK1TVkW/iWq2pu6id3XHTLCvgLEgrWX4j/PIi8LuYrETdm9LJck5y4J7iQ7Mn9K3lzn3yk2yWWHt+uIwz/3cM+sKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538213; c=relaxed/simple;
	bh=vW6TNIkeck9BpwYQUg+4uWlPjC9obh2Y2AixNJRS0k4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj8uRCZRzN7ETwEtaMIWIelGJdktKRK9Vn1nBx1qLwHOR2oSmPY5y/infsZqWs5yNcqVaSwIJSMaXKQZLBh58k/ZwVCI2/F8FqzXFiphtr6x0my6L7UVnwL1XQ5O6BX8lq3geMQ0gNbkKceUEvCsgDtU6sOATofJtitNWNkwiT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pIvpz/tM; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4qVf0031043;
	Mon, 29 Jan 2024 08:23:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=EYYIOSJVY3d6bCG
	KoPIC2EeJcrPTQrMYy67pwh4YFx4=; b=pIvpz/tMT4GpaHkLwy4YIHa2toYpVoo
	rv8Tr0BfBpi3Ff64G4bcySN8S2tFwzz0FpTkACTLl17QUWzL2aA8bi0ZcjDsU9rA
	Oqo8LpeSMaPsRcpKd0vJ0eygQe+5bNmMQDZlJmjsl2lDrOD1lpGYoeeiTWV+F8Zv
	xzUotVP3SQRTCZqAvaJEMXIpxM1Ogezak18fjtBqDQV5iYu6PEhTIt6XN2I93VSl
	3NGWDmvbF7oDKrX8AVldDow80CNmT80uRqocOXb537+2afAR4efD+w1sohry5fBG
	7bV9CnDHvxt4/u92NPdzGeuSUvZruFhE8FQ2bhHVDQoXEyzA8avQ0Ng==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vw043t3sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 08:23:09 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 14:23:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 14:23:07 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 42AB4820242;
	Mon, 29 Jan 2024 14:23:07 +0000 (UTC)
Date: Mon, 29 Jan 2024 14:23:06 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
CC: Mark Brown <broonie@kernel.org>,
        Cezary Rojewski
	<cezary.rojewski@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>,
        Bard Liao
	<yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen
	<kai.vehmanen@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23
 for MTL
Message-ID: <Zbe0yi5Qo1eG5yCk@ediswmail9.ad.cirrus.com>
References: <20240123113246.75539-1-mstrozek@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240123113246.75539-1-mstrozek@opensource.cirrus.com>
X-Proofpoint-ORIG-GUID: -_gIoV694mP0SnotpE1zKJindY_rtzTY
X-Proofpoint-GUID: -_gIoV694mP0SnotpE1zKJindY_rtzTY
X-Proofpoint-Spam-Reason: safe

On Tue, Jan 23, 2024 at 11:32:46AM +0000, Maciej Strozek wrote:
> The layout is configured as:
> - Link0: CS42L43 Jack and mics (2ch)
> - Link2: 2x CS35L56 Speaker (amps 3 and 4, right)
> - Link3: 2x CS35L56 Speaker (amps 1 and 2, left)
> 
> Corresponding SOF topology:
> https://github.com/thesofproject/sof/pull/8773
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

