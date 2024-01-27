Return-Path: <linux-kernel+bounces-41318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB983EEBC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE521C211B3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C56B2C6A4;
	Sat, 27 Jan 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKlss4he"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2DA25571
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373475; cv=none; b=W3zU9ZQw4gbtJxU0d34FYoniC315p67eBUQgCZtRwASCQ2uZ3Bc4CYVQs4TmWDwkUIHc7P44zKhuasDUHoWefcDMCameR0wAvZwOXJxYw/rJX+urzr2XuO/66zYWNX5VGpMRaL1Zil0V2lkhCsc2Zt8h5aDPgJ6HnKdeeznL0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373475; c=relaxed/simple;
	bh=52EY/SemdzO86LZW+X24P5o9GxO2ePPo7tueqcrByxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hddcifbUfw6kNQRNGRqE29Yis1xyZxCWU39r4R7A1HnMbLUSAypXvfUUJm/TefwHpZz5DN9k9LM8gNY8j7dwF+4/HZQScprz1tGPp8SjmuYqa9nfgB1L6IL9w6+vZC341+Z2f9hziVRO7SPGNdshL/hxgEi4QfHW//1VBYtci18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vKlss4he; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6432ee799so1670798276.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706373473; x=1706978273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52EY/SemdzO86LZW+X24P5o9GxO2ePPo7tueqcrByxo=;
        b=vKlss4he7FarMg/PdNMJ5UXiiR9iT4LtdMH2jlHxI4bQx3PApbu0nXjCCgyo8RK1uA
         MZADbYTMSOgm/JzSRIoMFLO9LT7iHdDjCOaySeugXJyjTUaLRIUpqlbRTTdA0IsaLI1i
         owU1CG0cqi+lZOmCaGGV5TL0wNv9flW2URzsuZwvvb9f7VutX4FYnJRn1rlyPAMGw/NY
         z+aBE8X2qyNx1AcapLR4mBIp0X5FwmqVXYIyQr4VIN5vgeL0YCX5AELBVOAS4mLvcMSZ
         9KGqm9M/sqviyEO5gR0TE3q7/EJjko4qvL8xdTO1FXyCH9FPZE0LCTrLgryRAv+VtLdk
         wPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706373473; x=1706978273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52EY/SemdzO86LZW+X24P5o9GxO2ePPo7tueqcrByxo=;
        b=V+EiIHj9DABqFQlGXdGz6FJhsCUB8zlJ7MqsQTW4na40KEtLwbKNWatslVC2pBkxDb
         V8Fq+51esPS89gSMqYVtBzg6FqxLy+cutONEqSVYaJE7C+w8Lz865auO/gt2kDe2zJNs
         P3sNhInRJWXCCE5kYhpXsQHRyCAQIrfp9fgCng5NHNkkXwBWo8c38Ts0t+Z3Hb2vnuvk
         n8yaqv9RNBgBaWlQMaA3hYfu9114ug2HOJaLOD9pwDwrlTp00ZGge4amZCejVNCA8Mld
         ajSSr7naBsz9HipmWUdg6wQYyscSiDJ4R248wV5IfZiKuSSNbTV4ewAB/33I1TelSh/P
         fg5A==
X-Gm-Message-State: AOJu0YxK/FM47fVj48hEKgalNPbcStGMZ7N17EIQTP3N4vsaKS6P5ria
	RU6Xlgrf/DYoqDRoiC2J+QB3xsuFbt20JrkeE3EFpA4M1acxl+BgWaomajnW/d4WOXoyrf3mwDd
	y0IZnWid46CMLHk4+FN3r2g6jmfzISneXvK0g0g==
X-Google-Smtp-Source: AGHT+IH6HdQ44ye/NMuXOgVUS/M7BGq7rU9eYNVXXNby5gNVSNwzfvRR0haZYsZfH2tla5inOMuU4vBcMP+4+MEWckk=
X-Received: by 2002:a25:848d:0:b0:dc5:f51e:6a60 with SMTP id
 v13-20020a25848d000000b00dc5f51e6a60mr1838267ybk.6.1706373456517; Sat, 27 Jan
 2024 08:37:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126223150.work.548-kees@kernel.org>
In-Reply-To: <20240126223150.work.548-kees@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 27 Jan 2024 17:37:25 +0100
Message-ID: <CACRpkdbpQNoh_ESB=CcUcP0_pcvDYCs9FeJ_wY74a7WJ77sLBg@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: Adjust n_channels usage for __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>, 
	Hante Meuleman <hante.meuleman@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Chi-hsien Lin <chi-hsien.lin@infineon.com>, Ian Lin <ian.lin@infineon.com>, 
	Johannes Berg <johannes.berg@intel.com>, Wright Feng <wright.feng@cypress.com>, 
	Hector Martin <marcan@marcan.st>, linux-wireless@vger.kernel.org, 
	brcm80211-dev-list.pdl@broadcom.com, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jisoo Jang <jisoo.jang@yonsei.ac.kr>, 
	Hans de Goede <hdegoede@redhat.com>, Aloka Dixit <quic_alokad@quicinc.com>, 
	John Keeping <john@keeping.me.uk>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:31=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:

> After commit e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
> cfg80211_scan_request with __counted_by"), the compiler may enforce
> dynamic array indexing of req->channels to stay below n_channels. As a
> result, n_channels needs to be increased _before_ accessing the newly
> added array index. Increment it first, then use "i" for the prior index.
> Solves this warning in the coming GCC that has __counted_by support:

Makes perfect sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

