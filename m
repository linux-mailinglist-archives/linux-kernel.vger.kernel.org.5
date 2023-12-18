Return-Path: <linux-kernel+bounces-3575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F029816E02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3795D1C23359
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481097D89F;
	Mon, 18 Dec 2023 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ze/LjXA2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1777D612
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5cece20f006so24566647b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702903109; x=1703507909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9VWZcyMq9vEFZ6B46QLWrNjc17rvxsmt5Uz1tOQgkY=;
        b=Ze/LjXA2vvkg0a9FelCxhCRylpH3MpEjmvr+x/5WGUo9V9q9oMhkCiHdPHGajvCDKp
         Ss33tgdwcyU5n+pEnXlEw5VRfbLCOeLlWLQ777llr6Bai/5ldWmUUtxTGJehFZ9+O+c/
         v5ee66CeeEdv0SAO4JT/kYMIn5M77tjbAiAcra1yBL4GfnUBA1nZFRu1FzZQy7acxeYv
         jQsjvMXPByzNF/Y2wZPvq8O2lFmZffHFire0UWL0HLLalb4Sxke8tmL/hrt+q4X700Ax
         IGFTP1LheXpoaRi2RYpRg/xLNlrxgwCReC+9NsVIU+3O5zVIgClyatyYnFI/FIGjKqAw
         KDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702903109; x=1703507909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9VWZcyMq9vEFZ6B46QLWrNjc17rvxsmt5Uz1tOQgkY=;
        b=MrkPbHO/GFceqCH6PAr9KDgh2boJHk4LMq840PZwpBqn1uWHpfMacTBLs/6nhtfeSm
         sztMws3bmQlUGAPay9LNjil0bjG8WQh+OHSr+YC+51b8DNesbI6KLYsPtUOHebHEtEf3
         QJ917jUaVxkWeIHMeGPbIhzST0Tm7RPyMkcdamS7NuruE5XgO6hqNQNqv5rmej8TIS+Z
         xTqx9+pRlHN7PgXM035vJD/d8ItRD2+G+Pk+/MhDAZh5K2wRcZJ13sdXf6Udx7+QAD+0
         r594EcmQexB4MJF/46XbGX2/4CBp87U+dR1SaPOxvz/LRLp8UstFP6dsLZaT4CEdjdGV
         Xprw==
X-Gm-Message-State: AOJu0YyD46n1WzMoZ2oNWAyunqjY/KGNGbzsDsiwfdQ/v3ACdM5xzGk8
	BfGE0WjVDU+2gZbCBwy5qeEn9qZObp1dBRs5xN0ehg==
X-Google-Smtp-Source: AGHT+IEzxMrhnAIrFDSx7lHbhOKXR25tW9t7K7WmazA6BGOr6fzv1BFu0LN6dSC2BpWMMAqEnXI5HuCSu5R4x0GvhMg=
X-Received: by 2002:a81:52c8:0:b0:5e7:572c:c7a7 with SMTP id
 g191-20020a8152c8000000b005e7572cc7a7mr17400ywb.49.1702903109284; Mon, 18 Dec
 2023 04:38:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZUPBVMdi3hcTyW2n@smile.fi.intel.com> <CAMRc=MeV9ZyOzuQFEE_duPTHYgfmr6UZU6bpjDPhrczZX4PHpg@mail.gmail.com>
 <CAMRc=MdSpk_OszeDCyA5_Sp-w=sL9DHB2gGCOFP+FCiobm2cbA@mail.gmail.com>
 <2023111513-stinky-doorframe-8cd1@gregkh> <ZXHUat2Xo1VcAxN2@smile.fi.intel.com>
 <2023121512-breeches-snaking-74ad@gregkh> <ZXxr8LD1P63k-xRV@smile.fi.intel.com>
 <CAMRc=MeBh5Uq1YTvcnGugnvOFYh+rqc7fJpZrSvfmHbwh3SKXw@mail.gmail.com>
 <ZYAlOpjJBuvY-wTR@smile.fi.intel.com> <CAMRc=MeJgJj7ikp85vj9KMxgh6Rfx5BrCa3uq52Rj+iDFmQunQ@mail.gmail.com>
 <2023121834-exuberant-visibly-329f@gregkh>
In-Reply-To: <2023121834-exuberant-visibly-329f@gregkh>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 18 Dec 2023 13:38:18 +0100
Message-ID: <CAMRc=MfUNaBcsxGstAk3Y1To2AMGvDY6EoQYcyBALDQuA=QGdg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:18=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 18, 2023 at 12:05:54PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Dec 18, 2023 at 11:56=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Dec 18, 2023 at 11:35:04AM +0100, Bartosz Golaszewski wrote:
> > > > On Fri, Dec 15, 2023 at 4:11=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, Dec 15, 2023 at 03:49:38PM +0100, Greg Kroah-Hartman wrot=
e:
> > > > > > On Thu, Dec 07, 2023 at 04:19:22PM +0200, Andy Shevchenko wrote=
:
> > > > > > > On Wed, Nov 15, 2023 at 03:21:29PM -0500, Greg Kroah-Hartman =
wrote:
> > > > > > > > On Wed, Nov 15, 2023 at 03:58:54PM +0100, Bartosz Golaszews=
ki wrote:
> > > > > > > > > On Fri, Nov 3, 2023 at 10:08=E2=80=AFAM Bartosz Golaszews=
ki <brgl@bgdev.pl> wrote:
> > > > > > > > > > On Thu, Nov 2, 2023 at 4:33=E2=80=AFPM Andy Shevchenko
> > > > > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > > > On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevch=
enko wrote:
> > > > > > > > > > > > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroa=
h-Hartman wrote:
> > > > > > > > > > > > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Sh=
evchenko wrote:
> > >
> > > ...
> > >
> > > > > > > > > > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundat=
ion.org>
> > > > > > > > > > > >
> > > > > > > > > > > > Thank you, Greg.
> > > > > > > > > > > >
> > > > > > > > > > > > Bart, would it be still possible to take this into =
next?
> > > > > > > > > > > > I would like to have at least this patch applied (w=
ith the first user)
> > > > > > > > > > > > to allow conversion of others (I have some more use=
rs of new API).
> > > > > > > > > > >
> > > > > > > > > > > Okay, seems we missed v6.7 with this, can you then pr=
epare an immutable
> > > > > > > > > > > branch / tag with this, so other maintainers can pull=
 in case it's needed?
> > > > > > > > > > > (I have something against tty already and perhaps som=
ething else, let's
> > > > > > > > > > >  see.)
> > > > > > > > > >
> > > > > > > > > > It arrived too late in the cycle, I needed to send my P=
R earlier this
> > > > > > > > > > time as I was OoO this week.
> > > > > > > > >
> > > > > > > > > Greg, will you take this patch through your tree and prov=
ide me with
> > > > > > > > > an immutable tag for this cycle?
> > > > > > > >
> > > > > > > > Sure, let me catch up with patches after I return from Plum=
bers next
> > > > > > > > week.
> > > > > > >
> > > > > > > Hope Plumbers went well!
> > > > > >
> > > > > > Sorry for the delay, immutable tag can be found at:
> > > > > >       git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driv=
er-core.git device_is_big_endian-6.8-rc1
> > > > > > for anyone to pull from now.
> > > > >
> > > > > No problem and thank you!
> > > > >
> > > > > Bart, can you pull that? Or should I to my tree and then push wit=
h other
> > > > > GPIO patches?
> > > >
> > > > Ugh, this is rebased on top of 6.7-rc3...
> > > >
> > > > My tree is based on rc1, if I pull it, then it'll be a mess.
> > >
> > > But v6.7-rc3 is something that is already in the upstream.
> > > I don't see how it can be more "mess" with this. Whatever...
> > >
> >
> > My for-next branch is based on v6.7-rc1 (as it should IIUC) and if I
> > now pull Greg's tag, I will be sending rc1-rc3 stuff to Linus Torvalds
> > in addition to the GPIO changes for v6.8. I bet he will not appreciate
> > it.
>
> No, you will not be sending him -rc1-rc3 stuff at all, that's not how
> git works.
>
> Try it yourself and see.  Git does a "what's the changesets that are
> in this pull request and not already in mine" when determining this.
> You can see it when doing a 'git request-pull', it will only show you
> the diff of what will be sent.
>
> Also look at the 'git merge-base' output, it will show the point where
> things will start to be sent, and that will not have all of the -rc1
> through -rc3 changes in it.
>
> > Greg: Is it too late to have this rebased on top of v6.7-rc1 instead?
>
> Sorry, but yes.  But don't worry, again, git can handle all of this
> easily!  Try it locally and see.  Don't fear the 'fast-forward' :)
>

Sorry for the noise. I did try it locally and noticed that a bunch of
commits that were merged before rc3 moved "before it" in git log and
figured this is what the PR would look like. However the PR is correct
and I should have generated it before sending the email.

Thanks for a lesson in git.
Bartosz

> thanks,
>
> greg k-h
>

