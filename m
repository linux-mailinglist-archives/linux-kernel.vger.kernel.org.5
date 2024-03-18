Return-Path: <linux-kernel+bounces-106634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B81A087F142
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33751C218B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC7726AC5;
	Mon, 18 Mar 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvMHB99Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB0F22087
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794316; cv=none; b=TtQJuZGCWVifEnNddzWiFHu7Op9rchbCxRaugS2fnBRyaH0+rHGCgddO2JUXt7l5OB4h7oXrjYoJimpje1cEwJ75gBnTa+rH6MFQRD+FfrphwLO6dibjSmQbmE7pWq99RRnR/5haaTCiQeNSKWj0zBhhZmeqeY2jJuKIChf3Tv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794316; c=relaxed/simple;
	bh=q4WLmhu28x58xZ4DZAEo0ZfSLiDCHD0gVl59UgFzn5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2gTp3KH6mr6hTDCulpvbPGwtn4RYygb+nB9iajZP6exqKSK8WrD7bIG2Ili7Slw6XZQv5zeczjahU0ijFQQQItjlm4mf+GPHI/iToGWYnUbDoxSaGQe2BBmAyJ2py1ZCYssnGyraLiSay8b81qN0ioNxJ5RZkUz6t4J8GZTe7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvMHB99Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848B7C433F1;
	Mon, 18 Mar 2024 20:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710794316;
	bh=q4WLmhu28x58xZ4DZAEo0ZfSLiDCHD0gVl59UgFzn5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MvMHB99Zi8UWGTiGwVwNkjhGa/f8xkONpGPxsNlMA6WNkX6HDAFJSW3wPK0MwlHUS
	 NCEXy5KF8yTXG6/5FAuUx6/KY4uXbsYDIF16vGVCxD+w0aPGuVZjDCBKZpXRBncQYy
	 4xZIWOhprLeIAZ9Qn1XGwnCD49qvEKMw7QP+q3K3duIJ/c54fyL3lyxVpJEOCt/gSL
	 9v8xgTnadPJ5o50DBL6BaVrqdJNL5FnXQiukAMY6GW5+S7VcIAW5KEt/wyEhgQjQH9
	 OQSfEtBTC+Ffa0FU5OFYPpKz+Byml38d0ibzLTZsXI++AlLf/PmjVR3adGY4ltR303
	 /wBDbRCQ1Bpxw==
Date: Mon, 18 Mar 2024 14:38:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: iBug <i@ibugone.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 126f:2262
Message-ID: <ZfimSElFZMQYB1j1@kbusch-mbp.dhcp.thefacebook.com>
References: <20240315192747.1749119-3-i@ibugone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315192747.1749119-3-i@ibugone.com>

On Sat, Mar 16, 2024 at 03:27:49AM +0800, iBug wrote:
> From: "Jiawei Fu (iBug)" <i@ibugone.com>
> 
> This commit adds NVME_QUIRK_NO_DEEPEST_PS and NVME_QUIRK_BOGUS_NID for
> device [126f:2262], which appears to be a generic VID:PID pair used for
> many SSDs based on the Silicon Motion SM2262/SM2262EN controller.

Thanks, applied to nvme-6.9.

