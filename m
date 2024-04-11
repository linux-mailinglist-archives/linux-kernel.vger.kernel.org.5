Return-Path: <linux-kernel+bounces-140201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FCA8A0CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6614C28371E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33514145B0D;
	Thu, 11 Apr 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY1JBLEA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFB913FD80;
	Thu, 11 Apr 2024 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828971; cv=none; b=LY9YPyWSEUtElkhogX2suEzZYOigvs3u8WxI4dGIDAklzQ/1uVFRCKJoQX0HRKYsLNsAtVjvnvHeZi6+0JNSkVnBdgFt2Xt6daL2xcbgnsyr3dLxGKz78S4Rvdr6m9qC3QjtnOTHV1S/hC5eIDNlIqzhat6ECKfBtxSa09MzRLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828971; c=relaxed/simple;
	bh=+e34Pb3pZ1eg94TgXhBzORR5jz/zvBqwI7txDmuccvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J51Y9NkQpzEKCHcTIPlx2LrCCJ2QSQZ+44MYYfxliCEKxWhLP8KR1/cIN7j8pDEpXU5Bzjr5cJ2ow4l452l/441r+nGhhn6P9ZXF+ncIp4aXu04cVaVPfptagJL/r8FQ2iuCmbIuFp9N4660oQYD55Yxx5wxDTppYD/BGuGqn+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY1JBLEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CE8C433C7;
	Thu, 11 Apr 2024 09:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712828971;
	bh=+e34Pb3pZ1eg94TgXhBzORR5jz/zvBqwI7txDmuccvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GY1JBLEAkpKc9458lEMO1wnDyXbJ3NMgZWQpxjRF+tJiMTivgCJercSi+X7UhfciK
	 1HRCEL+qXUG5IyERDDalInO6re3w0u4C10Lrtx4cIMKHKm/W1gkr0oBxQjrJ54ycp5
	 dZ/FDvZl2tQpTt7KrbM5OH5zqAwkcu/fWL4WZxgCGftTg4wTAt7wCwQd7P8ovgVQ8Y
	 eSHB4NZFpoavhIIcO21XCH+KXmysCThmyKRT4h0tc6BgN6zJ8Da+SOhRvEIW50LRmT
	 2ffaRMvmJoiDUxym72uWgKOhQ8BJZJKbLcsv6kqVAa8kK+xLwCXs/X9fYNfKHlC2Ca
	 6QMz2hXVtK7+Q==
Date: Thu, 11 Apr 2024 15:19:27 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] soundwire: qcom: allow multi-link on newer devices
Message-ID: <ZheyJ5PORudx9gsK@matsya>
References: <20240405144141.47217-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405144141.47217-1-krzysztof.kozlowski@linaro.org>

On 05-04-24, 16:41, Krzysztof Kozlowski wrote:
> Newer Qualcomm SoCs like X1E80100 might come with four speakers spread
> over two Soundwire controllers, thus they need a multi-link Soundwire
> stream runtime.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Only rebase (slightly different context)

Applying /tmp/v2_20240405_krzysztof_kozlowski_soundwire_qcom_allow_multi_link_on_newer_devices.mbx
Applying: soundwire: qcom: allow multi-link on newer devices
error: drivers/soundwire/qcom.c: does not match index
Patch failed at 0001 soundwire: qcom: allow multi-link on newer devices

This fails as well :-(


> ---
>  drivers/soundwire/qcom.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index fb70afe64fcc..ce5cf3ecceb5 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -905,6 +905,18 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  	return 0;
>  }
>  
> +static int qcom_swrm_read_prop(struct sdw_bus *bus)
> +{
> +	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
> +
> +	if (ctrl->version >= SWRM_VERSION_2_0_0) {
> +		bus->multi_link = true;
> +		bus->hw_sync_min_links = 3;
> +	}
> +
> +	return 0;
> +}
> +
>  static enum sdw_command_response qcom_swrm_xfer_msg(struct sdw_bus *bus,
>  						    struct sdw_msg *msg)
>  {
> @@ -1056,6 +1068,7 @@ static const struct sdw_master_port_ops qcom_swrm_port_ops = {
>  };
>  
>  static const struct sdw_master_ops qcom_swrm_ops = {
> +	.read_prop = qcom_swrm_read_prop,
>  	.xfer_msg = qcom_swrm_xfer_msg,
>  	.pre_bank_switch = qcom_swrm_pre_bank_switch,
>  };
> @@ -1173,6 +1186,15 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
>  
>  	mutex_lock(&ctrl->port_lock);
>  	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> +		/*
> +		 * For streams with multiple masters:
> +		 * Allocate ports only for devices connected to this master.
> +		 * Such devices will have ports allocated by their own master
> +		 * and its qcom_swrm_stream_alloc_ports() call.
> +		 */
> +		if (ctrl->bus.id != m_rt->bus->id)
> +			continue;
> +
>  		if (m_rt->direction == SDW_DATA_DIR_RX) {
>  			maxport = ctrl->num_dout_ports;
>  			port_mask = &ctrl->dout_port_mask;
> -- 
> 2.34.1

-- 
~Vinod

