Return-Path: <linux-kernel+bounces-78645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C5786166A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25F31F263E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC52126F00;
	Fri, 23 Feb 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3uZmWyM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E367B84047;
	Fri, 23 Feb 2024 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703582; cv=none; b=SjOL+iK4tAG9mZOr0niIMtHOBOd7O2KtpI2F6gq/QOlLuXKMsIb80H1zjNZknvoU1NEwp7t1Z3edm0gYZz46PB5D1hD22RbO8eJ0aofWMoxmnNjKaOgZl4JZtr5WoCMLRQ8mzV+um0tn3zn2EStIwNVIHDrwXYa7lp0znbh64Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703582; c=relaxed/simple;
	bh=9dJjw/4ASVXyYXTHVJ8CtjzaR84BLmXeR7uCeqpDAVk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=CGDwFWvFr68CGQ13byBy4EOweqqSUzdB9PcVgJPIvyIM/3OXM3/5D1H4B1nAyFPU8GR8pzd1v6b2yBerbgg2lLLcOy8MA/M9qoKDwS7W6ZMzojRKJH+b4OPNGmLhUyQg5GrooN+/tPFiqDg2VWcksjsxws1jSPQbXVCajPjFFS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3uZmWyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED244C433C7;
	Fri, 23 Feb 2024 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708703581;
	bh=9dJjw/4ASVXyYXTHVJ8CtjzaR84BLmXeR7uCeqpDAVk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=X3uZmWyMABZem3n0ZFvetZzC/ay7OAqtKsH83kW+KJ2wSe+YelPo5SiGBNARf2tDE
	 6hC9bbVjtSYHbZhZcck+T5R57fRIruTbI1kRXVr549bxvldma7QyaFhjoxd1wTp49+
	 NIjojNO1V9CU+RkPrSrlpkf9dCCtqucmFYVRhsm55NXdFRPkcTUDYo7Si9nxy0zLVn
	 13JTfiE12k0HoPCVr7ZwASAoqgFqBVzgzpxp94zC//hbtz7r6b0+XIVj9fR/IUhsmQ
	 +c1xp9lnW8lYJRhJEBGp8EX+uH7VGhz+y9kVfpHZ6g4FQgvt6uCGd+ud51fVwr49bI
	 BNW6BMLyCbKDg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] dt-bindings: net: wireless: qcom: Update maintainers
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240217-ath1xk-maintainer-v1-1-9f7ff5fb6bf4@quicinc.com>
References: <20240217-ath1xk-maintainer-v1-1-9f7ff5fb6bf4@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170870357604.2702005.6563808747303592523.kvalo@kernel.org>
Date: Fri, 23 Feb 2024 15:52:57 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Add Jeff Johnson as a maintainer of the qcom,ath1*k.yaml files.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1098eb62433c dt-bindings: net: wireless: qcom: Update maintainers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240217-ath1xk-maintainer-v1-1-9f7ff5fb6bf4@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


