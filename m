Return-Path: <linux-kernel+bounces-4325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1ED817B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6181C23351
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528E973467;
	Mon, 18 Dec 2023 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqiSaqMG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA0772066;
	Mon, 18 Dec 2023 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e0d1f9fe6so4378400e87.1;
        Mon, 18 Dec 2023 11:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702929371; x=1703534171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNO3jiSu7ic70hh4tyicrSnhqEtgPiAeeapM4Oz5gIE=;
        b=NqiSaqMGloKQxqLPs8WV4ghINoaTPX0j/m2I/tBkxWJ+GRHZ+zgocl2MHJ+k/mkHBW
         Ih6HfFqy80CVu0cxCBcfFDOSMKS2+yOWEMyJMUiwUJ3Ufnc638N0CMbbhPFZvjmY7Hps
         SUqYvsBbEjxG4j6JtKR6sWDNd6xdmt9zEX9ytuwP5L/g4vfXkVxYp0EZZ4iP4zQLmC1J
         SSkb42vGI5ee3vkHnGJDJnQY6SRy0iIb1JBm5RzFOMu86d4ittJf1qsGa+XQTRqcMC6C
         rfI5hCwqd2/Go4NvsMiKQ5jSjNWbpfGEcGjaZHbt8FU5zKh0ImmKLn7Ovq6lw9UTTkhN
         Yjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702929371; x=1703534171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNO3jiSu7ic70hh4tyicrSnhqEtgPiAeeapM4Oz5gIE=;
        b=SsUgRyRRfwWAW8Ataz2faRtICAGUA34x171E+jZS4AIHkAt9MiHYZHGmUEE4b+JAEq
         DpsYy+Iqd7TLiTZj7Km8Kr9P4T0rZy5pT+EToXhTk2Smh8oKlgdFZ4imBRU/SCJ2K/3j
         5WkM3gkaarw8AE64i6MRDix9S1zQ7smhY0iD+NptHrX0Nm2J+hfJY3cW17n2yakvACPc
         eeUksmzpkjg3MfT30Y7aeW4PaTwcV61qdz7MI7Qo9ZrKD2IDARqm/pteAblq/RmfSLiW
         KBK8iGErq7g6YLNLIJciQ24HZ7fCS/mb5NX4yJUUu5PwZQ7RUm5hNGm81o9Nfq6sEi7p
         Kd9A==
X-Gm-Message-State: AOJu0YyejNDLwkLb1ROboxG6XXr1A0FBZBpOF8hs10iJW4ZoZKhSNzXp
	j7mupHveik+MuSq4VGLrtWEuElEQvzA=
X-Google-Smtp-Source: AGHT+IGqqjw8wDeHxgdqEtTKBo2i830o6mNdblTFcEpQVPyBO4j57qkcMzMS3IxB9FnDj6Zou+dADw==
X-Received: by 2002:a05:6512:3344:b0:50d:1e07:5aac with SMTP id y4-20020a056512334400b0050d1e075aacmr8599983lfd.43.1702929370889;
        Mon, 18 Dec 2023 11:56:10 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id h29-20020a0564020e9d00b0054c63cc0469sm10780410eda.33.2023.12.18.11.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:56:10 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-crypto@vger.kernel.org, ovidiu.panait@windriver.com
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
 davem@davemloft.net, Ovidiu Panait <ovidiu.panait@windriver.com>,
 Corentin Labbe <clabbe.montjoie@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 6/7] crypto: sun8i-ce - Use helper to set reqsize
Date: Mon, 18 Dec 2023 20:56:08 +0100
Message-ID: <4532392.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20231218164649.2492465-6-ovidiu.panait@windriver.com>
References:
 <20231218164649.2492465-1-ovidiu.panait@windriver.com>
 <20231218164649.2492465-6-ovidiu.panait@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 18. december 2023 ob 17:46:48 CET je ovidiu.panait@windriver.com napisal(a):
> From: Ovidiu Panait <ovidiu.panait@windriver.com>
> 
> The value of reqsize must only be changed through the helper.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



