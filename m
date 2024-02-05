Return-Path: <linux-kernel+bounces-53062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF93B84A033
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B4E283CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779443FB14;
	Mon,  5 Feb 2024 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="aAY+f+X5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D244C60;
	Mon,  5 Feb 2024 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152867; cv=none; b=ascsryrargL9cA/GRzKcBxBaBFp4dHusNiW+8A8t0G3B/QFH4yFd5Vh4dfkwqcyXWsmgRi9BcHJjut3S/9h5XTImzA4hywzuknp5BSEi47/l6OQiwxS+kPNKAu5pPTnNAGGk07WXbgcy6PuYkzzgy6DiLKGwop/pSo6Vwrp0D6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152867; c=relaxed/simple;
	bh=Mnd1sC18c63o3tm122LNNMZDCwOQj4bb6qe+YsaOth8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XD7FJwUEBYwNF/yT+6x3/g0NolKq5hup/uZTVKUIP7uvKl8mcPFL1xr2zf6fIH08S/7YRUzjAOq6uTsuh+jZO5yP80WD9CCjbskvm27aYeRr9xFQgJcHyhWgx9bUke5Vtpi5kuLP4w+Eli3yNXxPhhY2IgM7psBjZVoeRdgJMjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=aAY+f+X5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 28F5647A9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707152863; bh=1bZVVMb3EeMvd/TY7zvm5NDAKmOh9DHUKjceIL87VKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aAY+f+X5dZUQRKBiv+ydtqW7t95Rhkp0wEFZ4uuUa2Zvyw+CnZVomz52dM0NXGA8G
	 OYy+6c9Z6d/Jyrkt2QW+bub9Avp7maPSbknZ+ysg7nEfDV68uidyjcCjJAD87ngccF
	 b4Fk8nusjzf0lsNP8q/PktLtQ5iicv/VwahRYGFfIeQ0BSegV4AYIaorqbWOaC/xJp
	 9oALfw2h5xJR4GBqMiTxxAE3RK5Gi5RDNmmnom/fe5l/xtvGJw86qyK2Cn4OMNoAAW
	 +MKVO+zcNhDoCT7u+l8fRGY9HA3vvb4Iwkckq/DYiz4EF1MmYuIpIpqY65vLlWosRL
	 Xwcw/+VEgCHuQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 28F5647A9B;
	Mon,  5 Feb 2024 17:07:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] docs: maintainer: add existing SoC and netdev profiles
In-Reply-To: <20240131125351.123509-1-krzysztof.kozlowski@linaro.org>
References: <20240131125351.123509-1-krzysztof.kozlowski@linaro.org>
Date: Mon, 05 Feb 2024 10:07:42 -0700
Message-ID: <87ttmmvnz5.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Extend the list of maintainer profiles with SoC and netdev.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/maintainer/maintainer-entry-profile.rst | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

jon

