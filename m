Return-Path: <linux-kernel+bounces-47115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A3844987
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F3E1C22F52
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB739ACD;
	Wed, 31 Jan 2024 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHYp/br4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE9F39864;
	Wed, 31 Jan 2024 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735584; cv=none; b=A59lYTifGr7UlFIEaxR6pEiWxGbP/waGUKLoVnxXYGvVDeelRPih9QSYZOrKZ2lGbLtCP1A0OkLgt4uPbC7H2MZF01l12nD+7HbnW4bu0N5DHJhepTNq4uuJWqOA6fFxWFLtaLNQEEwPhsx8dSwZY11JmWip4K9O9Hv61G76ems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735584; c=relaxed/simple;
	bh=KpeAZao1g931gOPKrARuB7csMwiSRG+PLjdP6UwwNN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnuWhNme7rjnOQAenMDjPV3jCGbZU79vdoc5s7dQi3iDjDX4d1UQqaPuQ1WD9mN91vWZxSEc3Ncf4/Idwy8/LWzqSG3e68vrPutpZXeeUE0MIkovpV+kkDN/WFXos7dpihG//LVFW/0WMj5CmdZYy0zUdKgp7r7+XGVD0q4MNsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHYp/br4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2990BC43394;
	Wed, 31 Jan 2024 21:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706735583;
	bh=KpeAZao1g931gOPKrARuB7csMwiSRG+PLjdP6UwwNN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mHYp/br4PIDgr2Q2UoE2YGQ9ybcMX5UUpZjaqU4OWWRx3mz93/SKLXjbGoMBcqGtJ
	 HzH+OOvNl1XNol3OrCKwFgZVB5YZ/czTicEfZwCOO3r30cN7qCdZL9YYzDhhuY2+wx
	 WX7CYjDJ5Rf8IdaXwg7R99cFfEn485JP9llYEuzEUYGewIzg/vvrE2l6t3xoFYLd1O
	 4sC/m+sJXDsu/0g+faGE4XrVPbT3PeneVq5q4gD6CDUEUw1pZaqdyT3qI+DLHjG2xw
	 ZobrCtsxoRmenhAMZPVTSRgwwZCvVdLzp8fOV/SPY1NthbyXZAgUVfW91qKJM5dPe7
	 wxnnYftoxanVw==
Date: Wed, 31 Jan 2024 13:12:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Takeru Hayasaka <hayatake396@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mailhol.vincent@wanadoo.fr,
 vladimir.oltean@nxp.com, laforge@gnumonks.org
Subject: Re: [PATCH net-next v6] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <20240131131258.47c05b7e@kernel.org>
In-Reply-To: <20240131134621.1017530-1-hayatake396@gmail.com>
References: <20240131134621.1017530-1-hayatake396@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 13:46:22 +0000 Takeru Hayasaka wrote:
>  .../device_drivers/ethernet/intel/ice.rst     | 21 ++++-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 82 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_flow.h     | 31 +++++--
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 37 +++++++++
>  include/uapi/linux/ethtool.h                  | 48 +++++++++++

Could you split the uAPI changes and the driver changes to two separate
commits? You should post them as a patch series, but combining them
into a single commit makes the uAPI addition to easy to miss.
-- 
pw-bot: cr

