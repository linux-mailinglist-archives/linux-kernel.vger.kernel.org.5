Return-Path: <linux-kernel+bounces-77615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C611A86081C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60FACB21016
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EE9BE49;
	Fri, 23 Feb 2024 01:10:53 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D3AD48
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650652; cv=none; b=Cex45T1zIK2JWeS0x494gUl75uJ7gij/uHtO29Cl7PmXwV8z1MUuoQs+dMezmOgMJ8Xt2DA5oCBOzUZlng3APxIeNmbzcGH8bsIlL7LYi9DOrAISfzvun+MVaph5pMAV/IrMMsS3/043dGQ6ayY4F/79BITaoL101+1U+nIOlGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650652; c=relaxed/simple;
	bh=eKSHPiYO+MMybgl4oNeCKlbZlM9yRQY6muenBaDcbr4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QzlAHZ+jmmo6jHc38CUDcj3h4E+yNlY/dG2Fc8Oj62bttIP5LP3L5hsQrk7E7Yc8seeeuC9m4tUpougI374C/auDKa5euPFekMOvvqE225tIw4kzd058YERRM9vElAOPuwx2++u5mtC9zZADJiYkd1IVyg0RPTVtcj5nQB9BGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id A757DA17A0;
	Fri, 23 Feb 2024 01:01:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 5D4F82F;
	Fri, 23 Feb 2024 01:01:54 +0000 (UTC)
Message-ID: <e51c5e6fe02bcc5a487cae063fe8f440013d0ca9.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: Don't check for unified diff format in
 git sendemail headers
From: Joe Perches <joe@perches.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>,  Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org
Date: Thu, 22 Feb 2024 17:01:53 -0800
In-Reply-To: <CAGETcx-mNt+_ST0opQ=_M1ZJK1acf8Rr0VqaAUskyig5YwL_dw@mail.gmail.com>
References: <20240222051539.3001988-3-saravanak@google.com>
	 <20240222051539.3001988-4-saravanak@google.com>
	 <ffec7c7b8eb86f573e420e0582075ba1e75d0e54.camel@perches.com>
	 <CAGETcx-mNt+_ST0opQ=_M1ZJK1acf8Rr0VqaAUskyig5YwL_dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5D4F82F
X-Stat-Signature: 84emiutu6wa9xscooj8xczjp9shqhzcs
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18RgCT5QkfnPaQE88ohROxOK5TC7IviFVI=
X-HE-Tag: 1708650114-305781
X-HE-Meta: U2FsdGVkX18LMVA0VWZJ4aeIuZ0cEqbn+W2bLZQwLu/PawQk8Fmel/P/PKvSSHePE8VTYmmrZJ650BTvuU6B9xN2HeLNa0z/wFZD9OWbg/tEIQOX8OcHLTvkQRYQYttrDalIVVOjjKqCxF7H2VWE0xRa7BlBRZsJeBR/pWiAWnVJwwMum2slC1u/kKXsnT1H5PvDeVp+pOVxisS5RBMIjWxWeFmWrSOcB6DtPYBCpijm5x3Rh6HJMYjd1bd5jDBhUdgnBO5Gy/Oa9V0XbKEzlQbFS+uK/zyiW+DwshZgikfUCbHNlfhhQ/Vn6d6YAw438kr5w62DlKqgEQUvcdeV4Jf3Md0RDZYliBLQhLtPtF/9wSuEqOcpMMLdwDuofOyl

On Thu, 2024-02-22 at 16:45 -0800, Saravana Kannan wrote:
> On Thu, Feb 22, 2024 at 12:54=E2=80=AFAM Joe Perches <joe@perches.com> wr=
ote:
> >=20
> > On Wed, 2024-02-21 at 21:15 -0800, Saravana Kannan wrote:
> > > When checkpatch is used as a git sendemail-validate hook, it's also p=
assed
> > > in the email header for sanity check.
> >=20
> > Why?
> >=20
> > If so, why not use a front-end script to stop/remove
> > the file from being scanned by checkpatch?
>=20
> Sure, I could do that. But this also makes it easier for people to
> start using checkpatch. Or I can put up a git hook wrapper script in
> here for people to symlink into their .git/hooks that does this.
>=20
> I'd prefer the lazy route of not creating a 1 line wrapper script :)

I'd not.  checkpatch is for _patches_.
Don't feed stuff to it that isn't patches and expect good results.


