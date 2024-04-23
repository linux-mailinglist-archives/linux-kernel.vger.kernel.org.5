Return-Path: <linux-kernel+bounces-155330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1B98AE8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6F91C22B56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98589137926;
	Tue, 23 Apr 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li0LzuVs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E6E13774F;
	Tue, 23 Apr 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880852; cv=none; b=rQm0JWFWQ+PNPDtIjBZ1+w0RwxkMn/PV9ORRXtJaDx7uQTYqjg3EFQPHfONLP+3935T0WGviMfZyg3mipzrGtvAlOfOd/6NaY7TdwEoRRfH3A6IOdxCgWLXE2TwCnYZtaMGIcNWx1F5wcWRYpNlQIdHRtJ8Uq5YkIR/+tJR8hO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880852; c=relaxed/simple;
	bh=8/0YPvkoCvlPTjqbj8S0/choyHb9I3h6/P3LtI+ylMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQsw2nLztFsAW+621OdnpKC0E+jo3w202d2MXyaTZhK8KDGs6uGvMphBdjR8Gh/ehjnRNJos9U/q0Ih2VGah7G7axQ4IOyrFgwz15g+v6bVodEDlUrrGWt4NHjLf2a/VPdHaly8NyX2Jok1U7A6MMz6jfzFU1yNBy+ej3YISiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li0LzuVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54184C116B1;
	Tue, 23 Apr 2024 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713880852;
	bh=8/0YPvkoCvlPTjqbj8S0/choyHb9I3h6/P3LtI+ylMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Li0LzuVsohzSNMYgwoA9ei4OCJ0Gte7wLEDxIFzSCpBzO3dr+B871eAXRwL5Fe9fN
	 hWSOuiNQdbuIzAs2QzZKF93ppiwxAhOuEfXHQSfQ2iSjGXNrd71rd5uQHsdcm8I3Km
	 RjI3GzzvPJZkneBzvLAxHmPKU9NIxDPrCL+R/R+eIwU5Z63x4rp8ZvzzhlKqmxZa9K
	 ZRNjEsvTK4UqhqyTFDBKA8ssAJkfFDmZQhZQHU9DBmtS3ytkFFe02UDAnfLPGaP6eU
	 k3waqEvAQiP/ErAyYl3scTCEEYRaXZ5T3/1sQc0App86wrvTwR1hg9ZSCkRbThSrNj
	 IBthSwyMO0nQg==
Date: Tue, 23 Apr 2024 15:00:48 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: lan966x: cleanup
 lan966x_tc_flower_handler_control_usage()
Message-ID: <20240423140048.GU42092@kernel.org>
References: <20240423102720.228728-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423102720.228728-1-ast@fiberby.net>

On Tue, Apr 23, 2024 at 10:27:17AM +0000, Asbjørn Sloth Tønnesen wrote:
> Define extack locally, to reduce line lengths and future users.
> 
> Rename goto, as the error message is specific to the fragment flags.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Hi Asbjørn,

This patch-set did not apply to net-next at the time it was posted
(although it does now), so it will need to be reposted.

Also, please consider providing a cover-letter for patch-sets with
more than one (but not just one) patch.

-- 
pw-bot: changes-requested

