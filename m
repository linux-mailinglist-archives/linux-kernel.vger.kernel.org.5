Return-Path: <linux-kernel+bounces-65497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E757854DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB962840E5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1565FF07;
	Wed, 14 Feb 2024 16:13:34 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC05FDC4;
	Wed, 14 Feb 2024 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927214; cv=none; b=Pdh6z3gSNZFjf/+UcIATGX+jv29lQAmy7ecrNJzwBsFRjatwXMbyqHg9aVLPGkvnPhHQqWbx/3xxYlR60itv4fbviuY94AAPMhl6bFI7Tka0rK9dwjB/ekUhcGU9n4K9IhKiUzyzSC/6r+v1mOW8+7yO2BL4QWolIT3r1uOqLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927214; c=relaxed/simple;
	bh=pq5EV8oxJSOVZB8A61RGJPHB3JKJ7OM4tzYYlyO/AlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Up0UQcdelSmI5o+vEkhGqReTwzl0vJQUdjA/JH/FXTtuCAFOBpyJGrtWCI1GcqI+JfsOr7KwTBKd0tfAXtxaEQlxPyIBZuiRMhPUhWKEjd5J9Mnyr+znZvypuzezOAxnptA2BRjB247L0AwdkXL3ZRLNt/W8ojzX6J+rCXdaMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so849932276.0;
        Wed, 14 Feb 2024 08:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707927211; x=1708532011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJX/Lm4XzhsAxdNHBuMFaeGm0V4bRWUDjix9hm2Iqf0=;
        b=NtTxCCVYX2TnTq0qgZFFIj2lydDzTbMYQZyFX+s58oSPJ1fk45DMmGO57oGaXrA67D
         twmu9qit51q5VihGE+AJe09SPh11gZiZJK3TQOATrEK9XOYrtaPKi5N5A2mrg6w0fvvD
         O63eDHIOB64whFRRZ85+01CruYSG27J8cZhPf1eeYlfg6Ct/fgGRtWQhmbzrS1jCUdVg
         OkW0pK+ZKPGF3g5pdAJC8eQAsFgVaccUZz1GMBPGL7/sCoPMqrRO16lHwRbhN9oyPNLj
         QVNDBD3Br2LGUC/DLdbpIGfWI/KQhFbLWYk/A+JxG5GNshk87/vY2dwOBoXvjzse4+wZ
         j4mg==
X-Forwarded-Encrypted: i=1; AJvYcCX1cojM0eH3Ve1xO5kh5fGWzL2fkx+uLLDHPWSNGWWbZ7HuB3F6loh+1GHuVg8RKKsTD2PGYc+3HzcIwNjAfIHCuuooL065GiJ0DAD0
X-Gm-Message-State: AOJu0YwkGLBuLybPfCczQD9UsZa9dV2hfsD/W6Ei+BuCny8bI6WGgfbo
	CebfCAXsVMDRJXG4opcJB42RgL8+oCrC7fwOh3BfqcQdf8+5+u8Dv6/Jquc4UXI=
X-Google-Smtp-Source: AGHT+IExe+e/xAWjak0joyKWnnfy1ZLwoTf/h/gjj6vqQb5UnetGWJPIVBln3Sp5O4t155VvWqsK2A==
X-Received: by 2002:a0d:cb54:0:b0:5ff:ceed:10c7 with SMTP id n81-20020a0dcb54000000b005ffceed10c7mr2003636ywd.0.1707927209586;
        Wed, 14 Feb 2024 08:13:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6rywe7hIvGFglStqVj1RWfZtUhuCCX54X/q0cSIsO2ief+IYsGKhqJhfbFWELcVpbDohLJe28xFLqvGkHs8NeBqBVwlJ4E1PXbRvg
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id m3-20020a0dfc03000000b00604198c3cafsm401762ywf.61.2024.02.14.08.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:13:28 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso862685276.0;
        Wed, 14 Feb 2024 08:13:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAVjm+UhUKfV53Ux9am401qflbvnEYhbiUWqOFt9wLhL+fR45dp7crHWe5hqoD2eZGT7TnQXDgXC0HFtf+SNrew/ZllepJVZaznZrd
X-Received: by 2002:a25:dd45:0:b0:dc6:d513:cd3 with SMTP id
 u66-20020a25dd45000000b00dc6d5130cd3mr1722689ybg.31.1707927208715; Wed, 14
 Feb 2024 08:13:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220221.2380-8-wsa+renesas@sang-engineering.com> <20240213220221.2380-13-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240213220221.2380-13-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 17:13:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWy7cEXYs7nZjy1_zPQ_cKHHNkYX6-uwUKM43uE5Q_8rQ@mail.gmail.com>
Message-ID: <CAMuHMdWy7cEXYs7nZjy1_zPQ_cKHHNkYX6-uwUKM43uE5Q_8rQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mfd: tmio: Sanitize comments
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:07=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Reformat the comments to utilize the maximum line length and use single
> line comments where appropriate. Remove superfluous comments, too.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Lee Jones <lee@kernel.org>

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

