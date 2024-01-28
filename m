Return-Path: <linux-kernel+bounces-41467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532BE83F253
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E8C285F04
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B941823765;
	Sat, 27 Jan 2024 23:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qmb+iyM7"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F323754
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706399593; cv=none; b=FQHYGLD0Itz90tz5Gau8tMy8vcw9Z0T1+PMFBnGLsVPR5BgYCelmiUabxVf3p4YSwGp00uZvSTyxgT8Wa9F6hyhzyzMYKaMtQUbqNe7GIsCencgI8MK8vlHLUyouDJOXlaVz9WabPH9XxbVQjlS8IpQ6nXrk5+g7Cq9L1kxx2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706399593; c=relaxed/simple;
	bh=y29bBOr0W8GWvuErd7/PqliVtdGt3XvPDU1lv0OLRhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeRxXTDwd+sa3iQ8FayCjJo7WkgEL18/AXVWwnVCB2skrX2vbnNeWXQVo8cyHr71A6n+Q/IF/DHxEXBimQpU4u1n9RCc5Kj+4qKd3nX/3v+iZP7dzmNyP6X1dJu+4w/uluKbTjA/G4NFAoVX67E+20e+j0lZja+Qbwo1nJHx8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qmb+iyM7; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5f69383e653so21343717b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706399589; x=1707004389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y29bBOr0W8GWvuErd7/PqliVtdGt3XvPDU1lv0OLRhw=;
        b=Qmb+iyM7okGb+fAqxVZWBuOSY6MxLeusIa7/+JSZ4mUBQbHQA1sI2XP4QcFeeX9g6W
         oA5K5WMV0wnq2T2e3ISg6gj/Ra5PGejJPBls4YoJlWSHgaJBN2N+0iaBjdCJlzKsEqyR
         DRS3oDtj4gpm9EohxZdAYc9CN+YqrBxcqcdqpH/4uIfBb3wKuo75i9uZQRPRqa8t7rXR
         Nb8EuQrluOiTdRWJUJ2urI91G0FpXUZGc//4rUGg6Wsc4bKCSyxH/89SWrJmAn0Y5/P1
         WVNSzrx8GZOjnUqPBNRQn06cEqlESWjvWBDJhuxNJLg81plp9PblJbvSrXjsxMRlkBg2
         WpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706399589; x=1707004389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y29bBOr0W8GWvuErd7/PqliVtdGt3XvPDU1lv0OLRhw=;
        b=M9vvaAUDyBk8hXpTODUVh3udiwJDNJRhomA5JM4LkM8+OtEEOLEJkllDX/aQP/Du8d
         NbqKsULbGZ4nQ9rxDn3Rm+HAhpSFMShhcKN9eOmcnc0I3wQVfwMkjPfa4YhkNk4Gue03
         VKP7h5yfvKrbx64UlUKMKXMTZRaPhCa85WPeLO1pOxnR+CvCMeWjfuVCMmO0a9TopWlf
         IuPwq9tcbWFp1Bvzu8HDSmVtNyU79+q5xdmgThyvey3JM9PqcbJXWYTL5SVdEEBSfeig
         g+FWSqSJ/2MZwb4uQ/Yo8XlkSnzsIEFfcM58740VhiPj4HW2qgu/SyaCNta0TS8aVVoJ
         rqRg==
X-Gm-Message-State: AOJu0YwNUtevW1ivWIFhvA+DqnA/sKMlnM4UBj59IViybi5hx+aSt6oH
	bYD7TJu/tiEwzJilAFm+F59edLjYAXu604lEI+HccT/d7g8scctfieqwgLvYY9Te/mNuzY6THZo
	Q9FJzC31fZApX9HSuwrPv5Nz18Z3T9Bdq8BNxTw==
X-Google-Smtp-Source: AGHT+IEhBRR1+Lt+t5PwX5bLtetfxOwsLRlWvg5X+Vn3cAbutbVfqPerwvTLBdzuw4fwNlv3dgffGIvAL7Z3lkau6gE=
X-Received: by 2002:a81:b187:0:b0:5ff:4b02:73b9 with SMTP id
 p129-20020a81b187000000b005ff4b0273b9mr2196680ywh.21.1706399589451; Sat, 27
 Jan 2024 15:53:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117124234.3137050-1-jean.thomas@wifirst.fr>
In-Reply-To: <20240117124234.3137050-1-jean.thomas@wifirst.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Jan 2024 00:52:58 +0100
Message-ID: <CACRpkdYFwS=KCmR5UDhz_G_DQ4B21f3JjJLTLCfr+D0Yn1iA=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: mediatek: mt7981: add additional uart group
To: Jean Thomas <jean.thomas@wifirst.fr>
Cc: sean.wang@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 1:43=E2=80=AFPM Jean Thomas <jean.thomas@wifirst.fr=
> wrote:

> Add uart1_3 (pins 26, 27) group to the pinctrl driver for the
> MediaTek MT7981 SoC.
>
> Signed-off-by: Jean Thomas <jean.thomas@wifirst.fr>

Patch applied.

Yours,
Linus Walleij

