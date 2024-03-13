Return-Path: <linux-kernel+bounces-101441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A4587A721
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB01281664
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965033F8FB;
	Wed, 13 Mar 2024 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="r4MeLfxn"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2730648;
	Wed, 13 Mar 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329525; cv=none; b=N2y5Kn+ROKoyPwiUmzMV5R8zguROYqMWSY1fLK1hu5IHPamZJrWgcGdpl4p69Fo9KAnPcSJK3FlG1i7vNej//+eL820nxbdKkDYJMRsnPSV8XAsyuJKYRFU/eae1v7Pb4RATjy1RXRHjA377djHs+z7ln42Zaqemo7rhpxkxtmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329525; c=relaxed/simple;
	bh=OpL4rxyz+uZrgVukUOb6VwUmnNshzynbyZBUIQpZkZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvsQXgTip3rqxtRr/+WcIjBkVJSWvDhRsXb1dXDLpucZkO1VIlnxRrqQjAtQhbcW96DYidlnqzFw48bSLgCd+GpC99B0mrnKHxwAxDfPZoByAQY0bDIwy+EdoL0qlmQiTGW04LZba8h6EV45QOszA9Oxzg0qSQXRR8Z7wMoRVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=r4MeLfxn; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=aGMqMAeJ9vQmIq+ADPBMsdeHkP5+Lwi6g6pE/7mo7uE=;
	t=1710329523; x=1710761523; b=r4MeLfxncjrhMDp94g1Dls6yYDgPZBmGszAgpA4x72fzdTa
	UURKR8LTx74E1uK5cCd9DlGIp4MMqEX38pzBjOb2l6hxM7z+XOs9M38WBKLdNRc051d1JMtSI10UY
	tdcs9drNRgMxz0fCWQ33mJmsmsXNPXLcaXnln6RjwA7F+YD8SCwexYsM/GsP2oyxtTYeCntUvMgXq
	Xs86pWlr/5kZnBLNJxPcsShybKEEwi2IWAWxyCHxZzqsU1Lr+qG5hYCX7DIgbAKqubtjhmU7+S+1S
	oyeOh2A+FQ6fFiAX1E8jmtUoQfNdA2+oEVkQ8VWu2cJvHiZeh+mYo0p3KZ59CepQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rkMq1-0003K9-BU; Wed, 13 Mar 2024 12:32:01 +0100
Message-ID: <8086dce0-11d2-4bad-be47-e16bbc0800d9@leemhuis.info>
Date: Wed, 13 Mar 2024 12:32:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regressions can bus with MCP2515 on sama5d3 connected over SPI
 stop working on kernel > 5.4.271
Content-Language: en-US, de-DE
To: Daniel Smolik <smolik@mydatex.cz>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <2ede8f49-41f8-4d9a-83e4-ea5d4d1677fe@mydatex.cz>
 <a2e64be0-e07d-4c55-aba7-87c7e4c876e0@leemhuis.info>
 <734cf096-3769-4610-b72f-394c31a8d942@mydatex.cz>
 <91d8a6b6-6186-4aa0-8462-56b4751854e9@leemhuis.info>
 <6918321b-038d-40b9-8149-d535bf9d3d52@mydatex.cz>
 <5f69d6ee-a07a-42a9-a238-7dbe1f82cc3f@mydatex.cz>
 <3e46d70b-196d-45c7-bfdf-869c78cdc81f@leemhuis.info>
 <20240313-polio-jinx-bc5fd5df7c06-mkl@pengutronix.de>
 <b6c9b015-86bc-475b-a190-e35fa76c1ceb@mydatex.cz>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <b6c9b015-86bc-475b-a190-e35fa76c1ceb@mydatex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710329523;7299a015;
X-HE-SMSGID: 1rkMq1-0003K9-BU

On 13.03.24 12:22, Daniel Smolik wrote:
> 
> this is my first bisection please be lenient :-) Threse is a result:
> 
> marvin@marvin:/usr/src/linux$ git bisect good
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [52f96cd135b160d44db4cb62a5b614b3bca20fbc] net: stmmac: xgmac: Remove
> uneeded computation for RFA/RFD

Have you tried reverting that commit on-top of 5.5 and/or 6.8 to see if
this fixes the problem, as advised by the bisection guide I mentioned?

Ciao, Thorsten

> Dne 13. 03. 24 v 11:35 Marc Kleine-Budde napsal(a):
> 
>> On 13.03.2024 10:16:47, Linux regression tracking (Thorsten Leemhuis)
>> wrote:
>>> Hi! Mark and Manivannan, do you by chance have an idea what might be
>>> wrong with Daniel's system or can point us in the direction of people
>>> that might be able to help? See
>>> https://lore.kernel.org/all/2ede8f49-41f8-4d9a-83e4-ea5d4d1677fe@mydatex.cz/
>>> for the initial report (but it is in the quote below, too).
>> At the first glance the mcp251x.c changes between v5.4 and v5.5 look
>> unrelated.
>>
>> I try to find some time to setup bisecting on an imx6.
>>
>> Marc
>>
> 
> 
> 

