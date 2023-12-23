Return-Path: <linux-kernel+bounces-10482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904E81D4E7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C4728379F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9097612E47;
	Sat, 23 Dec 2023 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx8nLma3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0ED12E4C;
	Sat, 23 Dec 2023 15:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D4EC433C7;
	Sat, 23 Dec 2023 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703346089;
	bh=5trcHziTMOvFeQvDD0Mnue2+rI3MUWi202GCDsyWAa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tx8nLma3rT/KaAg5uJR4CASDZtN3HO0iPlnl6B3nKa2X8TXm3phZcSrQvdtat145a
	 Ri5CNYSsWJEvE1B9sl3h2e/KbX4KlpBkWML6bNXpP1pV8uyt8hLtKz1Y8/ASjivrjr
	 MRr99AR2JrC9i2BAk+GbQMeCkKVz9flpddZHFPekuw2pFNEuNAfPSerGFNhRTvaLf8
	 5iurFS4A+DR1k1ynNxF4qjzEihSXFpSWEJHKQWAHLW66UMR4zK1lmQjN/36kPJXvuh
	 E76AAwbkzzqkuHyP8kWukNJWzGKVD88bSk50m8/V/lRIKif+Rdgu5GMOATa1y7bfvn
	 IIjMjJeVxIbqA==
Date: Sat, 23 Dec 2023 09:41:24 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	axboe@kernel.dk, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
	yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Fix I/O priority lost in device-mapper
Message-ID: <20231223154124.GD901@quark.localdomain>
References: <20231220100333.107049-6-hongyu.jin.cn@gmail.com>
 <20231221103139.15699-1-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221103139.15699-1-hongyu.jin.cn@gmail.com>

On Thu, Dec 21, 2023 at 06:31:34PM +0800, Hongyu Jin wrote:
> Hongyu Jin (5):
>   block: Fix bio IO priority setting
>   dm: Support I/O priority for dm_io()
>   dm-bufio: Support I/O priority
>   dm verity: Fix I/O priority lost when read FEC and hash
>   dm-crypt: Fix lost ioprio when queuing write bios

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

