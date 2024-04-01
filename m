Return-Path: <linux-kernel+bounces-126673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410C9893B49
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729591C20EB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9373F8EA;
	Mon,  1 Apr 2024 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olEDGg0s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785AF3A262;
	Mon,  1 Apr 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977474; cv=none; b=fv/6JBmWxMY27aYFOpWlRyNTfkruLI8MtIK9kmoswRY5LSsjEiUQTXWord2KhqGQqNpLD4qUkJL6keHpaqHN1Bc/LQ0gydNG/8S7Bvv8arU2tPnrHBLHY2WY+ukJcCV843FpAntQkcJStzQBeb+IE4Qj46vfeMzxpdjV0IxEh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977474; c=relaxed/simple;
	bh=S9b4HSEM/2PDqziShOQR1wWt0JzsyhQb7gIWzGjTp8k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QCP1E8Z81b/FV8mgWvu3JJNr2IWRVaE+argkQAou85MciYyA64Zbtn+tKYyXKbN3ENFiomFVgtHJhD2tYtq/cLm0pr5uihKOTPFOmv7UVewx/nqWkPTPW+8+AaAymYhSI/Eb21q8jIlFxxSh3jYWwyNgc+BO+3jAvgv/In8NRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olEDGg0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78219C433C7;
	Mon,  1 Apr 2024 13:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711977474;
	bh=S9b4HSEM/2PDqziShOQR1wWt0JzsyhQb7gIWzGjTp8k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=olEDGg0sasK0vUUJ0DRnbTjgsazK8GojY7P25lg0oA8J0wgmQm3tm/6VNF4ydA/Gi
	 GwV4WxqAYCvnQ6cAnangoHSUg8P3LIbEnqLprBrBUHFEPFvxeQrzJhEdl9DkDUyGRZ
	 P+7/mkij/BJRqwJIggIfQ6Ilu/byx6Y09cBkllmUpf0Hzx74XKi+Af5YH6bnRB5ih4
	 SMbW/egiSxPeTi2qN1NZwA8+Xp9e4QNGuafndOSDF7MBJEcR2MBgQV8m9nEn1ZyF7o
	 upaHstcC0quBKA/wgoVAq6Wi4LVST67LlSf9otB/nL9fPWHUoHY/jN8rN+aoCiQ1Xt
	 /FEteglNKksUg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Apr 2024 16:17:50 +0300
Message-Id: <D08TD4LASWJO.30BX8927MB1YK@kernel.org>
Cc: <dhowells@redhat.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>
Subject: Re: [GIT PULL] tpmdd changes for v6.9-rc2
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240326143838.15076-1-jarkko@kernel.org>
 <CAHk-=wgNpPQFJyLe5dwEVH66ubviuiwM1_tjbyzQv4BytPw7dQ@mail.gmail.com>
 <D07PD5NTOXSQ.30D5V19O6KMQS@kernel.org>
 <CAHk-=wi-VWatwU5Gi6n74LF66dRWCo4dUozwj_DwTBRO-wDFcA@mail.gmail.com>
In-Reply-To: <CAHk-=wi-VWatwU5Gi6n74LF66dRWCo4dUozwj_DwTBRO-wDFcA@mail.gmail.com>

On Sun Mar 31, 2024 at 8:01 PM EEST, Linus Torvalds wrote:
> On Sat, 30 Mar 2024 at 22:57, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > OK, point taken and it is evolutionary issue really but definitely
> > needs to be fixed.
> >
> > I review and test most of the stuff that goes to keyring but other
> > than trusted keys, I usually pick only few patches every now and
> > then to my tree.
>
> It's perfectly fine if you send me key updates - you're listed as
> maintainer etc, that's not a problem.
>
> But when I get a tag name that says "tpmdd" and a subject that says
> "tpmdd", I'm noty expecting to then see key updates in the pull.
>
> So that part of my issue was literally just that your subject line and
> tag name didn't match the contents, and that just makes me go "there's
> something wrong here".
>
> So keys coming through your tree is fine per se, it's just that I want
> the subject line etc to actually make sense.
>
>                     Linus

OK, I'll we'll address no problem :-) I think separate tag and
appropriate subject line  is sufficient change as we always sync=20
up with these (through IRC channel), i.e. David is aware when
I send anything keyring specific.

BR, Jarkko

