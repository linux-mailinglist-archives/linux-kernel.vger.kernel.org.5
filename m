Return-Path: <linux-kernel+bounces-30903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A968325B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219511C22486
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F202030D;
	Fri, 19 Jan 2024 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqf/4GF+"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A4320C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652811; cv=none; b=T6JIN5nY2GCj1Fnqf9j2N3vMG09CbGV8Cob52wVHi4afDiGtXRRHMbJ3V8k+O5QvePto2F2W5hzYY1DmiUCVwv4F+m5ixbS7Nul5Zc/hGEIkoJh+QYzBSYvQ90DNjdCFdofTJoPGz1jVf6pMiQV+5tssykDIB+fqXhrpnQvqtAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652811; c=relaxed/simple;
	bh=u6uj8vGAtWaSglPusO+zY1nNoEfV/kxZM7/ahLuGXb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTeNL3STlUYEX54AMk/RFwnb3kq3NpxytBnhDiMv6Cy3J5RZBxIMmu3V2E9czBIrGHHvTHMEs9+t5cPCvrFC0MHp0ytFbNqcEFIe7tdnTlmR60xe8hthaY2zIPc9ABnPjqYQ+s+Oe4Y01bAtHaxR2TFs3mwF9DaTwXqcXf3k1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dqf/4GF+; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ff7dd8d7ceso4698957b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705652809; x=1706257609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6uj8vGAtWaSglPusO+zY1nNoEfV/kxZM7/ahLuGXb4=;
        b=dqf/4GF+jONl9OH6zUmS0ksoS3fhH+o/vEFTUYsNLAIfZEC9dQ70m1GZPFhhuTmJ6x
         jy0+LMfrPE8CUK+zfqglwUc3wafQx1I/16PCRjyxlCwoq2O39jeLq61oSEPzHfqzXh0H
         +A15xSQ5DZP/SOOZt/xqAh0lRLqGlSggDwVjh1isxfFSCYVbzTOhx/Jy+xSeuyMa6+O0
         9hU/j4c/nox3yHy9Fwo+mRBtfTTQix+zjVZSaR9L9YNoqSp7Da3clRQrHqHxK2POwFmt
         SlaI2Xy3twct6cvr5qG3s4bjxU3MOcmIGIHVwCMvx1zGzIdKA8MQDvVaN2bsPF8tX2s8
         QGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705652809; x=1706257609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6uj8vGAtWaSglPusO+zY1nNoEfV/kxZM7/ahLuGXb4=;
        b=vejtWZk3NsuPxXryQYsQZXyc5AzBOUUXvHyy0U+18G+TNr8XKlTEliEUoWZVdIdH8P
         +0y1X5Yg6LohDBfa/xgk8PuDwRjDLnLItw4oUnPxp+JEMbKQ6mdMmehQpljA2ilkJWHU
         Uuj2L/u26bND7K3+LHtLff8HIzJ9fFW+QM1Sxo+H2LV5Kp75r8WukyhYv7rW/iDBdPHH
         xJGFEwM5o3Kx/E/GGoJid6Ekd2MdmzrpASG+evTY6tlEtM6QCTwYwQRYEw0dRlcRlKK+
         BZRCytr8eRfDvVBGrxdbNtLdlJSoEPHWwYkkv3m8oN7STL43Tn+As9tRl+i2Bs/WonNr
         AgJA==
X-Gm-Message-State: AOJu0YxwgsbeU3lQLBFSb3JvobQolGhIzw+v+MrMlqfQs0z7vGfjT9hr
	erFKI7Og+QaNt27T/dqA1wA/5b6P42Q/OQM+hHrT8ZU69ymD+Gbh+lmV8mU+F2kkpGDcDVB8qy1
	Dzt2IZeFWiYsqqR1CFysA8gMDHsgQWg5kyIn3hw==
X-Google-Smtp-Source: AGHT+IFZAqizoPdRuii626y01xkZm8MM4MJIrfjqmCqvUZtFJj6JtaG5ZTQJR1iBiKLFo2+ioyraQRvAy9rS/GrdsSw=
X-Received: by 2002:a81:6286:0:b0:5ff:957d:a018 with SMTP id
 w128-20020a816286000000b005ff957da018mr1588062ywb.45.1705652809496; Fri, 19
 Jan 2024 00:26:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222030149.3740815-2-samuel@dionne-riel.com>
In-Reply-To: <20231222030149.3740815-2-samuel@dionne-riel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 Jan 2024 09:26:38 +0100
Message-ID: <CACRpkda9kF8pcuccSj3Wyy6n7Q7Fd7NmCGcaMzT9sKbTKN1LJw@mail.gmail.com>
Subject: Re: [PATCH v2] drm: panel-orientation-quirks: Add quirk for GPD Win Mini
To: Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 4:02=E2=80=AFAM Samuel Dionne-Riel
<samuel@dionne-riel.com> wrote:

> Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>

The patch looks OK, it was missing a commit message so I added
one and applied the patch to drm-misc-next.

Yours,
Linus Walleij

