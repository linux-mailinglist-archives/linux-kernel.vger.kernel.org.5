Return-Path: <linux-kernel+bounces-31241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B8C832B00
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A9B24553
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6070E5380F;
	Fri, 19 Jan 2024 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io8NRcOd"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9EF52F69;
	Fri, 19 Jan 2024 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673458; cv=none; b=WGNIcychNfGlgcoe6AWhJe7ssEb1sYkfHUfcu/UJzouCeZHSXD5JAjeYSKVR2G5PgnWQ/x6VrXT0qml8BpAVW6cUkLSyi7rEhZXXArXf09fJ5Lh+tqx86Zq+qQzDFP255luiJOX9Eq5IGc0R49uWKve95tflQZtfITL8SdCuST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673458; c=relaxed/simple;
	bh=tRPuu7OgdAqiiCc7MB+woDeEMfwHVnY6ViwXozFMqG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVd2Ygo8IJt0uAuD0HJZp+IhcZj4xJ3BZKGJ5zZYtO2FnTBSNjLRDQPpUha9Vyo/81OqbPSyW6I6V7aaMc9tD6Oo8hq6JP8PnUl2AWzGHtc/6R86F38YApbpWXTG2dLkxA3wWup0Liifm3wIvUTzonDp/oaVHBHBqUYaxEDFecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io8NRcOd; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dafe04717baso766456276.1;
        Fri, 19 Jan 2024 06:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705673456; x=1706278256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRPuu7OgdAqiiCc7MB+woDeEMfwHVnY6ViwXozFMqG0=;
        b=io8NRcOdXi5KoGwoa2YT7fAxJZBmZXeK/drjeJymAycLa7YFmkPj2XwL+RzahhV+6L
         aGB0co4RwKAF6dAC2OGhyszFNTemo9D/IHZ3muF3EWyIUoShpnooZvjz5GyfU8Xzxjss
         B0aWxGL1N3lG7v3hSQlf2jLbDS5/Wx0wpsNd5t1SylBdMWIxsulv9pyqThYYFp+019fT
         aGOW0FGCVwlplrMiNgErjB98kgzKT+24KphLXpo7n9jyuLnG3b3lKWY1TKBhapSl7G5S
         Dyo6odOAIvX87t783R++l0ZIjyk3aS8o9w//C4KWqtvvCozojSaC2ecn8+aspw1V2iZN
         ixkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705673456; x=1706278256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRPuu7OgdAqiiCc7MB+woDeEMfwHVnY6ViwXozFMqG0=;
        b=AGW3tQ7mXZN34NXEpFFBdSiApRgQjPwOSSpD4QlYA9lhaG+KcWoK5ixFKiaypEudRq
         RwSgtidnRdSsURHpNpF6Qe90KxIZyNDd0RfzYB+F5DVd3WlBFe7i6etgJIE+s9yHkmX2
         znTLAek4C9+PjlthwmerPSdzSgU2fXA7Nj0jKa/UZRCe5xJkEAMROWah5IY09Lg94F7u
         nQV4BpZHY8d2ZpK+pPmVvX/qArdWTgpyoN2m9UU4Ua7/N8t2CP9J4jKYgrNZzd3sHxCQ
         p2VI4OiXLg40jYRRJ51wcIw4+hl3V6McqZwRZ5zDm0gW5iimpMTjgPT8jpfny9QO/IiO
         0/LA==
X-Gm-Message-State: AOJu0YxboImAbfnVs0gp40XNv5eOMnuY4C63rLooxeiBzGffzWWui2iJ
	STle9b01BSEfKDxF5wDKLZXkIjTpVsQOiI8A2aGY9C8FyDajdq6wm5aAgzJFzqRkUpwsyLLXswj
	QHjd11qOsV4AnozFYbGcfhgwrP0Y=
X-Google-Smtp-Source: AGHT+IG9CrOGmtruOqRrVWXa8Ob5+dEsScbKlLWeNtg9sGIc69623BaNprYguubebqRy+keV9ShuVjRAHf/IG7XJaF4=
X-Received: by 2002:a5b:4f:0:b0:dbf:15a:c9e4 with SMTP id e15-20020a5b004f000000b00dbf015ac9e4mr2182677ybp.48.1705673456564;
 Fri, 19 Jan 2024 06:10:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119115104.75456-1-ioworker0@gmail.com> <Zaps_0jnspsheP92@tiehlicka>
In-Reply-To: <Zaps_0jnspsheP92@tiehlicka>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 19 Jan 2024 22:10:43 +0800
Message-ID: <CAK1f24moboTz3FVko-RdpLQhaZU5gqduqtA3sB9npqBb21xrrA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT flag to process_madvise()
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for that.

BR,
Lance

On Fri, Jan 19, 2024 at 8:37=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> Please do not start a new version until all the outstanding points are
> settled. This just fragments the discussion and makes it hard to follow
> it.
>
> Thanks!
> --
> Michal Hocko
> SUSE Labs

