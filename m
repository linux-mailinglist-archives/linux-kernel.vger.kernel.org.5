Return-Path: <linux-kernel+bounces-142753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D798A2FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A638E1C23C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AF785654;
	Fri, 12 Apr 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUmCERz1"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91A684FAB;
	Fri, 12 Apr 2024 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929463; cv=none; b=B/x+EdVjXoSlCywLqIrhEUZz8XZK+whll6iWpPwnxLd5LIUoreoPfBK9aiNjkdf0++mqCc7SFR+73F6U5cITcE20Rx9KaiA6c6MKaiil2gvv0B19RhlUCoTdYeAWmnl+Ylqq8CxPk4U2GAEEmckE+vGDJSWrMXTI+nb01pluyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929463; c=relaxed/simple;
	bh=8geQCAid38ejEfA5++6WxsYiP02Q2buqSdVzCqz+9h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qs2Weeko9C1gm0MR9SyNSJ3O1ZJauVRiGmSaSl02ZuK3QyWJkoZ0AX8pfYC7EuT9hkASQo7BDJB3UQOSlWDWxZQep9wcogmDHbkQuw9xMFeMu699fVrXuCRXPQ0XtXDbteFohCmZosqGI7u4v6FVaeMtEl2vycPqN+A3fdg1X+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUmCERz1; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so3070036a12.0;
        Fri, 12 Apr 2024 06:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712929460; x=1713534260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HaWhaqdaDfNBrfCl5nObWWrEOo5ajao2bIANOPV6KI=;
        b=dUmCERz1taGZKLJeoAkVhnuB7GYeaxyeNCbJcCFr7l8pEwbi58ck7mdVcWw6//ubzn
         /rp8MZiIAFea75+DSatrgb0/UixoRBUDXsR/Xdx3A2W3LUbJWdxllXcord61pCAxgGIV
         fu/81wvwF2z4n3SPDOZlcp65jRza3bvOhkkKesjEutp/VJJK0sh1AvdPKsdKRzEBO7rh
         id20Ywfbj1sTptN9DXZ6Xfsohn/6w3s8yaFheI6yFF2JVyKCEDL54RTbV81PYsLO/g7+
         7RPzymj23BI9nU6X7qf7X5WucvqKiKvxO/RYiQR7kR2KvONe/sQ27d2a2/aN+hA1ThRt
         aoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712929460; x=1713534260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HaWhaqdaDfNBrfCl5nObWWrEOo5ajao2bIANOPV6KI=;
        b=Vxk8FJARpaizA750UCDABDgomj9EB6JId0NKZB4joxUz1oG35xW04QLNpbmTARNn3P
         m3ZQGyXLDx8UnBHqvS0xH+7+LFhAlELJTWv9dJuJLMa+Gf92eUk/6NQCOOoWkz718EUJ
         yLMfqCyuRhZMnPRYVR4+Ms05BxXqObrMTQ0gqO2PJX9RpALqIYxSu1xHYk+7mml+6eX+
         A3s521vm7GrLB8SG3yFp9CVE9Ullwjha/wWgO1MrDGDPDlfRhSd6w0RUrI/mj9I1dOT0
         dI01eHtXOJJ5j+4rncYUlVFQoUYdAQSM3cdP2/AVNOUUD7jrI44Wt4K6L7oaUGZO/oRZ
         3i8w==
X-Forwarded-Encrypted: i=1; AJvYcCW2/X61F1181GzhA+oYmolxA8JOSypWuw2H3/CAIx1NvHKpLjxDfZ0J6H1XY6xngc4ORVVEsb8VwP1fZG48RcejUsK5D174/UH/g36eWj/B71FtyNOU9gsb1t8+sgpwAM0DwzdMzpPwZ9N74l5fvuIKTxcWqGiVIoDeNaK9Q594TRsKycLe
X-Gm-Message-State: AOJu0YwdxiATibW//DKA9SN6B4BIoW8fCktlXnwp9IDimRc5DdMPCOBd
	eANkeYWg5p5ZOfFGMfZXSp9w+HzQ82RFGGtLU6r4OrmGLA/MCnPsZLV9vzqMp3bJudd9K0NVLSB
	3PlWHnBlzjwxRcRu4V4b4MI5/790=
X-Google-Smtp-Source: AGHT+IFEC8uEkeMBRcT6w34by85kMHZS8oKJ5rLKlabaLd1wkl5XRtWFVYL35N3RsZ6AdPmJmF+szA/5GkrvS36dQyQ=
X-Received: by 2002:a17:907:2ce6:b0:a52:a25:2077 with SMTP id
 hz6-20020a1709072ce600b00a520a252077mr5020537ejc.14.1712929459777; Fri, 12
 Apr 2024 06:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410104002.1197-1-zhi.mao@mediatek.com> <20240410104002.1197-3-zhi.mao@mediatek.com>
 <CAHp75VfF0pbrKXjWZg7sTr-T=_CbjP+deFQP-VLCGX8ooahctg@mail.gmail.com> <ZhkBIee2X0UY40yD@kekkonen.localdomain>
In-Reply-To: <ZhkBIee2X0UY40yD@kekkonen.localdomain>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Apr 2024 16:43:43 +0300
Message-ID: <CAHp75VcKFCvzcESqsc8OQ5SVuO4gJiE5ZEUwkdoqvLzM=2PejQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: i2c: Add GT97xx VCM driver
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Zhi Mao <zhi.mao@mediatek.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Heiko Stuebner <heiko@sntech.de>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Hans de Goede <hdegoede@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Paul Elder <paul.elder@ideasonboard.com>, 
	Mehdi Djait <mehdi.djait@bootlin.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, shengnan.wang@mediatek.com, 
	yaya.chang@mediatek.com, yunkec@chromium.org, 10572168@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 12:39=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> On Wed, Apr 10, 2024 at 07:00:02PM +0300, Andy Shevchenko wrote:
> > > +static int gt97xx_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh=
 *fh)
> > > +{
> > > +       return pm_runtime_resume_and_get(sd->dev);
> > > +}
> > > +
> > > +static int gt97xx_close(struct v4l2_subdev *sd, struct v4l2_subdev_f=
h *fh)
> > > +{
> > > +       return pm_runtime_put(sd->dev);
> > > +}
> >
> > Hmm... Shouldn't v4l2 take care about these (PM calls)?
>
> Ideally yes. We don't have a good mechanism for this at the moment as the
> lens isn't part of the image pipeline. Non-data links may be used for thi=
s
> in the future but that's not implemented yet.

Aren't you using devlinks? It was designed exactly to make sure that
the PM chain of calls goes in the correct order.

--=20
With Best Regards,
Andy Shevchenko

