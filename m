Return-Path: <linux-kernel+bounces-37266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 313B383AD7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8986DB2779E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316E57CF1D;
	Wed, 24 Jan 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isDYyH63"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D027A732;
	Wed, 24 Jan 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110560; cv=none; b=C2REsuBR9EblW/P6eKo7RrGJHKyuGMVUjb6zhA8D8FgttV0uTspo9dbepftEicdWpIY1IibPOezeIatEN+v7aDG9KpF/y+B2MyoPxCQC2xFmaqNmEu+xgUmQhbHFmdgHuzSkkrLZcgOy2EYVVnJxamS1jTdGqD5XP3pvPH7ZSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110560; c=relaxed/simple;
	bh=SW10x5ZYQBcq/mUx5y/fzQ2kfJ0/aS0ZxO8iSqv6fmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQgZNdz2nTuBzHGUOulDVXY1bpgMAyZtbPB8QMnmlcZJafUAQim8mcOFQjaHTRQxJv5brtD4so8Qwp4jKwCthW6jqRa5hD1FSWSNWjN9+HKWZoek6Spu+X5jPoVAQq9i2X908slBTkLFFAuIs5sQ4geJ+awjYSHvpEX+yak0CzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isDYyH63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480CCC433C7;
	Wed, 24 Jan 2024 15:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706110559;
	bh=SW10x5ZYQBcq/mUx5y/fzQ2kfJ0/aS0ZxO8iSqv6fmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=isDYyH635MqpTdPDONjxAukTzj7ymX5/cLSBEsa5RuEn1e5m5VpQ0QnzRPaEKpo6F
	 hPjaDzpVx74ZM5tsdUI2N6UKABu/kjk9DaUF6cIS470LzfIKK5nCoA5kI+ypH1sIgL
	 97aZbfkslGoArqeWkB0TPsrBw5XM+hX6lkaiKx6xUZ3gRGtXA+JV7xDqMR6soQ0vlc
	 XcWuCv/sWbOrDq8COZyArE0U/xD6c3qdNIIDfyHHCkW3xvNAt2kus0aCKDlpvhtyn5
	 EHQOIIOisLZCqFaJWFIb0a/Kx3B33IBMis80dHNetP8H+UQHjofCyFPTtb0xBdH+z/
	 fft/Uxcg9xo7A==
Date: Wed, 24 Jan 2024 07:35:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: patchwork-bot+netdevbpf@kernel.org, timur@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 marijn.suijten@somainline.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: qualcomm: Remove QDF24xx support
Message-ID: <20240124073558.41c1b99d@kernel.org>
In-Reply-To: <0679f568-60e7-47d8-b86e-052a9eb4c103@linaro.org>
References: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
	<170605983124.14933.9916722082205803213.git-patchwork-notify@kernel.org>
	<0679f568-60e7-47d8-b86e-052a9eb4c103@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 13:38:19 +0100 Konrad Dybcio wrote:
> Jakub, can we please drop this (or should I send a revert)?
> 
> It turned out that Qualcomm is actually still using this internally,
> for "reasons".. [1]

Oh, I thought you only meant they are using the UART driver (somehow).
I'll revert, sorry.

