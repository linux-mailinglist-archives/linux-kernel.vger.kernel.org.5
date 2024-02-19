Return-Path: <linux-kernel+bounces-71011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0E6859F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BDC6B207B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C392722EF0;
	Mon, 19 Feb 2024 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmNL1Cx5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB91400D;
	Mon, 19 Feb 2024 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334056; cv=none; b=gFyqfISjOC7Rt6kUunWsAzx52dEidscPYPO4Dsq6oSPwLdZG4YeC4u4fGSmcUR3vUMKOsbq7wsgdQqygRkVA556hI4W3tLP0al5FEDVX3jhYELrdKPCOThF1XD4UHruVHxcX35QWLsORjEOVR6kAMa7htAE6OAubZVrEYoE8yOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334056; c=relaxed/simple;
	bh=QX9VqCiNwjLqmAeEaD6uOKNoSTkvv4XaSDdFozPuvSc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gqA2HplMoHs9ymFKwPqAryMECQKZvYN7ujx6TgO/2e2yzZd2Ah9NVQRtad9119wlxZ7D7HZmG+Zkh7XjtU+MnzXvtlU0jDkp4MC6xBdub6qA3/5uG5IW98ABk0t4ZF1MNrXdnHvI1wdF0sthcR5WqzO9nqI7uiUpyCyqfvuwQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmNL1Cx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A009DC433F1;
	Mon, 19 Feb 2024 09:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708334055;
	bh=QX9VqCiNwjLqmAeEaD6uOKNoSTkvv4XaSDdFozPuvSc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YmNL1Cx5zSY15GprT73iuJJNnocx4b7DTvaLcreqOjCBhiC2cXSkL6S5DfCTGKTe7
	 c794+pumTq5zW46fS4CQL4yk5yYko2h/EhatH4d346q4AggaiEx4l/4HyGJgyh0tnU
	 4JY86QZ68vY7ZAbTSw5oJGGDRWVvBX8KYuAdAHIAUqd6TK/SFl8r+qzzwUoZfr/UsW
	 yRrwKb3aQLWQhmyOaV9C+sEypjzl2n6qQ72Dk/cx0eMYMbUu91kC1Nt+UrCW2wUNOg
	 /pxqXjcJWbE8WL4CgRPFdjyMPv6BW6iklOZBbV5OCJEBUkOTcUSHoAO0I2ykyeWo1m
	 hR+dN3wxbCz3A==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org,  Jonathan Corbet <corbet@lwn.net>,
  linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: MAINTAINERS: add "Profile" keyword entry name
References: <20240219082448.14157-1-krzysztof.kozlowski@linaro.org>
Date: Mon, 19 Feb 2024 11:14:12 +0200
In-Reply-To: <20240219082448.14157-1-krzysztof.kozlowski@linaro.org>
	(Krzysztof Kozlowski's message of "Mon, 19 Feb 2024 09:24:48 +0100")
Message-ID: <87zfvwbyu3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> The HTML output of MAINTAINERS file prints "P:" for subsystem profile,
> e.g.:
> 	Status:   Maintained
> 	P:        process/maintainer-soc-clean-dts
>
> Use "Profile" as this entry name.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Heh, I was confused what HTML file Krzysztof was talking about but after
some digging I found this:

https://docs.kernel.org/process/maintainers.html

This is very useful! You can link directly to entries[1] and it's easy
to read which makes it easier to talk with non-technical people.

Jonathan, I wish we would make this HTML version more visible, for
example what about adding a link to the HTML version in beginning of the
file? And maybe add a short introduction text at the same time? I can
send a patch if there's interest.

[1] https://docs.kernel.org/process/maintainers.html#qualcomm-atheros-ath10k-wireless-driver

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

