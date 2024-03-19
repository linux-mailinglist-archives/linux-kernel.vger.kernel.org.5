Return-Path: <linux-kernel+bounces-107499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADB787FD57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CC7282958
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C067F499;
	Tue, 19 Mar 2024 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhbfgXul"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49F7CF03;
	Tue, 19 Mar 2024 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849990; cv=none; b=ZPTSNKGSJAdsw81kq8yQrvnVOzn3/cF9FTx/fNh9yt53syq4qX5ydIqJykAgiBOpInHhuz7J10MSRq8QJCFyOJZ8XbpsYtSQ8feE6uS/XEVZK4UkiOPCRAnRKaOeknsa4He/WK0PY6nEIIF9Eu8A/7MY7TcdWzf+3xQtLvslgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849990; c=relaxed/simple;
	bh=bKAtYoJBSuOHQQgagWmINKfaNalyupmW9O/fQEj1bpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udAZpKio6v/Sg9sCqMCkqaUSpa1fcqIp8IBjB7uZkNq9YTog5gKckdkMyvqVWrijUfut2R9VvBmVE/G9nn0AqFjaLqavhKF+2JeOseUmzIQotouIG2gTOP/i0Nolui4j46UyxypVZJfzUOzj8L9EXMj/eTqGVQm3ihTCMb6g1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhbfgXul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8EEC433C7;
	Tue, 19 Mar 2024 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710849990;
	bh=bKAtYoJBSuOHQQgagWmINKfaNalyupmW9O/fQEj1bpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OhbfgXulU9Vp/bUvWbaxfDXAhUEcinY86e4TwFGgQJ6blxtPoaurjvKQ0SnYRRWtQ
	 kuR11qwDUoedyVx8C+mpDPig/xhGx3aoImViOGVVeceWhsF3+KG/UL6CwLnAIcTu0B
	 ZtAJEn4LqNwQdJ5ENR7imp+3TVYEX+QLH//T3fI0jjsaTzjCS9DLN7DvtNUZ0KS8MU
	 gftWI4E4vRvavKX+lvaoXMnNrDWi+mtNooOjDTawtwgfzBrsg8qREx+DSuyG7929S8
	 R7zRfxQoFDPq8kHRtPGsAq4g64oYJRyMvB7PpfmrHX7KBEt2NArekMXI3WgMOCVGBx
	 8LpY1IZfFpsXA==
Date: Tue, 19 Mar 2024 12:06:25 +0000
From: Simon Horman <horms@kernel.org>
To: Francesco Valla <valla.francesco@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	fabio@redaril.me, linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: networking: document CAN ISO-TP
Message-ID: <20240319120625.GI185808@kernel.org>
References: <20240313223445.87170-1-valla.francesco@gmail.com>
 <20240313223445.87170-2-valla.francesco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313223445.87170-2-valla.francesco@gmail.com>

On Wed, Mar 13, 2024 at 11:34:31PM +0100, Francesco Valla wrote:
> Document basic concepts, APIs and behaviour of the CAN ISO-TP (ISO
> 15765-2) stack.
> 
> Signed-off-by: Francesco Valla <valla.francesco@gmail.com>

Hi Francesco,

As it looks like there will be a v2 of this patchset
please consider running checkpatch.pl --codespell
and addressing the warnings it reports.

..

> +Transport protocol and associated frame types
> +---------------------------------------------
> +
> +When transmitting data using the ISO-TP protocol, the payload can either fit
> +inside one single CAN message or not, also considering the overhead the protocol
> +is generating and the optional extended addressing. In the first case, the data
> +is transmitted at once using a so-called Single Frame (SF). In the second case,
> +ISO-TP defines a multi-frame protocol, in which the sender asks (through a First
> +Frame - FF) to the receiver the maximum supported size of a macro data block
> +(``blocksize``) and the minimum time time between the single CAN messages
> +composing such block (``stmin``). Once these informations have been received,

nit: Once this information has

> +the sender starts to send frames containing fragments of the data payload
> +(called Consecutive Frames - CF), stopping after every ``blocksize``-sized block
> +to wait confirmation from the receiver (which should then send a Flow Control
> +frame - FC - to inform the sender about its availability to receive more data).
> +

..

