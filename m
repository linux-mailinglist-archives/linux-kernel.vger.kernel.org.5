Return-Path: <linux-kernel+bounces-83775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D556A869E56
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F56A1F26B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E12B4F213;
	Tue, 27 Feb 2024 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="yzdzyNvt"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A281487E0;
	Tue, 27 Feb 2024 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056412; cv=none; b=tnSKZlU5ZVXDuK42SYD2kmsr3WGYgDwRfrHV2D+yy1pdl8zllWfEBZmUyIVo20/piaEEHkSNRDClpl+06yE9P7X0ADxGZKMUspwT2QaHMNsdHzWmoNXat1CrQ805eFxFbTfARgGyqg6SEBWVycjTr2D/AHCcPndzN7L16rY7XKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056412; c=relaxed/simple;
	bh=c90nDEyQ9o6pvTcW0BOnwG8XDipWFoGcy4Cc229zvz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMAsOENv+30lO4g7bYikhl4uptc0+MLh63GUYxqlL9A0E5wkYJbe7jYrRWVr0UlXWtzgiuXuYgJaJdozThMI47W08LEfbDYr4EOh0cEsnUsbGmax15Se6SAoPY7zop1rYrdi6MlYJqvRxuMJElZLdVE+drIkuWHbseaqsvSoNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=yzdzyNvt; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 5B7D2214FB;
	Tue, 27 Feb 2024 18:53:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1709056408;
	bh=LKeDRUHtoiqOMYcLDtZAVbnU3PdygZ0zlrtrdsKagF8=; h=From:To:Subject;
	b=yzdzyNvtTXl/zNpCf8cFRsrGrhKsr+qrQJMpET+wKzJxNODHCVvFnWamw2cqROZDT
	 m3dEuR3JvCGetiJpfTmcmG0MOFms/Rvgc9XX4IjCCha5pAGZ8rNd9z8tA7U10Nh+/9
	 nC662E2VpOtsMRyEWD51yPkEod+AYG7K8+kyI/F173CrIZlqpPMe3bf3AhyJmgM5jH
	 eTorhaYYewY4JY1S6PuvPgWjFaCtv/GroVQiay58E7c5oP4ud/Rs57f7tqDf3/r5UK
	 kV1U9gk2koCaEt0lCVtlqFX5+iK9qE+tSZwxEREOFgZnUCJ6zsrjeOSvhBh3dKUtDh
	 nH3OK+4xKBqpg==
Date: Tue, 27 Feb 2024 18:53:26 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v8 2/2] wifi: mwifiex: add host mlme for AP mode
Message-ID: <20240227175326.GC11034@francesco-nb>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <20231222032123.1036277-3-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222032123.1036277-3-yu-hao.lin@nxp.com>

On Fri, Dec 22, 2023 at 11:21:23AM +0800, David Lin wrote:
> Add host based MLME to enable WPA3 functionalities in AP mode.
> This feature required a firmware with the corresponding V2 Key API
> support. The feature (WPA3) is currently enabled and verified only
> on IW416. Also, verified no regression with change when host MLME
> is disabled.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

with the same disclaimer from patch 1/2, I'm not a wireless driver expert.

> ---
> 
> v8:
>    - first full and complete patch to support host based MLME for AP
>      mode.
> 
> ---
>  .../net/wireless/marvell/mwifiex/cfg80211.c   |  79 +++++++-
>  drivers/net/wireless/marvell/mwifiex/cmdevt.c |   2 +
>  drivers/net/wireless/marvell/mwifiex/fw.h     |  21 +++
>  drivers/net/wireless/marvell/mwifiex/ioctl.h  |   5 +
>  .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
>  .../net/wireless/marvell/mwifiex/uap_cmd.c    | 171 ++++++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/util.c   |  24 +++
>  7 files changed, 301 insertions(+), 3 deletions(-)
> 

..

> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> index e78a201cd150..1e7f4afe9960 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> @@ -760,6 +786,144 @@ static int mwifiex_cmd_uap_sta_deauth(struct mwifiex_private *priv,
>  	return 0;
>  }
>  
> +/* This function prepares AP specific add station command.
> + */
> +static int mwifiex_cmd_uap_add_station(struct mwifiex_private *priv,
> +				       struct host_cmd_ds_command *cmd,
> +				       u16 cmd_action, void *data_buf)
> +{
> +	struct host_cmd_ds_add_station *new_sta = &cmd->params.sta_info;
> +	struct mwifiex_sta_info *add_sta = (struct mwifiex_sta_info *)data_buf;
> +	struct station_parameters *params = add_sta->params;
> +	struct mwifiex_sta_node *sta_ptr;
> +	u8 *pos;
> +	u8 qos_capa;
> +	u16 header_len = sizeof(struct mwifiex_ie_types_header);
> +	u16 tlv_len;
> +	int size;
> +	struct mwifiex_ie_types_data *tlv;
> +	struct mwifiex_ie_types_sta_flag *sta_flag;
> +	int i;
> +
> +	cmd->command = cpu_to_le16(HostCmd_CMD_ADD_NEW_STATION);
> +	new_sta->action = cpu_to_le16(cmd_action);
> +	size = sizeof(struct host_cmd_ds_add_station) + S_DS_GEN;
> +
> +	if (cmd_action == HostCmd_ACT_ADD_STA)
> +		sta_ptr = mwifiex_add_sta_entry(priv, add_sta->peer_mac);
> +	else
> +		sta_ptr = mwifiex_get_sta_entry(priv, add_sta->peer_mac);
> +
> +	if (!sta_ptr)
> +		return -1;
> +
> +	memcpy(new_sta->peer_mac, add_sta->peer_mac, ETH_ALEN);
> +
> +	if (cmd_action == HostCmd_ACT_REMOVE_STA)
> +		goto done;

This goto here, skipping lot of code, just to do

  cmd->size = cpu_to_le16(size);
  return 0;

is not really nice for my personal taste, but fine like that.

Francesco

