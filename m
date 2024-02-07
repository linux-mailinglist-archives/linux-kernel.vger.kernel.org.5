Return-Path: <linux-kernel+bounces-56341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB4E84C8F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C482E28A028
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F4171AD;
	Wed,  7 Feb 2024 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWtxvwZX"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6673171AB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302916; cv=none; b=WUSTjbA5Fr2DXKXM28uQva8cj+14rYmIVTLGmDSKfTzh9ba7FvLUP0j40ZF74UIIldsqMWzskX00OnS/5aoHCPRg0vc8xONExzCCLngN/g945ZTj77Yi7+WL7w3QJWkJFxGKafZLvRbUy4mZC+uwGH9X8fGMPGLtYKVKNAmdUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302916; c=relaxed/simple;
	bh=GvnB5ueesQjpAOjR8nVz/seYPxt7xYcubH1vH2siBcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqA70uES7h3ynYat8EokDV5KNWPlJvEYNp0nSsLj31tyEBvYmrFujTj2DYQCmwOI/bZZxCpXSo6HhjbZZHjlD11KsoHxG8HLuQbLvfw/aWU+4FhsxtKpEJv5/3HM6U/SUFtQy0gglHYXQ2a8Zk+mfV4errGwxZXguHWjnJ1fhtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qWtxvwZX; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbed179f0faso1176090276.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 02:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707302914; x=1707907714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvnB5ueesQjpAOjR8nVz/seYPxt7xYcubH1vH2siBcI=;
        b=qWtxvwZXobwkpcgLQmpiCsjLIucoGXOvzXpXo/BsuM0g1YobvUrnM44k7I8cNQpaCX
         Z6/W0KaIRqHE9gY3zG8FHSKvSA8hRVpw3L2MbTDekFU9zvAAyTQ3IskpQ87AkqTijC8O
         XBS2hqsKO9gadOOJhF7r7O+0hlTDYBJbvJEnoA9yhHS1bF3mUngq+S0hqSSPnh9m0zps
         82TxwyGFE5iYF46oECYPurRusyz8XyEItJNB5mBtEyVMWWCG/IxRJmCW8RSP9nC5EwwQ
         xdiQtUNhOzvXPfSYSLGlwe/fG8TbQ/ypXBnFF8tIJ75wIZ+W5ODb3Wiohr9yQPMET9VJ
         qfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707302914; x=1707907714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvnB5ueesQjpAOjR8nVz/seYPxt7xYcubH1vH2siBcI=;
        b=cGAIGMJfpiVdkc61LIC8EHG5XyOHfI/vzsclVOKCUeansVkpDXV8v8nSPxjFN9fxW7
         3H3hxw7tIvQBpLUNDKL0gsB6PcCZFch7uWUVxDGAAksv/ZreOhj+55CM8kJVroyQLf03
         iJ+X0L52KW0VOSdPnMgK61JbhMdH99LZRxa8eE+JcS+EBUFf46SQMJlQ6xunhRJAeACk
         LVTWTURFM/ByMzHLtIQwL7mStxT3hdnOuBSLRulSK6eobr12ei+aJ4sAAqjq17IEH7I3
         jMy/GZjYOiAfuBpP6oE01yp6/y5xUV68Nt5HH2K8J4+szm3TO/QqWxsxNyFjOW6kS5+6
         6Djw==
X-Gm-Message-State: AOJu0YzyiJtJ1HE2wl+lqRc4QuRKTl5jyVmJjgfpfcwBztj5VPDNHeR+
	mQwuC1LHKDFxNxakgfqL5T638/qY8JQGS65WRkYix9M7kEfLFPKUFG+mA7buPqBuMGB4HHYu31F
	ZQec+pOv5t/R1l5/mEeMa0irxAjpumVHcHXQuYg==
X-Google-Smtp-Source: AGHT+IEyeEd+YmW1ElXSMWlGNBIbSjnJ686ocEUtx/vkJsI/HbYPN0Ib4cxLvb7P2uWVdDqkJpUOfJUu6YpaPjdJ3OM=
X-Received: by 2002:a05:6902:4cc:b0:dc2:58af:2af7 with SMTP id
 v12-20020a05690204cc00b00dc258af2af7mr2987912ybs.22.1707302913682; Wed, 07
 Feb 2024 02:48:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131071910.3950450-1-wenst@chromium.org>
In-Reply-To: <20240131071910.3950450-1-wenst@chromium.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2024 11:48:47 +0100
Message-ID: <CACRpkdbRY70+Er-=Xv338j68NgjEKZeD5FYW9GqFY-68sCBvgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: mediatek: Drop bogus slew rate register
 range for MT8186
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 8:19=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:

> The MT8186 does not support configuring pin slew rate. This is evident
> from both the datasheet, and the fact that the driver points the slew
> rate register range at the GPIO direction register range.
>
> Drop the bogus setting.
>
> Fixes: 8b483bda1e46 ("pinctrl: add pinctrl driver on mt8186")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Patches applied!

Yours,
Linus Walleij

