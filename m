Return-Path: <linux-kernel+bounces-158624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB978B232B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D492874A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACA7149DE3;
	Thu, 25 Apr 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/y6tfKz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67A1494C4;
	Thu, 25 Apr 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053188; cv=none; b=pAtBgY6qfJ2iqQtaRIoYE/ke4U8OAQlojqZa+qirfEeLEMdbTsSbHWOXEszfx5LYs4+5Ywf+cAWQbS8otgj8uKvRQ/oVyHHNpZ7y8HHD0xMk5T8qcl/HAMvgvH0mXpvEm87M1k4xliwFPgXt3xu8nxmyibWrDU20kmB64bFp4lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053188; c=relaxed/simple;
	bh=q8Fc8bGuKfZhJ9bV0xXSD+ms886NX3ElTyriE5uXRjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OptD8Fq/pVVB52bjxctv+bqhzU9nAo1Avu2Fwu1JwURax6ssGn3/H+d1ffsD0KWWdBZv00zsIcNv3BtWPAk0EXq1SQoDKed5RLGKW0O080i3Rvyw6E/4F/AzDzck4RVW6eLNDaCTgt+fulbM6CUYyCw7O2Qq03hYHiN8pISlkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/y6tfKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03FDC113CC;
	Thu, 25 Apr 2024 13:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053188;
	bh=q8Fc8bGuKfZhJ9bV0xXSD+ms886NX3ElTyriE5uXRjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/y6tfKzgFh32a1GAYHkZYBY4XB5U60kptxA3VLkB7ThcyhGxdwn3537Inle8EDAl
	 DWbmehmNneYuzgjywEOTgoo/CLdCSQ88tiMkyi2IC7O+t2Uwn48C4tvYIbmAw4WdhS
	 HR1zyVofPZP0RXl1mbctHuebcCDvx2bLsPqX/Y5aFCYOfyafnP6CHDpux950e9dMfI
	 uw1ZsfeghqQzhVYEm0euFEa5wN3f3/kQNh0NFT6cKC1CbPEFlsqaT4+RmxrqhEC0mg
	 a4r2igcre9HEd1B7phjo67twtiYQbZpj+ueTLIp55OPkp4Mce0enx8R+rgVZhc9WF3
	 tNWZtCuYSVSqQ==
Date: Thu, 25 Apr 2024 19:23:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: mani@kernel.org, quic_jhugo@quicinc.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v4 1/3] bus: mhi: host: Add sysfs entry to force device
 to enter EDL
Message-ID: <20240425135300.GE3449@thinkpad>
References: <1713868417-37856-1-git-send-email-quic_qianyu@quicinc.com>
 <1713868417-37856-2-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1713868417-37856-2-git-send-email-quic_qianyu@quicinc.com>

On Tue, Apr 23, 2024 at 06:33:35PM +0800, Qiang Yu wrote:
> Add sysfs entry to allow users of MHI bus force device to enter EDL.
> Considering that the way to enter EDL mode varies from device to device and
> some devices even do not support EDL. Hence, add a callback edl_trigger in
> mhi controller as part of the sysfs entry to be invoked and MHI core will
> only create EDL sysfs entry for mhi controller that provides edl_trigger
> callback. All of the process a specific device required to enter EDL mode
> can be placed in this callback.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

One nitpick below. But I'll fix it while applying.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  Documentation/ABI/stable/sysfs-bus-mhi | 13 +++++++++++++
>  drivers/bus/mhi/host/init.c            | 33 +++++++++++++++++++++++++++++++++
>  include/linux/mhi.h                    |  2 ++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
> index 1a47f9e..b44f467 100644
> --- a/Documentation/ABI/stable/sysfs-bus-mhi
> +++ b/Documentation/ABI/stable/sysfs-bus-mhi
> @@ -29,3 +29,16 @@ Description:	Initiates a SoC reset on the MHI controller.  A SoC reset is
>                  This can be useful as a method of recovery if the device is
>                  non-responsive, or as a means of loading new firmware as a
>                  system administration task.
> +
> +What:           /sys/bus/mhi/devices/.../trigger_edl
> +Date:           April 2024
> +KernelVersion:  6.9

6.9 is done, now we are working for 6.10 (feature wise).

- Mani

> +Contact:        mhi@lists.linux.dev
> +Description:    Writing a non-zero value to this file will force devices to
> +                enter EDL (Emergency Download) mode. This entry only exists for
> +                devices capable of entering the EDL mode using the standard EDL
> +                triggering mechanism defined in the MHI spec v1.2. Once in EDL
> +                mode, the flash programmer image can be downloaded to the
> +                device to enter the flash programmer execution environment.
> +                This can be useful if user wants to use QDL (Qualcomm Download,
> +                which is used to download firmware over EDL) to update firmware.
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 44f9349..7104c18 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -127,6 +127,30 @@ static ssize_t soc_reset_store(struct device *dev,
>  }
>  static DEVICE_ATTR_WO(soc_reset);
>  
> +static ssize_t trigger_edl_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct mhi_device *mhi_dev = to_mhi_device(dev);
> +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> +	unsigned long val;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!val)
> +		return -EINVAL;
> +
> +	ret = mhi_cntrl->edl_trigger(mhi_cntrl);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(trigger_edl);
> +
>  static struct attribute *mhi_dev_attrs[] = {
>  	&dev_attr_serial_number.attr,
>  	&dev_attr_oem_pk_hash.attr,
> @@ -1018,6 +1042,12 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  	if (ret)
>  		goto err_release_dev;
>  
> +	if (mhi_cntrl->edl_trigger) {
> +		ret = sysfs_create_file(&mhi_dev->dev.kobj, &dev_attr_trigger_edl.attr);
> +		if (ret)
> +			goto err_release_dev;
> +	}
> +
>  	mhi_cntrl->mhi_dev = mhi_dev;
>  
>  	mhi_create_debugfs(mhi_cntrl);
> @@ -1051,6 +1081,9 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
>  	mhi_deinit_free_irq(mhi_cntrl);
>  	mhi_destroy_debugfs(mhi_cntrl);
>  
> +	if (mhi_cntrl->edl_trigger)
> +		sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_trigger_edl.attr);
> +
>  	destroy_workqueue(mhi_cntrl->hiprio_wq);
>  	kfree(mhi_cntrl->mhi_cmd);
>  	kfree(mhi_cntrl->mhi_event);
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index cde01e1..d968e1a 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -353,6 +353,7 @@ struct mhi_controller_config {
>   * @read_reg: Read a MHI register via the physical link (required)
>   * @write_reg: Write a MHI register via the physical link (required)
>   * @reset: Controller specific reset function (optional)
> + * @edl_trigger: CB function to trigger EDL mode (optional)
>   * @buffer_len: Bounce buffer length
>   * @index: Index of the MHI controller instance
>   * @bounce_buf: Use of bounce buffer
> @@ -435,6 +436,7 @@ struct mhi_controller {
>  	void (*write_reg)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
>  			  u32 val);
>  	void (*reset)(struct mhi_controller *mhi_cntrl);
> +	int (*edl_trigger)(struct mhi_controller *mhi_cntrl);
>  
>  	size_t buffer_len;
>  	int index;
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

