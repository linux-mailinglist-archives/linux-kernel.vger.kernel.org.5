Return-Path: <linux-kernel+bounces-28667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1A983019E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97667286413
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B58313FE4;
	Wed, 17 Jan 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeAYpp0X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44228125DE;
	Wed, 17 Jan 2024 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481708; cv=none; b=ZgEPqVAYanj9QV9uWUY9ezclrWvA1A0ecqvV5VCdm1dWURwGaQh5X5HrzU52oxZyVLECcb7Vu1gelwUTCo4ayfXAjAKO+wQbFo9L126KMTUpsp111z8LWXEMb83XAbnYEETPF4AWDP1R4CNLVCpzX7v+JKKifNYxh35ahXkfYv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481708; c=relaxed/simple;
	bh=fnuaszwXIg6BRjy1CENiKmNPIyPN2c88uPBpm47pmzQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=ih3FtxcNoV+ZXd44MUw82mYpQB/o8jK7yhE0+9BW+eIIEllIbIpTaCfX8MXUP0jHM7t9BmeLGMCw0VLJj1nihqQr4iuhDWfZgSggCMFIHhMdtcTRIeR56SasHBKH+rMI+x3lq8XmxwownTQTCAuAdYIdsug/F/NWXV7eo+VEJgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeAYpp0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CDAC433A6;
	Wed, 17 Jan 2024 08:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705481707;
	bh=fnuaszwXIg6BRjy1CENiKmNPIyPN2c88uPBpm47pmzQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JeAYpp0XQQetbSji4FFlfxqiRy8/u3gyO5HBpKkr538ICVxJ//NPsk2kRvvFNumJe
	 s3YC5ImKUDbifbZ4ZIbyTNfjAc3r/t0BG/wVYmpX5zdLpCu1WSOyXw6wqfEBLc3nof
	 xHtTzN73SwaKIGZrNM6mjxjIXnDaZ0FAnSL43+AJhOno23GLkj71/lY0Y2LHzK3jdY
	 rbw4THK76lvpJOG6fQifUNbzxDEr/tK/Ro0XFN/8x5sd0mxr45D92k5uLFfympSDP+
	 UkRCLRVH8Bi8V2bdIIldafmRbevN+OIxWFgFToJYF14T6AKDJx8mLeA33MCmi4FUOo
	 2yqJazIErjVdw==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>,  linux-wireless
 <linux-wireless@vger.kernel.org>,  kernel-janitors
 <kernel-janitors@vger.kernel.org>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: Question about reference to config KERNEL_6_2
References: <CAKXUXMyfrM6amOR7Ysim3WNQ-Ckf9HJDqRhAoYmLXujo1UV+yA@mail.gmail.com>
	<8cce0dee8588b9f3cd0c1a3f073466b01905a703.camel@sipsolutions.net>
Date: Wed, 17 Jan 2024 10:55:04 +0200
In-Reply-To: <8cce0dee8588b9f3cd0c1a3f073466b01905a703.camel@sipsolutions.net>
	(Johannes Berg's message of "Wed, 17 Jan 2024 09:47:44 +0100")
Message-ID: <87y1co5ogn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

>> 
>> Commit ffbd0c8c1e7f ("wifi: mac80211: add an element parsing unit
>> test") and commit 730eeb17bbdd ("wifi: cfg80211: add first kunit
>> tests, for element defrag") add new configs that depend on
>> !KERNEL_6_2, but the config option KERNEL_6_2 does not exist in the
>> tree.
>> 
>> Also, Kalle Valo [1] asked during patch review about that, but did not
>> get any response on the mailing list.
>
> Oops, I probably thought I'd clean that up and forgot.

Heh, I also forgot to follow up on that :) Great Lukas that you noticed it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

