Return-Path: <linux-kernel+bounces-164927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21D8B850A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAB61F21B79
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693DB3BBCC;
	Wed,  1 May 2024 04:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MQiWBJ2V"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9CE11CB8
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 04:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714538192; cv=none; b=KuJilRocHxSbW2s/QHq9ysSrQcuN2VyDNGMWppXmBZ2cw0MzSmjnCNoDa2KydOtSTqpARgf2Aq9/NnHwkGT2zwwZIYvmAl7dF+Xq0tSLBJN7Affg/cGAjF6F2ZX9f0erd0HWUM+xeiVMaPAL26Yaq6RbR3N2tHvSjUaTQkg3SGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714538192; c=relaxed/simple;
	bh=YKBL3Xlm5cnWdNbk81l0J2LSLyE3+5eFoXiFZouHEfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvk7Wu1NPRCfyTKDFz3f13Fjn7U5W34U4knhPkaQMG+ntmblGoHyceXJuBaCCw2CYKAOXk3soyAeGkPgyfeKEursVEAOjk1kSj4VO97VNQtpJYHgKNIZQ8F+udKiC1qdZYpTlbyFJzK7qI5XcPpBtsxfkw+SWm7xJcRkA56tIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MQiWBJ2V; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a59cdfc1-7cc0-4944-b527-68c3ff981529@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714538186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/zxLrv/112LnHWHBf9LH/ua85DzPXjXJ+sUgBkQQh0=;
	b=MQiWBJ2V6/7jUo+/vdb9BitJWGQJq6EH6FJES4FfwY83SQhPpyRcbtv4B87DA6kPIhKMPF
	W4y9tzbJcdfCQbNu7Mpg7m5wD0LuKuybya1lKAKBeIPncdzoINeuV24ky0cNyn6SjmPPk9
	gwR49jqtTNVU3m6JcohQGzb3s/Dqpl0=
Date: Wed, 1 May 2024 12:36:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: drm/debugfs: Drop conditionals around of_node pointers
To: Doug Anderson <dianders@chromium.org>, =?UTF-8?B?6ZqL5pmv5bOw?=
 <suijingfeng@bosc.ac.cn>
Cc: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Biju Das <biju.das.jz@bp.renesas.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240321222258.1440130-1-sui.jingfeng@linux.dev>
 <caa6fb05-8080-444a-93c3-2d9283ccb74d@bosc.ac.cn>
 <20240429-enchanted-cooperative-jacamar-cf2902@houat>
 <6db82a3f.c7.18f2c927d9f.Coremail.suijingfeng@bosc.ac.cn>
 <CAD=FV=W2ksFLtv3o5tqrpXY4aHD_wUq7R7rT9hOHCQa8FLmeoQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAD=FV=W2ksFLtv3o5tqrpXY4aHD_wUq7R7rT9hOHCQa8FLmeoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/5/1 05:33, Doug Anderson wrote:
> Hi,
>
> On Mon, Apr 29, 2024 at 6:16 PM 隋景峰 <suijingfeng@bosc.ac.cn> wrote:
>> Hi,
>>
>>
>>> -----原始邮件-----
>>> 发件人: "Maxime Ripard" <mripard@kernel.org>
>>> 发送时间: 2024-04-29 19:30:24 (星期一)
>>> 收件人: "Sui Jingfeng" <suijingfeng@bosc.ac.cn>
>>> 抄送: "Sui Jingfeng" <sui.jingfeng@linux.dev>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>, "Douglas Anderson" <dianders@chromium.org>, "Laurent Pinchart" <laurent.pinchart+renesas@ideasonboard.com>, "Biju Das" <biju.das.jz@bp.renesas.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
>>> 主题: Re: drm/debugfs: Drop conditionals around of_node pointers
>>>
>>> On Sun, Apr 28, 2024 at 04:52:13PM +0800, Sui Jingfeng wrote:
>>>> ping
>>>>
>>>> 在 2024/3/22 06:22, Sui Jingfeng 写道:
>>>>> Having conditional around the of_node pointer of the drm_bridge structure
>>>>> turns out to make driver code use ugly #ifdef blocks.
>>> The code being ugly is an opinion, what problem is it causing exactly?
>>>
>>>> Drop the conditionals to simplify debugfs.
>>> What does it simplifies?
>>>
>>>>> Fixes: d8dfccde2709 ("drm/bridge: Drop conditionals around of_node pointers")
>>>>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>>> Why do we want to backport that patch to stable?
> Technically it's not CCing stable and so it's not really incorrect.
> ...but I agree that this is a bit of a stretch to call it a "Fix".
> Maybe drop the "Fixes" line?


OK, good idea, acceptable.

Originally, I add the fix tag to hint that my modification belongs to
the commit d8dfccde2709 ("drm/bridge: Drop conditionals around of_node pointers") too.
But get missed.


>
>> My commit message is written based on commit of d8dfccde2709
>>
>> $ git show c9e358dfc4a8
>>
>>      This patch is based on commit c9e358dfc4a8 ("driver-core: remove
>>      conditionals around devicetree pointers").
>>
>>      Having conditional around the of_node pointer of the drm_bridge
>>      structure turns out to make driver code use ugly #ifdef blocks. Drop the
>>      conditionals to simplify drivers. While this slightly increases the size
>>      of struct drm_bridge on non-OF system, the number of bridges used today
>>      and foreseen tomorrow on those systems is very low, so this shouldn't be
>>      an issue.
>>
>>      So drop #if conditionals by adding struct device_node forward declaration.
>>
>>> Maxime
>> I'm just start to contribute by mimic other people's tone, there seems no need
>> to over read.
> I think the fact that you skipped the reference to commit c9e358dfc4a8
> ("driver-core: remove conditionals around devicetree pointers") was
> relevant here. Referencing that commit makes it easy for the reader to
> see that you are following convention used throughout the kernel and
> not just asserting your own opinion about style.
>
> If you add that reference into your commit message and send a v2, I'm
> happy to apply it.


OK, thanks a lot.


> -Doug

-- 
Best regards,
Sui


