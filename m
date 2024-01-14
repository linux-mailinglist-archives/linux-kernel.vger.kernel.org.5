Return-Path: <linux-kernel+bounces-25528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3485982D1E8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 19:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75181C20ABC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B7A10A32;
	Sun, 14 Jan 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZWeDXxT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09FC1640B;
	Sun, 14 Jan 2024 18:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA64C433C7;
	Sun, 14 Jan 2024 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705258547;
	bh=j57z2FuABnO5E4/9dPETH3wR/+lTQdlklV9KN1rL0SU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZWeDXxTfFkote0uBLuO9SG4LSyprfuQHOPhanXYfS4/VDJZ8zsziARZgTf4gmRL4
	 hwUltMEV6kSW3xK1yqQ59I6c2RWsS42S5in5FYLJfNa/nhyla70XxE8irdrMQUFejJ
	 GF0heRYoivSfwN+Kf14TSeQ/FAhGf44fn1lYz5cnGWkbSGG8NNF2Lg+IduQyJkyMcb
	 GfMcPZCgmWX0PqC3cumth+o0cv+PIEhTBfvNytQRqW2MaEyaZdj0iA9Hh3spNFJZmD
	 GX1ReKGKpkxpzp33ZI9byVmjtJlSY4Uf98r0MAMK4/LhhE/KCelLCksN4/d1hftzsd
	 5ceV6D12nvSiw==
Date: Sun, 14 Jan 2024 13:55:45 -0500
From: Sasha Levin <sashal@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 4/7] Input: amimouse - convert to platform
 remove callback returning void
Message-ID: <ZaQuMZFSC4iwntY2@sashalap>
References: <20231226002649.7290-1-sashal@kernel.org>
 <20231226002649.7290-4-sashal@kernel.org>
 <ZZ0xt75z/qSf5f8V@duo.ucw.cz>
 <qkb22czelncqf43vr2kuz6i6npuq4juyr3ggl3jkdbp6t2uzfs@ftbna3qj6qhq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qkb22czelncqf43vr2kuz6i6npuq4juyr3ggl3jkdbp6t2uzfs@ftbna3qj6qhq>

On Tue, Jan 09, 2024 at 10:50:04PM +0100, Uwe Kleine-König wrote:
>On Tue, Jan 09, 2024 at 12:44:55PM +0100, Pavel Machek wrote:
>> Hi!
>>
>> > From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> >
>> > [ Upstream commit 42b8ff47720258d1f6a4412e780a480c139773a0 ]
>> >
>> > The .remove() callback for a platform driver returns an int which makes
>> > many driver authors wrongly assume it's possible to do error handling by
>> > returning an error code. However the value returned is ignored (apart
>> > from emitting a warning) and this typically results in resource leaks.
>> >
>> > To improve here there is a quest to make the remove callback return
>> > void. In the first step of this quest all drivers are converted to
>> > .remove_new(), which already returns void. Eventually after all drivers
>> > are converted, .remove_new() will be renamed to .remove().
>> >
>> > Trivially convert this driver from always returning zero in the remove
>> > callback to the void returning variant.
>>
>> We don't really need this for -stable.
>
>Agreed! These patches shouldn't get backported to stable. Even if they
>are a dependency (which isn't the case for this patch AFAICT),
>backporting of later patches isn't hard even when dropping these
>patches.

I'll drop it, thanks!

-- 
Thanks,
Sasha

