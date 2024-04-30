Return-Path: <linux-kernel+bounces-164190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C1B8B7A72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539B61C22BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0AA173340;
	Tue, 30 Apr 2024 14:45:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85141172BDA;
	Tue, 30 Apr 2024 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488299; cv=none; b=H8/5VYp4g8OPyr9TvziWpXo3cPrJ8MoGZpVBdLlmxWZdh3S1mmbvQ68qr61QyfKXA/UPO3RWMi26WXWEeq+DyZBI/KE3RU/tV8RGP9gb6xISLyW91B62uxsuJ11wnxQ+ySMtGq1XujtWg+J1Ri7wb0pGk8BnX9b0LFGkZDk7i+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488299; c=relaxed/simple;
	bh=y7griHojfl1pFZ6T9EVMzuUEuFb4+F8c8GFoW4bteyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z8daJbySwfhS+OJ3968qeui/dztH1+/ZcFlLXAOl1YX3BKcmws7eQvrnR9rxnIIABGf8iFXPNud4JuAdYLuddZJ+v1HTedolocxgHdCnF2UFVh9r3eBLGjSM4AROxf7bnCob0NHwhwI9jGMLuDNQCd6LdIN9X69XGd3RqXPUn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9367C2BBFC;
	Tue, 30 Apr 2024 14:44:58 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 7F486106074C; Tue, 30 Apr 2024 16:44:56 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Herman van Hazendonk <github.com@herrie.org>
Cc: benwolsieffer@gmail.com, chris.chapuis@gmail.com, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240415151645.1986014-1-github.com@herrie.org>
References: <20240415151645.1986014-1-github.com@herrie.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: max8903: specify
 flt-gpios as input
Message-Id: <171448829650.854776.9656658871915488250.b4-ty@collabora.com>
Date: Tue, 30 Apr 2024 16:44:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 15 Apr 2024 17:16:45 +0200, Herman van Hazendonk wrote:
> The FLT pin was incorrected documented as an output. The MAX8903 uses it to
> signal to the processor that a charging fault has occurred.
> 
> 

Applied, thanks!

[1/2] dt-bindings: power: supply: max8903: specify flt-gpios as input
      commit: 55f7073f6f59ef2c9e98b70f74118dba62e1aabc

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


