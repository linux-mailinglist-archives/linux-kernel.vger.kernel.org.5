Return-Path: <linux-kernel+bounces-158783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C638B24DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7C61F21C64
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B5414AD02;
	Thu, 25 Apr 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rbythsld"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEFE37152
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058229; cv=none; b=ZV/+8OgBIqtUiu4cROQFypEgL7Zc+w+bNQpj7cTjNra7MniRZ7qkJNR6v0IeUEPvNSZ+rYjx0dABQjIbSf2ySwp7q910VqUdOlDzNErUNlbg2f+vV5dPgw/xjd2HXLcdED+o02Ii45P+PMIYSOwFJK/CBqDpPtrs8NBjWpvYKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058229; c=relaxed/simple;
	bh=xMO6QB4vLJZwoTzv53a8qtOWGB+M+OPofrKJTKiTp8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDRdbmoXRjsgpn21ds4DkTZIC2oqcOMxYhucuw782B/S/svcy3ftORIStNaaF8FBNxNlwiyaxeqG2dwEHSDO2piOrwEzg3rIgiVY9I+Jw1PFPxHupknDHLbQFcXkGs7/JHRMVrVWDH8L1xiHK13krxGfWtwCtMk5SySqlqVtssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rbythsld; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f418cf10-ad19-4483-96a3-46b5d0630160@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714058225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATs7kGNU7MX+/Quk4OUyTr0R55wWS//nri6UrNWeeWc=;
	b=rbythsldaxvF0hDSi1Cqu5f4ezVwrIeFeVv55JXP54HbOWzC3dP45CEWw/QcBw8X31HSrD
	7PUBgDZmp8nrr8xmSCQm2QVfyWyM0JeGag2oKydLlix6I4jWv39qlHQO2eiMWaUsxArmfz
	+Jl3KkMq4t+Ho1Sf1XCICGzocXQH4gk=
Date: Thu, 25 Apr 2024 11:17:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 00/13] drm: zynqmp_dp: IRQ cleanups and debugfs support
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 David Airlie <airlied@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
References: <20240423171859.3953024-1-sean.anderson@linux.dev>
 <848aabf8-aec7-4a14-8f1d-c40f76d025fe@ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <848aabf8-aec7-4a14-8f1d-c40f76d025fe@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/24/24 14:54, Tomi Valkeinen wrote:
> Hi Sean,
> 
> On 23/04/2024 20:18, Sean Anderson wrote:
>> This series cleans up the zyqnmp_dp IRQ and locking situation. Once
>> that's done, it adds debugfs support. The intent is to enable compliance
>> testing or to help debug signal-integrity issues.
>>
>> Last time I discussed converting the HPD work(s) to a threaded IRQ. I
>> did not end up doing that for this series since the steps would be
>>
>> - Add locking
>> - Move link retraining to a work function
>> - Harden the IRQ
>> - Merge the works into a threaded IRQ (omitted)
>>
>> Which with the exception of the final step is the same as leaving those
>> works as-is. Conversion to a threaded IRQ can be done as a follow-up.
> 
> If it's ok to you, I'd like to pick the first four patches to drm-misc already.

Fine by me.

--Sean


