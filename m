Return-Path: <linux-kernel+bounces-148067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D718A7D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE011F21AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E356D1BD;
	Wed, 17 Apr 2024 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZm+RTm5"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3B184D;
	Wed, 17 Apr 2024 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339558; cv=none; b=M/3FUN0uk+wZ9pUJ1EQNR7ZLi9lWMrPki/F7xBsHI4I4kVCvPzlH3Hs+OgHLXkFwQqbiKOvsKVXvQZN8cS6BGQ9SHd2qEG0dJbq1ZTtPzXFIYwAU9yEYJcFQ6+34N5N5g7eSEB4lS28WYTYozqfQIyoe8hnAad5E/y1cPdN76/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339558; c=relaxed/simple;
	bh=7sbLFB24/YkE/uJ7LyMqaRUnqPin2KGBb/ZMZwIVLkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4ntM42v80gTHFXYQ4TQDtNfswNi/hiTa90CKlKQoL8vvVbWpiQiKU6ap2MSLeha1hjUvU5bHEjS8t4VnvMySvYgh9AYQbSRJXoHSIscyk9eRwRKRTFDwkjtLu8zB6joTqOfXOYatbJjpw0TfON9z/IzWCYgTfWQrRGG849ydBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZm+RTm5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so8109979a12.2;
        Wed, 17 Apr 2024 00:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713339555; x=1713944355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hqZsS5WFXp2anKYp/KMCMRd0WZLVdKrhJY6wlW+zA8=;
        b=DZm+RTm5kVpW9ExT7IcuEnZqG1P9AxGT44GvyhhsshRBrST1FEQhnJNl0Q8hOJH3U2
         cH6u5K/fPyNtSV/p7533kv/hmWJkA1nvdu8WXjhZerpwuoKjJPffLgAQNJhMLAPDv8io
         xl8cdtuFaF3PbX7JKI9qCbZUZDf2f9aG+MZzGYs0hpOAH/0XcxkyOM4U9hgi0j50/m1v
         j9unbiyH3Y1EWWSCk41Xj+LcMq49ofyMcFO21THIw2oBBwW2Mv1i1DOMxCkUC0pwlm2M
         dErc7Fk9VKUm5h76Xf5QaTRcz/DRsCC0TY2C68BpLfOGeb/HCDFFjUDLu06Hu/GEcNwO
         5pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713339555; x=1713944355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hqZsS5WFXp2anKYp/KMCMRd0WZLVdKrhJY6wlW+zA8=;
        b=jiDEWfiW0TrGK/2lsqNX+Yzaklooxzlpt7eQFu3TDkzdxOZqQ3hT6yFxlBGZoz1Pzs
         MO5Vksc7u/39haHPiVXSyww2LWlwkkg9ijmyHu2Dubsl081kZU/dTgWB3QF8IJTe3olS
         MtHLd187AsR/3HGrskfCYYAtyUjJg4y8fJk1uv+w7xb4NKU8f5oZc4GWsHy2YP08NzVE
         yORdP0+5zsFJ1xhJL6kvCj57Da4QBKeY6TTareCk6o6+Td4WBD5/jjx9vMUkVNhZQsoK
         xfcQgrRjfvK+kVaC5GcsUGyDOLsqv2ShxiIxMAcwiIoWuR6hH9u3PivUaV8Ud1POwtfX
         rQXA==
X-Forwarded-Encrypted: i=1; AJvYcCXL9eSX9CltPxa+I03TVP6b/8X0KvGI2AUztId5nMr8w3cAfydLOEaEeYbUsm8WqXXUxh7P5JBc7dRJltKdGzpqIHdFu+4yq/cm
X-Gm-Message-State: AOJu0YwB4as1zFgEWJEy4MTdaR8bBW4Nnt7i/Kprl17zVCUHvoPoG00T
	oh3baWGa0qqCoRpzn9IVDEI4nzYMeHDDfbVqZVmE1JMzSOluIgRUOfJ+ojfbom9PfJgrYCwJUK+
	25gVcgbgIQNE8RVynLrmcpogMOZE=
X-Google-Smtp-Source: AGHT+IEl0qIvHxHQdUAiHcuiklcq+45P96LqjE9gzwoqDEYieAoy2ibD8U3aLCc/2H9+4gG/eDXw8QqUOqWA6T3V0Z0=
X-Received: by 2002:a17:907:1b29:b0:a52:617d:d77f with SMTP id
 mp41-20020a1709071b2900b00a52617dd77fmr7776390ejc.56.1713339554627; Wed, 17
 Apr 2024 00:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYON+ry7xPx=AiLR9jzUNT+i_Va68ACajOC3HoacOfL1ig@mail.gmail.com>
 <92fe8e95-bc01-4d7d-9678-8cfc55cc4a7b@rowland.harvard.edu>
 <CAEkJfYORHKO16xT3DCS04JFzkquz6oZ5CdC2USJ5-c0WihAMXg@mail.gmail.com>
 <45e246ab-01e8-40b7-8ede-b47957df0d7b@rowland.harvard.edu>
 <CAEkJfYMjO+vMBGPcaLa51gjeKxFAJBrSa0t_iJUtauQD3DaK8w@mail.gmail.com>
 <69a6f4c9-6470-40d1-99f1-aaf532497d02@rowland.harvard.edu>
 <CAEkJfYNJyyGhR9AAWc0V7o8i6pmS+OB=KSbh6XqVWAAGetS9hA@mail.gmail.com>
 <5704ac63-5e5b-416c-a2a1-57528e76a02f@rowland.harvard.edu>
 <CAEkJfYMSwuikpBJudOaFYrxgf9e=_O4nig6sTPLLAtpdEKQuyQ@mail.gmail.com> <5f3526a6-6ede-4181-a4ff-076e022cfb49@rowland.harvard.edu>
In-Reply-To: <5f3526a6-6ede-4181-a4ff-076e022cfb49@rowland.harvard.edu>
From: Sam Sun <samsun1006219@gmail.com>
Date: Wed, 17 Apr 2024 15:39:02 +0800
Message-ID: <CAEkJfYMPQJn+kYzxFwwix3fwKeu3aAdYKgp+Ksvq=o4CoTXEWQ@mail.gmail.com>
Subject: Re: [Linux kernel bug] general protection fault in disable_store
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Greg KH <gregkh@linuxfoundation.org>, swboyd@chromium.org, ricardo@marliere.net, 
	hkallweit1@gmail.com, heikki.krogerus@linux.intel.com, 
	mathias.nyman@linux.intel.com, royluo@google.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 12:35=E2=80=AFAM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Tue, Apr 16, 2024 at 05:05:55PM +0800, Sam Sun wrote:
> > On Mon, Apr 15, 2024 at 10:47=E2=80=AFPM Alan Stern <stern@rowland.harv=
ard.edu> wrote:
> > >
> > > Actually, I've got a completely different patch which I think will fi=
x
> > > the problem you encountered.  Instead of using mutual exclusion to
> > > avoid the race, it prevents the two routines from being called at the
> > > same time so the race can't occur in the first place.  It also should
> > > guarantee the usb_hub_to_struct_hub() doesn't return NULL when
> > > disable_store() calls it.
> > >
> > > Can you try the patch below, instead of (not along with) the first
> > > patch?  Thanks.
> > >
> > > Alan Stern
>
> > I tried this patch and it worked. I agree this patch is better and it
> > avoids introducing new locks.
>
> It turns out that patch is no good.  The reason is mentioned in the
> changelog for commit 543d7784b07f ("USB: fix race between hub_disconnect
> and recursively_mark_NOTATTACHED"); it says that the port devices have to
> be removed _after_ maxchild has been set to 0.
>

I checked the commit you mentioned. Maybe your first fix is all we
need to fix the problem? At least no race would occur for
hdev->maxchild and usb_set_intfdata().

> So okay, here's a third attempt to fix the problem.  This doesn't try to
> avoid the race or anything like that.  Instead it just adds checks for
> usb_hub_to_struct_hub() returning NULL.  That should be enough to prevent
> the invalid pointer dereference you encountered.
>
> This should be tested by itself, without either of the first two patches.
>
> Alan Stern
>
>
>
> Index: usb-devel/drivers/usb/core/port.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-devel.orig/drivers/usb/core/port.c
> +++ usb-devel/drivers/usb/core/port.c
> @@ -51,13 +51,15 @@ static ssize_t disable_show(struct devic
>         struct usb_port *port_dev =3D to_usb_port(dev);
>         struct usb_device *hdev =3D to_usb_device(dev->parent->parent);
>         struct usb_hub *hub =3D usb_hub_to_struct_hub(hdev);
> -       struct usb_interface *intf =3D to_usb_interface(hub->intfdev);
> +       struct usb_interface *intf =3D to_usb_interface(dev->parent);
>         int port1 =3D port_dev->portnum;
>         u16 portstatus, unused;
>         bool disabled;
>         int rc;
>         struct kernfs_node *kn;
>
> +       if (!hub)
> +               return -ENODEV;
>         hub_get(hub);
>         rc =3D usb_autopm_get_interface(intf);
>         if (rc < 0)
> @@ -101,12 +103,14 @@ static ssize_t disable_store(struct devi
>         struct usb_port *port_dev =3D to_usb_port(dev);
>         struct usb_device *hdev =3D to_usb_device(dev->parent->parent);
>         struct usb_hub *hub =3D usb_hub_to_struct_hub(hdev);
> -       struct usb_interface *intf =3D to_usb_interface(hub->intfdev);
> +       struct usb_interface *intf =3D to_usb_interface(dev->parent);
>         int port1 =3D port_dev->portnum;
>         bool disabled;
>         int rc;
>         struct kernfs_node *kn;
>
> +       if (!hub)
> +               return -ENODEV;
>         rc =3D kstrtobool(buf, &disabled);
>         if (rc)
>                 return rc;
>

I applied this patch and it also can fix the warning. I am not sure
which one is better.

Best,
Yue

