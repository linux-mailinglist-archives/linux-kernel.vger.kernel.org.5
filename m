Return-Path: <linux-kernel+bounces-82063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E376867E86
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADCC2982CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7708812E1C3;
	Mon, 26 Feb 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he/GTxt+"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEF412DDB6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968628; cv=none; b=l2/R+peDnXkfNwmZlCfMsC4lNN2I0+O88TU/Or+bPnB+yY0h8sp+IVNFRae8TfKoTObivGhrBexNAidN1lN4tOhlbLKOS+FpGn2DrAz9FB/ToGcCwTVigDKpeQ6+0ZNFF+yt1035AqYTjLk6PDUAiF+m443h56zgnYWAUt4QQMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968628; c=relaxed/simple;
	bh=jx4yv3Vb9QsFxQU8+9tf7Unri6IYO201CeFY0loJz7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJQ5f71MDU8hMjOuet9dv0cAYpMgVQisPEPXLTr6Pk3nP6/+1hW75CrvOHFj/i9QW0ETPq0rBxNN1GUXfILDvRWZP7f5BqhLT+wjZY1g982hB6RrHMH4mK4Q2hgZTEhv+a6aUYqmQlobDhUQX8UsRAt1b0V9acQzhnIVvqTKObc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he/GTxt+; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4caabc3f941so1616351e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708968626; x=1709573426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlU3HISJ9jAvKCuFTV2ZE1TaFEVSXaWxNoCiDt0aWio=;
        b=he/GTxt+g+fY1uGrWJ8ZWibZ0LFwJR9/N++yGcN5OINucU5QFfAECKTz0mp19Mei8/
         AgThac8W7zouogFqQauCWXOKgWQJLj/vmgPidhudntkAPn0G5b/gIZW2sP8YGZ8efx/f
         MvXQmNa8/R4u4U50cDR5hoSJVS232v3CQIn+S9NgCf7SKqmYUBz9/BpJ5shZEnFzVpJt
         2sY+AM/krbSxrGooIczfiK8U/NoXFBIL/t/2xGBvfEjbUhm+CK9B2E1Ae6pFYsRHIeKr
         mM+NT0wwK/klisZfUCzqTP0r1DAhJlY7DxLQaGhdc3kiCQyyw3Pz3ONJzDoJAEZQWXtf
         yw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708968626; x=1709573426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlU3HISJ9jAvKCuFTV2ZE1TaFEVSXaWxNoCiDt0aWio=;
        b=k/deUGB+6lf5CeLcugxg49IOdH7ZXRtVctOxKVc+WyFFqEa4PuWAVHY4ei43+jmlPQ
         jpTLPvoXjbUxiLXeSWQhEoPFP9U5l8ez76C+AK+X34/ixtxxx+6MGkO8Z2AWPq6487Iw
         HwIpou3RnCFEN9x8dICZUcXfLd0T12yLHv6uBb6aWdRmEn7Ntg7ewvGFNLMYCcHW03R7
         fjhfUkldXgzvMjD9mwVKFxkELpXVND6c+rXKd7JyQgloRMV+tBI0j4sEFWhvZip8u7hR
         dKbVhNx7Lz8d8JWWeBS+6LlnpZVdnYi7Hi8vpGiaccklpZMt4BbR6Tv5VAI2AC6DfYmJ
         gprw==
X-Forwarded-Encrypted: i=1; AJvYcCX0vLG2e6kcfwxUee5bKIJeH5M4X71DXGSJe5FO2vIJki6WJ17uYszIQxpYdQW4tlYc3Z8FBh/hle+EB2R4CtJ2mNXyrxFBKOEZ96Rs
X-Gm-Message-State: AOJu0YyZaAgm4vOm7Rkr4TYxJ7zVQ313CPi5L5OssYf7rtfoHN0Z/6dI
	XbrVPMZH7bcjcWKLkMlPJbzYIrufPFV+jYG0cjzKakQIrjRtiIlP9/Z69nAv4xSLivBtaDlhM/t
	Wc8fNQXLrOLlhN/FlMg55pQ56LM8=
X-Google-Smtp-Source: AGHT+IFNj9mCKXnXvnV3TH4npUHQ7MVLq3yv1FkOkTPORiP+GBI8BqX4iVn1lvUDxb6L5htvPeQich0LkgqxAkd6r6g=
X-Received: by 2002:a05:6122:1c85:b0:4ce:96b7:c2f6 with SMTP id
 eu5-20020a0561221c8500b004ce96b7c2f6mr5270302vkb.5.1708968626162; Mon, 26 Feb
 2024 09:30:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216180559.208276-1-tj@kernel.org> <ZdUK1jhMUSyC7yUj@slm.duckdns.org>
 <CAJhGHyC8Y7QU3TWDA1jz3D5VB3BDG9JcZ4XB_9rft1UiMF7uYw@mail.gmail.com>
 <ZdWMd2rHjCEUOfAp@slm.duckdns.org> <CAOMdWS+7=qD9e=Q+Rv65rMXJ1uc_KPVN43uWrJ+xUdoXoV-D4Q@mail.gmail.com>
 <202402250940.15C634D27@keescook>
In-Reply-To: <202402250940.15C634D27@keescook>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 26 Feb 2024 09:30:14 -0800
Message-ID: <CAOMdWSJ4WVXV+-c_dXOWmSxXadb4a-qgpBe+fLPNsZtW0-uayQ@mail.gmail.com>
Subject: Re: [PATCHSET wq/for-6.9,6.10] workqueue: Implement disable/enable_work()
To: Kees Cook <keescook@chromium.org>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, torvalds@linux-foundation.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > > For 0001-00010:
> > > >
> > > > Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
> > >
> > > Applied 0001-0010 to wq/for-6.9.
> > >
> > > Thanks.
> >
> > I have rebased the conversion work based on
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git disable_work-v=
1
> >
> > 0001-dma-Convert-from-tasklet-to-BH-workqueue.patch
> > 0002-IB-Convert-from-tasklet-to-BH-workqueue.patch
> > 0003-USB-Convert-from-tasklet-to-BH-workqueue.patch
> > 0004-mailbox-Convert-from-tasklet-to-BH-workqueue.patch
> > 0005-ipmi-Convert-from-tasklet-to-BH-workqueue.patch
> > 0006-s390-Convert-from-tasklet-to-BH-workqueue.patch
> > 0007-drivers-media-Convert-from-tasklet-to-BH-workqueue.patch
> > 0008-mmc-Convert-from-tasklet-to-BH-workqueue.patch
> >
> > Patches: https://github.com/allenpais/for-6.9-bh-conversions
> > KSPP Issue: refactor all tasklet users into other APIs =C2=B7 Issue #94=
 =C2=B7
> > https://github.com/KSPP/linux/issues/94
> >

Kees,

> > I am working on drivers/crypto/* and drivers/net/*. This might a
> > day or two more. Please provide guidance on the types of testing I
> > should perform.
>
> Great! What's the plan for these? Will they go to subsystem maintainers
> after the next merge window, or is Tejun carrying them?
>

  I think it's best to send it out the subsystem mailing list. Ideally, get=
 some
testing/benchmarks run and then look at getting them into either Tejun's
branch or via subsystem maintainers. I am open to other ideas.

Thanks.

> -Kees
>
> --
> Kees Cook



--=20
       - Allen

