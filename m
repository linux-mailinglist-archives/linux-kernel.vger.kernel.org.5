Return-Path: <linux-kernel+bounces-61149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F61850E00
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBC9B2664D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E3F79CB;
	Mon, 12 Feb 2024 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KopBSSTH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A17462;
	Mon, 12 Feb 2024 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722866; cv=none; b=nnZeLS2EvUcE6tNgV1ul2rZKa+yi+VDPDhcp6gpI13PX5FXDLo6+ARKOMTNQZM7zXzJwSSAGBWW4OR92wA4wcz9FVTvStt3xPcfKov7+7cMckZE0VPvjNGlk9hk4834bUzqoDebaWcNWyur2MBoN8TOeUJXGySCd5ENUsaxfL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722866; c=relaxed/simple;
	bh=3aMNHjlxc62FQVzZmnlMVcwgj0/VFMqeJ+TcZxLjSvg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KCE92KVxTdOGTaaQXpDg7OavAZP+kKXH2v/MX+AzjwLM5no3rSjXFE/8BG2niawExchlYhqJDWi5/eFkRQEskxI1A/kv7FjXsy635uLvHHbeerIoj/r31c6wlZAyk3DqolxCkhbTICp50ykM+Cs4L3AzsfQ3ndzqZ0nzbetDRac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KopBSSTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA29C433C7;
	Mon, 12 Feb 2024 07:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707722866;
	bh=3aMNHjlxc62FQVzZmnlMVcwgj0/VFMqeJ+TcZxLjSvg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KopBSSTHwl+GzzLjkSwYTO4SSaQrRYAiQlFhe89mRxjKAtD/795s06xVdAlyL1pP1
	 0w4j/4VWKKOFvUyBXFd5J2V2Yc1Yj0sVe8sHz/1hzS7SXTQakmxitPZvoNdjaC22fP
	 LXMf+GV0xzPDCHElMqYeYdvzU7Y6Ts73zCG5POs1mNkeW9bYy80dOBkrmKlIIE6fqQ
	 gVLZxzexqxljf3FpYT11IE4v13n3zF4uqFvFg8ot4fC7YlZ+5XAk9CIqOwLelc+VVB
	 Xf7T/vaakDcexuUHR6QoxwgNRe5vqch3rlkMR49kiqI/TtWkFi3eog+ZHAH4zOu67Y
	 4I2dUEbqhnz5g==
From: Kalle Valo <kvalo@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Daniil Dulov <d.dulov@aladdin.ru>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Pieter-Paul
 Giesberts <pieterpg@broadcom.com>,  "Franky (Zhenhui) Lin"
 <frankyl@broadcom.com>,  "John W. Linville" <linville@tuxdriver.com>,  Kan
 Yan <kanyan@broadcom.com>,  linux-wireless@vger.kernel.org,
  brcm80211-dev-list.pdl@broadcom.com,  SHA-cyfmac-dev-list@infineon.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  lvc-project@linuxtesting.org
Subject: Re: [PATCH] brcmfmac: Remove unnecessary NULL-check.
References: <20240211150516.3475-1-d.dulov@aladdin.ru>
	<60a0a753-47ba-4f80-b93e-2878f214bc3c@broadcom.com>
Date: Mon, 12 Feb 2024 09:27:41 +0200
In-Reply-To: <60a0a753-47ba-4f80-b93e-2878f214bc3c@broadcom.com> (Arend van
	Spriel's message of "Sun, 11 Feb 2024 20:25:21 +0100")
Message-ID: <87il2uf8gi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 2/11/2024 4:05 PM, Daniil Dulov wrote:
>> In this case req will never be NULL, so remove unnecessary check.
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Looks good to me, but when do we call things a "fix" and when is
> "improvement" more appropriate.
>
>> Fixes: 71bb244ba2fd ("brcm80211: fmac: add USB support for bcm43235/6/8 chipsets")
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Yeah, this is not a fix and the Fixes tag should be removed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

