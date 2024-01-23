Return-Path: <linux-kernel+bounces-35947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B423483990A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A521F2D459
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ABE8614E;
	Tue, 23 Jan 2024 18:59:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3685582D9E;
	Tue, 23 Jan 2024 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036375; cv=none; b=tOuHyeQmYojiKLXHU9yA6b2CAt7cdV5uRjaryrAwJ1M7H1XDTngZ7xOz+VrwH813B1GWmmiG/m0hk7W8r6ibwDCzBgOikRuaxslLls9aLysYUtvOntP58P/uRx+ISDeA6Y1UMu1s+Cb1WahoHzeJP2o2Bdj6aOf9W0ZWZbfGsjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036375; c=relaxed/simple;
	bh=bnVw0ffKgVOq+CzE6GW0VBCiI3gY758pcaofpgNUL+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI2CrDza7zsm6UehKhZeu4pth0a9f14pShvyzBAQE4bsInlsnOzF2upbRXpyJeZiv/HS+WepHrgkX9qZqSFDuCnrgRSTWlm+Ik18zZ1O8Onguxi5/u9peuTFfYndo18a6VusyWwvgdaQQtWSKTIfrOtDrwA5RaODX1cUWN6xSAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85FEF1FB;
	Tue, 23 Jan 2024 11:00:16 -0800 (PST)
Received: from bogus (unknown [10.57.78.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A908E3F762;
	Tue, 23 Jan 2024 10:59:29 -0800 (PST)
Date: Tue, 23 Jan 2024 18:56:18 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: cristian.marussi@arm.com, jdelvare@suse.com, linux@roeck-us.net,
	Sudeep Holla <sudeep.holla@arm.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] hwmon: scmi-hwmon: implement change_mode
Message-ID: <20240123185618.wt4k7j662sz4gsju@bogus>
References: <20240123150526.3615901-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123150526.3615901-1-peng.fan@oss.nxp.com>

On Tue, Jan 23, 2024 at 11:05:26PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 

hwmon: scmi-hwmon: implement change_mode

The above subject gives me no clue as what this change wants to achieve.
At minimum you need to mention thermal zones as HWMON supports more than
just thermal sensors and change mode mentioned in $subject applies to
only thermal zones.

> The sensor maybe disabled before kernel boot, so add change_mode
> to support configuring the sensor to enabled state.
>

Again above applies to thermal zones only in this patch. It doesn't
cover non-thermal sensors, so prefer if you refer it as thermal zones
instead of sensors.

The change itself looks good. I will ack once you fix the subject and
description so that Guenter can pick up the change.

-- 
Regards,
Sudeep

