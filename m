Return-Path: <linux-kernel+bounces-97914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E9F877190
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F681C20A5F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A102540870;
	Sat,  9 Mar 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="VoW/Q4px"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C31BDF4;
	Sat,  9 Mar 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709993209; cv=none; b=kJEJBbrd/cmweBhEIajX5G8wvyuijh89qypQrKFysafFPD+3ourxC4oN3pnZMiUOe28aYYgpCwkkoB1PcCikpKgza8PlAEEQlbLyOpz1CKsEFaIjGOWhl9wQWJpBL6iMzPJRGLo+KtW8bW3RIpyYtDz+lyfWDdNDbuDA9qMYO6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709993209; c=relaxed/simple;
	bh=DRLJ4cBuxvF0fY5uEWgVJE771EWuG5ot5GbzGWoLM8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxkjH0OnpXWWDkoX3yDJEXnBuKpbXZssC+0p6515JX7DBv+oyn80lYTFfFBwO0mlaa16VEA5uhBjOPK293qwNnOLkbtSKYtCfTt1nk7628s+Zx1yD0HfwjI2I3/PMRVKzBG8v7n5Og5Ln7Yw0te3erxoneo73f8V5hyXrTS4BYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=VoW/Q4px; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Tw2VS+QsVfGXZiZF1IkS/2FHF2jIkdONTN9aFBFDJco=; t=1709993207;
	x=1710425207; b=VoW/Q4pxBpnYhwN1FjFf/rZ0yfISfiuRhIylFAfoIlV8BB90wjqBJHAmkEJdb
	4xEc22hUDxlX3nlfGxMjBmH3Eg8twNLRal/M047kigODfN34SZV9ctR71rQQDrh4sGUYQLBVc1X//
	JcSxrNhwz+XMIM+Hb9fXdyqHfybffe0kL0c9kpEMgx1ez4PFLVi3NbedrEIRUmOjK7dPAIW40ixNk
	veP7GZxVUbRPJqXJNsWQaA2eNc5oVaU9gADwDfO74FC28bnatPeRbABeq7JK8QUMq+lIxUqIvRJnf
	gEheFW1DWNm7m87AwS6fghoGJynhVc3XnUoZUSG6/vwi2EmbVw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rixLT-0007yp-Dn; Sat, 09 Mar 2024 15:06:39 +0100
Message-ID: <b888cbe2-6071-4445-91cd-8ce7cc9cc8f4@leemhuis.info>
Date: Sat, 9 Mar 2024 15:06:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Probe regression of efuse@11f10000 on
 mt8183-kukui-jacuzzi-juniper-sku16 running next-20240202
Content-Language: en-US, de-DE
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: regressions@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <47cdeac1-121d-4b1a-a3ac-e2affc7a2fc3@notapiano>
 <c4416256-eedc-4c9b-b968-3a02490c4c09@notapiano>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <c4416256-eedc-4c9b-b968-3a02490c4c09@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709993207;077ff1e8;
X-HE-SMSGID: 1rixLT-0007yp-Dn

On 08.03.24 15:31, Nícolas F. R. A. Prado wrote:
> On Tue, Feb 06, 2024 at 11:11:00AM -0500, Nícolas F. R. A. Prado wrote:
>>
>> KernelCI has identified a regression [1] on the
>> mt8183-kukui-jacuzzi-juniper-sku16 machine running on next-20240202 compared to
>> next-20240118:
>>
>> #regzbot introduced next-20240118..next-20240202
> 
> Not sure why this got filed by regzbot under the mainline tab rather than next.
> Maybe it was the missing collon? 

No, I guess that is a bug in regzbot: the support for -next is there,
but not much tested. Will need to take a closer look, will do so in the
next few days.

> In any case, the fix has already made it to linux-next, so this should close the
> regression:
>
> #regzbot fix: nvmem: mtk-efuse: Drop NVMEM device name

Out of interest: Is involving regzbot worth it in case the fix is
already in -next? Or is that primarily to keep track of "we found a
regression and a fix was already available in next". I don't mind if
it's the latter, just curious.

Ciao, Thorsten

