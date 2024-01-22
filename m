Return-Path: <linux-kernel+bounces-34083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBDE837303
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F77E1F241E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8139B3FE5F;
	Mon, 22 Jan 2024 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmG21VZe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234A3FE54;
	Mon, 22 Jan 2024 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952760; cv=none; b=rrhOXcQlT/9Jj/XQS+4Plki3Y+R/9wDYx+Xfqi6uTWqfWsBZ4oU1hpfMnFXofL7s/+YQSUzO+NEW6hhVIWHZVwDcPx/WxI6mJ9rOzh1+pjdLvTczy/ShnpRwZTSDS1nIBrdp/bSSvQWn1CpBOClFQZRzV6jiqBMAj6z66fR3PDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952760; c=relaxed/simple;
	bh=eFoz8C5174Hx4Idtet8wUkXk9kxOMv9MXY1aO/KddUk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NWiFpzTOdNqABW1mZuV/duwGMiMs96twShZ2/cbJ9TL11HkawEAM5A2Xm1Yw/QhI5FW0S8QvDGoSxHgM00HyQxE+bwiT+DEovtt9LgJh7LyHodEbmEoTmzcWbeFY8mOo6Ptl6Y988Zg5oyhjYSPp0nrLeK6/TikwihXaqsjt35I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmG21VZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C870C433F1;
	Mon, 22 Jan 2024 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705952760;
	bh=eFoz8C5174Hx4Idtet8wUkXk9kxOMv9MXY1aO/KddUk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=TmG21VZePMhqeQpkw5vSbgw7XjDSsUIgNsbfwpdlSxAHfsffndFG7qE4B5QIL0cBe
	 Ru+Oaur76IQb3gs87l95GEHJgfAJE1Ka9o2f/XDrXFHwcJYyZAMGz/dhxsTVfNpvLj
	 Nvlf2JO3sO5FKj10D+EcbMCfaHNEca5yeIbMs+bGTe03ugglWz5R5dRHfbih1K8Ujn
	 me6SVkoWGkiXFzLmzo813b4gCvNTw45/Nmjvw7tJc9ZisI2WikNUIRNB24uYB+mCG+
	 xZBdwnbfThCn9X9EB09gdrmHpm+6eDz0l50LdcKupMeOoP74X8udVXNPYBZgSUx+Xg
	 9Nrg5AzBGxDng==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jan 2024 21:45:57 +0200
Message-Id: <CYLHS5HX5TXF.1CD2QEVLGTHI0@suppilovahvero>
Cc: "David Howells" <dhowells@redhat.com>, "Eric Biggers"
 <ebiggers@kernel.org>, <keyrings@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] keys: update key quotas in key_put()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Luis Henriques" <lhenriques@suse.de>
X-Mailer: aerc 0.15.2
References: <2744563.1702303367@warthog.procyon.org.uk>
 <20240115120300.27606-1-lhenriques@suse.de>
 <CYIZP2D9FS0N.1XY2F5VX9STEY@seitikki> <87il3llh8s.fsf@suse.de>
In-Reply-To: <87il3llh8s.fsf@suse.de>

On Mon Jan 22, 2024 at 1:50 PM EET, Luis Henriques wrote:
> "Jarkko Sakkinen" <jarkko@kernel.org> writes:
>
> > On Mon Jan 15, 2024 at 12:03 PM UTC, Luis Henriques wrote:
> >> Delaying key quotas update when key's refcount reaches 0 in key_put() =
has
> >> been causing some issues in fscrypt testing.  This patches fixes this =
test
> >                                                 ~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> > 						This commit fixes the test
> >
> >> flakiness by dealing with the quotas immediately, but leaving all the =
other
> >> clean-ups to the key garbage collector.  Unfortunately, this means tha=
t we
> >> also need to switch to the irq-version of the spinlock that protects q=
uota.
> >
> > The commit message fails to describe the implementation changes.
> >
> > You have a motivation paragraph but you also need to add implementation
> > paragraph, which describes how the code changes reflect the motivation.
>
> Thank you for your feedback, Jarkko.  I'll address your comments in v3.
>
> But before sending another rev, I'll wait a bit more, maybe David also ha=
s
> some feedback on the implementation.
>
> Cheers,

Take you time :-)=20

BR, Jarkko

