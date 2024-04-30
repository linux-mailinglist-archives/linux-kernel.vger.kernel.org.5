Return-Path: <linux-kernel+bounces-164590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFC88B7FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D7F1F24D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67FF181323;
	Tue, 30 Apr 2024 18:32:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D0E1E86A;
	Tue, 30 Apr 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501971; cv=none; b=GV/7Ij4STZ09j/BGMronJwWDuOukUlhaNXLnTX/cHE4M0BCf0dxjH4rlyUJ6yz6hUWfHURIhI/oeIN1y+VejgsyRo26dP9qTyKb0zKnWeX0eLfMWAk9onWO4ISj9X2kOrjJ2bpBlythl/u8JRnjXU/Pcuib2t1dYhotGQg/Tjns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501971; c=relaxed/simple;
	bh=t5tGTEhFr8KFQV0f+cxOC+J/X75OuPA3Tuq3aflsfq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8I4A5XIk6w70AFPHJ8eN/MLoJxzsRlRmUIJEqjtnpjuTjrDV+BbBLGLze4bP33wqeLzOwXVWBhTXZIQbUlsB9EK2rOO/hNP0rseWO0sU9Ifhv90FjppgjaYskf4KqKCUx0I+/xiklnYhIeAPGZbqmed183CosCrST/bTbvZEgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D189C2F4;
	Tue, 30 Apr 2024 11:33:11 -0700 (PDT)
Received: from [10.57.65.13] (unknown [10.57.65.13])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C5E33F762;
	Tue, 30 Apr 2024 11:32:44 -0700 (PDT)
Message-ID: <bb351bd3-931f-4acc-831e-2866a535bd9a@arm.com>
Date: Tue, 30 Apr 2024 19:32:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] thermal: core: Fix thermal zone initialization and
 move passive polling management to the core
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
References: <5790995.DvuYhMxLoT@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <5790995.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/30/24 16:44, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This a v2 of the patch at
> 
> https://lore.kernel.org/linux-pm/5938055.MhkbZ0Pkbq@kreacher/
> 
> with one fix patch added and a couple of changes more in the main patch.
> 
> Patch [1/2] fixes the thermal zone initialization in the cases when getting the
> first zone temperature from the sensor is delayed and patch [2/2] is an update
> of the patch above.
> 
> Thanks!
> 
> 
> 

I have also tested the IPA and Step-wise - they work.

Tested-by: Lukasz Luba <lukasz.luba@arm.com>

