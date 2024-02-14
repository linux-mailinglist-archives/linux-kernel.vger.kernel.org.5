Return-Path: <linux-kernel+bounces-65488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 026AA854DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86895B2986A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58B95FBAB;
	Wed, 14 Feb 2024 16:07:46 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB35F871;
	Wed, 14 Feb 2024 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926866; cv=none; b=DrPtteQiezpsYZUqD0ImwjU+Ldbqmbyv1JFma628OqBpN1nOmM1Gy/Xb2a9cbNWYsiyhTac722vle1W7LvdTyoCDcpUgwkOoCVFE9YEqMMQobChy9JdwgLuhwjoAuVIkoFIwoceeP+cieOkaOWWWf47jH7XgEOMaH59IIlOEW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926866; c=relaxed/simple;
	bh=/wn8PFIf2PxzrUI74KjXYHRoSlM8BgLQMQZEj4J19j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anFx5psB+SMn0IXdp7Lra0XoiVslk3tK3SPfY0aFG5+fR1QX2i/DHbLS1cSKXu5TtQ2kzmj/6lzX+/g8QbqGPGYBv9xhQnhCKK5D74SN61iz7DJKCIzJ0AyMHWqpZWu0xfRUBU8zxy+z3ZG8DuIZS2Gnt6duB744tYKJZaUfWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so1282176276.1;
        Wed, 14 Feb 2024 08:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707926863; x=1708531663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtC8sspF5KFgbo57U/SzL9Y/H76L4X0jZ+uSkWvCzvk=;
        b=Ra99ob54uVbs/OQrGWQv7Dmbg4c7/aKmVH/+O+x9dI30i+lpOjS29O1LuhDYuUHJ/F
         JRMLNmxGsFbPc8ZktS09NnIJWGrwKaj+P2oIO3G72/Of/lqAfCbGBGI5b6YNJLipkuX0
         rvgixpRyCwAWJFsyX1DyWyFQvtNr0029ZqvmQF9sch6WP7YmA1O+QFT2cN3JW2aoSH74
         avIFNOVby7kBgK/EYztjGlE5f/umgeIT2O5JW31kohBPyTIlTM9cGxvpAtA0C2bdhL48
         RdukodS0GKFr4LnceZjnqfpyXqKtPRRbphM8CYcq4CmqCvcbYUeoBrhfvSsYxtAvlfmo
         Gp+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/3q65sXI9n8YdYT1D8AHH89W4hc0Esj+fKqmEQBezBfzeVCv8T5N5gltdKyYgkx3VoO0eLho/aq/AGYILBd1a2o0ipHpsSrVOFIHN
X-Gm-Message-State: AOJu0YwJX4BWNJ9sYZZhOxT7WnxIG0P+mmfxbcuciS5zi7apfoIBjDwT
	dSlC9QhFTzQ9HyESVddL6quuMaO9q6jA7Wv68FXmmF6d/MwdRn0apmKD0YemcjQ=
X-Google-Smtp-Source: AGHT+IG7wNyT+hkIWsiVvfps5N3Bkj+Wk1M6sYuKbMC0HoN0UN46apfjPmw6eRF6W7ynt79idfAd3Q==
X-Received: by 2002:a5b:c50:0:b0:dc7:4564:fe6b with SMTP id d16-20020a5b0c50000000b00dc74564fe6bmr2488966ybr.60.1707926863474;
        Wed, 14 Feb 2024 08:07:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLieOpI0NSwJs3j1ePOHMT46/LDA+l8kklmtgHjGoNsUehPKXKnIMe5fBTB9nyzzJR4ss53xCoeFe09WmNFJBo9+QIFtIx82rmOzFU
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id v125-20020a25c583000000b00dcd3e78d086sm510054ybe.46.2024.02.14.08.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:07:43 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc74435c428so5473371276.2;
        Wed, 14 Feb 2024 08:07:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwZOgop0jQahvjrdRjiYRkDintyWY4pcEnVXRLV2cPex1NLPxcYnwShHruJn7cR4f8JCmwgOwFGJb4UVKKghT7x22TK7geF3JpdGsP
X-Received: by 2002:a5b:b03:0:b0:dc6:9c51:760f with SMTP id
 z3-20020a5b0b03000000b00dc69c51760fmr2747494ybp.56.1707926863021; Wed, 14 Feb
 2024 08:07:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220221.2380-8-wsa+renesas@sang-engineering.com> <20240213220221.2380-10-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240213220221.2380-10-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 17:07:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUheaKW5JgVxc9zuBufqBLEec1uFQvcCiijbY4gpOdqig@mail.gmail.com>
Message-ID: <CAMuHMdUheaKW5JgVxc9zuBufqBLEec1uFQvcCiijbY4gpOdqig@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mfd: tmio: Remove obsolete io accessors
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:46=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Since commit 568494db6809 ("mtd: remove tmio_nand driver") and commit
> aceae7848624 ("fbdev: remove tmiofb driver"), these accessors have no
> users anymore. Remove them.
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

