Return-Path: <linux-kernel+bounces-140338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8B88A1301
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E425AB25815
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D321474C3;
	Thu, 11 Apr 2024 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="CqpnU+BP"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030EA145B08;
	Thu, 11 Apr 2024 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835013; cv=none; b=C8X4/jX0I67H/j4MDO3MNinfJqiydrNkJsdm21L8ukQlYwEo8M+wInQJO1PR1BEWajaVhDkQNoGCenB10kwbnckkTw6gDzwj17trj/USw31LHkoBJZPhfgtbknA0iJwy+o76V6148KFjqbO4ls1+pfCRbZPKHwTK4AwArs8sM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835013; c=relaxed/simple;
	bh=1APKQilN3KOr/QtnFwq4ziD2NuoZYSGfZUZ72o0YZC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FYjYRktXCbwdW3/7gWVtRDVph+NkTQ4qo7dmUL7cFiYGBC7TH3xyQGx2uyzqpGRECZsIzmenDwTryz/oVRgZdUNjl5biYm/P90My69Lyu3YXM3vwivoL0RKEzbWrIvh7DdCK4Em3yi33ALjWyoWJxBu5cUkAfDMbgR1piph4b0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=CqpnU+BP; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id DF9C7100002;
	Thu, 11 Apr 2024 14:29:48 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712834988; bh=vfdGuoVAYV58AUhj/zofkCcJDkvE34z/umq0QY3tVtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=CqpnU+BPtIXoHL27lTCUB//pJ/oI7+UiMbh3szTXfRpXA8CnXmVQQiLHxygyWtLUj
	 qKTdLrv5s1PgwQvJPr+GqH3mAExr90VgrbKLu/Nw9sFQ2Je1fqBqimQvwTNt/CRNax
	 kW0Two4BFNPX2EF4MZqqk9bE9B/ALjiqFUPC+BA2Y9VoKAldOpgpBp38dOloRnsIBs
	 Gs0WFPci0Jj/AJSZNbTmk3s/r88n+MuKN5Ax4GTQr+D9g1toL1A0K6Ywn0TprLSQ+h
	 q42sCK1BXn0V5BSQYdOW0zpM6IkFtsiW23focFz5UEZdCm5KMsrnt7ErV3/iO5uYy9
	 NnfYS1PtZua4w==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu, 11 Apr 2024 14:27:48 +0300 (MSK)
Received: from [172.17.214.6] (172.17.214.6) by ta-mail-02 (172.17.13.212)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 14:27:28 +0300
Message-ID: <478ad5a2-88b7-4069-aa9b-52084ffeda67@t-argos.ru>
Date: Thu, 11 Apr 2024 14:24:58 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: thermal: tsens: Fix null pointer dereference
Content-Language: ru
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Christian Marangi
	<ansuelsmth@gmail.com>
CC: Amit Kucheria <amitk@kernel.org>, Thara Gopinath
	<thara.gopinath@gmail.com>, Bjorn Andersson <andersson@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20240405090720.16419-1-amishin@t-argos.ru>
 <2cd986c0-8663-4143-9d35-4af94fe5e4bb@linaro.org>
From: Aleksandr Mishin <amishin@t-argos.ru>
In-Reply-To: <2cd986c0-8663-4143-9d35-4af94fe5e4bb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184672 [Apr 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/11 07:47:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/11 10:13:00 #24743273
X-KSMG-AntiVirus-Status: Clean, skipped



On 09.04.2024 12:52, Konrad Dybcio wrote:
> 
> 
> On 4/5/24 11:07, Aleksandr Mishin wrote:
>> compute_intercept_slope() is called from calibrate_8960() (in 
>> tsens-8960.c)
>> as compute_intercept_slope(priv, p1, NULL, ONE_PT_CALIB) which lead to 
>> null
>> pointer dereference (if DEBUG or DYNAMIC_DEBUG set).
>> Fix this bug by adding null pointer check.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: dfc1193d4dbd ("thermal/drivers/tsens: Replace custom 8960 apis 
>> with generic apis")
>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>> ---
> 
> Maybe we can replace p2[i] with p2 ? p2[i] : 0

Your solution look better for me. Thanks. I'll offer v2 patch

> 
> Konrad

-- 
Kind regards
Aleksandr

