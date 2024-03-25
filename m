Return-Path: <linux-kernel+bounces-117721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC03C88AECD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB191FA3BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB1263D0;
	Mon, 25 Mar 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uuC/Ui9O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE04C92;
	Mon, 25 Mar 2024 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391749; cv=none; b=lDn+cVyrVwlEfX1LPQCvGz5RitfX157R4ZYBHSuzEXGepJlRTlvLr5QNiIq6/bVYvAQdj5mLp7zENUstAqWMSjze/ygLZPugpwcZOHxkDK4gaXfiZsXbRcB/Ug5pX/ShCQ/yxGlokH8GZyBX8xYKsk8/Ruj6dg/DvEZKe5hxIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391749; c=relaxed/simple;
	bh=5CdMefyATBgGCHIRqMk7725ESPjfqM7SgvpVwBuNyME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc9Gs0hO7Bwi1aPx8e18umBsXz/fNNgqAJQgjGZ55hkmh5NdlXtRSx28otef393VXAvMkkgmBNI6UAc8OLgTyZknpyOiEb0AWV6MH1G/ZFAWZAlur63v/4xKJNah4ZpLq38AgjgqzKN8KOjJvEFc/OoaaK7SCRZXv46kVBu2mIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uuC/Ui9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC207C43394;
	Mon, 25 Mar 2024 18:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711391749;
	bh=5CdMefyATBgGCHIRqMk7725ESPjfqM7SgvpVwBuNyME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uuC/Ui9O10UnSvEt3iSAcwMp8qy8/bdOuAIOMGkpJgKQQrQIqibm0PSIeNt7TP1gN
	 s1tmWqXJWECaehNVUUIlbLxE5Lpw1VhN7DewcaaSaTwCPm5u5ifX/gRV6hEVGELW+x
	 XsBlEWCjrT6HjMTSe59NQsZtW0JnkZQoVYbYeacA=
Date: Mon, 25 Mar 2024 19:35:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8712: Fix instances of lines ending with '('
Message-ID: <2024032546-earthworm-ardently-ed12@gregkh>
References: <ZgG6UC1Fiac7pDfa@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgG6UC1Fiac7pDfa@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Mon, Mar 25, 2024 at 11:24:24PM +0530, Ayush Tiwari wrote:
> Fix instances of lines ending with '(' to address checkpatch warning
> "lines should not add with a '(' " and conform to common kernel coding
> style.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_ioctl_rtl.h | 123 +++++++-------------
>  1 file changed, 41 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
> index 7c0b880ac686..70d48e6b4112 100644
> --- a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
> +++ b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
> @@ -18,92 +18,51 @@
>  #include "drv_types.h"
>  
>  /*************** oid_rtl_seg_01_01 **************/
> -uint oid_rt_get_signal_quality_hdl(
> -			struct oid_par_priv *poid_par_priv);/*84*/
> -uint oid_rt_get_small_packet_crc_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_middle_packet_crc_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_large_packet_crc_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_tx_retry_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_rx_retry_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_rx_total_packet_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_tx_beacon_ok_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_tx_beacon_err_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_rx_icv_err_hdl(
> -			struct oid_par_priv *poid_par_priv);/*93*/
> -uint oid_rt_set_encryption_algorithm_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_preamble_mode_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_ap_ip_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_channelplan_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_set_channelplan_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_set_preamble_mode_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_set_bcn_intvl_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_dedicate_probe_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_total_tx_bytes_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_total_rx_bytes_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_current_tx_power_level_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_enc_key_mismatch_count_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_enc_key_match_count_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_channel_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_hardware_radio_off_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_key_mismatch_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_supported_wireless_mode_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_channel_list_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_scan_in_progress_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_forced_data_rate_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_wireless_mode_for_scan_list_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_get_bss_wireless_mode_hdl(
> -			struct oid_par_priv *poid_par_priv);
> -uint oid_rt_scan_with_magic_packet_hdl(
> -			struct oid_par_priv *poid_par_priv);
> +uint oid_rt_get_signal_quality_hdl(struct oid_par_priv *poid_par_priv); /*84*/
> +uint oid_rt_get_small_packet_crc_hdl(struct oid_par_priv *poid_par_priv);

<snip>

Why are you keeping these functions that no one calls around at all?

Why not remove the ones that are not needed, and then, after cleaning
that all up, then worry about the few that are left to get into proper
shape here.

I would bet most of these aren't needed at all, right?

thanks,

greg k-h

