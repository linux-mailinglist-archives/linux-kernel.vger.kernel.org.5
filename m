Return-Path: <linux-kernel+bounces-155491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087ED8AEB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AB01C21F35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09C113BAF5;
	Tue, 23 Apr 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I1dmGLrD"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932A17BA8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886808; cv=none; b=FjsYX3ICMQwokJ5/347pv+wrDEAgb4i1/GWY4rHfoksQ7od0BX8dRzFMW7//yQjl0B3Pr6+gyxgyQv75f5mw7HOAcqvtWwQAcADitZAwa3fM7UTcGc2SLJR63pNS9k9gm7E5cq+bvq+IWeuWSljKxVqAy5zKYIhINCYiEN18iDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886808; c=relaxed/simple;
	bh=EaEheerZ/dpbVMj6RbzHvHiteCBHHw2Zr/DXXU/q1gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqYiOzenoTfIMmcTs4uF49mUGR8bSu0+L0nHYfjxyFFmrWqzv0YYibH8XzEy5W//phb4j8wGaLjeAbaOGuuvTf1cgPDf+YDI6FCRpYlHLtS0zjBtmEqumTixqFuN+9aULYrDe1DIIQvJ2r9aY3gjL3FCqX0lbcesxJvHofcmiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I1dmGLrD; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cd183655-e099-4a6d-835d-7555f6f6884d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713886804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI+FWVmFzDJ71B2CmVKYD+k5daGrcnKhGtzV6yF5veA=;
	b=I1dmGLrDePb9xsdKYx37/WVWwTbL/tKeQamGlpVeWaSqZ5qRIT6dUDtjWk5L0KK01LwDCa
	LhS5yqosxrq6qWG39HB6KU74TdVFyo78yAAzu7pVTcn2amgDoOMzQKEsn6hLxLhVWOeCcs
	Nj1CTQcKrAvj/4l7kY+drh7WwNrd750=
Date: Tue, 23 Apr 2024 11:39:59 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/13] drm: zynqmp_dp: IRQ cleanups and debugfs support
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Michal Simek <michal.simek@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
References: <20240422184553.3573009-1-sean.anderson@linux.dev>
 <5334a3cc-bcf9-4791-9ca9-1d0093899707@ideasonboard.com>
 <472464bb-ae10-4452-aedf-a52b3eb8a25a@linux.dev>
 <dd82b42b-4987-4bb8-b16e-580fe21009c3@ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <dd82b42b-4987-4bb8-b16e-580fe21009c3@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/23/24 11:30, Tomi Valkeinen wrote:
> On 23/04/2024 17:59, Sean Anderson wrote:
>> On 4/23/24 09:33, Tomi Valkeinen wrote:
>>> Hi Sean,
>>>
>>> On 22/04/2024 21:45, Sean Anderson wrote:
>>>> This series cleans up the zyqnmp_dp IRQ and locking situation. Once
>>>> that's done, it adds debugfs support. The intent is to enable compliance
>>>> testing or to help debug signal-integrity issues.
>>>>
>>>> Last time I discussed converting the HPD work(s) to a threaded IRQ. I
>>>> did not end up doing that for this series since the steps would be
>>>>
>>>> - Add locking
>>>> - Move link retraining to a work function
>>>> - Harden the IRQ
>>>> - Merge the works into a threaded IRQ (omitted)
>>>>
>>>> Which with the exception of the final step is the same as leaving those
>>>> works as-is. Conversion to a threaded IRQ can be done as a follow-up.
>>>
>>> What is the base for this series? I'm having trouble applying it.
>>>
>>> I managed to mostly apply it, but I see the board hang when I unload the modules. I didn't debug it as it might as well be caused by my conflict resolution.
>>
>> The base is v6.8-rc1, but it should probably be v6.9. I can rebase and resend.
> 
> Did you have something extra in your branch before the series? I got "error: sha1 information is lacking or useless".

Nope.

--Sean

