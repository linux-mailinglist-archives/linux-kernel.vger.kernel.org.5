Return-Path: <linux-kernel+bounces-62990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7073A852890
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EC81F214FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43EC18AE8;
	Tue, 13 Feb 2024 06:04:53 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3131018659
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707804293; cv=none; b=JE4/+UYggy09djscBIsXx4Vqfbts645IRSHWbgtGS5/zmYPKatYSW3wXNnkF/qv/GgBKp0CY1w0Dc01d/rVBVQeUV2Sa6IZibF0+0jR8ro1UhJxDJnGDsftnX4RUPY22osimuPNzNiLtd7c69OsHrmqICKyPTSO9cpx5+TXu2TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707804293; c=relaxed/simple;
	bh=qxuoBS4d0ZV5YWPV7tIWWZ16ZSmSB9y9TnGRUPPxDTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1D2Rml4jt6F90eP9ou8mLa0AEtpzYxwVBOJY32krQBRWGFXSQ35Kn+qhM4VYNgKAzHaxsYu8S08nddE5VqWnBC0X2C72ae55s3gyeNogjDHJ1cjDNsRUcTRglCrgejS9XaPX5FhIDjAqiXM62sm1w4H/6fNbxOpLbVcYLnhovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Tue, 13 Feb 2024 06:04:48 +0000
Message-ID: <155d9261-a429-47c4-834b-b435782615ca@sdfg.com.ar>
Date: Tue, 13 Feb 2024 07:04:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tools/nolibc: Fix strlcat() return code and size
 usage
Content-Language: en-US
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-3-rodrigo@sdfg.com.ar> <20240211104817.GA19364@1wt.eu>
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20240211104817.GA19364@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/24 11:48, Willy Tarreau wrote:
> For me it's 58 bytes, or 19 less / 25% smaller, and at first glance it
> should do the right thing as well.

Oh, here I get almost the same (57 bytes), so it must be the example we 
are compiling what is different.

I'll check this after some sleep :)

