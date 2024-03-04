Return-Path: <linux-kernel+bounces-90931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F3E8706F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F5C1C21E83
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2994F4CB23;
	Mon,  4 Mar 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rl+/nwJS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFC48CD4;
	Mon,  4 Mar 2024 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569477; cv=none; b=a4H33TZDI0Wbsd/gOuwpdlUtFUmWusTwHYM5J7UQ951BeFdeNU2xUKL9DkXNW2UYzpj5duxKyn/mD4T269DOJisVePtKhH8Fx/BrmHTPJPkpo+MEIyp1AgvpFMz1NJQssQZeGxm5p3hx9ICTJO/rcxvnD0HlAzF8jdvPg/tra0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569477; c=relaxed/simple;
	bh=4bl9idDy4ImQ3vuQfnN6eqrCgY9eP4dfifWKxpLFpXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnIXYszpcCT498eICSCCFv9OhfCz6NBHTlaAwsESXgKLW/ZEYQsUl5PblTllO/TQJ/kHstVbOFTYOL/AZRIi2m4ikKah1YPKjMEQ3iC7NQ0f11DPY5GfrvC6SJntiXiyQ1jGkssp2PbKRva2Piig8qtJgGx5RvBby0LAAvVXKD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rl+/nwJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020E0C433F1;
	Mon,  4 Mar 2024 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569476;
	bh=4bl9idDy4ImQ3vuQfnN6eqrCgY9eP4dfifWKxpLFpXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rl+/nwJSAcjCNFW39mqqDuDDWDgQCSl+Ihojl8n0dI+56DeCCxDmAVAzDzHtl9ACW
	 CwFWGBOPy5dINmczEmy9EjYeM7Zb5/WcCMZIfSHb8ba3W6icCGnzClnmgea/vZxEnk
	 cAoV+VsS9mo/I5qjLoO+qTkZS/O2DB4OS0SQ73/rSs9/STmg1XhB26ppqZxaEosYa0
	 NHbJ83oNJ8YtHGZzNxpJW5HZ+FnGbkoBtDk/NgdYfTVsudGMszf0v+9ppkGwpwCa5G
	 MSXXWFm+KqKrDGBMTrBqMs0ax3NVgZS4QE9n4v4n7Qu0jsxPlpzgBKJzEh/BCg/8un
	 7+gH7Xcbw+1uA==
Date: Mon, 4 Mar 2024 16:24:31 +0000
From: Simon Horman <horms@kernel.org>
To: Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mka@chromium.org, andersson@kernel.org,
	quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
	elder@kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/7] net: ipa: change ipa_interrupt_config()
 prototype
Message-ID: <20240304162431.GI403078@kernel.org>
References: <20240229205554.86762-1-elder@linaro.org>
 <20240229205554.86762-2-elder@linaro.org>
 <20240301162628.GF403078@kernel.org>
 <30604225-dec5-4ba7-9e7d-4c845c8ee9d6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30604225-dec5-4ba7-9e7d-4c845c8ee9d6@linaro.org>

On Fri, Mar 01, 2024 at 10:37:13AM -0600, Alex Elder wrote:
> On 3/1/24 10:26 AM, Simon Horman wrote:
> > There are two cases where this function still returns a pointer.
> 
> Yeah I saw that.  I'm in the middle of testing v2 right now.
> 
> I'm very sorry about that.  My process includes testing
> every patch but somehow I missed these errors on patches 1
> and 2 this time.  (The netdev CI doesn't report all the
> problems with patch 2; I'm not sure why.)
> 
> Anyway, a new version is coming.  Thanks for the note.

No problem, stuff happens.

