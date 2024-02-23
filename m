Return-Path: <linux-kernel+bounces-77644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 468B6860868
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7CF1B225AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F65FB64A;
	Fri, 23 Feb 2024 01:40:44 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B55CB5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652443; cv=none; b=JAeLR6FwrXoQk8GlQbjEjrYooVpYhnxYe2m5nf3HDIFfyM+lHiYOCcmRnh9sVj8MFW3gwnO/2AjR3IJWyh6eS8Hkwn1fzZRyZ41iHdYDuijcEipzmza0hfSIOVYvAWfPHZs9g3noSkrptoPSYsm/9Q0vbdxYob+c7kC2oXbsvV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652443; c=relaxed/simple;
	bh=06nlyah+LimYhn6q4/L7UyYLSWP/+zvjFYNxxwsEfmI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V8tB4OFk/wR2x2F/hIItRt4OcArgBltDBaw6qRFywvHjFADptd4EoKWtPiyYT4u+n7dqUfHplfbfn92cNYStRx9B3KaCypVQhQf2Q1GdWYjqOGKLzR1+8+8Ex02F/qJn/H9CR21j8k5brwYtOXiYUjD+hr1H90rIK7537aYWWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 382F3810F7;
	Fri, 23 Feb 2024 01:22:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id CCE982000D;
	Fri, 23 Feb 2024 01:22:01 +0000 (UTC)
Message-ID: <17265e7ace81d4e546a0b990d3e4723c6e6f4968.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: Don't check for unified diff format in
 git sendemail headers
From: Joe Perches <joe@perches.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>,  Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org
Date: Thu, 22 Feb 2024 17:22:00 -0800
In-Reply-To: <CAGETcx8rANkOHhay6iFoXtXtJ8KvoNQBAMpruGENys+L2uHQTQ@mail.gmail.com>
References: <20240222051539.3001988-3-saravanak@google.com>
	 <20240222051539.3001988-4-saravanak@google.com>
	 <ffec7c7b8eb86f573e420e0582075ba1e75d0e54.camel@perches.com>
	 <CAGETcx-mNt+_ST0opQ=_M1ZJK1acf8Rr0VqaAUskyig5YwL_dw@mail.gmail.com>
	 <e51c5e6fe02bcc5a487cae063fe8f440013d0ca9.camel@perches.com>
	 <CAGETcx8rANkOHhay6iFoXtXtJ8KvoNQBAMpruGENys+L2uHQTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: CCE982000D
X-Stat-Signature: 9x9389jnokt9gxoox5kye9oawx8f1tw5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18+rkEm7949bNaeLsD5HarbInaSmXaVqA4=
X-HE-Tag: 1708651321-214556
X-HE-Meta: U2FsdGVkX18rgb+OfNzocMgCYQ2csH6MhWu06jBGyR2HUz0/0kU/7m/6/weIZvGizCKD6WXDbnmjlTyp0y2dgB89aDKDvrwuq0Q2V71bu5ftwi01DMzpCpAkkW1BAYF6FIwm1b2Vlvn2E6keJguhPfRkQpI85Xb0EFbIeI3CpV6LSnKNYvNMQQvEAyFEfrmA2Fwgwwf9j2vV+BqDd97nb3nJBmXqRQxjtz4Z3x8Br5nI7EcaItr7kbgCGUwLbihOsncG/BlsDxs3XWTIPEVwieGKp0jakAK8exbGxrZ+NFqFdhtg58yZjI4FJ3pzRcwmWvGELTRQxhldmzs8W18Oyi1BQ1DZ+rp0HXeH7QHsAJY6nA+CyP7DJ9Ark+MYdzM5

On Thu, 2024-02-22 at 17:10 -0800, Saravana Kannan wrote:
> On Thu, Feb 22, 2024 at 5:01=E2=80=AFPM Joe Perches <joe@perches.com> wro=
te:
> >=20
> > On Thu, 2024-02-22 at 16:45 -0800, Saravana Kannan wrote:
> > > On Thu, Feb 22, 2024 at 12:54=E2=80=AFAM Joe Perches <joe@perches.com=
> wrote:
> > > >=20
> > > > On Wed, 2024-02-21 at 21:15 -0800, Saravana Kannan wrote:
> > > > > When checkpatch is used as a git sendemail-validate hook, it's al=
so passed
> > > > > in the email header for sanity check.
> > > >=20
> > > > Why?
> > > >=20
> > > > If so, why not use a front-end script to stop/remove
> > > > the file from being scanned by checkpatch?
> > >=20
> > > Sure, I could do that. But this also makes it easier for people to
> > > start using checkpatch. Or I can put up a git hook wrapper script in
> > > here for people to symlink into their .git/hooks that does this.
> > >=20
> > > I'd prefer the lazy route of not creating a 1 line wrapper script :)
> >=20
> > I'd not.  checkpatch is for _patches_.
> > Don't feed stuff to it that isn't patches and expect good results.
>=20
> Would you be open to being a maintainer if I add a git hook
> sendemail-validate wrapper? It feels silly to add myself as a
> maintainer for a 1-line script. I'd rather give it to you :)

<shrug>

I think you need a local script and not one in the tree.
Or maybe some different git invocation command.  Dunno.


