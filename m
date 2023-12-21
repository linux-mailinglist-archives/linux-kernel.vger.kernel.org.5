Return-Path: <linux-kernel+bounces-8580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B075681B9B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38BFBB21FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4499A360A0;
	Thu, 21 Dec 2023 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTINVrUo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B71D6A9;
	Thu, 21 Dec 2023 14:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A74C433C9;
	Thu, 21 Dec 2023 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703169652;
	bh=ri5KEEnsiQYrzG321GXsHIE5EoVCZaliNnZtZXHZhxY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=jTINVrUoxf0xMKKDKtGckqKXUM6nl+CkqezQpPY3seXQlzd/MDpf4SYcNsQmaEBAL
	 caKLw4FjqDCaxl2x4U2VbAVoyQDlo7q8E3JCAzl8TIcSQNwhI8txmuzrcbJ6AnwFKE
	 6BP0IUy/vqT015XN/BnrQdBiGPSzIRuc3qv/fehgvGpsoLFy/tHNp35rP6qgwv58fZ
	 XmGTnNV6vYPDlh7KP3aPCDo/zAnytA77aVVzm9sLr0Sjv/2NjiSNcVbM9//85exDdi
	 4P9v6RNLAMTpiYkAgfTPUBYdOj7JRmih5kCcasYLkhLTE/U4wEaj+/PST1o4OkdyJ0
	 PxaqfSZacuXxQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-next 01/11] wifi: rtlwifi: add
 calculate_bit_shift()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231219065739.1895666-2-suhui@nfschina.com>
References: <20231219065739.1895666-2-suhui@nfschina.com>
To: Su Hui <suhui@nfschina.com>
Cc: pkshih@realtek.com, Su Hui <suhui@nfschina.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170316964846.1243375.3938053797242635689.kvalo@kernel.org>
Date: Thu, 21 Dec 2023 14:40:50 +0000 (UTC)

Su Hui <suhui@nfschina.com> wrote:

> There are many same functions like _rtl88e_phy_calculate_bit_shift(),
> _rtl92c_phy_calculate_bit_shift() and so on. And these functions can
> cause undefined bitwise shift behavior. Add calculate_bit_shift() to
> replace them and fix undefined behavior in subsequent patches.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

11 patches applied to wireless-next.git, thanks.

52221dfddbbf wifi: rtlwifi: add calculate_bit_shift()
acefef7a7e7a wifi: rtlwifi: rtl8821ae: phy: using calculate_bit_shift()
969bc926f04b wifi: rtlwifi: rtl8188ee: phy: using calculate_bit_shift()
1dedc3a6699d wifi: rtlwifi: rtl8192c: using calculate_bit_shift()
f4088c8fcbab wifi: rtlwifi: rtl8192cu: using calculate_bit_shift()
3d03e8231031 wifi: rtlwifi: rtl8192ce: using calculate_bit_shift()
b8b2baad2e65 wifi: rtlwifi: rtl8192de: using calculate_bit_shift()
63526897fc0d wifi: rtlwifi: rtl8192ee: using calculate_bit_shift()
ac32b9317063 wifi: rtlwifi: rtl8192se: using calculate_bit_shift()
98d9c7731dbb wifi: rtlwifi: rtl8723_common: using calculate_bit_shift()
5c16618bc06a wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231219065739.1895666-2-suhui@nfschina.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


