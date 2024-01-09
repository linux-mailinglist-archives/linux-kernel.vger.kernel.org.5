Return-Path: <linux-kernel+bounces-21383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B25828E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7447228643A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E863D961;
	Tue,  9 Jan 2024 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myH0n18e"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE773D541
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so3184975f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 12:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704831354; x=1705436154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQBuQHYjeBWmqCwTGH4YkN69mVB+VC/t7tF3wqgLXWM=;
        b=myH0n18eAKxpvut3gHEp6WZXm051QjYL3F2Jh+U5T927OjliOIBAQUrhbeuRdUYXTA
         NM+hMAx2WNQyq4YvRuguOxmZHCLHsygpxqI8gGPkvSddKVPOlX7Q/rxZx+Q3D+Ruc3au
         Smes7WOUo44lEdL3vmDxpPx4kgSOV+9wUCTwTeKt7S6WB8W4IYXgBvn4jV6rTmxvNV6S
         RqUZKKC2KXulnIyZI3TpN/knNjAleYU49nqClQVZQ6AmeY9KlX57T0toPtq5SD1go7Rj
         Qxn5NEpvYJfDAyzoTMYiG6xKvlJgsYJ8O9OOjLjzoVhuoU/udCoSgyn3TJPKeynNDkOW
         0oAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704831354; x=1705436154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQBuQHYjeBWmqCwTGH4YkN69mVB+VC/t7tF3wqgLXWM=;
        b=VgITvplmviq96YliP+Z9E5vzB91SNZKDbgEZd3THi4ox1mGjdDay4VTa4hGxM1Dv1t
         dDFspcGx57FDPQdtJAKPBcWqzW5sDVD522G6g0B0uEKlQ5EpAJT/nIUOFyCTkzh6mO4q
         x5HvXrliHhPz2LcFC8J831+1v+XUtDI0En2vmPNrd9C030B6K9DvkphzGzq3zwoGP+vC
         edFvuVYPwuZI7SBuoGsL8cqKF+LzbH5avxg5rSNoXu0FOPPM3BY3xlZLXwu96OiNxu5y
         /WnAuW2BxCES1Yz+t9L4j68UZ+M2yU3lxsfi83vqJs6ROHW+0K3ci9F4YIIl6a5Gg3mi
         qr+A==
X-Gm-Message-State: AOJu0YwrdxbxctjchYFtcSW5ZpdN6ptJ4sJBdEsNwp7ARAR6Req03PJe
	XakCPTc2CG6pWFPhw7NFBUg=
X-Google-Smtp-Source: AGHT+IE4R7zgERsrbs9fWbJ69vzmnx8iBlzpLeYPnFGrt0JnjOw8UGQcz7XjE6871uIgRVOA/YyG7Q==
X-Received: by 2002:a05:6000:543:b0:336:ec62:ea8b with SMTP id b3-20020a056000054300b00336ec62ea8bmr841769wrf.63.1704831354380;
        Tue, 09 Jan 2024 12:15:54 -0800 (PST)
Received: from jernej-laptop.localnet (213-161-3-116.dynamic.telemach.net. [213.161.3.116])
        by smtp.gmail.com with ESMTPSA id cr8-20020a05600004e800b00336673a4153sm3191685wrb.80.2024.01.09.12.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 12:15:54 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
 Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject:
 Re: [PATCH 10/12] mailbox: sun6i-msgbox: Convert to platform remove callback
 returning void
Date: Tue, 09 Jan 2024 21:15:52 +0100
Message-ID: <3783111.kQq0lBPeGt@jernej-laptop>
In-Reply-To:
 <2db7ef94aa35587980697405ec373e0b7bb70466.1703710628.git.u.kleine-koenig@pengutronix.de>
References:
 <cover.1703710628.git.u.kleine-koenig@pengutronix.de>
 <2db7ef94aa35587980697405ec373e0b7bb70466.1703710628.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dne sreda, 27. december 2023 ob 22:02:38 CET je Uwe Kleine-K=F6nig napisal(=
a):
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



