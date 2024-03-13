Return-Path: <linux-kernel+bounces-101431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0396487A708
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352CD1C21984
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212A03F8D1;
	Wed, 13 Mar 2024 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mydatex.cz header.i=@mydatex.cz header.b="ZwlkzazJ"
Received: from kali.sitour.cz (smtp.sitour.cz [77.48.244.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B17224FD;
	Wed, 13 Mar 2024 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.48.244.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328952; cv=none; b=ARU03ueyD97yfkw8hquukWiZgxefx3x3OhUvSylj8rA77LiCSKw62RiAE2G/QFH+OH8/RyUukN+qvDhE7qGOOWDLj9MmGcxumomzhpmmfAovpk/pmkkI11Cn9gwd4Bn9JDaZ50aYsb3xsGfABgJ29CVjx5BECKRJq6yhqiYeroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328952; c=relaxed/simple;
	bh=WMx5/j1YEecQD2XDSpfO6H03HAlIbOY/dc9fwmS4g5A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=liNNNKbebzPgk0KD4vmtx2vvRGPk6xietQzvrnK51UJObatyxG0PdkvTZ86Y/wOvCdiwlx9G3qqUAo6/su2ZzR2khN8me0jh/3BXFyMK6AdqtyZSQtvXasAowEHuGuJY8C7R/Zw9XudrHhBG1w0BFa6Fs3Ls3kW3oapQHvjJTro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mydatex.cz; spf=pass smtp.mailfrom=mydatex.cz; dkim=pass (2048-bit key) header.d=mydatex.cz header.i=@mydatex.cz header.b=ZwlkzazJ; arc=none smtp.client-ip=77.48.244.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mydatex.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mydatex.cz
Received: from localhost (localhost [127.0.0.1])
	by kali.sitour.cz (Postfix) with ESMTP id 9E2BF4E0278;
	Wed, 13 Mar 2024 12:22:28 +0100 (CET)
X-Virus-Scanned: Debian amavis at sitour.cz
Received: from kali.sitour.cz ([127.0.0.1])
 by localhost (sitour.cz [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IRI5MDbd2KzZ; Wed, 13 Mar 2024 12:22:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mydatex.cz; s=mydatex;
	t=1710328946; bh=WMx5/j1YEecQD2XDSpfO6H03HAlIbOY/dc9fwmS4g5A=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ZwlkzazJmhJG7mSZdd7eP/ZZ5caKfFQ89O5ODBFFrCwlQgHZOLlm6kfxTivkJvfrP
	 kZmscKyXgLt5fLMkgdH5Yw8lBmLboZbTuCLHmPmZQptKUDBW3epdz3ORs8x88VCo9K
	 Kti7WmbnZ7ZV3Qmz4/cYRZaCUNwBJ+baLdfdXxKtVUn3TkKc+jupdBvLxQvHBPWKKy
	 H0vu4oh1Ata6Phi2dVqJB8eqRqpQy9oVYSr/FZB58T8Bmcee5kOaIkwz/7CDbEeibG
	 wCNGcznwJtb74qKC2RMbTu3OGqBj4B0VwvB4bHQIBmJolgQ/U9EiRB6zWjZhC+SzSa
	 qQmcJ7XVYvYiw==
Received: from [192.168.3.13] (firma.mydatex.cz [84.242.99.246])
	by kali.sitour.cz (Postfix) with ESMTPSA id DEEEC4E0276;
	Wed, 13 Mar 2024 12:22:25 +0100 (CET)
Message-ID: <b6c9b015-86bc-475b-a190-e35fa76c1ceb@mydatex.cz>
Date: Wed, 13 Mar 2024 12:22:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Smolik <smolik@mydatex.cz>
Subject: Re: Regressions can bus with MCP2515 on sama5d3 connected over SPI
 stop working on kernel > 5.4.271
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
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
Content-Language: cs-CZ
In-Reply-To: <20240313-polio-jinx-bc5fd5df7c06-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

this is my first bisection please be lenient :-) Threse is a result:


marvin@marvin:/usr/src/linux$ git bisect good
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[52f96cd135b160d44db4cb62a5b614b3bca20fbc] net: stmmac: xgmac: Remove 
uneeded computation for RFA/RFD

Regards
             Dan



Dne 13. 03. 24 v 11:35 Marc Kleine-Budde napsal(a):

> On 13.03.2024 10:16:47, Linux regression tracking (Thorsten Leemhuis) wrote:
>> Hi! Mark and Manivannan, do you by chance have an idea what might be
>> wrong with Daniel's system or can point us in the direction of people
>> that might be able to help? See
>> https://lore.kernel.org/all/2ede8f49-41f8-4d9a-83e4-ea5d4d1677fe@mydatex.cz/
>> for the initial report (but it is in the quote below, too).
> At the first glance the mcp251x.c changes between v5.4 and v5.5 look
> unrelated.
>
> I try to find some time to setup bisecting on an imx6.
>
> Marc
>


