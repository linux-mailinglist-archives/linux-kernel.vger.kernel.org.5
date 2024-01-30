Return-Path: <linux-kernel+bounces-45378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5F5842F76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A36F1F25054
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BED14AAA;
	Tue, 30 Jan 2024 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4OWk6a7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E2F7D406;
	Tue, 30 Jan 2024 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652988; cv=none; b=acOgMqPWi4rOje8s13cdQ53wPMwHDD7hhGwHPkwajLIi7YEYBU9e4hjepSMKd/TrsgTc1OI5qvo+S2OSfkIIA3mn4akG8dnSzQzHooWC7eMYEznHuNVt+QAYtgcJ81mK47gggzPJbB7ODEr9SXasiHpcwBJJiPAYtKFt/3jfQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652988; c=relaxed/simple;
	bh=f25iLcPMK0k8gAxjaDlDVvbcRPBJ4ixsnzHF4uFNFq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eit1E1cTJA9QSvvtsz1ZeZwaHszj0kR/T+cdFHbXUvNvBEryCLVShNup3djfJH3Dor0DVptlmKPVjU7GYZ7RTvyzk8AGIbfF8MozTlJgGZxJdcpUawVWXZ1bMb1NSNJMl7HXtvMNnBJFfa/HegMhs3b3voxJnSRrrHGHynfuork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4OWk6a7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F64C433C7;
	Tue, 30 Jan 2024 22:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706652987;
	bh=f25iLcPMK0k8gAxjaDlDVvbcRPBJ4ixsnzHF4uFNFq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4OWk6a7/veS3WKyS3Vr7yxwzKwWEBHHEIiGAAWi7lPfAk9W60W6BsuP/ISlbjQD6
	 cHNWcORiJxM1H2tHCNopA5GTfxuGEgAaszKWDl5QT/665D69C9Cx8cUES2dkPR4yM5
	 w/TtnvbOruU6zbmKrSzUxFBcI0GSAqRA3DXa7hKFUswRcbI5UHnwOv/2wN0uKCYAFj
	 v2JiU74LjzpxtpazdXh3TZvXDrJdA41kLKgnK9t3lTaEAhQ6L5TJtKbmbBoorD6HS1
	 mYRWlYbI5LpKoQ8aAYJyucC2pXqvD6wQgbL6tqzdaHcgvNp4GW6VAaDazqgYzn0ugg
	 VGqruM0Ey9nFA==
Date: Tue, 30 Jan 2024 16:16:25 -0600
From: Rob Herring <robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: tpm: Drop type from "resets"
Message-ID: <170665298341.2514549.15693954097698298933.robh@kernel.org>
References: <20240124190714.1553772-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124190714.1553772-1-robh@kernel.org>


On Wed, 24 Jan 2024 13:07:14 -0600, Rob Herring wrote:
> "resets" is a standard property which already has a type. Users only need
> to define how many clocks and what each clock is if more than 1 clock.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/tpm/tpm-common.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


