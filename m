Return-Path: <linux-kernel+bounces-9070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DC681BFD5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52F51C24901
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5876DA6;
	Thu, 21 Dec 2023 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlyodUzc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980B6280F;
	Thu, 21 Dec 2023 21:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA92EC433C7;
	Thu, 21 Dec 2023 21:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703192574;
	bh=Pch3cUPPm9M2grj1J1SCcBO1AYY7StPUOGyR6OF+oHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlyodUzc/Wan56wBQ5rCTP9uWqL+Gs7D/9jGZ840oOnuCGjVJXRQs/pgoIhpNmBuS
	 UBg/IcR4MZN1Jn6+M/+HguLkz9R1f4pZghLUwcdOhfdxNwrsaPLKNDcKCzRqnmyDwd
	 EmuCGEOzYGYvJuBOedtzQtVdjBqpShPcFNO9/rFEpNjiclsNQm+Pp5Twu4vjLRLNOP
	 CdG52mNlz1/pYzQqIdtKXxAHKwq1TkyK5uS+PaoXGaGWdqk/o/axrkNVGwAyKjDifY
	 bTGfba4bnOu53QFmEtceCEH7fkCdDPfK/JTGw4KbGrCBZFccTCNk2oyO2jRrCR7SZq
	 wJgadbNSMB+UA==
Received: (nullmailer pid 88422 invoked by uid 1000);
	Thu, 21 Dec 2023 21:02:51 -0000
Date: Thu, 21 Dec 2023 15:02:51 -0600
From: Rob Herring <robh@kernel.org>
To: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc: linux-watchdog@vger.kernel.org, Ley Foon Tan <leyfoon.tan@starfivetech.com>, Samin Guo <samin.guo@starfivetech.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Palmer Dabbelt <palmer@dabbelt.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>, Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, devicetree@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>, Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/2] dt-bindings: watchdog: starfive,jh7100-wdt: Add
 compatible for JH8100
Message-ID: <170319257135.88357.1722653226891421278.robh@kernel.org>
References: <20231221084358.3458713-1-jisheng.teoh@starfivetech.com>
 <20231221084358.3458713-2-jisheng.teoh@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221084358.3458713-2-jisheng.teoh@starfivetech.com>


On Thu, 21 Dec 2023 16:43:57 +0800, Ji Sheng Teoh wrote:
> Add "starfive,jh8100-wdt" compatible string for StarFive's JH8100
> watchdog.
> Since JH8100 watchdog only has 1 reset signal, update binding
> document to support one reset for "starfive,jh8100-wdt" compatible.
> 
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> ---
>  .../watchdog/starfive,jh7100-wdt.yaml         | 40 ++++++++++++++-----
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


