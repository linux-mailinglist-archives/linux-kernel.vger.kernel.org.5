Return-Path: <linux-kernel+bounces-79141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161E1861E20
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476241C25228
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE7214CAA9;
	Fri, 23 Feb 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EN/bf0ME"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD461142623
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721282; cv=none; b=S/z9Yi3HZIFK1COrjOfonsJEHzDqUL+pGPsq0O/C8adCKlo2Mg6tCNG36YsYu6jUitr4hoQGJUeR8uYyeAaxi8RN2Wk49cZHeiCeA3qPWAumfjTGW+av5636USoP/ueaioJOhRGa86mblSV6aTlUONOe/PFrhCxQf78oJqQvFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721282; c=relaxed/simple;
	bh=6Pe3mftHpbIxO1fJyf6AHXeqBVBF+S3SXbDBF0k3DhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3KMr0yyuf711434qKQD6Rqy/rFuAdNFs91gJ+LQQKhXnl71+7QEsnUCafueZGj5cZo2Z4KE6wahO/udl+yxjw/iUZU87I/EZQtGNnFNwnW5uZ7lTWvrDSJ28p13stZY/sXU/HZ8j2yxOcRqaQC3ol+VWoNzXnez4wVoHlzPJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EN/bf0ME; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so778207276.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708721280; x=1709326080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Pe3mftHpbIxO1fJyf6AHXeqBVBF+S3SXbDBF0k3DhU=;
        b=EN/bf0MElR4p8SAmUtq/zsx10naa1JUorfhqxU/m8aflv6yqGYT/6I9vTT+u84u581
         GniW7RodCez7lb4BUFZgCTeTOx4xYmpUtE6PKdr6ikM/zaW5cIfI9JIfEIzfVoS7Ui3s
         Vempw8zyh+gt3yRU1v0hsBqmK9Zom6KlJlqa2pYmPayEKe1bvX0RgZ45udK3FzJz2BOo
         dXDS9foILJ5b2P/BblA/0tjqafhIE+QIUVlrgF6rpki8hBHKlDwI0mVW9Uws8Sjc4GHS
         PigBk51Q9PxOMTIBFzJp8wejA0AmUQ2jEhtPK+9JNJr9dh2y/j+JzMy9pV3TGvwOP01z
         ejmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708721280; x=1709326080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Pe3mftHpbIxO1fJyf6AHXeqBVBF+S3SXbDBF0k3DhU=;
        b=qyhOu7G8gYL+6fsD+aTC1/9MXda1PK2UlboKSyhzf5Z10m2bjsECzJv4wQIKtm97tp
         tyBd0v8ebbpFOdwX+fJQY15ad7t7qGxkY8Bfx0WZq/jJlByx5kaxtvv8687M2Zb/xc26
         91tnTYKZSaAIitobTGIlwDlZ+TNeDz/+taigfstFRWWnBd2/kbTYqB1PzYVSc5aX5D66
         KOLPkwpTgcCQqHgfzjADGwPa3UpZeLgiwoLChEoc5SpDpIDs5z3BvsJdAJUBVQ0qgu5F
         H6OogDTJ/+SDkYPT+eIgY4fQL0UORPZmCndS8SFOvEc5/JiybpU1T05KMmHOwh5/UOSO
         9OwA==
X-Forwarded-Encrypted: i=1; AJvYcCVT2y5hoGgxdWlsAFsLkSh0OdVCQ7FqNMfJfiEO3KvsC/aVu+s9xyVc1k9kbZ2OwlVP5EjBy1iWX1zMGX7YkpF3lYt6TSPv7v0FL75J
X-Gm-Message-State: AOJu0YzV0SE5KPYI41o2fiO/in9ZbSUpJHD2/VFM9eEDL5GNYOIHEhLE
	m80Lo2uqRPOgq+GYPmTd9T+h8c8mNMTZkCqb+0hxckARC+wbAqtRMIc5VpQ1mrMLn3bhYYmLk76
	P72q4JJhjDTfr7x5lY8gnaHYMxbF3lzwB2tkh0zzhZQqcpyhK
X-Google-Smtp-Source: AGHT+IGmkFRwYb4ij5VVoeEzcfF1Sc2dnJzwqFomuU9KqSGsoH8EJyxMrufSg4cF1JmFNOb53aFUYcG9m+OJGYejrxY=
X-Received: by 2002:a25:e804:0:b0:dcd:b034:b504 with SMTP id
 k4-20020a25e804000000b00dcdb034b504mr936331ybd.27.1708721279784; Fri, 23 Feb
 2024 12:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223181656.1099845-1-aaro.koskinen@iki.fi>
In-Reply-To: <20240223181656.1099845-1-aaro.koskinen@iki.fi>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Feb 2024 21:47:49 +0100
Message-ID: <CACRpkdaVNhMPeeGM5QdHsgaUddixRM+-gTf8-2B-3OeLXLE5QQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: OMAP: fix USB regression on Nokia N8x0
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 7:17=E2=80=AFPM Aaro Koskinen <aaro.koskinen@iki.fi=
> wrote:

> GPIO chip labels are wrong for OMAP2, so the USB does not work. Fix.
>
> Fixes: 8e0285ab95a9 ("ARM/musb: omap2: Remove global GPIO numbers from TU=
SB6010")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

