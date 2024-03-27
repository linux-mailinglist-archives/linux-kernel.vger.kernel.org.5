Return-Path: <linux-kernel+bounces-121454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEDF88E822
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A063B1C2F9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25CA12AAC3;
	Wed, 27 Mar 2024 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXboqwKN"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6424127B56
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550664; cv=none; b=RdqxiqnCqNtPbio8iS6XqTUuoYVKSBBVqt9T761shTKxvdZNryq4AXFndR+w1fhkfoPCDRrw1HXP6r7uKGDrzRKhYeTtfuf5ZwRT+HNqHNOYvcK+xG788wRqTLcVVOoYnztdQMmdJsvyfdSBEJPeBf/gnfcUW66HptkrAOg1zPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550664; c=relaxed/simple;
	bh=T5JrzvQt69iNjL4/EANWsxT3z20iGSHRmfedO6EBr8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfIt91FPzghstPtKh5vjSZtFXHh94PretBp1y1ZacMMn0nKKAlEz90sDFBXKv88ZHCBtsSaj0Gj1Dewmbod8UHAqNibmyrGm0d0hZQo1SH9VI4oSFUQyKfv8Qgj72xo2KMvv9aeowyrPrKRTC5hPLCe5D7HXhjASp0ktOLl2N5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXboqwKN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e8f51d0bf0so5496208b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711550663; x=1712155463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q2C6v07RAOGYu2hu4GY7euXWF8ETU7ffxo3I9AlpmE=;
        b=HXboqwKNPllksNoXo++jpdJAzBJLajKwaeeBYQjNnA7FgahulwVVS9lZrpINGTr1pa
         L3qkuaRExDpEx3ylME/ggc/prcvMH1Btayrqd8OcApJM6jhZj3o/bs3dwTEVy4GInmqh
         VayOWabSsUfjOHw7NU+v32m+DwT0rjgNJtQIt3SVoqWTadbX4NKZ6b0fkFFvUl5ySkAA
         kL6PtXeFNrxBdxX0lbZWFJ2zogFPMIPTKSv/b+NDIuBcSc6QK13ZlKf2TBcjjsh1EmiK
         aRSPDdc4eiFKGUrq/jg7d6bBcNVVMeh9Vada/RfgkaqMZ+DK/IvWXlGQoAUeQZ47XhPz
         RZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711550663; x=1712155463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7q2C6v07RAOGYu2hu4GY7euXWF8ETU7ffxo3I9AlpmE=;
        b=vn7RkxNB3Px65zKhnTR+XjZQuKqhGd//Gq2pYnGrQV4h7lvB2V6SvPpOQCOhrusoJk
         zE8MTbAiDO5iKx/ydtPFOg7nbOiceHD4LMQxRsX6hI8Wu+DBiE2C5/V6/Vc2VPWj4TQF
         3Sxm+JqCjjZDaGxnVaDiZ7Lq2gS/v6YolSxLsikrAlDHu/QFxOY43xzRAtP3dtE2eFX5
         BZ52c93CH8awmhcUD0YYrJlDjpCe244gQ4gnTX5fcA6rvkJ8yFFgFrpuqdQd7YENWV1F
         1qCJeN1IOZ4GJyePuPrfiwu2U5NiYEm4aSgdeou8SdNagyKrMUPWv+4cZ8DKcUoiKDub
         pkoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/Hc2rC7yZn0XT3BMQGfhRzLyeo2XvpjD+wk+AXdWm4S6YY7nD7FADIWuPyNk88J+PoBxsmA+3biWwo2mvCR9POYBLrR/ypb0/tteK
X-Gm-Message-State: AOJu0YxxpJx2eya5B63rd7OQ0lgs9tFL/cMJSlGzTyipFXn8SQrOVFBb
	es1nwJqAkRCTBzrwiQ/oaNZb+ZYZlan8Mo0JJlO7zTQ+uoCoRLakUTpJAUFVvJZvCYzu6+EIKw5
	+9Rbu1Z18qLH1rerXToNxauWD9J8=
X-Google-Smtp-Source: AGHT+IE1qaXoQhFdrtV7QT8MND6FcMTo2zAxmPDuHTiYsb86YGvn9Hfou3VfjATjJrHui3jRqwzdKYDjQpt/iPCMqrw=
X-Received: by 2002:a05:6a20:7a9a:b0:1a3:69e9:63a9 with SMTP id
 u26-20020a056a207a9a00b001a369e963a9mr56558pzh.18.1711550663028; Wed, 27 Mar
 2024 07:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mbsAYmR_dRPpQQ=9-NWhTtp0TWiOz0v=V-0AvwYbWw4A@mail.gmail.com>
 <20240327-magnetic-nonchalant-hare-bbe8d2@houat>
In-Reply-To: <20240327-magnetic-nonchalant-hare-bbe8d2@houat>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 Mar 2024 15:43:55 +0100
Message-ID: <CANiq72kqqQfUxLkHJYqeBAhpc6YcX7bfR96gmmbF=j8hEOykqw@mail.gmail.com>
Subject: Re: drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set
 but not used
To: Maxime Ripard <mripard@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 8:59=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> It looks reasonable to me, can you send a formal patch?

Will do -- I found another one when running the CI with the above one fixed=
:

    drivers/gpu/drm/qxl/qxl_ioctl.c:148:14: error: variable
'num_relocs' set but not used [-Werror,-Wunused-but-set-variable]

I will send you one for that too then.

Thanks!

Cheers,
Miguel

