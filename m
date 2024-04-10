Return-Path: <linux-kernel+bounces-138361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C389F01E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5045D284F26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09764159568;
	Wed, 10 Apr 2024 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAMREDu1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B687154C00;
	Wed, 10 Apr 2024 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745874; cv=none; b=QS+BstSxDmzj378Au649LJNc/5qnuAAXiJSBLbsb3HC9bZQRnNM4dwroQO6x6hDaAH6KDcKfnw3oQFbTzF5LJJbrGVet1p+TltJKXzP4IRkDKvFOfjIyuipE2zk9DPc6Xx70TsrDyIJAFON/IQwCrTa2CQl8RiBqa8Ie7WQC2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745874; c=relaxed/simple;
	bh=d+0+LR6L1IBAup/75jhlBSGYcw5/zriWC81MfvfVkUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuMAGZy94kC2cq4KyePcwStMvrbIGOTVRIJabARAFmOgQKVzv07R6k/J8iMFqNfPIc5NrNbM3qABtNAaEDUrmOoaPgoQM/6syqDLlBquGtFENUCLNZkWbT0bv2Sg4BpKk0ULnKpgfEFP4tzv0bsUfM95Vp0JSLr+ONMTPtPeCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAMREDu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CDEC433C7;
	Wed, 10 Apr 2024 10:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712745873;
	bh=d+0+LR6L1IBAup/75jhlBSGYcw5/zriWC81MfvfVkUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAMREDu1dIcEcDV+g0187w85+XnxoAL7Z3ymPOCHjQtuoM9LAYXtv0JlvF4pj66Ba
	 tODxA4yYGGU/pRF1u0TCwX1mvm04SgYtnI6qTieo4C4kwm0+Y/znmPM04grT5qRn1J
	 q0bPrWPNvaDs/Ip7k9bpxR+TLiyiLALgyEOFGS4+u4I3bFJWn81AtQ9jCfmi5etT3F
	 tVC5UEvTqSrez89WnhfsaA2qALK2gihRxR9Pi8XyrBFADfIJW1dm1aTgtfs+DaKrWb
	 onGQrQWk9oxtzVkcomGlTBnyXUT/VBKqxGkgQVVeIctVJJQkpPdXVHmAT5kDRJ1dam
	 qY3XzikKOMnCg==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH RESEND v8 0/6] riscv: add initial support for Canaan Kendryte K230
Date: Wed, 10 Apr 2024 11:44:17 +0100
Message-ID: <20240410-endnote-falsify-f22d7fe308cc@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=622; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=aOAuGM/qQpYkpIQU1B2iLXnrNX4jsQerO8QnmDLtYho=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGliuQ0ffnoILznYbvc5PODQu7f8/olHPkYm7yu7nftUI MjmS7ZDRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbSuIXhfx579IwcVSftd59d 9x9X6w/a6FsXWZ5+NnGi1gyOo0c+sjEy7P+4o+YIc1bvxaXyvkLGNV48RV41Ue+lixcHRzS0fa3 nAAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 08 Apr 2024 00:26:58 +0800, Yangyu Chen wrote:
> K230 is an ideal chip for RISC-V Vector 1.0 evaluation now. Add initial
> support for it to allow more people to participate in building drivers
> to mainline for it.
> 
> This kernel has been tested upon factory SDK [1] with
> k230_evb_only_linux_defconfig and patched mainline opensbi [2] to skip
> locked pmp and successfully booted to busybox on initrd with this log [3].
> 
> [...]

Applied to riscv-soc-for-next, thanks!

[6/6] riscv: config: enable ARCH_CANAAN in defconfig
      https://git.kernel.org/conor/c/cd899f85b1e4

Thanks,
Conor.

