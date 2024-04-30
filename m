Return-Path: <linux-kernel+bounces-163959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECAC8B7697
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8FB1F22865
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2120171E45;
	Tue, 30 Apr 2024 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBJeq0bb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811242AA5;
	Tue, 30 Apr 2024 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482446; cv=none; b=QJrXMxJK2dzyrJThXq6b/wjq3iqj0ISTKDPYT8IlP5qLDIdqG+d9I+tacWhHMpo8cy6B5uwSIyVnrIJlqxwnwOQwsFZf1DA/lippVoI/gaLdneBdO3WyMLw/dzfX7qh7+tqTZUOE9sVuBTPrgQqi3mTwspmW90abfIDVLDcq1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482446; c=relaxed/simple;
	bh=qiB8b8aLGWUB+eW++cRid6E+04uq3CftdA6/Q44apIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbbfRYT6A986sTUlDX/L8xuQgRDpUVSEgylVxeCVJQOGFS+w4Q+M2xozDFI3apvvuPscYspkyze8gTOYb2H9E1vpcx7C7gvi7QGwOnPGJ3Ac5XuRD8DV89j8uxQE4KuOF5bPdak5LoY3S8+4oEtO5XvT2AKBjso4VD/BcCyN01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBJeq0bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751C5C2BBFC;
	Tue, 30 Apr 2024 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714482445;
	bh=qiB8b8aLGWUB+eW++cRid6E+04uq3CftdA6/Q44apIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBJeq0bbPN317U9uxx2fIaIucH6xI2Fc7aKbxOwOVV6pLDIovvHFJjiwY9CiiKt0k
	 cMFeGHF/xDFlqhnZISR8MnYp74hPGMrvGK1f67KZC4iCpAtkDYR2QQSvREBPtFphs0
	 RKeM8Qr85mIh2L33tfOFplIUlzyWOi5TWdJXeU/wCJX9Nr/HM/0viGOTQ7Ohj1VMVL
	 pBbKyNxXASVF42DCSYtwuhTieLO2zyBAwgbzdGCjx5s+EFT1ME4VoUf6M9bEB/9xdE
	 N5Ke11VPDfWk6rUgWK7H0DUmuV/2BNe7QcbuPGY52qi3qCR12fmruRszx9fWUqILfP
	 gGMkL0VEqKaBA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s1nCf-000000007Ur-3g1n;
	Tue, 30 Apr 2024 15:07:26 +0200
Date: Tue, 30 Apr 2024 15:07:25 +0200
From: Johan Hovold <johan@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Doug Anderson <dianders@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, quic_mohamull@quicinc.com,
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
Message-ID: <ZjDtDRCHT3z-3nHh@hovoldconsulting.com>
References: <20240426155801.25277-1-johan+linaro@kernel.org>
 <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
 <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
 <dbba45d2-f955-4d3a-aeab-26b0900d5823@quicinc.com>
 <Zi-ohCWv58d2h5VM@hovoldconsulting.com>
 <CABBYNZJyqrNKebwPPPqjOAdrkpBJ0fqHyD2iVtypeQKCDcL+AQ@mail.gmail.com>
 <CABBYNZJyRR9FA7TYN4+aWMtG9FPUBWMvCtMNUfvaEzxVcYOt-g@mail.gmail.com>
 <ZjCYu2pc8376rjXk@hovoldconsulting.com>
 <9eebd77b-c070-4260-a979-9b97f14eb5b1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eebd77b-c070-4260-a979-9b97f14eb5b1@quicinc.com>

On Tue, Apr 30, 2024 at 06:22:26PM +0530, Janaki Ramaiah Thota wrote:
> On 4/30/2024 12:37 PM, Johan Hovold wrote:
> > On Mon, Apr 29, 2024 at 01:31:53PM -0400, Luiz Augusto von Dentz wrote:

> >> Anyway the fact that firmware loading itself is programming a
> >> potentially duplicated address already seems wrong enough to me,
> >> either it shall leave it as 00... or set a valid address otherwise we
> >> always risk missing yet another duplicate address being introduced and
> >> then used over the air causing all sorts of problems for users.
> >>
> >> So to be clear, QCA firmware shall never attempt to flash anything
> >> other than 00:00:00:00:00:00 if you don't have a valid and unique
> >> identity address, so we can get rid of this table altogether.
> > 
> 
> Yes agree with this point.
> BD address should be treated as invalid if it is 00:00:00:00:00:00.

We all agree on that.

> NVM Tag 2: bd address is default BD address (other than 0), should be
> configured as valid address and as its not unique address and it will
> be same for all devices so mark it is configured but still allow
> user-space to change the address.

But here we disagree. A non-unique address is not a valid one as it will
cause collisions if you have more than one such controller.

I understand that this may be convenient/good enough for developers in
some cases, but this can hurt end users that do not realise why things
break.

And a developer can always configure an address manually or patch the
driver as needed for internal use.

Are there any other reasons that makes you want to keep the option to
configure the device address through NVM files? I'm assuming you're not
relying on patching NVM files to provision device-specific addresses
after installation on target?

Johan

