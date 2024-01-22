Return-Path: <linux-kernel+bounces-33591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9941836BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FB728866D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0269B46433;
	Mon, 22 Jan 2024 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="LtEqjSxW"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504446427;
	Mon, 22 Jan 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937271; cv=pass; b=QNf17aYwZm9GJlohX4KSAD2jPax9ARHcP++mpjF0k+cGa5wIXN/SjMgoY8MC81V44T7oe6CcLE+deB7/6x2dWpGZ/X3yZ57NSeehOcXVCdHtKUkbhvD9ChwiK8MObD1qvPNCw8QoZTjmw+NQ/KlI790uR5bjb1qcKrWzftBI0rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937271; c=relaxed/simple;
	bh=LArNfFU9YRUKCkH7jrZj0/mO2+RglQS0Gl+D9m9pX+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sqMoi7Yhsi0RBrVODjUHpACdnnpQjtQqfyDp+YmCOHW3xiww/mlEygFwjjg/TBNIsY8fzmzoI1yGfI+sxiGCUq87/fFq5NlEcIOWGRXn/dXzLwD6OCS6KTFVY80e75RNuQNNSuw6aJ7ev6fNvL+20fKPWrySXJPUBg60GYGaUY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=LtEqjSxW; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1705937262; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QCVpFMqNjGjVV5EYuqft1OMPhcfFWj1kJTavp9G6VYI5X3wT7cOt0cpn46XuR/Bf3M3GYzCD3GB9Xr/mIt9FI8MRMXewtDLeO1+9Wl8z2ErJuGpbQ1vDkLUEuWiaSrWtKXmKztyNshhYWpHE9MhWReR//NBCp+B1qiNjZbui2/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705937262; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LArNfFU9YRUKCkH7jrZj0/mO2+RglQS0Gl+D9m9pX+U=; 
	b=jKj7ruVKE+un6FS5k/HX4pt1UY7I7EmwyQ+/UT5cbtVBf9nltWka8Mh3hyOHkmxe3Z7/V/R3fLDamXkfdwSo69bYlPvyK268e5QaY+wn058MnXJxj2MTLYa7Z1BpAybGuKtD7bgbEHIhziOAVH/Vvx6EKcNG8hQF9/i59tlwdq8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705937262;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=LArNfFU9YRUKCkH7jrZj0/mO2+RglQS0Gl+D9m9pX+U=;
	b=LtEqjSxW3AzRRJjj9ZdopFj7fyJIi2bQ6+nYf5n+QBs32YUpTLzI4GrlNfn2KvE+
	fwjsan2t/XjO0u8VNxArGQ5V2rp37cvVOQ7zbFmeYngaAAxinAt6/DWeW1ghy1OXf0F
	i+4xY3WdHYItkw/SEj792RD9bdGQfiVC90NI/wfw=
Received: from tb.lan (182.118.232.146 [182.118.232.146]) by mx.zohomail.com
	with SMTPS id 1705937260833107.56326002159994; Mon, 22 Jan 2024 07:27:40 -0800 (PST)
Message-ID: <e0a9f2eb23813f4b6666d7b5082afcb98ffeb509.camel@rong.moe>
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974: Add device tree for
 Samsung Galaxy S5 China
From: Rong Zhang <i@rong.moe>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Date: Mon, 22 Jan 2024 23:27:27 +0800
In-Reply-To: <47fb5916-a4b1-4917-ba0d-41bb7240edba@linaro.org>
References: <20240121154010.168440-1-i@rong.moe>
	 <20240121154010.168440-5-i@rong.moe>
	 <12e04abf-7720-4c2c-9f1f-0cfee7ba004e@linaro.org>
	 <9b1c28415b5e3a5d94d167612fc0b7e0f9d0a767.camel@rong.moe>
	 <47fb5916-a4b1-4917-ba0d-41bb7240edba@linaro.org>
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

On Mon, 2024-01-22 at 16:17 +0100, Krzysztof Kozlowski wrote:
> On 22/01/2024 15:51, Rong Zhang wrote:
> > I've glanced similar dts. To solve this, I think we could either:
> > 1. keep the dt-binding in [PATCH 3/4], and delete "samsung,klte" here
> > 2. rewrite dt-binding like crystalfontz,cfa100{36,37,49,55,56,57,58}:
[...]
> > My preference is (2.) since other variants of klte may be added in the
> > future. I would like to hear your preferences.
>=20
> It depends whether the devices are compatible. IOW, entire klte DTB
> should work fine on kltechn, just without few new devices.

Yes, they are compatible. I'd used the klte DTB on kltechn for a long
time before I made this patchset. It worked totally fine expect for
LEDs and WiFi, as I've said in the cover letter.

Thanks,
Rong


> Best regards,
> Krzysztof
>=20


