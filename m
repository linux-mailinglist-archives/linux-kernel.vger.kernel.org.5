Return-Path: <linux-kernel+bounces-76505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C885F80D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A981C215A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE69605B8;
	Thu, 22 Feb 2024 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isDtrnur"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809675B5A3;
	Thu, 22 Feb 2024 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604641; cv=none; b=SlQ7U6WXCKVvgBsEC5HdAwxQwrmSWq3ONagJrnYIjXE3Qq7izCyLQaxnPjUyHpiNW18ABZMhEEpifIpotd1ekYHdBYJvFY3tdSWSijR5s4MVMHsUKJLDFC7VqH5w13HOS9ZBH41NN1uTlVtF9l2/2XVPbbYh1Db5IS76jf5fK3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604641; c=relaxed/simple;
	bh=UQcJF0MxGv8FI6zkieEqniVVC2e2rV9dcda8hmiOZeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxgXGkHkpMKVkGPtZKqrn5yhcyKjHlu8kYdjwLaCIujRY9kfqWzkCmQsVqCNq5wZnNRT+vDSahzClCruAU5sPwUnmchJa6+k095QxzxaQB8Uam5wv/3OytaS/Z3tdGlWuVAJ2Bzjy+viIcDrWfVP1V+RkfHEffVkx0BBj81D10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isDtrnur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C60C433F1;
	Thu, 22 Feb 2024 12:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604641;
	bh=UQcJF0MxGv8FI6zkieEqniVVC2e2rV9dcda8hmiOZeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isDtrnurIw+5Awb+A0d791uKs9I8QT3zdq69bW1sofnwb5nAt8Kac80quAWL5f3RV
	 P0+Jf36cR2xhYg4PTXu7SSFojqatfSknDlf+AF3Q29HmyfPVs1in/4OXO8zPTOKbfI
	 QNBkantiKyCCvPLHlSF965Sk67dW7xv143FncXNIkPjzypclgtw24uIPs5j1XsjRbh
	 Fm+NW7BsRao4R1z2VB7SftScm3I3iOmFrO9L08phdYEM8bPmwPwpIuZK6uX2EqVQXr
	 nPyLhD8MF5u7g1FNwOvciDMhL6+0+crtpTgBQHvPfe5nZcPZunwlu6Z6E0z83gsZiy
	 Uo0qWYln/uhuQ==
Date: Thu, 22 Feb 2024 07:24:00 -0500
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	james.smart@broadcom.com, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.10 13/16] nvmet-fc: do not tack refs on
 tgtports from assoc
Message-ID: <Zdc84CT6LXmbz2DQ@sashalap>
References: <20240207212700.4287-1-sashal@kernel.org>
 <20240207212700.4287-13-sashal@kernel.org>
 <ZdJVw8PbwTDngATQ@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZdJVw8PbwTDngATQ@duo.ucw.cz>

On Sun, Feb 18, 2024 at 08:08:51PM +0100, Pavel Machek wrote:
>Hi!
>
>> From: Daniel Wagner <dwagner@suse.de>
>>
>> [ Upstream commit 1c110588dd95d21782397ff3cbaa55820b4e1fad ]
>>
>> The association life time is tied to the life time of the target port.
>> That means we should not take extra a refcount when creating a
>> association.
>
>I don't see this one queued for 6.1 or 6.6. What went wrong here?

Yup, this should have been dropped from all trees. Thanks!


-- 
Thanks,
Sasha

