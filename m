Return-Path: <linux-kernel+bounces-73453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3400D85C2CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8ED6B22AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA44D77621;
	Tue, 20 Feb 2024 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="NMO8NtBn"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5D476C9C;
	Tue, 20 Feb 2024 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450595; cv=none; b=Fecn16lq1PbIcfIo+Uy6zOas08rqhU9J3PbUIQhfj+tS9Up+zNPlImqTnc2V7KHvtkvmCqpD9A+o2qy8wOzuAWb6v82+r/d5v8mcYIrmumIsheIa63dAj51typJBzMaHt8ke/VaNJ6VsRfBfVgv9c0QYewHYn+EsRRjjmAo05jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450595; c=relaxed/simple;
	bh=cmTEJiha2tFDubjqRfGi+KdNyZivDUyjm8JbT+qL5uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fd7yUt1K1RV4WwWm8rav8eZkBsjhBJopH3XV0mOxV2S5b9SeTYb1IL8SXoz3LJEo6KmFyX6vEAOoJMg+mAiWrNOjn0oTI9Be1knAAUiV3LEC2R4vZF33QAciOwDIQraK2ld0+Ou5qLzrjPr8O+XYP/uRx6O9ZKNmLSv7sB7JIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=NMO8NtBn; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3789F100322;
	Tue, 20 Feb 2024 20:36:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3789F100322
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1708450582;
	bh=CT2QMXS2awc1UaugLcYawqtrm8RuYnHBK31jT43QizI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=NMO8NtBn7IkhhTHIh+4qe3rb8AJgePA80AUDKl2Jh0f9msCkzvOsYcsI+orVuKYw3
	 KkLezKeEuOlsZzYNQC788a1Lg/g7HHZxF4VTu5Ic6f/RF2zobGj0JpUBj5H+k+aE0b
	 c0WwZ+scGjZcW4Na2zSk2Rir4nWJWLiGiamhMCaHIa3KHh3Ivjv/ZRoyBGIgwe7VwO
	 jqIsOmbFPWRpsESeF0mxOq2Cu71rHvsb+TfEOcl8jdN0He0SBwzf60QcyXy0Q1HVWk
	 CpeSnvelkUGEDXQYp1IVVzXLNxH9+nRQVWgo5EtfrxRChM2ikxbUzDuaaI3jx58ZlS
	 vKQr3zKgkpMfg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 20 Feb 2024 20:36:22 +0300 (MSK)
Received: from [172.28.64.15] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 20:36:21 +0300
Message-ID: <a25ff51d-d328-43d8-98af-91598c1ef23d@salutedevices.com>
Date: Tue, 20 Feb 2024 20:34:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: allow to skip clk_core_req_round_rate_nolock()
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <kernel@salutedevices.com>
References: <20240126201433.1830600-1-jan.dakinevich@salutedevices.com>
Content-Language: en-US
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20240126201433.1830600-1-jan.dakinevich@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183586 [Feb 20 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/20 16:18:00 #23712592
X-KSMG-AntiVirus-Status: Clean, skipped

Please take a look at this patch.

On 1/26/24 23:14, Jan Dakinevich wrote:
> Calling of clk_core_req_round_rate_nolock() can be time-consuming in a
> case of deep hierarchy with multiple dividers/parents. But if the clock
> already has exactly the same rate as desired, there is no need to
> determine how it could be rounded.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>   drivers/clk/clk.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 2253c154a824..04f0ddced932 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2423,6 +2423,12 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>   	if (!core)
>   		return 0;
>   
> +	/* skip calculation of rounded rate if the clock already has exactly
> +	 * the same rate as desired
> +	 */
> +	if (req_rate == clk_core_get_rate_nolock(core))
> +		return 0;
> +
>   	rate = clk_core_req_round_rate_nolock(core, req_rate);
>   
>   	/* bail early if nothing to do */

-- 
Best regards
Jan Dakinevich

