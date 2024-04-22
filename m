Return-Path: <linux-kernel+bounces-152872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50498AC588
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997751F24023
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A4D53814;
	Mon, 22 Apr 2024 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNdDQvcq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C851037;
	Mon, 22 Apr 2024 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770700; cv=none; b=BKCBh4PAdTWAJQ9ausCLRQBY0AFR9TTD/1xqP6rBacvZ7wxKZMUpMqtNyHL7o81C2dA93BpEEc241u677mufFhYnxIqlrULFodbclBqI00vFoDIRNH0sCkwun4eHhAe//ZfiYWcDgPLZZKl7fKOSVvGlXYItOb3uMOAFwy6+AAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770700; c=relaxed/simple;
	bh=n1rgUnp+TQN8uWTIEcVitLd7jUdMIkcsybmOH7TAZDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXtVY8MCYE+kMRlXEyiQBLVYayOUQDXr3zymxKHHHTwBkmbbw2ANcC0oZjnMwcXmPo+vAuDmZmSAseD2Bj4/PwoKmAbwjjuY50Mdq+t0PQE+kYG4bgd95VOKudC/bQHUJjDzZCxu01p6JegQqCvldIKE4+GgvV6TsGqnC8fHXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNdDQvcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C12C113CC;
	Mon, 22 Apr 2024 07:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770699;
	bh=n1rgUnp+TQN8uWTIEcVitLd7jUdMIkcsybmOH7TAZDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNdDQvcq3vorF+4E/GkyW3Slc1cKMfuikW6UJWa5Q1Nw/MLXBBskJVr3CZVE/FrVV
	 ujwUNsRTCw2V3HEFMEC1kv7Ly9C2a3MsxXtSejilKS3nJfam3MajMs9Gezu1iRA4g4
	 41xUqxSy8StJ/+EiwVk89Y3tUAr4Qj6IpygcUTS33Q5zbFj8osSJh9s0SLmGdp0DWw
	 OgBnpzQO5j97U9QRYYLWMsaPP61b0c/MshrGnd7VnYynl/klGnImS/IU+n2zkFjWtK
	 AiK76IXJhUkO67rWRMv05RmNq6rP+x11SaRt1kWkzKbElKJY+ATvTtKhNlxDD/ba4R
	 fx8S+ZGbdzyQQ==
Date: Mon, 22 Apr 2024 12:54:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, quic_jhugo@quicinc.com,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v3 1/3] bus: mhi: host: Add sysfs entry to force device
 to enter EDL
Message-ID: <20240422072446.GA9775@thinkpad>
References: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
 <1713170945-44640-2-git-send-email-quic_qianyu@quicinc.com>
 <20240415115616.GF7537@thinkpad>
 <a62cb28a-e6ab-4f60-9210-b7aa8e0c34e0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a62cb28a-e6ab-4f60-9210-b7aa8e0c34e0@quicinc.com>

On Tue, Apr 16, 2024 at 01:45:18PM +0800, Qiang Yu wrote:
> 
> On 4/15/2024 7:56 PM, Manivannan Sadhasivam wrote:
> > On Mon, Apr 15, 2024 at 04:49:03PM +0800, Qiang Yu wrote:
> > > Add sysfs entry to allow users of MHI bus force device to enter EDL.
> > > Considering that the way to enter EDL mode varies from device to device and
> > > some devices even do not support EDL. Hence, add a callback edl_trigger in
> > > mhi controller as part of the sysfs entry to be invoked and MHI core will
> > > only create EDL sysfs entry for mhi controller that provides edl_trigger
> > > callback. All of the process a specific device required to enter EDL mode
> > > can be placed in this callback.
> > > 
> > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > > ---
> > >   Documentation/ABI/stable/sysfs-bus-mhi | 11 +++++++++++
> > >   drivers/bus/mhi/host/init.c            | 35 ++++++++++++++++++++++++++++++++++
> > >   include/linux/mhi.h                    |  2 ++
> > >   3 files changed, 48 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
> > > index 1a47f9e..d0bf9ae 100644
> > > --- a/Documentation/ABI/stable/sysfs-bus-mhi
> > > +++ b/Documentation/ABI/stable/sysfs-bus-mhi
> > > @@ -29,3 +29,14 @@ Description:	Initiates a SoC reset on the MHI controller.  A SoC reset is
> > >                   This can be useful as a method of recovery if the device is
> > >                   non-responsive, or as a means of loading new firmware as a
> > >                   system administration task.
> > > +
> > > +What:           /sys/bus/mhi/devices/.../force_edl
> > s/force_edl/trigger_edl
> > 
> > > +Date:           April 2024
> > > +KernelVersion:  6.9
> > > +Contact:        mhi@lists.linux.dev
> > > +Description:    Force devices to enter EDL (emergency download) mode. Only MHI
> > How can the user trigger EDL mode? Writing to this file? If so, what is the
> > value?
> 
> User can trigger EDL mode by writing a non-zero value to this file.
> 
> > 
> > 'Emergency Download'
> > 
> > > +                controller that supports EDL mode and provides a mechanism for
> > > +                manually triggering EDL contains this file. Once in EDL mode,
> > 'This entry only exists for devices capable of entering the EDL mode using the
> > standard EDL triggering mechanism defined in the MHI spec <insert the version>.'
> > 
> > > +                the flash programmer image can be downloaded to the device to
> > > +                enter the flash programmer execution environment. This can be
> > > +                useful if user wants to update firmware.
> > It'd be good to mention the OS tool like QDL that is used to download firmware
> > over EDL.
> 
> OK, can I add an additionnal line like this
> Users:          Any OS tools that is used to download firmware over EDL like
> QDL.
> 
> > 
> > > diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> > > index 44f9349..333ac94 100644
> > > --- a/drivers/bus/mhi/host/init.c
> > > +++ b/drivers/bus/mhi/host/init.c
> > > @@ -127,6 +127,32 @@ static ssize_t soc_reset_store(struct device *dev,
> > >   }
> > >   static DEVICE_ATTR_WO(soc_reset);
> > > +static ssize_t force_edl_store(struct device *dev,
> > s/force_edl/trigger_edl
> > 
> > > +			       struct device_attribute *attr,
> > > +			       const char *buf, size_t count)
> > > +{
> > > +	struct mhi_device *mhi_dev = to_mhi_device(dev);
> > > +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> > > +	unsigned long val;
> > > +	int ret;
> > > +
> > > +	ret = kstrtoul(buf, 10, &val);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "Could not parse string: %d\n", ret);
> > No need to print error.
> > 
> > > +		return ret;
> > > +	}
> > > +
> > > +	if (!val)
> > > +		return count;
> > What does this mean?
> 
> If user want to trigger EDL mode,he has to write a non-zero value to this
> file. If he writes zero, nothing will happen.
> 

You need to throw -EINVAL for invalid inputs ie., <= 0.

> Do we need to limit the valid value to a specific value like 1?
> 

That's not needed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

