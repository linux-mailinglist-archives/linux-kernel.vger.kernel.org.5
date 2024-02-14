Return-Path: <linux-kernel+bounces-65494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D993854DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB73B2A298
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27B760272;
	Wed, 14 Feb 2024 16:11:49 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD56960256;
	Wed, 14 Feb 2024 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927109; cv=none; b=GVjv5BqD+6ZNoaX/z/cY1V/ZsuMFIaCDJvmLSFwTFcj8LtKecYwyUOzK2Q3TRMheZmYN1WzXYs/7+olEgtGIEeEk7jpde35KIT5i1vU4VoHAEWJO01BbMlzdvAK2ln+jYf+LD7wEyHXM6+PDtBq7uaKkaEOC5Qhw/gKHUYsNKrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927109; c=relaxed/simple;
	bh=d4akXQyBlYkmtopNPAr/6VdhOPSW6iTSkYa6TsdpGaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oc6nvD5VkSAubOo4U12eIFrKV8eK33eoWSco7BWq5T94ORGlMioBnSwtveIhFxbfPNp+7XxsZyIa04M7xAoKiTqIHxJ0ymvV/JXgiQ/QpJvvPoucHJthwHpUkMA2sQTFqQmL4cho45RcS+dQ07b9Pauh1bA9/DIrUf6vGLo2s/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so2161220276.1;
        Wed, 14 Feb 2024 08:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707927106; x=1708531906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGOxaMcTl6yCKxcFlv5id+yk+dzCu0igLgeJZ2j17sU=;
        b=GgfJhp8C1Kn6M/pQBsLmBy1oMhxHvHIJk9kFsFjVGpcGM8KMXD+jPCXjKAQMrdMuOb
         x+0VfzpaiCAWF2IuoBTK0kFaxzjVu2MDJ77UUHGVIq4GGGAFMFGV9qu0L5R9oGAPToZt
         QrL/tnuoPMmw1d5mp18CMuFBdjTbD1XIg9cQwGoOUM/IdncQaj1GBrs/s3joSCByde9T
         wqLrhAfC43yJWP923gxJQLTPtlt2bu0etiEJFj9GZviJqt87VCwEQG3NxkJZanBdc0QS
         Vioc9otsLH0TFibf4EY/7bm1YPm35r3QEuybYryg559jbguvL5gyQ5SVhvqshFw5SFd2
         HVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0CRBvel46LfJRqUSiv5AYwqhfZwslmdBVlh71fIf39LKZ3WuEVjAOU0NwnfbklkMEJ+NDYyETIUeRhGof2oP8cczjRoNBttgEEl6X
X-Gm-Message-State: AOJu0Yx/F0eYk5nvV65qUfOw9jG7Kpo4pTCI1vyKsDrJjL7S+WfRhc4T
	jsQm5FyoxXP4GlvOasGkmFeydG3qOa3LHDjdxi9LLb7noMrgTZgG3RWIQMrO+Cg=
X-Google-Smtp-Source: AGHT+IHK6YtkcLr/gm60ChTokRH0nBMuDHAv1w8fzoqUvxpW/9FiKf2cmfGaL4vVIdvbX4UYjYfn8w==
X-Received: by 2002:a25:ef07:0:b0:dc7:497e:cddf with SMTP id g7-20020a25ef07000000b00dc7497ecddfmr3063668ybd.33.1707927104879;
        Wed, 14 Feb 2024 08:11:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjNONCFX+FvSpamRKXQ9KUAGZNXDYs75eHGLvkfsF0y96MDffrDAzmfk3LK40NH1OSEuE/lNOkRR2xSRYbTb7ewr0xS5QXzmpDKzUh
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id x14-20020a25ce0e000000b00dc6d51c8555sm987329ybe.17.2024.02.14.08.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:11:44 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcdb210cb6aso696281276.2;
        Wed, 14 Feb 2024 08:11:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWz6OQDXicv+SxyPsKu0MxlEPKc3Ohb9AqnyU6oENL63VjXdt3RRNReWNSy6lNr/ctT9rJJtOsXbcsYXb8K0Iwwa5yoG0/ZPKt/vkSz
X-Received: by 2002:a5b:54a:0:b0:dc2:466a:23bd with SMTP id
 r10-20020a5b054a000000b00dc2466a23bdmr2639079ybp.54.1707927104199; Wed, 14
 Feb 2024 08:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220221.2380-8-wsa+renesas@sang-engineering.com> <20240213220221.2380-12-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240213220221.2380-12-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 17:11:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUCgr-OpSSueFpL5pqxpDqw-2qDKmjABGCeozLcs4QgLw@mail.gmail.com>
Message-ID: <CAMuHMdUCgr-OpSSueFpL5pqxpDqw-2qDKmjABGCeozLcs4QgLw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mfd: tmio: Update include files
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:05=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Remove meanwhile unneeded includes, only add types.h for dma_addr_t.
> Also, remove an obsolete forward declaration while here.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Lee Jones <lee@kernel.org>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

