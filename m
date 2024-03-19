Return-Path: <linux-kernel+bounces-107452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B9187FCB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29C11C2269C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AAE7EF00;
	Tue, 19 Mar 2024 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+X2h4GW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F004554FAB;
	Tue, 19 Mar 2024 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847178; cv=none; b=FF0asP0hS/cmwmodl4RhLgz0Uee1A3Q2I1sXRet38E2RBbTA8Rp6o98sjSb2RlsxdNFUBiYyVtjxPx2t1VO0Mnzamz4DpwjwYo+g9iveAnmu74YRIxuFh8eIk4/7QN5qvZb60fPlX1fte6rlRcYrBgBzjs1qiiCH7Ei3uq7BtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847178; c=relaxed/simple;
	bh=gcEM9qz0TirwhaFVtmSHsd1Q3XrgfZWom0ZiVSCPIuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANshJt8HChUU+nJordmEuC0muMpAxwjkAl+WBcymXcrlyHqz2ynAY5NDzHvwrpk/xMeh6OI3cmnZUeIFMnnlDogK6aV7dDHEZwJmGSpa1B5J2X6tVfS7ys4cwFAQaedSeih+hmgXcV7szxWEaDEH5BeCtzBCuXR43r+JoacxLRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+X2h4GW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B35CC433C7;
	Tue, 19 Mar 2024 11:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710847177;
	bh=gcEM9qz0TirwhaFVtmSHsd1Q3XrgfZWom0ZiVSCPIuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+X2h4GWDG9wKujPkgiBtokUTbzKA3RwohrgYbE17sfDXYQmI6PMx+glGM6jFzDIi
	 MKutKxf0WXbuF7nC2K2dSSQkYMAxzPriIvCI5xwl0BlAjCgqjaRMs1WZnrE80F6bAJ
	 uADyJruE2UXcKXutG9Y9DVCEM5Y+IwX+t10uc4Fnt+h5qtjhYCOyVsZU3QzZoyMYcL
	 QDETx5HJPIzL+t3d3oejj7HbS0LKIxg+v+IIKzuzaKVeRHU8qta4gjGLDSg7LmeEm0
	 tfHR2w8EdpCeZ+BpRxOgQzYNQzNOlX2BEh2Y2QWRhBWSFIEa/oBeF7BbRW/qTw96Sq
	 XHm8Hu6g+nozQ==
Date: Tue, 19 Mar 2024 11:19:33 +0000
From: Simon Horman <horms@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc
Message-ID: <20240319111933.GE185808@kernel.org>
References: <20240314-kdoc-ieee80211_i-v1-1-72b91b55b257@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-kdoc-ieee80211_i-v1-1-72b91b55b257@quicinc.com>

On Thu, Mar 14, 2024 at 02:23:00PM -0700, Jeff Johnson wrote:
> Running kernel-doc on ieee80211_i.h flagged the following:
> net/mac80211/ieee80211_i.h:145: warning: expecting prototype for enum ieee80211_corrupt_data_flags. Prototype was for enum ieee80211_bss_corrupt_data_flags instead
> net/mac80211/ieee80211_i.h:162: warning: expecting prototype for enum ieee80211_valid_data_flags. Prototype was for enum ieee80211_bss_valid_data_flags instead
> 
> Fix these warnings.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Simon Horman <horms@kernel.org>


