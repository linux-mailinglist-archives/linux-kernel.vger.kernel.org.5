Return-Path: <linux-kernel+bounces-142887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7878A31AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887D82829AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89F91474C0;
	Fri, 12 Apr 2024 14:57:34 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE0D13DDAC;
	Fri, 12 Apr 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933854; cv=none; b=iYxGjAN+RWUMND/tvV98MbziMWCyFJ0pbWoKxAH+46kQiRzb3BJOB3gJITLLF6HWpU88zbCO5+Siv0p17CDt44Qwiz9W/tfveYbuOKWSb7j2PHW7ymLPQQV2xvbZtqJXlSIuk9xJXbKBrpMFStkQyvmdOo8BVhMRNzFHCTTdQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933854; c=relaxed/simple;
	bh=UPCVu988L4eoHjepWEh/X8oPhqda5hmF+SLEW/y0I/s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mveUF7ATgT/x8itHBVkHETd73/OxdWu5qeVRPLz5noLZywnabLlZ8r/+CfR/+8pHwYSCEG51uU68SVUYIb2j9t9k0m81lD3NrXDsI57aWLvMNI+ItA14be7Y/VzuN8l1mNR12cR9wsxz3RM3d1K07KM1l81n5C57tfQ6h0DhGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 7ABA2FFE4E;
	Fri, 12 Apr 2024 14:57:21 +0000 (UTC)
Message-ID: <4e486902-9238-48db-b0b2-2abce4f3b812@enpas.org>
Date: Fri, 12 Apr 2024 23:57:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] HID: playstation: DS4: Don't fail on calibration
 data request
From: Max Staudt <max@enpas.org>
To: Dan Carpenter <dan.carpenter@linaro.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Roderick Colenbrander <roderick.colenbrander@sony.com>
References: <d0e5bb97-3e18-44ac-89b0-503cfe16417f@moroto.mountain>
 <07848795-14e3-4020-9e60-e3221ff6ef80@enpas.org>
Content-Language: en-US
In-Reply-To: <07848795-14e3-4020-9e60-e3221ff6ef80@enpas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 23:44, Max Staudt wrote:
> On 4/8/24 09:41, Dan Carpenter wrote:
>> Hello Max Staudt,
>>
>> Commit a48a7cd85f55 ("HID: playstation: DS4: Don't fail on
>> calibration data request") from Feb 8, 2024 (linux-next), leads to
>> the following Smatch static checker warning:
>>
>> [...]
> 
> 
> Hi Dan, Jiri,
> 
> Thanks for the report!
> 
> 
> Jiri, if you prefer to do so, please feel free to stop/revert this patch for now, and I'll send a better one soon.
> 
> [...]

Jiri,

Would you like me to send a patch on top of the existing one, or a completely fresh one?


Max


