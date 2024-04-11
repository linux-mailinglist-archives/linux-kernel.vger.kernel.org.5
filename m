Return-Path: <linux-kernel+bounces-141470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3098A1EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DE22941F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EF253E0E;
	Thu, 11 Apr 2024 18:20:16 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88925380F;
	Thu, 11 Apr 2024 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859616; cv=none; b=gRiwqTGCYDBhZXjoGp4orgKA7JtEpcU9PASFWeCjXUlbiCGmHcdAkSYBfSaSJzXF+8SiwP4QVVTb+J/VnHHbFtOq1qAKkpeXZ8YNLt95fjA2ANPgMlUSoic4Ef56EMYnf+gcoq/HoAWvorG1h3RygtLBmjSQxgdLJ9W/nPJe/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859616; c=relaxed/simple;
	bh=S6BbPnTwdycm64mGNGE9rNMDIIUFWfyMUwmQclD8Mto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szMPaFUL/AyjCOs7A5eVKslmNI6GM5EPdiOFlYRvYNPgqTYI5IyKj1ekb4TIGP1pALrpkmOrI2f/MZF1VDQDL3SBWJP6bCyW0QAbtCRSEdfbHnFJo2qpxsDhtkMSyXT0VNCHrmUB3DerNPtp8Yl5zlEPEFQ4+Qh9UfwA4kUTqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6eb5511088aso110639a34.2;
        Thu, 11 Apr 2024 11:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859614; x=1713464414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6BbPnTwdycm64mGNGE9rNMDIIUFWfyMUwmQclD8Mto=;
        b=mrOJjsDv8tsd5dvZhPFiz7YWXQYea7sfLXWPEBAhHIJZqlj3NRF8r3wuL6WvwR08X5
         P2aTZOBZlb/XEnrSQk3arkLiF/l0n1dKHBQb8Bv1Fkq3obqLQNaDcJmZ5vMxL8FuV83l
         w6lI+1q/lZNoxIy364nwj64EXBId1nNsz8kSkj/tYwOsr6y8ZbbLZxQ1iHYvyNsjjdcf
         9Xxfk8Ulevq0quu3gcnW2K1D0hdjr7Gjk7LTyKFdB1wBcn+TEXTTESRMDgf28pyG2orC
         lvg4xOb5kMhXn/cVBld2XPcUR7q0wYfH/gkNxjtg4mI1CEOmtJCN1flCO3eEfPdk06Jm
         wEWg==
X-Forwarded-Encrypted: i=1; AJvYcCVSc7vbu3Npx1YofH6jkDY1CNu6/u/E8Efc4s1f0I4/oESPXPDryZ7kXm2wqi5pzbPF/B8sKxAbbMiuYxdWQlPKRljDyG3GLtMeQtOy
X-Gm-Message-State: AOJu0YxMAtaDl2IBdSXioOEZzsa8cSuzqRkpj5+IjoSZi/1mQg+iRzGt
	sucTqEeaaQ0pemVBN3o56wMRgr5/stES9/4vSx/kErwRuNPQUOqYsadXA4aJTEMnc7sIn9lyjx+
	axrzZ4kY16N1VRGkBjVoyYw3O0WhehA==
X-Google-Smtp-Source: AGHT+IGfOQrSozcDeM1LPWL9Oz5KLScywrgAK+QlWW15/KT6k2ppVPLYa8awmW89vNOiBQ57yevzPHBrjdngDd57Zw0=
X-Received: by 2002:a05:6870:1650:b0:22e:1514:8077 with SMTP id
 c16-20020a056870165000b0022e15148077mr304248oae.43.1712859613789; Thu, 11 Apr
 2024 11:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJvTdKmK_U7nChpm=MzaDyw3T9V6hSua-6C89WCjo828vxm+yw@mail.gmail.com>
 <CAHk-=wgaTzpJssX2z7OiQOLL0BZzHGAfJn0MYPhuN9oU0R2f-Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgaTzpJssX2z7OiQOLL0BZzHGAfJn0MYPhuN9oU0R2f-Q@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Thu, 11 Apr 2024 14:20:02 -0400
Message-ID: <CAJvTdK=BO2YtUCrNzjMR8EydaDzaPasfi9m3_4UreC2J1MYjTg@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat 2024.04.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 4:18=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 10 Apr 2024 at 06:24, Len Brown <lenb@kernel.org> wrote:
> >
> > Turbostat version 2024.04.10
>
> Tssk. Things like this should still come in during the merge window
> and preferably be in linux-next.
>
> I have pulled this, since it's obviously just tooling (and the
> maintainer file pattern update), but stil...

ISTR that once upon a time at the kernel summit you expressed a
preference that things
like utilities (which sometimes depend on merge window changes) come
in after rc1 is declared
to basically stay out of the way.

Yes, this batch was delayed a week or so after that due to some revisions..=
.

Happy to send this kind of thing during the merge window when
dependencies allow (yes, they would have this time)
since that is your current preference.

Also, yes, I can have my turbostat branch routinely included in linux-next.

thanks,
-Len

