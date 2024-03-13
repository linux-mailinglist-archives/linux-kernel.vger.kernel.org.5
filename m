Return-Path: <linux-kernel+bounces-102243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC9A87AFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2681C25FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B257C6CC;
	Wed, 13 Mar 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb6Y0o+m"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1361688;
	Wed, 13 Mar 2024 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350069; cv=none; b=EV8+8rJqQibUruSkoDrkKyIhgeDATswBF5h5KfWnVcAqNDPV70LiTrHgJKU0VrsQpP+By9ZWn1Td9y6XlH7hLBJjPoPp9SnBDBvrJrwo2KRH/O64mevQ7d7d9wzYU5v0rzfiUe9yrhXanYA86XK8qsPrZMWAOfzfYl/t01pJbtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350069; c=relaxed/simple;
	bh=2OTaIjGgDXofJxx9Ee7lWxiDlWCxWOuc2nGuNlCC90s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwFZ7yzVZpjXiXFHD5Uued6ozEq4hiqlAUIJpG5Tcy4c85iYsQQFcyz5K6PUz5JQG9Z0JWZBPo6GXumPIif/0LEPbd1ItaNcvAN++62YZsRVpWNCQ4n1MAn1q0wcacFLRgWq7pKWHjcNqo6GCPbc1B0do/fnYWtldY9qr7ElLW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb6Y0o+m; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33e94c12f33so3412006f8f.3;
        Wed, 13 Mar 2024 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710350066; x=1710954866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3lVNzpe3EGPa9RLkujrZt87SIOXgz2iKMU/KVgYcOI=;
        b=kb6Y0o+mCqVBfDIKAuIONwDfExsgNZVY18qFzMEyWRM9hooOJ2AFO69tz1CmEFcS5l
         +LkNxVoa/nBttVlkYsH64nwcQMKJWe/3VIfW+ZZwcGZ4r9h6+nuUvq7EgmG+TMivnEXW
         wqvVD3nJJ9O08Z1Kq/GiEQrjzRTeFnDdbQi6jtE+0xAGy9Sdqv276vFVG5aHyMl0XXeD
         Du/yixRpVvufk4NKbtPeL7MiyDz3f8zLuhVLawNyHgKuI6MVrN3EdqVXRe12y0hUSzF4
         dYxs3cgmY7veXz9fH3F6Fk4dMbAq7uU9KOl4aXmw/j5BQdryYKRiUfzuzmGnS5AmBixs
         cjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710350066; x=1710954866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3lVNzpe3EGPa9RLkujrZt87SIOXgz2iKMU/KVgYcOI=;
        b=S76QCpjSmRzfB2eghdg7elTguokjyct8CwPL7gKyeH3KVYUHVrtHU83eQFWIm7+nZh
         b3Z+hbQll6OqR5CYypZWBDSmVd6LrV7FVfabcVJXc7QhwUer7/CY2mcKFGiqKoWQlWo8
         /OCrpKfXo0gvAZPC6uR3ePM1ZiIyJXnQE71sNIYlQLa/yXFk3Cc+oz06Nglq69nd43SV
         D2h+DFssw59h6IsJklFEAPOeDs8X8Hxahv3xPihUOzTFM9PexANHoPPxpMepTIjlWj7p
         76xkJfw4QGRjSQBIw7pFjH4CibC4F8doXPiq4gpOhGlEM2Y7mmOW4/hngCWB/1yxjN8k
         qJSw==
X-Forwarded-Encrypted: i=1; AJvYcCVGh/aOIibJKD1HJcIlgcgdBM3Vh3yvJ4Oahe6zushYZlqNtFlWt0I59TBHDVrpvygWu58k5rAX/yZl7njeZICJ/u3cnAy405E6+nq3
X-Gm-Message-State: AOJu0YxE/j8wQq3/uy9O1c8MKLKkSiUAz4jR9ltAumjVUxDjgfsMR2XX
	x5oD56N8rYWzCNbua1fHdfqs/SPEUgo/4uqbA8h5KotOLKBC40eOeBl0WnGF
X-Google-Smtp-Source: AGHT+IFVxS4gydSuP1Why/aTVAez1v+HgruO0HqIkhk62OgdvkGZMiY8ntdvY9LKbTc01gQlr8KBrw==
X-Received: by 2002:a5d:5285:0:b0:33e:b719:8bee with SMTP id c5-20020a5d5285000000b0033eb7198beemr1419837wrv.53.1710350066163;
        Wed, 13 Mar 2024 10:14:26 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm8318396wrb.89.2024.03.13.10.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:14:25 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
 Chris Morgan <macromorgan@hotmail.com>, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/4] regulator: axp20x: fix typo-ed identifier
Date: Wed, 13 Mar 2024 18:14:23 +0100
Message-ID: <4901806.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20240310010211.28653-2-andre.przywara@arm.com>
References:
 <20240310010211.28653-1-andre.przywara@arm.com>
 <20240310010211.28653-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 10. marec 2024 ob 02:02:08 CET je Andre Przywara napisal(a):
> The registers to set the X-Powers AXP313 regulators are of course
> "CONTROL" registers, not "CONRTOL" ones.
> 
> Fix the typo in the header file and in its users. No functional change.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



