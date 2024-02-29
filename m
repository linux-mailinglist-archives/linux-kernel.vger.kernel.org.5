Return-Path: <linux-kernel+bounces-87204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F69686D10F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E301F26084
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386CF757F2;
	Thu, 29 Feb 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2i8Xfzk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4D70AEA;
	Thu, 29 Feb 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228706; cv=none; b=ebA9uRoh6Wl162R4bIJYEShhxMmXgw3kC6YtkNvd5Lz+339uE1+4jPvAGe4W5ZgOvPZoz92CSp1tLH5Klh30z+pVzSdposYm4c4X5sLlBolvOzI9eY8NBhfav5IJ1cogT0d7ZnzMMYoeD5sNklDVcM0dNUshvv45oPQtS50pTy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228706; c=relaxed/simple;
	bh=r46YDK3Axw+cBVddXAlXM7gpz+1Uk3YSMg9uwZliBas=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G0EZi1YTWhIKu1XqedPitruNw0prWGemNAhIZvW2jytviD62DK9A46deO6wejstg0HuHI7exi8rQDZOQJzFDq5CMNOIFyDGwkmnEtyAigKKAi7G2/DYxRt4+NHTGSu4YpXql+DK+6TSUCAQ2eAxPJguSwWbeYks1reG0Xjqu3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2i8Xfzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8812CC433F1;
	Thu, 29 Feb 2024 17:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709228705;
	bh=r46YDK3Axw+cBVddXAlXM7gpz+1Uk3YSMg9uwZliBas=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=j2i8Xfzkwu24kv9T/itHx2J8zwt0IqaZDa5JJoKmmrrPJ1VSWZUP9nFIujBp7qi7A
	 Ucy1S6O+YGoWkH5sNSzLkEIWkPoDbT1gUsg9G7nvqy0b+i0gyHI4FN8/sMcNMiaibU
	 mHFEmGVSE6DHMCyUObCBJW8pr1q8qyDF4ta8ZSRINsjehq1ZpRrSnhtexezeVakKM1
	 gyIrxxfmxG3YzQW+HOrb9Ulqg2avUOW/Dox2h+N2T6XY/zTU+enoCL1AG39BLYpDH5
	 uVMDf8f2CWmOt/bpFOWOF20TNqRm3/0CI3mYcZpoTA0Qb6HTR4vWXAg+TVdSBoGLYo
	 Yxa83LMlOImsg==
From: Lee Jones <lee@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Flora Fu <flora.fu@mediatek.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 amergnat@baylibre.com
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Fabien Parent <fparent@baylibre.com>
In-Reply-To: <20240226-audio-i350-v1-13-4fa1cea1667f@baylibre.com>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-13-4fa1cea1667f@baylibre.com>
Subject: Re: (subset) [PATCH 13/18] mfd: mt6397-core: register mt6357 sound
 codec
Message-Id: <170922870128.1628445.8442233644486002127.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 17:45:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 26 Feb 2024 15:01:51 +0100, amergnat@baylibre.com wrote:
> Add MT6357 codec entry in the MFD driver.
> 
> 

Applied, thanks!

[13/18] mfd: mt6397-core: register mt6357 sound codec
        commit: 79d98102a31ab777b4a6632d799ab2bc63654cf8

--
Lee Jones [李琼斯]


