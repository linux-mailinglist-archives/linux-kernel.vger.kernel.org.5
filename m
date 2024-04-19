Return-Path: <linux-kernel+bounces-150933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E148AA6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FE6B225B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC6B53A1;
	Fri, 19 Apr 2024 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOjl9G2d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F72137E;
	Fri, 19 Apr 2024 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713492658; cv=none; b=dscI/NOX3c0lwrVMisTQ22JzyXblhYdzSz+/g742BY6CSpTk2hxvs/89mR8j70qnPqX9k518/ACes05nLyP7rolREtzAEjt/OuQUWScwD36bWHX+8+UxWNYfFsQWl1a6+V4paQS2K3ZTSXKs2ScTctAfNxc8g5Dtoh8upOXcFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713492658; c=relaxed/simple;
	bh=QaV+xo7U3yWHbxjqI/LRP7MZjmnnbvWg/dAHM/JGoEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLWRbb8aWBqcFTJZ9k0oKh7csAF0yXMcuF2wt4iK7i6+IiKaFNIxd3gHnsVNhXHVoTe+ojQPc+mHxo1ms/EK6x7rzXz2Uv/qFaXq2QS41fpmGhJEYWMVs0GE68u0brDkXIgn0Yl7m8I8Gbu2g/dJW9asLPd6+FaFAmOOk/dLve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOjl9G2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D4DC113CC;
	Fri, 19 Apr 2024 02:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713492658;
	bh=QaV+xo7U3yWHbxjqI/LRP7MZjmnnbvWg/dAHM/JGoEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AOjl9G2dEx8ReZc0m7tYPEf7jgd/ziF1kARS7rD95QZP4dZb48eNcJdpcb5ILAUw2
	 PTBYyUMSVLnTtM7RRd7Pn3ZHyAO9toLUBs8rs0vHlpWA3QK1t5Q+4V7haXkfyIlExr
	 Di10vRRUKgP8BnYETrw7E1k8ulUi5ttqGoSKZ+JlafBO3UQkeuzITh7QgAuLaMNtVa
	 moUdfaLiI57Yt4yk7f9RPnSdyL7CspYOeOHyysZcrQoa4YBgAsqTahH5vdxavEnowH
	 XqeMeq8PLW/zXJcHapu7GZsJq222WFprPxydqvuLy6TuF+Y6nOoVoE8/thwxj6ZLI1
	 EsGYaQOherSnw==
Date: Thu, 18 Apr 2024 19:10:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
 <sdf@google.com>, <kory.maincent@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
 <przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
 <richardcochran@gmail.com>, <shayagr@amazon.com>,
 <paul.greenwalt@intel.com>, <jiri@resnulli.us>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mlxsw@nvidia.com>, <petrm@nvidia.com>, <idosch@nvidia.com>
Subject: Re: [PATCH net-next v4 00/10] Add ability to flash modules'
 firmware
Message-ID: <20240418191056.7e764d06@kernel.org>
In-Reply-To: <20240418103455.3297870-1-danieller@nvidia.com>
References: <20240418103455.3297870-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 13:34:45 +0300 Danielle Ratson wrote:
>  Documentation/netlink/specs/ethtool.yaml      |  62 ++

You may want to squash this into one of the patches, otherwise the
system headers are used for ynl build and they don't have the newly
added enums:

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index f4e8eb79c1b8..e08b3d7cecee 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -16,7 +16,8 @@ get_hdr_inc=-D$(1) -include $(UAPI_PATH)/linux/$(2)
 
 CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
 CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H,dpll.h)
-CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h)
+CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
+	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h)
 CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
 CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
 CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
-- 
pw-bot: cr

