Return-Path: <linux-kernel+bounces-34170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642948374ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AF21C2917B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7369A47F5F;
	Mon, 22 Jan 2024 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXap1gsb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CAE3D962;
	Mon, 22 Jan 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957786; cv=none; b=OZxLBR2GD7YsdTrCXG+HPTWNvdNOfcxaFmad031UfQHYFSlSRSBcBu7dZNdyV1UBZufWukWrftZmJGtYk3wrwBlDPXOhYit12lRwXXFVPcG6uprUNSVcK+3gezO21k8GsRPhvH0cxqxDFjj6ckLETQjWGUigti1s9e3wn0d5Xhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957786; c=relaxed/simple;
	bh=Ih7R6TYxhCM9I3BeQKAYztZnAv4JyEVKt9MpxCjzGWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKbDU4TcoQx2r8BfeCT6w58rsnBWvYPu8bMVn15x+1PsNGIHM3H8ZlAy5WpsUbJqhRIgbVQS0lEvV2GRuF6KYdqE5Ji6/og6X/e3H4x1+Iv+pQW2YTn8QZP8qoDvdLyDqEcKUNvhMj4adLG1b4agF06XlevTyGSwXH6sIO9K+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXap1gsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7201C433C7;
	Mon, 22 Jan 2024 21:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705957786;
	bh=Ih7R6TYxhCM9I3BeQKAYztZnAv4JyEVKt9MpxCjzGWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LXap1gsbnuqyJgpUh20kPe601KuOC0HAQTF5WaOrs+Di36aEs0U41afa7zyLoBVXV
	 +qr6Spp1cMGbGTwm3jllrajaeJdB/1EgVjjx6nT6GAzNUe3hNx/T6zqZ9fPvA0qvlx
	 Cz/HHKqvkwDPG55XRCihWpu7LBIL9CEhxX4q1N+4CoYRUFVlqJHj6zn0Vx8eUyjOVv
	 SRN+MKyAEZeQ1QruUgeA8ljEd4M/lrR+noQJXHLgdUkV+yNAO92fsUqR3kv2kFseoK
	 Q+hZ1vtBqRbXkGwFYQN6GyTGAACygObyPYFw43sBU2drzNRtAQZWePvpBxEBRQiiNo
	 rtRPY2NbiOx9g==
Date: Mon, 22 Jan 2024 13:09:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Denis Kirjanov <dkirjanov@suse.de>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Marijn Suijten
 <marijn.suijten@somainline.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: qualcomm: Remove QDF24xx support
Message-ID: <20240122130944.288284fc@kernel.org>
In-Reply-To: <88a6314b-f780-4511-85a5-839115beeff5@linaro.org>
References: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
	<ce1b41a4-a9bc-4dbc-ae85-5187b3cab10b@suse.de>
	<88a6314b-f780-4511-85a5-839115beeff5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 16:36:01 +0100 Konrad Dybcio wrote:
> > On 1/22/24 15:02, Konrad Dybcio wrote:  
> >> This SoC family was destined for server use, featuring Qualcomm's very
> >> interesting Kryo cores (before "Kryo" became a marketing term for Arm
> >> cores with small modifications). It did however not leave the labs of
> >> Qualcomm and presumably some partners, nor was it ever productized.  
> > 
> > You forgot the net-next prefix  
> 
> Right. Should I resend, or just leave it now?

Looks like our bot guessed right, you can leave it.

