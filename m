Return-Path: <linux-kernel+bounces-35794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADE38396A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9871F23FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62BB80046;
	Tue, 23 Jan 2024 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRig2XuW"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E14811E4;
	Tue, 23 Jan 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031775; cv=none; b=l6b6uop71XUMQnN0jkY7p+YpiVmHQHk8SsxvHZkXYCpAxKOjJ7GrLmJfmsMOXZR0wS1nxskJhK7Jw7IzmaChSkUTjNQ5zSI3fFfyNy3+71ezr3zq+s9JkSAcDWLuJAMMFLffAu/4ZRILqEzPGeAVWDjAmvXWg1i7T+8BtAHnnhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031775; c=relaxed/simple;
	bh=8pc24spgmXPatNy46icvObRxrkz2BjHey8vExIG5+DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHjehepuKz+RT5XKWocwTL5n/lPZwZVRMbO4+Ctx9eyl4rnVXJPFRfbz5jYaSlaJmLVAGbrXL8Eo47A4CoZrESUD7lmulETmPmADBzTLMVg1q2pS53ATp9voNw0c08ziPR7sl1+Nhz5DfXCFWD+2R97JAAtsI7srlJFQw+NSxMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRig2XuW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso59347225e9.2;
        Tue, 23 Jan 2024 09:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706031772; x=1706636572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pc24spgmXPatNy46icvObRxrkz2BjHey8vExIG5+DY=;
        b=dRig2XuWMHjADtY839PPwSS/IY9YwsVZfRgx13U6JrVsY8BZm+pecBdbfY7gC8up17
         O5qM48REDwRvxNEwzWojkg0gB4G09CXBQSBhmiYrF1Rc5Wm16H5OSKe1ZSBjGQsWOLuv
         +2EctGBwgHBH99s8MXCau/ASexYtPSNy8ZLKzzVpszPeedWLJdjNgdyqAurwnHIiPuDf
         ZgsClnvFRpKo81kOv7q++Ax615b/+mg+nHr7Rk0uDYTBdPxD33b/FNT3VRK9xtsGBbCC
         7+ry52N5V4fvA9ptFE+E3TBHy3896IqJU8vjmPeyqVy6WBbHDj8rVqAojJ9yjE/i5T6j
         tZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031772; x=1706636572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pc24spgmXPatNy46icvObRxrkz2BjHey8vExIG5+DY=;
        b=oOSqYemOwB1YrZ3FEa8tOJUARu8LzCvZVyd4lFvz5RbgGf7pfZ7Xi0Qrr3O4OSb2uf
         l6P5qDnUu72aMd/65/bhzDipMhI4fPZecZo428ffWZKi3saHDXtOQ5a46n/fagH4GD8u
         Lg7ZZRgvEr6O+iHtrupNrBSETwJMSgc8UMQluaqeM07dI5yfACTpL980PF6mB2MaedC6
         SREF2dbX3qdiFz/2Gn5Cd34sBBjmvTj4RumhSvTCQ2Oeaz1+gMdzfEBMcz+cHKn7AJmg
         6AMcq1XXv3MH4jGazGey0dMLH+631LdczVp85hSe2gSdusSZaSPJaxLQb/qBbzMYU84x
         ygRw==
X-Gm-Message-State: AOJu0Yw0md833eoFNXziIxWyQFko9LG2ISC3weB3pjzD5s3asINcrS5T
	oXulsp6y1TZYWeZNff+nk4g03W5oR4N5Vc2jLkuGvDkn/rMBCLxG/JTecfBL
X-Google-Smtp-Source: AGHT+IFw87D3LFYgYwwCGd82u9LdTEv5cKIfV943QiE9irMJ589vP9IBdgh8NaBgMnNCK2JgkWgEvg==
X-Received: by 2002:a7b:c307:0:b0:40e:c180:89fc with SMTP id k7-20020a7bc307000000b0040ec18089fcmr365493wmj.87.1706031771854;
        Tue, 23 Jan 2024 09:42:51 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c4f5600b0040ebf603a89sm2249826wmq.11.2024.01.23.09.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:42:51 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-clk@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi: sun9i-cpus: fix kernel-doc warnings
Date: Tue, 23 Jan 2024 18:42:50 +0100
Message-ID: <4891826.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20240121051845.17603-1-rdunlap@infradead.org>
References: <20240121051845.17603-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dne nedelja, 21. januar 2024 ob 06:18:44 CET je Randy Dunlap napisal(a):
> Move the function description kernel-doc comment to immediately above
> the function implementation, correct the function name in the comment,
> then add a function parameter description to prevent these kernel-doc
> warnings:
>=20
> drivers/clk/sunxi/clk-sun9i-cpus.c:25: warning: expecting prototype for s=
un9i_a80_cpus_clk_setup(). Prototype was for SUN9I_CPUS_MAX_PARENTS() inste=
ad
> clk-sun9i-cpus.c:184: warning: Function parameter or struct member 'node'=
 not described in 'sun9i_a80_cpus_setup'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Emilio L=F3pez <emilio@elopez.com.ar>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



