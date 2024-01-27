Return-Path: <linux-kernel+bounces-41336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388A683EF04
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10602819B4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44FB2CCB4;
	Sat, 27 Jan 2024 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="YiI/KIK2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IK+hT4KW"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B722C85A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376159; cv=none; b=dTiQ9caDKWEHppKwMfz1hq9Dw4UeZjPmaM5P+NZch9jn2z/9lYNNqTur+3Y8aIj382w5tzPxR98IbxcZRwMcY+/Iov7+uNZwF76DqoEjn+sS3/h2WwE/TDze/W7uELnMqWsRE25gQyCL11pm2TCyYRB07/1Rz7wgsr8BKNVlIog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376159; c=relaxed/simple;
	bh=GLpeF7tKBkJQpK/HoDJhmJ33WffFzG6KRYtzM+zQ1Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/iuxCyRDO/FiFl9AIwWjtGY1ss05F2xVdrMcfB0+eg/ood418y0/5bDywgZ9mA8YiKtREOUdSpZvwQ5QBAPj3vvn3VOvLI1Ymar4WkcqMtaACC/fRRFCMJWzi+F4Ha4aGVHaE0BA9dyUNjli+Ib1U+BbA4lZo3PfTUOZFlqwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=YiI/KIK2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IK+hT4KW; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 68D505C00A1;
	Sat, 27 Jan 2024 12:22:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 27 Jan 2024 12:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706376157; x=1706462557; bh=TGCzW0dxep
	QwwblJTJF2TdlDPBbGBPOjAiGMUcsUm+s=; b=YiI/KIK2FtTk/D2Mh1aZjOAuSe
	GFY9xhHTx0MGi7R3bjO6z0udu3UqQ2U4OBg/8VtC4qls4+KkPIzCrxatGRU0fmLW
	KKkfAdBEk4bzN/59SDHCq5kJYWxq+dU61r82L3ePUD8AOX/KAv7BiV3d5sQ3FXhq
	WEbx0iChkStC9CPXauNjso7YPZzD3b6dgNmDHCLWdUUNyuOAC2lGYkL4IFt9JXjt
	wcNCA7F85hZlDGNXKcUBXKbUOFqke5rOX0V40+oOTYcdEDWNwnw22sPg2JCP3LiA
	+8XwbjBLDsb6u4MLd6mejzwJalEIDLA85xgHlS6cz0kgECmfHGk0FURNP5yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706376157; x=1706462557; bh=TGCzW0dxepQwwblJTJF2TdlDPBbG
	BPOjAiGMUcsUm+s=; b=IK+hT4KWdAXc7moYqsU18vYlDNDvDiyrp7j45Yh4kY4E
	W+lTbfYnf13AWiIYYIO9lFG3BO/63bU7z7LLuI4OrqwsYc16FtuoAtvOzY39iwp7
	Y0zIljQKVM011mZYn4V4FbZyqTTMPgfQvr9ES00CFnDWVuOCBQXb87YZ+0viy1ny
	Z+PtFGezHSR3+i6T7Am0tlXEucJxp/ReZ+GMwATXDgaYmsgy6wegrTJc+kVfT2C/
	7P/v8Ic/kfVwMAxI5RQqHSJVelMFQcK7iL5QqpHYkQ6yGy9aiOqxRDv5ouJLIrTp
	VzIlkBI7kMUjJmig8BVLva3+IrPRzT9genjhs9t/2w==
X-ME-Sender: <xms:3Tu1ZdBf3LD-5wHjkFZY-WS8mh9kLYdFALi7vlm-p2f3x-heMT5weA>
    <xme:3Tu1ZbjHn0fm4A4gq2w2p3URQa3iMI9t2cNpy2H_qQvY03pj1c_Xia5mHxgjdvhFj
    ThE4QO6mLTeUfaTTEs>
X-ME-Received: <xmr:3Tu1ZYmxd7EYUbZsbtINVs87EdNrHwLHjKmzXN-A98QLQuFK2r_H9hZsNm4tnt2P7KtJe1KY-zMQEBzeSQ0SWWNCHzno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:3Tu1ZXwZp9ZE37bn8fKV5dA61Hy02MM406sxqaG9T0i_TqrhnBkvZA>
    <xmx:3Tu1ZSQGn8hj-VitulyFUjfX7DUcJnmxCH-j6ggtlFHjV0GEOEWFeQ>
    <xmx:3Tu1ZaaRUK0e5NaEvAKg0Hqalox-MRrcTvnxxZpbTEQbdosrrJomlQ>
    <xmx:3Tu1ZYO6It51LcxBjXJPe1YDEBirAs1eo3XEQE5jH6XetIfWvPGUmg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jan 2024 12:22:36 -0500 (EST)
Date: Sat, 27 Jan 2024 10:22:35 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tandersen@netflix.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pidfd: don't do_notify_pidfd() if
 !thread_group_empty()
Message-ID: <ZbU72/83nv2UdcCK@tycho.pizza>
References: <20240127132043.GA29080@redhat.com>
 <20240127132105.GA29091@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127132105.GA29091@redhat.com>

On Sat, Jan 27, 2024 at 02:21:05PM +0100, Oleg Nesterov wrote:
> do_notify_pidfd() makes no sense until the whole thread group exits, change
> do_notify_parent() to check thread_group_empty().
> 
> This avoids the unnecessary do_notify_pidfd() when tsk is not a leader, or
> it exits before other threads, or it has a ptraced EXIT_ZOMBIE sub-thread.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Looks good to me, thanks.

Reviewed-by: Tycho Andersen <tandersen@netflix.com>

Tycho

