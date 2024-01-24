Return-Path: <linux-kernel+bounces-37399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96483AF45
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D88828A338
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164CE7E792;
	Wed, 24 Jan 2024 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="iPpGD7mh"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A457A721;
	Wed, 24 Jan 2024 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116093; cv=none; b=LBPZJ1FfgPthH+rAvQEcAix8Su7E/KFZAU93eXiSy2fbB0JZphvOFeSQqZQ36NKXLCtf7xlmwQsF1Mzt81FqLvgJ+9MvYPJEW7dt9kxak9fllPwSP/Mrf5u9HIS+y2T+Tt9frxt6B+vra69AKzSVMJ+IN/yW4rhf7+V85hv9k4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116093; c=relaxed/simple;
	bh=PaGBImxL7sghNWTOqzAD9YYkMMEzO6cVhf/26RmtPqo=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=VAmXfdTnxCKMUwkWknE0G1BFNhxy0y60boSyjwGp55pSvZMW7P8OJ7mSEzn2ewy4WxsowznFqT++i4VAwsaw2M3SbyQx360YF4tiPHGdbUVn8fWiwqG3Cl3DnojdAxcf8cM+u59wmLoUpRCMxEjzQ/iiY8rbvyFJzSO0oBkqSio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=iPpGD7mh; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=OqQ4IZQIE9+PmJibss5jkdI7LxH9/Q44XuEFmP9Az1s=; b=iPpGD7mhEhtMres27S1EGqeme8
	F/vGRQhRlc0cG42pDsZrHzR84DZmtu0Od/+DXmaAAuHQ8tvgQBe5K3dvQILB1V4QUTs0IZcxu+Xms
	riOFH7xoc89h3xHS37I/brdZS5wzfK1dyFZmTqNrp/O9YsYb4fTa1hbnF6aXiGYhQsRg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:42940 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rSgjL-00086W-O9; Wed, 24 Jan 2024 12:08:04 -0500
Date: Wed, 24 Jan 2024 12:08:03 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 leoyang.li@nxp.com, hvilleneuve@dimonoff.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 andy.shevchenko@gmail.com
Message-Id: <20240124120803.019e8408c5a8de292d9a6a35@hugovil.com>
In-Reply-To: <799819b6-6183-4d92-8bf6-93e2e2c1122a@linaro.org>
References: <20240124164646.1506814-1-hugo@hugovil.com>
	<20240124164646.1506814-2-hugo@hugovil.com>
	<799819b6-6183-4d92-8bf6-93e2e2c1122a@linaro.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -0.8 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: remove redundant company
 name
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 24 Jan 2024 18:00:00 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 24/01/2024 17:46, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Company name in compatible description appears twice, which is not really
> > helpful, so remove it from product name.
> 
> It's just a string. There is no bug, at least you did not describe where
> the bug is.

Hi Krzysztof,
in fact the fix is based on comments you made in a
review for another board that I submitted:

https://lore.kernel.org/all/6035c4cc-afe1-456d-a4d0-16992da09a2e@linaro.org/

------------------
Company name appears twice, which is not really helpful. What's the true
name? Gateway EVK? Then keep only this.
-----------------

> This has probably little impact on user-space, but there could be such
> which actually reads compatibles and depends on them. Or bootloader or
> whatever. Therefore to me such cosmetic change of correct compatible is
> not worth ABI impact.

Yes, normally you would be right, but in this specific case, the board
is a prototype developped by my company and we are still at the
prototype stage, so there is zero ABI impact.

Maybe I can add this to the cover letter if you want me to submit a V3.

Hugo Villeneuve

