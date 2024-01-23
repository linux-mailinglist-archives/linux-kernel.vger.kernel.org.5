Return-Path: <linux-kernel+bounces-35799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDED8396BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3482930E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B921D8005C;
	Tue, 23 Jan 2024 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig8dRydk"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20727F7DC;
	Tue, 23 Jan 2024 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031955; cv=none; b=hrOEZmtTXpjCtox32watrILfc0ioFjPbSBzpQfYVIuotJW9XYZ20Yl6dAIaKgfiMdvML2TI4IDKszb/Qx7N3Hgn/z3m4KZcZfJo/Pye2wTDH7cXLB8IwZ+Tt7O8is6SJRKc0qrAjEEnCPSfdRLbVxiMo5glVxvjLN+ijp7qROYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031955; c=relaxed/simple;
	bh=ZXc8X08+C4aO2O5jlqzBh0CEREPFaIm/XJ9W8jBxH/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYbXGodI97Goe9xMBgiYLbid8PwujS/b5BhpQebUJzexjPoBVWsa9cmlkJ6am+sKlPkKyDV182Ba2+pH2NoBqkKz38I0VGD6d/8mks94ORG21JgXySJJf6NXYQ0zp7v8mWbmea6H3Aa1hNZksHDrxTTs4FHgVN41TFWGVGNWMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig8dRydk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ea5653f6bso43043315e9.3;
        Tue, 23 Jan 2024 09:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706031952; x=1706636752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/6uOVc6gr+0+h5k4oBTqEhdhyiqp0MSyJeHam6ErFM=;
        b=ig8dRydkYO+Ih/OP7T1RTVfYIv4vjovc7OCVC35Ja9KiBreL+qZ11OGoMoLHC9fBDn
         gdRxn1z5MLVOuoWsCY5q66/aTzW+zufh/frq9gGwL7HkhIa6tdnhUOuprQn1l6Karv8V
         0+7gGSxGU+oQE+YHlxts4KqmRCHZHyPft9II0xgQCdV8QsBrjO5VtjFDcmhuz6Qkp3ZG
         2nYZdUr2966wg0m7ZQ9UwWgqDEFA8ixOH+Uew/YrUlf/9/C5J7oyftjdeeLk9KvnOe8Y
         PcJi12DEmo1K8IdroE/tIZPCTFJ5zU0z3njEZCfqtvhBfKrcXFP1tL8ykcoLnvlcz8bQ
         ModA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031952; x=1706636752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/6uOVc6gr+0+h5k4oBTqEhdhyiqp0MSyJeHam6ErFM=;
        b=xBEW2koPAgM3pn4CwHot0QA8WMJlMIBogv+8TDEjnQ+s9d8DeXWK0pQDOXPAxZPEKX
         vQbj+IbsSxWhxbfGYf60x+Uwhy/I5cP+byQGG1o8MahdRdokIK2E2HTM1FJXsj8/BvYq
         wkA1PHEhf3nNfRd4mjiur8sdgDPYJ/ryWzU2Z9U1mHLemYRO2LC2oyjk+KF0QjVBSIic
         hkd55aXxS5EGb6uZoenYCRbOCjvUJw2yWJyycRnuQWqdRtxjx8a9DNnLfuQl3moHVsYX
         20Vriza6qVKtHMIXedNqfV9HU8v0/PvEwGmfo8J9y+f4iYQlCSCx8mVgYv3fBVOcC9jy
         yJ8Q==
X-Gm-Message-State: AOJu0YzwJXV6966JR+08VvQ4RbJqOPLKZd97y0GgNQFERJuXUgDVn9Uh
	kbg9igsI/pThp/ii0ZH7Lkgzc1IS5SbLiyhPt3XTjuhEBxQh6Mg2RkGe5IVF
X-Google-Smtp-Source: AGHT+IFuZXYplWtmBlDewf9kxG9wih9uIsbolfMZHUhnH9YUI7jgKgcARlDQEFRaRcWgximZQPznuw==
X-Received: by 2002:a05:600c:54e3:b0:40d:877d:ca9 with SMTP id jb3-20020a05600c54e300b0040d877d0ca9mr365916wmb.104.1706031951673;
        Tue, 23 Jan 2024 09:45:51 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id w15-20020adfec4f000000b00338a3325331sm11936004wrn.69.2024.01.23.09.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:45:51 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject:
 Re: [PATCH] dt-bindings: sram: narrow regex for unit address to hex numbers
Date: Tue, 23 Jan 2024 18:45:49 +0100
Message-ID: <13436805.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20240123083450.20996-1-krzysztof.kozlowski@linaro.org>
References: <20240123083450.20996-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne torek, 23. januar 2024 ob 09:34:50 CET je Krzysztof Kozlowski napisal(a):
> Regular expression used to match the unit address part should not allow
> non-hex numbers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej




