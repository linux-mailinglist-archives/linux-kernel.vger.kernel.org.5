Return-Path: <linux-kernel+bounces-145014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72668A4E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620F71F219CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D5A664B7;
	Mon, 15 Apr 2024 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9KDrW6r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3D634E2;
	Mon, 15 Apr 2024 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182183; cv=none; b=CyoiBHkBEjuaTYnqjciIv25O8Ev4ZmI5T4CLDJD6u/NsX5HXm8Pwo78FNjxg/PX5+iJmSlCp53/2+iOnXHKVPp8kxZgLDeHxYMnqr9plTXqX4I08L4gFJpWlFUg20prfM3Tcd78dNqRe/k2hhkj4oD1CBmHoXhwTzpvnlDE5Cbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182183; c=relaxed/simple;
	bh=Y7NdTGJ5WllEpMCU0vHN/6b9JSORAL8KQcYrFDsZBEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk0yajq2+v/p4sYIIWRNTyhWa8g9o4cPzXusAmzziVMjpgMDUV9KolhlIvXazhDxsfSnAHTdoXKA+ZLoVrzm+t41wu5AZbuD5vXgIhh2rsZx11dhnc2b3rTLGPyuUVAtjCI1ERrqZuFgWUa9jB/NZgqYBnS5OAZj7lbS1SEif/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9KDrW6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70507C113CC;
	Mon, 15 Apr 2024 11:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713182182;
	bh=Y7NdTGJ5WllEpMCU0vHN/6b9JSORAL8KQcYrFDsZBEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9KDrW6rzI4upgYlURPA9wBKJaXXTAehYjqV6mSy9lM7v4cOyvOEJ1YGuI8bUCq2b
	 klXoY1sHxZuy8IgLj6gbl5Id/bVP0Kx2Ybyi1wQyI9sHAo1mQtG5vVCzM9HulnttA8
	 aXl2Xb9F2nJ7hgTiTEDQnDcbc1mhIUZ/egqsRmp/L5tlPjMg5YD5lPp470nUqyklxd
	 mwXKPe2cM1ZzUMvw9lWLkiH9k07ENAs1XOBzvVDk21woQUmWtpzpNRssjHQX7a1jhh
	 7sU4L3mJY8PZ1BBxcOc9P+5nE4TRHkl/1qJfBc0qrbNAmM1kRC4oO114kVnds1PAIo
	 baTBv894ravpQ==
Date: Mon, 15 Apr 2024 17:26:16 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: quic_jhugo@quicinc.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v3 1/3] bus: mhi: host: Add sysfs entry to force device
 to enter EDL
Message-ID: <20240415115616.GF7537@thinkpad>
References: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
 <1713170945-44640-2-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1713170945-44640-2-git-send-email-quic_qianyu@quicinc.com>

On Mon, Apr 15, 2024 at 04:49:03PM +0800, Qiang Yu wrote:
> Add sysfs entry to allow users of MHI bus force device to enter EDL.
> Considering that the way to enter EDL mode varies from device to device and
> some devices even do not support EDL. Hence, add a callback edl_trigger in
> mhi controller as part of the sysfs entry to be invoked and MHI core will
> only create EDL sysfs entry for mhi controller that provides edl_trigger
> callback. All of the process a specific device required to enter EDL mode
> can be placed in this callback.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  Documentation/ABI/stable/sysfs-bus-mhi | 11 +++++++++++
>  drivers/bus/mhi/host/init.c            | 35 ++++++++++++++++++++++++++++++++++
>  include/linux/mhi.h                    |  2 ++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
> index 1a47f9e..d0bf9ae 100644
> --- a/Documentation/ABI/stable/sysfs-bus-mhi
> +++ b/Documentation/ABI/stable/sysfs-bus-mhi
> @@ -29,3 +29,14 @@ Description:	Initiates a SoC reset on the MHI controller.  A SoC reset is
>                  This can be useful as a method of recovery if the device is
>                  non-responsive, or as a means of loading new firmware as a
>                  system administration task.
> +
> +What:           /sys/bus/mhi/devices/.../force_edl

s/force_edl/trigger_edl

> +Date:           April 2024
> +KernelVersion:  6.9
> +Contact:        mhi@lists.linux.dev
> +Description:    Force devices to enter EDL (emergency download) mode. Only MHI

How can the user trigger EDL mode? Writing to this file? If so, what is the
value?

'Emergency Download'

> +                controller that supports EDL mode and provides a mechanism for
> +                manually triggering EDL contains this file. Once in EDL mode,

'This entry only exists for devices capable of entering the EDL mode using the
standard EDL triggering mechanism defined in the MHI spec <insert the version>.'

> +                the flash programmer image can be downloaded to the device to
> +                enter the flash programmer execution environment. This can be
> +                useful if user wants to update firmware.

It'd be good to mention the OS tool like QDL that is used to download firmware
over EDL.

> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 44f9349..333ac94 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -127,6 +127,32 @@ static ssize_t soc_reset_store(struct device *dev,
>  }
>  static DEVICE_ATTR_WO(soc_reset);
>  
> +static ssize_t force_edl_store(struct device *dev,

s/force_edl/trigger_edl

> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct mhi_device *mhi_dev = to_mhi_device(dev);
> +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> +	unsigned long val;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret < 0) {
> +		dev_err(dev, "Could not parse string: %d\n", ret);

No need to print error.

> +		return ret;
> +	}
> +
> +	if (!val)
> +		return count;

What does this mean?

> +
> +	ret = mhi_cntrl->edl_trigger(mhi_cntrl);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(force_edl);
> +
>  static struct attribute *mhi_dev_attrs[] = {
>  	&dev_attr_serial_number.attr,
>  	&dev_attr_oem_pk_hash.attr,
> @@ -1018,6 +1044,12 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  	if (ret)
>  		goto err_release_dev;
>  
> +	if (mhi_cntrl->edl_trigger) {
> +		ret = sysfs_create_file(&mhi_dev->dev.kobj, &dev_attr_force_edl.attr);
> +		if (ret)
> +			goto err_release_dev;
> +	}
> +
>  	mhi_cntrl->mhi_dev = mhi_dev;
>  
>  	mhi_create_debugfs(mhi_cntrl);
> @@ -1051,6 +1083,9 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
>  	mhi_deinit_free_irq(mhi_cntrl);
>  	mhi_destroy_debugfs(mhi_cntrl);
>  
> +	if (mhi_cntrl->edl_trigger)
> +		sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_force_edl.attr);
> +
>  	destroy_workqueue(mhi_cntrl->hiprio_wq);
>  	kfree(mhi_cntrl->mhi_cmd);
>  	kfree(mhi_cntrl->mhi_event);
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index cde01e1..8280545 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -353,6 +353,7 @@ struct mhi_controller_config {
>   * @read_reg: Read a MHI register via the physical link (required)
>   * @write_reg: Write a MHI register via the physical link (required)
>   * @reset: Controller specific reset function (optional)
> + * @edl_trigger: CB function to enter EDL mode (optional)

s/enter/trigger

- Mani

-- 
மணிவண்ணன் சதாசிவம்

