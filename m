Return-Path: <linux-kernel+bounces-152931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4898AC649
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA681C20EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542234E1D9;
	Mon, 22 Apr 2024 08:06:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5298502A3;
	Mon, 22 Apr 2024 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773177; cv=none; b=ZTUSI5MBUBDKh2gIWkkIA7OvSObR8ZsjATsN82N9QBKNO60B7NFYLOxSm6JuM7j9tnEg7Uwvo1S1GWHvtjW8SLZfr28/Z1lKO/v1xly2xVRrmZUvxzEBGNrnNlM8GuMg73+5/aEA2A35In4aLceNvoBSdWCM0DfpvMHztW0eJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773177; c=relaxed/simple;
	bh=wq+CiAOkBhbaPfNxLl01fN5pEr+i+/JBNleBv3P9oWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EicESuOJuTJq2WLMUpywXbVQgTI5/7FTfmV1OxkQeaPlKE6q/zf4jdQHSwjCc++hzENofs5jdFGcpgKy0NOKbzOLsO2apgB3eWzEF+gQOL3GVZA0X7Rot2iHC3sey2u7FLGb7DSTQ9yWCWtwiSlTH+9UnnxIT6xBWMXVLW9yD9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B019339;
	Mon, 22 Apr 2024 01:06:40 -0700 (PDT)
Received: from bogus (unknown [10.57.84.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D86F3F7BD;
	Mon, 22 Apr 2024 01:06:08 -0700 (PDT)
Date: Mon, 22 Apr 2024 09:06:06 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, souvik.chakravarty@arm.com,
	mturquette@baylibre.com
Subject: Re: [PATCH v3 0/5] Rework SCMI Clock driver clk_ops setup procedure
Message-ID: <20240422080606.zai2sgr74o3dcasp@bogus>
References: <20240415163649.895268-1-cristian.marussi@arm.com>
 <6b8e12767fdfaf1ba819896fbd610733.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b8e12767fdfaf1ba819896fbd610733.sboyd@kernel.org>

On Fri, Apr 19, 2024 at 07:08:54PM -0700, Stephen Boyd wrote:
> Quoting Cristian Marussi (2024-04-15 09:36:44)
> > Hi,
> > 
> > a small series to review how the SCMI Clock driver chooses and sets up the
> > CLK operations to associate to a clock when registering with CLK framework.
> 
> Did you want me to merge this through clk tree?

I am fine either way. You add:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

if you prefer to take it. Or else please provide your ack for me to
take it via SCMI tree.

-- 
Regards,
Sudeep

