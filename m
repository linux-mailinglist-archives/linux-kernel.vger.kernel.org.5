Return-Path: <linux-kernel+bounces-16258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC9F823BBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22959B24D5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752ED18C29;
	Thu,  4 Jan 2024 05:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SFDKHHdA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F24218640
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 05:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbdd61d80a3so85886276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 21:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704345508; x=1704950308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDxFbYixhs6f1tAqnhwF6CXml/tJlYbDmEA428x1Kyw=;
        b=SFDKHHdACm8tLObsZlGZeRHAsxUy67XRfgHHCkUmdp6Ztbzm0Jo+6NaKd1Z2MHuTma
         YpfgX6Kl5xDEK230o1EMg9d4Z1yn1m/NdsJ75rtbWeVom1qb9h8WvWEL5j0BS1K4DE2v
         Cx1S2U53yKQbYiS6/WQ5Zr3q0OdS5BPw/gwiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704345508; x=1704950308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDxFbYixhs6f1tAqnhwF6CXml/tJlYbDmEA428x1Kyw=;
        b=CsgIu+ltZxNHchN0k0OYmaR72wPZmya9wUkEEjneBjtOcOQ6BcCpAW/4N0CSUZRNFU
         ngKGSdEWkDdJ/sKS5SH8xJulINmwce/PdaQBiVjMhG6szuPGz+4hJKls1cXnWU7KG7Vk
         szQuJZoMWgf0zbaJnIUAQTlg7Mtg96LrJQdCEtVVCkOXEfw8WI+Ob/aaK30jle4ZD3I3
         188DTzj9RpGpdgz86Rv9CZyA6oJjDGgFst7cYNJOfUzw8IKWbz/XnhAzC9yIt4QIq7v8
         lfULhEtcVa1LKBims77AbBX6erF39qtA9A6UMod5j5MiibERPJsok7wrDum/IhbheItE
         5SEQ==
X-Gm-Message-State: AOJu0Yz0eipwV2qEx8YX6LbLo6HKyM74zpK7/hcCajKwfMdZ34zO9cp9
	nUDByksAsKbwMxlRa4517SWkChFGic0XGEX3S9yf5bBZFYub
X-Google-Smtp-Source: AGHT+IFfPrKd5UvUBwLgNuQi2a3WeIo8NksR83Oc9+RtmyQIjk6I/eGg0w+05h8CifxSZf3x50auweXBOYX/clLqHMQ=
X-Received: by 2002:a25:740a:0:b0:db5:4ec5:6f2f with SMTP id
 p10-20020a25740a000000b00db54ec56f2fmr7340ybc.20.1704345508267; Wed, 03 Jan
 2024 21:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215060159.555229-1-ghanshyam1898@gmail.com> <e9b028b3-20e6-4e74-a305-c4f18efc70e1@infradead.org>
In-Reply-To: <e9b028b3-20e6-4e74-a305-c4f18efc70e1@infradead.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 4 Jan 2024 00:18:17 -0500
Message-ID: <CABQX2QO0mPD3KYZYVk+cEr1z9o_cjRM9nct7piZhD4oJEm2hZg@mail.gmail.com>
Subject: Re: [PATCH V2] drivers: gpu: drm: vmwgfx: fixed typos
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>, zackr@vmware.com, 
	linux-graphics-maintainer@vmware.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 1:21=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi--
>
> On 12/14/23 22:01, Ghanshyam Agrawal wrote:
> > Fixed multiple typos in vmwgfx_execbuf.c
> >
> > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > ---
> > V2:
> > Fixed some more typos suggested by codespell
> > and the community.
> >
> > V1:
> > Fixed multiple typos
> >
> >  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/=
vmwgfx/vmwgfx_execbuf.c
> > index 36987ef3fc30..76aa72e8be73 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> > @@ -127,7 +127,7 @@ struct vmw_ctx_validation_info {
> >   * @func: Call-back to handle the command.
> >   * @user_allow: Whether allowed from the execbuf ioctl.
> >   * @gb_disable: Whether disabled if guest-backed objects are available=
.
> > - * @gb_enable: Whether enabled iff guest-backed objects are available.
> > + * @gb_enable: Whether enabled if guest-backed objects are available.
>
> "iff" normally means "if and only if" and its use in the kernel sources i=
s
> usually not a mistake. However, this one sounds dodgy to me (before your =
change),
> so it's OK IMO. Also, the line above it uses "if" for a similar comment.
>
> Maybe someone else knows better.

Right, this one was "iff". I submitted a version of this without the
iff change to drm-misc-next.
z

