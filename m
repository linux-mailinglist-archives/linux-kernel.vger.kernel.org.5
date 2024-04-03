Return-Path: <linux-kernel+bounces-129892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0CB8971B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDE51C25CD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CA7149016;
	Wed,  3 Apr 2024 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoXYoA8X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCF148820;
	Wed,  3 Apr 2024 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152479; cv=none; b=hz4BLRNNrbt55Q+OEUH4qM64vRO7ZekUAGRqTZ5rtASX2ZGYs6rBcposg4H7aOgsScgk/60nS32UJOM/rS8+khSLMI3isyl5RjGj+ggV02akazk01g296HZhX+TlH/+ju4bMDU/0gU9L/mVp/o3q+LqY+P/zDipT///CVKGnWLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152479; c=relaxed/simple;
	bh=jmLir6yT+gXZwNc/mLtJCMF1x5e9R+cRof8vBe2L93U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=L0GoMQN6rhJz0CBExhh9wRMc425UbzQyFYsF92JkjN9huWE91xjI4O14AdrmSQ7+sX1Cxqda7RbLP/Nqdn52pJQ2A1YwxeKfwIZzcWrsOOeORl6FAg2EaZQxRAuWcuxN5dZLmlkq/2KXQ/douDrXjfTnyTq4Vr0/69DMokhp6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoXYoA8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA13C433F1;
	Wed,  3 Apr 2024 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712152478;
	bh=jmLir6yT+gXZwNc/mLtJCMF1x5e9R+cRof8vBe2L93U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=RoXYoA8Xu3bK3fwacMxAUk55arZBbe8CSE0xL8PSkJ3LC07/XU2PHh7+AuCstnLfx
	 famW8CIYt4jydEYRZEIDzw/p+FKjZ1OC0Yf9Ec/RARno3Hd8gtQpMg6qk6BEaqgRU5
	 JYn5naQopH64LRTGh38PCKogDX3Tlrn3mUba3VN5gumRdikAVYysrxIuoLMzw0jpUn
	 ZvfXILkBp0Gy1QUrz2abtzArDjNIj1lFdzrXMiIkDad3NjCTSavW47yLDU6I4XCytm
	 IyjaH1bqtzpgymZkv/OAfQ9G7IGV1RSifehVdAZXCgN47lyU6ER91FKgy583Mp3NDG
	 V5uyp0DpLwGmw==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,  Marcel Holtmann
 <marcel@holtmann.org>,  Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
  Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Jeff Johnson
 <jjohnson@kernel.org>,  Arend van Spriel <arend.vanspriel@broadcom.com>,
  Brian Norris <briannorris@chromium.org>,  =?utf-8?B?SsOpcsO0bWU=?=
 Pouiller
 <jerome.pouiller@silabs.com>,  linux-mmc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-bluetooth@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  linux-wireless@vger.kernel.org,
  ath10k@lists.infradead.org,  brcm80211@lists.linux.dev,
  brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 7/7] wifi: silabs: wfx: drop driver owner initialization
References: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
	<20240329-module-owner-sdio-v1-7-e4010b11ccaa@linaro.org>
Date: Wed, 03 Apr 2024 16:54:33 +0300
In-Reply-To: <20240329-module-owner-sdio-v1-7-e4010b11ccaa@linaro.org>
	(Krzysztof Kozlowski's message of "Fri, 29 Mar 2024 18:24:37 +0100")
Message-ID: <87bk6q5z6u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Core in sdio_register_driver() already sets the .owner, so driver does
> not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Also here the preferred title format is:

wifi: wfx: drop driver owner initialization

Feel free to take this via sdio tree:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

