Return-Path: <linux-kernel+bounces-122937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5484388FFD3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F97A1C262B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC1580024;
	Thu, 28 Mar 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRXvm0ap"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A23E7E105;
	Thu, 28 Mar 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631270; cv=none; b=oPnaESiKrJQdujj7LGDuvDTaXlHl/3+qbjKhZBCxETFyHXUxzSEzusOK3lDhZXyIm0UeLBeh94DkctXo1Bh/SryAClBRvtnXn1iNXpGERZsVz3bmPSBE0plPDi6YRj5KgEpwM2yqIdfjJ6CljsJm1VFgBV4zFv5ov7SVazwQ0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631270; c=relaxed/simple;
	bh=n3sgCTvXdScEHWS5sc+0tIaUwY4MGQOeVlMAcU8GRxM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=c6BbUoTn+UXWOmdSdupjLE82l0TtTymL3KlsBayGJsAdEyQdY6jFvpD/egeQKXkZGInced52EmJfSZ+tjyNVMQ6SnOu5YJREl/IVkV5TqHVbVF7/4JR24Eanw+wGaAXOv9h5SD7k5ZddIcOXrjxojWENhIsUQg00PTwI5vxETE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRXvm0ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED26C433F1;
	Thu, 28 Mar 2024 13:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711631269;
	bh=n3sgCTvXdScEHWS5sc+0tIaUwY4MGQOeVlMAcU8GRxM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=HRXvm0ap7UxuutzO+R1lu9U4RyUO3+5ggjByG3IM1uGudUngkf+Mw2xBK5Op4MMT1
	 SHaIKjS5raIuq2/H7ViZs6f6hj8jozj/1H9PFcHYZcP3+Vc9Gy6kYBKFG2R/rngAil
	 pMHmukugHxTuyPaWIGJhRKQGGRi5t4jAcq2/uwd3xsSjr8tDVsEZcp+5642B5i4vcp
	 EiGq4MOtWprNg/WwPamqmdXSPS6tTqsqIZrZ/HYjoH/7llGx3LNTX3G3NacuqixuGO
	 ignBaN5pFgzO8MKiyhafdstupmn+rJelYNmorm/ckT8mzM2NKjRHPWSYmiyG5405mY
	 +MBYP5mM39A5w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: ti: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZgDcwIgxkhs6ZVdY@neat>
References: <ZgDcwIgxkhs6ZVdY@neat>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171163126667.129280.6353986762848602648.kvalo@kernel.org>
Date: Thu, 28 Mar 2024 13:07:48 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> Remove unused flexible-array members in multiple structures, and fix
> a hundred -Wflex-array-member-not-at-end warnings[1] in
> drivers/wireless/ti/
> 
> Link: https://gist.github.com/GustavoARSilva/fbf63c114d01319bbd19baf95b4d704b [1]
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless-next.git, thanks.

f4b09b29f8b4 wifi: ti: Avoid a hundred -Wflex-array-member-not-at-end warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZgDcwIgxkhs6ZVdY@neat/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


