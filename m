Return-Path: <linux-kernel+bounces-36790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8961A83A6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF6AB2718F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1132C1AAA9;
	Wed, 24 Jan 2024 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XygMAVFD"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267FE18E2E;
	Wed, 24 Jan 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091806; cv=none; b=mthDJqw2hMqvLTgGEJO0j7u+3xJzKwHv+7zkYbJm2gg2jflzyeEsyRZMwNTF8XxIzSm7LwsLKm5QppL0qwy3T03C/2DCCm32t6IBmz7jUjhoDsgIPQBlqssMWxjXFoYgYZOPn4hR5Ca+y3vboxbCDUlo9L4KgKMJLrCt7Kc13KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091806; c=relaxed/simple;
	bh=/VJeUAM84CSLJvQc/kYjOBJ8RgcjG3WuFyUcu2r93yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lL0T585A8pjBDfYn3uYo4E2tC1mrUX2LJo5RPrmn7fkwCo92edv6hm/UqHrBlFBTO/P2/wueCjEwEOjuPCvogLkgENAXwQes1gC3zsChz7nYkOYkyf288JaKhdUMEQrF83H+8HUiP1DXlPB/2EXe9ViKD74DZGqx2M72sSvOyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XygMAVFD; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5100b424f8fso1409910e87.0;
        Wed, 24 Jan 2024 02:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706091803; x=1706696603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VJeUAM84CSLJvQc/kYjOBJ8RgcjG3WuFyUcu2r93yo=;
        b=XygMAVFDtCFHeOhuZlSuWfxLkdG9lIrhAlZjj0wgtyejXhbFjK1VYtQJ2ahijnm8z0
         2+UY5W0Kk6zx5s7t3uPxIUoExWRmCTaci5t69mltQM7KHW5Zh840VA/gkecSQ4FAaSTI
         BTAXUVHoly1XTIdckAAmdBlStcbGwKeS3wcZ1L3L26EmFc96wPy/hQfiTOYilFCWKzyQ
         5/pIZVcwtkUH2CbSzPb9ZytqzVUoRWYmkIncB6GwQ6ArR5o6XmWerGMuFm6cj3j+5+54
         NVATVg17skefPCWAmsMNLOYo5Q+cx0nJoy5+ekdB3qU0q7V11UQkDaoR9kTOt0vIDl8f
         JbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706091803; x=1706696603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VJeUAM84CSLJvQc/kYjOBJ8RgcjG3WuFyUcu2r93yo=;
        b=ZgC3MVN8g24z57uRWY47SKfz9e2Q0JvPIv0dXwOYlFZ0fNmWPeyxzaWjbx/0+jU9fE
         DobcDUWLXGt+Z1Xw0pXzpBi2Lb7qzc33DhXh1PXnYtFkahfvYJoLRxoFVVxBOzg2UOvW
         nGmJZFL30cCsDCLH9y0hX19tiXUyFMsctUcYXDFSDAoLlCI3DE66LhM/k5iof7Ds/m93
         n14DvBRdHxZAzuQHMJpFaOVIILky9EIO1y6eevPmym2+IFHZ+0aexHaIwyeHPYaGgBCK
         oi8ZUrItLqB20l97mTI7L7KnIHpEdSNT/UhvlNa9RmSTdORm5tXqUcs0BU1pfuK3NjIf
         IS4g==
X-Gm-Message-State: AOJu0Yz/LDrcIapv9Rhw66cEVl8H0pfH6oAY4D5afmaqwk4zCmzmuF/w
	hADH6ach99yq3sS8Y85sK8F/kJSIszXUVHRYfROA2olU32sCtgAUubmf4wPPcJlevVgoZc4gxGA
	rwYJ4/lwwIZAD8SCOlVzcltfoV7fKvejU1U8=
X-Google-Smtp-Source: AGHT+IHVUHj4ZWKcDVAzVxEsRP3TMRqjTrkTddl6alF5VOMTinXZ91Fx9PiHMwcDZjn53Je3HAsriWOENxwFy1mgY9U=
X-Received: by 2002:a05:6512:3611:b0:510:cfa:994f with SMTP id
 f17-20020a056512361100b005100cfa994fmr734818lfs.100.1706091802960; Wed, 24
 Jan 2024 02:23:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124072436.3745720-1-bigunclemax@gmail.com>
 <20240124072436.3745720-2-bigunclemax@gmail.com> <ZbDV1RcDGnRjVqI7@infradead.org>
In-Reply-To: <ZbDV1RcDGnRjVqI7@infradead.org>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Wed, 24 Jan 2024 13:23:11 +0300
Message-ID: <CALHCpMgT_3QbyNm6NmyVtUD6=rxcwzJ_udMyKejLjMNeJ8AYgA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] aoe: avoid potential deadlock at set_capacity
To: Christoph Hellwig <hch@infradead.org>
Cc: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Christoph

=D1=81=D1=80, 24 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 12:18, Chr=
istoph Hellwig <hch@infradead.org>:
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Just curious: what is your rason for using aeo over nbd?

The main reason why I use aoe, because it's not require a userspace
client. All magic can be done by the kernel itself :)
Just enough to specify an aoe interface via cmdline or bootparams.

Cheers,
Maksim

