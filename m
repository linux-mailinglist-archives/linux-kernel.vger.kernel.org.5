Return-Path: <linux-kernel+bounces-142681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35788A2EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECC82857E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785F75E093;
	Fri, 12 Apr 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="OUum1sQ9"
Received: from smtpcmd04132.aruba.it (smtpcmd04132.aruba.it [62.149.158.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616835DF0D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927042; cv=none; b=hH+VvuxlZ6FjhyIhIwOnEmxVfGpoZThqUkEr2pQi/ael88drMVRGrWHQclnp2lRzJDczKPhI+iKcUzOcRga4VkyBkUEpIt1JCU+0me7IUYIoyyd1uyPoVlhL3XqoHfgI3SsmUxGwxqYiUs97bCKHmof70F27d8QHv8YzE468n1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927042; c=relaxed/simple;
	bh=Td/ncmI9XkUlhUno++tl/BVScfif0kPUbCiXZcu0rVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYtEeJVAQ4RqnheyGASuv6wKJQMmFcvt3sfPp+ZR+MFae5oZyRFM0b8/jlMeWlXL/X3h7nTBMIm4muAUVMLE34df+MI3pIZUjLqF9BTXHImZW2JWVZlm/agQPgdp0G+g53FUG+1NTFC8S6a1YFguAEdKRmG1d+tNQRqzw1A0Su8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=OUum1sQ9; arc=none smtp.client-ip=62.149.158.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.57] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id vGZNrbQFUoq80vGZOrTQSf; Fri, 12 Apr 2024 15:03:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712927034; bh=Td/ncmI9XkUlhUno++tl/BVScfif0kPUbCiXZcu0rVY=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=OUum1sQ9v9EUEb8b4zEAnInDffnUnFKcTltD1A/6VCm9kgzRa700pyGXw3xnzEwRD
	 XsOhm8ZYmyLPmEzyie1uL8csOALsxFx6IkVJooex612cz2x02N8vFGdfPOSn+v5T7N
	 PCAIkmZhC09r4C+dlV2N8Xu/ck07Q0WsOvAMVcq8QufRJCZ+RKKtkZvZquVFsufaMP
	 /EKKaHjoOADw1JAcZGri2tdsdT6oMGsQ6lmlRB7Rsdbqen4Guz7dpWf4OuDtv3ePGW
	 kV6wzyNCaLVD2dKKOufWnXrIYr2vv4zSXB+v9KZhovFFnOs+eOX1KnTgccH7bfLfPD
	 UgU5tJh1+JaPw==
Message-ID: <f2f656af-cd63-4c3e-be65-82c65967570c@enneenne.com>
Date: Fri, 12 Apr 2024 15:03:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: clients: gpio: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <f4b9402af72e5f285c8b0f068076a76418f653f5.1709886922.git.u.kleine-koenig@pengutronix.de>
 <6d73b0a4-34e6-44ce-8757-4f4931c3da85@enneenne.com>
 <4iii7uxyfovs6ntm7hs2w546k3upbhkepgzxarjk4wnlqmeern@sh6gkyuiqpjs>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <4iii7uxyfovs6ntm7hs2w546k3upbhkepgzxarjk4wnlqmeern@sh6gkyuiqpjs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLXf0ungDy/36KgIpCCb2lW0LqaQSk70vRkZddObUMiGKfOMhs9fZFzpMlYIIvzpVxd9f7bryGWoNuTUCQ8mrxQUl0lfhFqATeRw2WWTnSdGJ9zgNiXe
 gEYxDMjyzrG62dpI4gWbsVVLbd8kczTxChtGBFkyMaUbVJ7lmmAGgdlu5u6A5fOmOBZOMgWsRDJothgnD2cQiE1knBZPk2AsjYmLdHx02zLkcgmLlp5T4plQ
 g4FvAqNHSS2f28q0QCm/c8ztrxUMw980dUCToiQvXXY=

On 12/04/24 14:26, Uwe Kleine-König wrote:
> [Cc: += linuxpps@ml.enneenne.com]
> 
> On Fri, Mar 08, 2024 at 09:57:29AM +0100, Rodolfo Giometti wrote:
>> On 08/03/24 09:51, Uwe Kleine-König wrote:
>>> The .remove() callback for a platform driver returns an int which makes
>>> many driver authors wrongly assume it's possible to do error handling by
>>> returning an error code. However the value returned is ignored (apart
>>> from emitting a warning) and this typically results in resource leaks.
>>>
>>> To improve here there is a quest to make the remove callback return
>>> void. In the first step of this quest all drivers are converted to
>>> .remove_new(), which already returns void. Eventually after all drivers
>>> are converted, .remove_new() will be renamed to .remove().
>>>
>>> Trivially convert this driver from always returning zero in the remove
>>> callback to the void returning variant.
>>>
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>
>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> 
> The MAINTAINERS entry for drivers/pps lists you as single maintainer.
> Who is expected to pick up this patch given that you "only" send an ack
> but didn't pick up the patch? (Or only picked it up in a tree not
> included in next.)

Sorry. I forgot to add Greg Kroah-Hartman into CC. :-(

I've just resent the acked-by mail.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


