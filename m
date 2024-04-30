Return-Path: <linux-kernel+bounces-164186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FCF8B7A66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C761C226AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DDA17B4E6;
	Tue, 30 Apr 2024 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GVfN5bDH"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB9770F0;
	Tue, 30 Apr 2024 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488064; cv=none; b=X9LS0/FZD1POZz4eqOvkDVBHFx3FM9lYDo6i2moLF8DfudxuR2x5kM8wEnpkCUkhQ3k4A9KMVUHPfVGCtOsQd3+zEWbbbz+6L3VvK8yXYIXzy12UuxmAasfEJe6nsnFmsjH38Pw8PCF7XBE4+WCVimSA951MFyugX1hPZuqsycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488064; c=relaxed/simple;
	bh=mF4D0bjwFYpqf3wf5iTDpehEqt73WSoAjWjD4DyHamk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TyeLA9o1AObMr8yIb7z62i5ONPyvRuTQwh1JL5zzqIsCxhW88fjjlfFLe2+otzrap0imib8+9iaoUMs/8WOuv/EriiLG2/qQR2zbDsUfl5EzjYJdBVV8xQ3bSeOr2zk4OtwXxzsA1DwvMx4XqrRHIcuxJmSNjaZ+aedbFrp/49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GVfN5bDH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UEdMBq005235;
	Tue, 30 Apr 2024 14:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=YwM+R5Y3CMJbTvogva1QfzG8leQfU778k06xwg/Mcwc=;
 b=GVfN5bDHVzxlH7qQ8GoMldAWpUGXDu9QFtzQT37hrJ/s13hreQDUokgjoIaCMqsXYUtk
 MSq8PkQ219gEjPc0cr2GW9qzRlf7oJc4QTzxHXBBjoS55K6k7ohamqhJ3HIiV/ZsvY+t
 K4ZCyITW3v7DoLqeJ5LLuYl+qz+zzMSDI4qcT+Io75bHZnI3+RFelbaMbZB7RVauG8/W
 H67InC2pGe++yoRCdKM1DEKQKCSE1YNanjEpy/LysALASXjWyuZbGwXTvXIG/oSUG4DW
 7fAfGp1ZNKBRf7EttySjWvQQ09d6RNpmD6JcNhzivBnYyHDJBMrQDl//ouYCqEMDw8ss LA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xu2k9005y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:40:50 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43UDTXSh003210;
	Tue, 30 Apr 2024 14:40:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscppdghg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:40:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43UEekXj11272672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 14:40:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23FF92006E;
	Tue, 30 Apr 2024 14:40:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E212420040;
	Tue, 30 Apr 2024 14:40:45 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 30 Apr 2024 14:40:45 +0000 (GMT)
Date: Tue, 30 Apr 2024 16:40:44 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>, imx@lists.linux.dev,
        Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] clk: imx: imx8mp: Add missing CONFIG_PM ifdefs
Message-ID: <20240430144044.35561-A-hca@linux.ibm.com>
References: <CA+G9fYuP7S+a89Ep5g5_Ad69EMwRkJ8nM+MMTzbEcP+6H2oMXQ@mail.gmail.com>
 <20240430141609.2244416-1-hca@linux.ibm.com>
 <99ef1ba3-155f-47e8-b1a4-e46cb056cbfd@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ef1ba3-155f-47e8-b1a4-e46cb056cbfd@app.fastmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cAhw_NzK7JsV_S9ipQmmkWxam1nOQf_L
X-Proofpoint-GUID: cAhw_NzK7JsV_S9ipQmmkWxam1nOQf_L
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300104

On Tue, Apr 30, 2024 at 04:30:37PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 30, 2024, at 16:16, Heiko Carstens wrote:
> > Add missing CONFIG_PM ifdefs to fix this allmodconfig compile error:
> >
> > drivers/clk/imx/clk-imx8mp-audiomix.c:356:12: error:
> > 'clk_imx8mp_audiomix_runtime_suspend' defined but not used
> > [-Werror=unused-function]
> >   356 | static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: 
> > https://lore.kernel.org/r/CA+G9fYuP7S+a89Ep5g5_Ad69EMwRkJ8nM+MMTzbEcP+6H2oMXQ@mail.gmail.com
> > Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for 
> > power saving")
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Thanks for your patch. I see the bug as well, but
> I think a better fix is to replace the deprecated
> SET_RUNTIME_PM_OPS() and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS()
> with the modern variants, RUNTIME_PM_OPS() and
> RUNTIME_PM_OPS().

Fine with me, I leave that up to the original author then.

