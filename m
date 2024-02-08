Return-Path: <linux-kernel+bounces-58258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DA284E393
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B331F28520
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB9479941;
	Thu,  8 Feb 2024 15:00:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93976025;
	Thu,  8 Feb 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404409; cv=none; b=r3Hpejx6M3Y3TS+Sfo0lgX7PX560oQuAxm/3fBm+9ZUeq1xwIlGGI09mN4DeDU5tolbBrOqVkey2Q8iPC2P1eUPLenJGZeqY/vf4eNSsDFrRzSTHUqSPTl9KZJs4kctI1kYXklEOI5BWMTkMTh7+uqw2dGmT5x5nIC8/kQncvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404409; c=relaxed/simple;
	bh=JgUSlvBa25iUWSF76UIBo/lUmj1syc5Wcu7HYrfiClw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1Q7mjENYLcYXkW2dU+Ge4rNjRqWrrA3/QOGcp7unIWQR6adcNC8/969gcWUJTNkUhDXHD4kJL76RQl+NA9jkkxnoEKpaQMOd4W8UeI4cTtP7C9bBeUNwehZnTNZ9/XwyjY5R81AgrnhfU1BXhqtEf9nq3v1Xs8nluBtiblJtTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 619F41FB;
	Thu,  8 Feb 2024 07:00:48 -0800 (PST)
Received: from [10.57.8.23] (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B676B3F64C;
	Thu,  8 Feb 2024 07:00:03 -0800 (PST)
Message-ID: <532898c8-70cc-47ff-926e-a03be361d26d@arm.com>
Date: Thu, 8 Feb 2024 15:00:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/23] Introduce runtime modifiable Energy Model
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com,
 amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
 len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io,
 wvw@google.com, xuewen.yan94@gmail.com
References: <20240208115557.1273962-1-lukasz.luba@arm.com>
 <CAJZ5v0hxubw0VvzTikEwMeS0JQEx=YTqdbhOLhu+Q_n6u4i5gQ@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0hxubw0VvzTikEwMeS0JQEx=YTqdbhOLhu+Q_n6u4i5gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/8/24 14:01, Rafael J. Wysocki wrote:
> On Thu, Feb 8, 2024 at 12:56 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>

[snip]

> 
> All applied as 6.9 material, thanks!
> 

Thank you Rafael!

