Return-Path: <linux-kernel+bounces-49793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CC0846F75
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBD41C24457
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8319313EFF7;
	Fri,  2 Feb 2024 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piMwGDYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFCD13E22B;
	Fri,  2 Feb 2024 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874725; cv=none; b=D0SwyceiLLVztUvGRZ560LvvW/KsoqRF2VBO+n0AxZTdXT+IMkyoi9RXLsWgLm51wjclFz+wOyR/gz2l2SF5k37fjaz6CSlY3SUFRszfw+NiYScZAY8DLtlAoYE22Xfdq/Ha7N/xVp4R+ixC3jaFlZL7jJyFuLvNGrIbNw68T8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874725; c=relaxed/simple;
	bh=rfyC29dgn3AiLpQ41hkAc/jedTFSLQEOT9DvwX/eNqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxFs3jzPBRa+8V+i5i8AJJewk/aA/gnBA1sj9aiDFWeGW+ApsSHdDLkEsq24016Q2J/nVEPmDUhCQ+9Jlsp7ck2mjAHajReRqfmlRbZi3+tuW97RCYKaZhfcAnMeDvYJjM5EBe/yEMdKZpRGNgh+HLok/iFfWaNW9KU14gvMRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piMwGDYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BEFC433F1;
	Fri,  2 Feb 2024 11:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874724;
	bh=rfyC29dgn3AiLpQ41hkAc/jedTFSLQEOT9DvwX/eNqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=piMwGDYfY8riUgZvSlUZHlFnPQhiCq3/y1vxq6ljys8VCbR/su/RVtW3XTn3Eji5x
	 njG/qNNi0jHeciTV8VRKowmKRPDprAUXpT2YhbQ6srgi3csNfD9mVs3Jg3f/01WEMg
	 qgGBs9eFwGPixk3SdGKlKEJnV+toWBTL52QwAxTggzX0FlfdqgZFfGBMenHi49ofEj
	 4BKCjYem3Ino1QtJpkr3ev9sIAxU1/Z80o6k0gLRKxklRjXQb/LBHX8OUKVH+9pvcK
	 tuhl24r6hMDFnSuVNu475MxbGHJ3DwhvL66TA0LqtEKUbit5QSMS3CdgEmdvTu9hWQ
	 vlbO3AjdTkHjQ==
Date: Fri, 2 Feb 2024 12:51:51 +0100
From: Simon Horman <horms@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	leitao@debian.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/8] net: netconsole: add a userdata
 config_group member to netconsole_target
Message-ID: <20240202115151.GL530335@kernel.org>
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
 <20240126231348.281600-6-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126231348.281600-6-thepacketgeek@gmail.com>

On Fri, Jan 26, 2024 at 03:13:40PM -0800, Matthew Wood wrote:
> Create configfs machinery for netconsole userdata appending, which depends
> on CONFIG_NETCONSOLE_DYNAMIC (for configfs interface). Add a userdata
> config_group to netconsole_target for managing userdata entries as a tree
> under the netconsole configfs subsystem. Directory names created under the
> userdata directory become userdatum keys; the userdatum value is the
> content of the value file.
> 
> Include the minimum-viable-changes for userdata configfs config_group.
> init_target_config_group() ties in the complete configfs machinery to
> avoid unused func/variable errors during build. Initializing the
> netconsole_target->group is moved to init_target_config_group, which
> will also init and add the userdata config_group.
> 
> Each userdatum entry has a limit of 256 bytes (54 for
> the key/directory, 200 for the value, and 2 for '=' and '\n'
> characters), which is enforced by the configfs functions for updating
> the userdata config_group.
> 
> When a new netconsole_target is created, initialize the userdata
> config_group and add it as a default group for netconsole_target
> config_group, allowing the userdata configfs sub-tree to be presented
> in the netconsole configfs tree under the userdata directory.
> 
> Co-developed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Hi Matthew,

some minor feedback from my side, as it looks like there will be another
revision of this patchset anyway.

> ---
>  drivers/net/netconsole.c | 143 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 139 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c

..

> @@ -596,6 +606,123 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
>  	return -EINVAL;
>  }
>  
> +struct userdatum {
> +	struct config_item item;
> +	char value[MAX_USERDATA_VALUE_LENGTH];
> +};
> +
> +static inline struct userdatum *to_userdatum(struct config_item *item)
> +{
> +	return container_of(item, struct userdatum, item);
> +}

Please don't use the inline keyword in C files,
unless there is a demonstrable reason to do so.
Rather, please let the compiler inline code as is sees fit.

..

> @@ -640,6 +767,14 @@ static const struct config_item_type netconsole_target_type = {
>  	.ct_owner		= THIS_MODULE,
>  };
>  
> +static void init_target_config_group(struct netconsole_target *nt, const char *name)

nit: Networking still prefers code to be 80 columns wide or less.

..

