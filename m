Return-Path: <linux-kernel+bounces-64703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8605D8541B9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D189A1F21EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C986F945A;
	Wed, 14 Feb 2024 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="UzTr5fn/"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB833EA;
	Wed, 14 Feb 2024 03:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707880571; cv=none; b=ut98f2PqJtWsFiHkmQZNLWpw/Tl0CdO3ilsuc5Ng/gOTfiaMUvQPlFn8pMr8mKsGwHV3eZjuMKJ4ySXhfyi7Rnavs4kmQ4OSbF7O+p4JbStYY6Ex4qyd7VJ1BcE2szKCvVH0jfHDA2exsZCR0CfTPjiKaP37sNeBdr57kECGCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707880571; c=relaxed/simple;
	bh=+Q9XMabLHtXXcLBCri2MEt+Zj8W3nhrTULyowOO0Mg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IufBaoFe4//khmV2XVzw5U6cFhjQL10rkYsTx9e+elLMenTNmx9Y5YywY/3PeZvRB9uxjuIVfJJarSaOpu+uxQrIkGzJxuT1TsqLlGdPI7LO/LBNLod1TlGL+SDKl1QCgCCdXb318Xp9haQOvWmOZi39KZKmNDmsiW8no4Bmq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=UzTr5fn/; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DNXX9s020343;
	Wed, 14 Feb 2024 03:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pps0720; bh=fwHI8IKkaHcLSD5H8fNp0S1R+2+9iuvqdEoEGjw4yZg=;
 b=UzTr5fn/JAIxvRdjIkgN+khKuX7EnZVl7BBIdz7hQHZcpX0os8ltT4xYtyBYrNE+OIfT
 dlen7SOmHy1+H8lqH9SS1IwClL4eaqcdYk0nIK2zZSIld8mJzY2iKUhJlIHlrFULioXd
 UT0nC8EN2TGM0OTQSRbwLb/dcoxn2LuHD2F09hTbGN4aDiw6ZHGEUBhBIKoHMonoox10
 o41mgMUVY+mVbfbjbDHKrUuIxLENJ13OkZsX3OEHXJdsMEI4Z/KM4kKu1JEjMvPy3fZq
 /LjzJDSw6d2uqHLdKKewlgkbxPCjim2hfkuhh9eCCn1TXbLDKbNVXlHf8OQ/EyEmzhZk 8A== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3w8fqtv4bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 03:15:47 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D834580036D;
	Wed, 14 Feb 2024 03:15:38 +0000 (UTC)
Received: from perchik (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 49270800378;
	Wed, 14 Feb 2024 03:15:37 +0000 (UTC)
Date: Tue, 13 Feb 2024 20:15:35 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog/hpwdt: Support Suspend and Resume
Message-ID: <20240214031535.GH2879@perchik>
Reply-To: Jerry.Hoemann@hpe.com
References: <20240213070203.489846-1-jerry.hoemann@hpe.com>
 <7b70a8e7-10ce-4835-891c-b854919fa3cb@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b70a8e7-10ce-4835-891c-b854919fa3cb@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-ORIG-GUID: Kxcod8UR9wrfdgtdks4RCp3rzXbt6u0L
X-Proofpoint-GUID: Kxcod8UR9wrfdgtdks4RCp3rzXbt6u0L
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140024

On Tue, Feb 13, 2024 at 08:12:57AM -0800, Guenter Roeck wrote:
> On Tue, Feb 13, 2024 at 12:02:03AM -0700, Jerry Hoemann wrote:
> > Add call backs to support suspend and resume.
> > 
> 
> That makes me wonder if we should add something like
> 	watchdog_stop_on_suspend()
> to the watchdog core. Almost every watchdog driver supporting
> suspend/resume repeats the same sequence (except for the debug
> message). That is a separate question, though.

I think that is a good idea.

> 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > ---
> >  drivers/watchdog/hpwdt.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index 138dc8d8ca3d..6565cfaa8e57 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -378,11 +378,38 @@ static void hpwdt_exit(struct pci_dev *dev)
> >  	pci_disable_device(dev);
> >  }
> >  
> > +static int hpwdt_suspend(struct device *dev)
> > +{
> > +	dev_dbg(dev, "Suspend watchdog\n");
> > +
> 
> Doesn't the suspend / resume code already display such debug messages ?

It displays some.  I mostly was using to make sure that the
callback was being called.  I can drop it.


> 
> > +	if (watchdog_active(&hpwdt_dev))
> > +		hpwdt_stop();
> > +
> > +	return 0;
> > +}
> > +
> > +static int hpwdt_resume(struct device *dev)
> > +{
> > +	dev_dbg(dev, "Resume watchdog\n");
> > +
> > +	if (watchdog_active(&hpwdt_dev))
> > +		hpwdt_start(&hpwdt_dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(hpwdt_pm_ops, hpwdt_suspend, hpwdt_resume);
> 
> That disables / enables the watchdog as part of regular suspend/resume
> handling, meaning any hang during suspend/resume that happens later will
> hang the system. Sure you don't want to use SET_LATE_SYSTEM_SLEEP_PM_OPS()
> instead ?
> 
> Never mind, though. Your call, obviously.

Your suggestion would be an improvement.
Will change in version 2 of patch.


Thanks for the help.


> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks,
> Guenter

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------

