Return-Path: <linux-kernel+bounces-37666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA3483B355
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86FF2882E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7C41350CF;
	Wed, 24 Jan 2024 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arnQ/DFh"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E821350C2;
	Wed, 24 Jan 2024 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129540; cv=none; b=X6qNPV0HfTPpJ9vC0xnwqNBbzdKiN5ikkx1ip+B0bPZ5RIAnpB/iQowaO3sDcoTpjljvkP++K0I+14Z00AJ6NMB+gKMDcKTiO6fmaEdfS0ATcn7O0clbkh4NwCbFWr38ozDNKZ2bVTf2M9IvYGiB0041K3KpQ8Zi/dCs6OXqq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129540; c=relaxed/simple;
	bh=Lq2wvvcWH0lcKD+XRWckbLxwDQv4YOsl/2uTC/5zKlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcdcc+xwO8Ybn24ejBi6TXd48K33v4sbmVdsSyHJvkNEMZDshapq8CqXUvxQx26iHDjBAA5teGdm3ZJZqnTMdxzv/YOmyZUM9uSQN1QJuECpT2QHorXdgXLfVSoCntC9xb52SbuXYCJDyFkXRSMnBKPdAJAkqazNtixc98yJ/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arnQ/DFh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so14825966b.1;
        Wed, 24 Jan 2024 12:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706129536; x=1706734336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lq2wvvcWH0lcKD+XRWckbLxwDQv4YOsl/2uTC/5zKlM=;
        b=arnQ/DFhoI3TrsmlhTgUrsrRfq2g5xfZPvHnpVlEscDv/c1SycoU1kt8scY21YFoET
         VRWu+1Rm7+9QCsu5VCOjkwQwzQkcDGlo3Spgd75KscrkJn9Mm4lgSGTtDLBhYhEGYkrZ
         K97DeHtdxZIEWAMeocL8RJftVHsw0P3+0tTQIxqOweaQ/v6e9cRUdrdH/s4wZvTLWDS5
         P/IRkiAJcg8/4WbxceoKP9QNu8WDHPJptkoqayh9RDBIHZOLyViy1CKB2lcHDXWYr/V3
         OsiP7BV6kKwkOGUu/Vjud6fh5tu8D385JjiVdu3LfxL/C5qopT7SUC2TnC4nVBoXceKO
         TlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129536; x=1706734336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lq2wvvcWH0lcKD+XRWckbLxwDQv4YOsl/2uTC/5zKlM=;
        b=LGq7AvYMFoLbdsPzgIu2NpuhQ2Rqr6PgEG0CuEvMAOyBUGOSAwu8N4iLaC+Y++1l6c
         HI4BKoqLb1tpslva/qpiryf3IPYyDehyrcvMfwFmWcWUG0dOiw38sxp0iFOL34Y8dL/Z
         JjvsxkvbhPnVH7qsG8+zgLi2fADmJO5vTm1YyDPSQQSBzZ6AP38tko3zuJA4RpuDndkI
         ZQwWmEvSOJ+z2fbN10NO3rv67j+A2+hb8rZEuq01Y3gLyuUZnGbpMqKV1cicwT9r6Cvl
         Xj8U/9i5COT8LEACpQ7WqYJa/sspiQj0s50FQfyy5c8VisXEkZmsrVj0nX26a99tr+sp
         azKw==
X-Gm-Message-State: AOJu0YwOk9AGb5Pa6PnvmZJVyJm4K7VAjw9jbHpVWC+wpzRWEUSsN05R
	7fuEW3uzbgjiyISRzXJICmpXDyfEBq1Z/Si1TFtkFVSnV3a2kHqexNcBySu3Q/6H0HSYHZIWSha
	eXI5xh6EVUqcGm9bLSt5sNuX+uu0=
X-Google-Smtp-Source: AGHT+IEYFWPLw+3WJbyvV8ucSHMH4Lcdn82CMUL29kZl3sSg/w0RroU7mSwAw1vM6+VvVYDIjYKl/NL56kcNCOtPiGM=
X-Received: by 2002:a17:906:ce5c:b0:a30:e1b6:2879 with SMTP id
 se28-20020a170906ce5c00b00a30e1b62879mr243561ejb.1.1706129536440; Wed, 24 Jan
 2024 12:52:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com> <20240124153016.1541616-3-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240124153016.1541616-3-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Jan 2024 22:51:39 +0200
Message-ID: <CAHp75Vf=3U3pjFXck8isd7jcNuDbrPWRLCtN=RL5U+wFxZp0sg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] mfd: cs42l43: Use __u8 type rather than u8 for
 firmware interface
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lee@kernel.org, broonie@kernel.org, alsa-devel@alsa-project.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 5:30=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

Hmm... Don't we need a commit message, even if it mostly repeats the
Subject line?

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>


--=20
With Best Regards,
Andy Shevchenko

