Return-Path: <linux-kernel+bounces-33839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 580A0836F57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD281C269DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30435A11A;
	Mon, 22 Jan 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="mWNYWuTO"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965559B7B;
	Mon, 22 Jan 2024 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945087; cv=pass; b=QDpS/yksmb0OhucI6OmoK6AbFWFj6tpeDMMG5onZ/mmg3kxKkh0+g5TnHw/dR5zri7yc281RG5BwT1eHgdn0PfLT8Jj3eyofHsvY4J6Y9oUBAVP8hk+LOgH1QnoqfvLvjI9MCUe0mrcxNm+x1GuWkUIpgeQnrRVphfXbUaDlDAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945087; c=relaxed/simple;
	bh=TP1/GIhm0AolInvICof2QAYpqp3X+269kiaQUPdI4pI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qpF92GxyNxCrWiyLUXrNomVBG4Ik00E7PAs2ZrK67pBgycc+UdvflqykYj682mJwGdPe7QSixcpUyfH2ROqybT9hO9R58GkKGNcXz2QUCDgTyzC3KSnmEAZjXRyNxqMhUwlUnooFwZaKZH5pT4W+HH10PW7DY7wQuBuYZQNJWJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=mWNYWuTO; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1705945080; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TG1rVNTJ/gBR42F8jp7dBf6vVAf3/rMkUMKbWHAvg44spJCHvcHLlTJ7J/Hd8rVfWZ1HX8YIys/lKqSVwFzmwy+/hjtoVSd+6BsT4BJh2EZTDqahx5WjEPOYgkTLsRWu0LX5Z4EtCh6+3gemO10klOLeJmBU79uE9OumEy03a0A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705945080; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EeIzTxqVAm5xGJwXvmtUxCe9G4u7J32wQZzbvkU2/WE=; 
	b=FwTA/fdZNuZL1QTtL99wyFUUYxeKDMpvu4XUf+2BwcVAuAzLT4aKDgPtZQUUaNgeBp/Hr1g3zFhyBC7r/gwTWnyOsH0UxkwFSlfn8Z5JRU+J2SkZyKBw0oTzax3ygjSN+73AaGzvgTwjhZ+cfbF2bFaIG+nES7lRmjFQkFNCSYI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705945080;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=EeIzTxqVAm5xGJwXvmtUxCe9G4u7J32wQZzbvkU2/WE=;
	b=mWNYWuTOtFCRT8Xp3nmgI0bPCEwa25RLgPgc21JMTuCrKm5F9/9Xek+Ya/tKNXia
	NL+4ZCII0QK1oC+4dpv6JBSCz6m8smo25yQI2ebvnI48its5LQTpSOBt4DQ/J7ZmEZ0
	nTPizE2XXNjzztDFsOqzuoDD1DsiVjZrgJXZ9WPo=
Received: from tb.lan (182.118.238.16 [182.118.238.16]) by mx.zohomail.com
	with SMTPS id 17059450788345.314839394946716; Mon, 22 Jan 2024 09:37:58 -0800 (PST)
Message-ID: <9882dfb98a2c49d655775f17cf6c89f1a9181d69.camel@rong.moe>
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974: Add device tree for
 Samsung Galaxy S5 China
From: Rong Zhang <i@rong.moe>
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson
 <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Date: Tue, 23 Jan 2024 01:37:50 +0800
In-Reply-To: <1635b0e5-df47-4918-be83-edc27c59d8cf@linaro.org>
References: <20240121154010.168440-1-i@rong.moe>
	 <20240121154010.168440-5-i@rong.moe>
	 <1635b0e5-df47-4918-be83-edc27c59d8cf@linaro.org>
Autocrypt: addr=i@rong.moe; prefer-encrypt=mutual;
 keydata=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
	cMTsfqztU+orM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Mon, 2024-01-22 at 11:50 +0100, Konrad Dybcio wrote:
> Looks like you didn't change the brcm,board-type though?

In "[PATCH 2/4] ARM: dts: qcom: msm8974-samsung-klte: Pin brcm,board-
type in wifi":

   /*
    * This aims to allow other klte* variants to load the same firmware,
    * as klte variants have little differences in the wifi part.
    */

So it is intentional, in order to let them share the same FW, in
particular, the NVRAM file.

Without [PATCH 2/4] and with this [PATCH 4/4]:
- klte DT probes "brcmfmac*.samsung,klte.txt"
- kltechn DT probes "brcmfmac*.samsung,kltechn.txt", but never probes
"brcmfmac*.samsung,klte.txt"

With both [PATCH 2/4] and this [PATCH 4/4]:
- klte DT probes "brcmfmac*.samsung,klte.txt"
- kltechn DT probes "brcmfmac*.samsung,klte.txt"

I pinned "brcm,board-type" in the klte DT instead of the kltechn one
because other klte* variants are known to have little difference in the
WiFi part. By pinning it in the klte DT, future ports could be easier.

If you'd prefer not doing this, I am OK to drop [PATCH 2/4] in the v2
patchset.

FYI:

LineageOS considers all klte variants use "common" WiFi FW:
https://github.com/search?q=3Drepo%3ALineageOS%2Fandroid_kernel_samsung_klt=
e+CONFIG_BCMDHD_NVRAM_PATH&type=3Dcode
https://github.com/LineageOS/android_device_samsung_klte-common/blob/8f71a6=
3415397def5ba886f4030b0d91e2253262/common-proprietary-files.txt#L251

I've tested the klte port of PostmarketOS (with klte FW and this
patchset) on kltechn, and it worked fine. For the FW used by
PostmarketOS, see also:
https://gitlab.com/postmarketOS/pmaports/-/blob/439227770ffcd32eb7e26436598=
c804dc35637ad/device/testing/firmware-samsung-klte/APKBUILD#L17


> > +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts
> > @@ -0,0 +1,16 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "qcom-msm8974pro-samsung-klte.dts"
>=20
> It's customary not to include .dts files, instead split the common parts
> into e.g. qcom-msm8974pro-samsung-klte-common.dtsi and include this in
> both the existing and the new one.

At the very beginning, I thought including .dts could make the patchset
tiny (considering that the difference among klte* is also tiny).

I agree that splitting the common parts into a .dtsi will make things
more elegant and make klte* DTs consistent with the style of qcom DTs.

Will do in v2. Thanks for your advice.

Thanks,
Rong


