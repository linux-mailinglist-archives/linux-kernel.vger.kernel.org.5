Return-Path: <linux-kernel+bounces-127503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3180C894C9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D2C1C22093
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76843AC08;
	Tue,  2 Apr 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eflhh8zE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258092C689;
	Tue,  2 Apr 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042757; cv=none; b=qUXhhf09f3yopJrl7ZEF2ZG51N/PlVMthPohwdpraxu6vktEd7OIOdtS7TED3HxazVLntlNqIACcwn0z5AJqlLoZU+qVb3TUFSW77n+8YsEH375IuSF8R0U6ac0pliOoHMvoL5xS7bMGpxhBC11Zfl2fDu2usNA25gNmfGaYhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042757; c=relaxed/simple;
	bh=KQMf4VtPzd84hyGt6kCsCtQ12pBU4FXg9c014tnmT4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mW/rwP/eKDITyjq5GFTRbP4nDielN6qxwUpmSQfbhJsz6pgrYb3DA1l38ryTf+L+oGLSRDk5EgiUvSLy4D3xWJcjlNtZWk1S8h1FKS7iWncYRPj0srfnYEUJGB7W0WaAAUEbRa0Mig+3DV4AnwN2jnR0RPOtV3l4xxqQzTH6W84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eflhh8zE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C63C433C7;
	Tue,  2 Apr 2024 07:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042757;
	bh=KQMf4VtPzd84hyGt6kCsCtQ12pBU4FXg9c014tnmT4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Eflhh8zE6J2yENSOcXythi7o+kKM6iTUQPj060dc139attEsMbhY2FExIvFEXS13w
	 2Sk0rJ8BhUpisj7tcIUGn6hRRc1WV/Sd5pUvw+7elD33lZv4Dw+6khRaIiCYPA8gPc
	 itbrJIaemcJxN87yr5jWbj8MYbkwM22S5C5evnlpZwoRm9w+eskcmQHbZGhX4XMyrL
	 3c/6tg203ePz4vTlKDJDoaZ+7Orivcu2wE7Za5vV/fYM1cwJ0AG9H7AW7KGD6vcwL/
	 CSxf5g1O0I3rVZEG31ItAHSZ35/kt/obFGajU5mUwaY6j7rdPS3kNJ6c3KppK8x4vV
	 QB0Ae4hUdiPaA==
Message-ID: <24c917f6-9ff8-4bca-8cc2-5c14c64c2c9b@kernel.org>
Date: Tue, 2 Apr 2024 16:25:54 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: ata: ahci-da850: Convert to dtschema
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327064354.17384-1-animeshagarwal28@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240327064354.17384-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/24 15:43, Animesh Agarwal wrote:
> Convert the ahci-da850 bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

Applied to for-6.10. Thanks !

-- 
Damien Le Moal
Western Digital Research


