Return-Path: <linux-kernel+bounces-42989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3C68409C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06617B226DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCF9153BC9;
	Mon, 29 Jan 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXj1JtCo"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47177153501
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541693; cv=none; b=F/eusYQh4sqlXe3eOjs8PkhI+TJChx7yoXy9D8rxJt64/DcczKmZMMrzWWiV87lLrZq61pv5Ip8X/PE7V5udacgTmlFFz6EGtK6lZgqbTPNVPifNgdCGtrZ91Iff191PEf4du+RwAYpSuII7nQlKrjgft+35OdbUWRNG01m74XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541693; c=relaxed/simple;
	bh=Yr0Gg4ZN/YTqeJCocAlPACN9hbFoJwEV8sIIfBm2+J4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IXJMdxqNrSQhiCKndSnRZ/Rh6k4ca9+22E/h9dA/ItPpOgq3LplaAEcv62kPJkKuev7O3sGRBIj+8+Tvf4GO04zFEIjnI9KGhl5h2cyIhQjhL2KKoSe3ZI3suEbazNMae4JI5oMguuTEgKocWzCVVvZiUj3m3jmtdNma+Pyd8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bXj1JtCo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ef6bbb61fso9273685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706541689; x=1707146489; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yr0Gg4ZN/YTqeJCocAlPACN9hbFoJwEV8sIIfBm2+J4=;
        b=bXj1JtCo5s7PaXpwN4+jpM+ZiLDjwecA6GlOFZcMlf+wpvIPFyUN8S5PYvkVXgAyT5
         l+TCKCm6cqpp/wDIwvIwUipDOc9i3gj0a2JM4O8U1p8ajIQyyxcVWYH9IJ/GSk5ue4TH
         yCh1rNkwoVLmMi/AyWU7hHEBtUVR754ka+NLpopnasDq4eH1X1J5Z7OgMxdq2xEpxI7z
         KD5toaCV6O5qm+9VRyuEKETOwRcUXvtXfr+Yl9ry9mJjCN/2Pz3PAglBUk9dN3+Pz5Oj
         /EdPpgiBNdFPGSlCb7BZp2Hdzfy8hRVG5Tl8fR5xpQ7/NpQwd6QlTl++f7pKL1VSVUqn
         euMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706541689; x=1707146489;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yr0Gg4ZN/YTqeJCocAlPACN9hbFoJwEV8sIIfBm2+J4=;
        b=PNgFhHBQmC/cdRfdvoBhm5qxczRVavXAgCej5RiNUZT0s3jes04jaJ5gM2EQq+UyRB
         81dUOni2SjR0Kq1/lAiXmIMTgxlLLi2BCclvMBuw5Q9Sc6q1fFjzfiNVn98rDS1D1NKi
         h7W3Wvh/F7OoNUwx3gvgZ7PLmi0eJB8AbY8UMlsLp5Hq+qSEr4oMXwv+A9frXt7WbKAo
         C1iUD076JvGur7AnT8sUGFAMTr0b8X+2K+UoR0RScsboXRN0o4duQDdfZL4aJlohs9CI
         frZZFR3/oBgEe5at+Q/XPGsPdQaPErD3/DdTZKjwQin5QYfd/Z0WLxJbCu2JosL9eM6Z
         uViA==
X-Gm-Message-State: AOJu0YwoncZRfUnCwtZ4cUGag2RYYKP3/6xX9RIcrp6YwXT3TYqMyE+4
	bhypqu/oVMb0Uv1QUZVy0tZVGWhECRzWmu+Gi10lBPw3o/g7kFdR0Lf9RGYjWIc=
X-Google-Smtp-Source: AGHT+IEzoijVfCt8+qN2nuTGFrXrZs1WqIXWOvTgI1LDfM1lPD/GKTa3xJcudrDqJxoujcPKnOcl1w==
X-Received: by 2002:a05:600c:4d96:b0:40e:d319:4792 with SMTP id v22-20020a05600c4d9600b0040ed3194792mr4646562wmp.22.1706541689549;
        Mon, 29 Jan 2024 07:21:29 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id bw11-20020a0560001f8b00b00337af95c1d2sm1257849wrb.14.2024.01.29.07.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:21:28 -0800 (PST)
Message-ID: <7537f9d4c49a5f3891dba4a8f68ee7332f045cc5.camel@linaro.org>
Subject: Re: [PATCH 9/9] clk: samsung: gs101: don't CLK_IGNORE_UNUSED
 peric1_sysreg clock
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
 tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org,  alim.akhtar@samsung.com,
 s.nawrocki@samsung.com, tomasz.figa@gmail.com,  cw00.choi@samsung.com,
 linux-arm-kernel@lists.infradead.org,  linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org,  devicetree@vger.kernel.org
Date: Mon, 29 Jan 2024 15:21:27 +0000
In-Reply-To: <e845e0fa-846c-4f26-9d8c-79eccae72cc2@linaro.org>
References: <20240127001926.495769-1-andre.draszik@linaro.org>
	 <20240127001926.495769-10-andre.draszik@linaro.org>
	 <74b63fd9-bf7a-4a88-bfa9-a975a4f12bca@linaro.org>
	 <7d42f80acf7c8bd3882f5ac253a761c71de2034c.camel@linaro.org>
	 <e845e0fa-846c-4f26-9d8c-79eccae72cc2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-29 at 15:08 +0100, Krzysztof Kozlowski wrote:
> For this case #9 must be squashed with #3. #4 with #9.

Will do as you suggest, Krzysztof (I think you meant #4 with #8).

Thanks for your patience.


Cheers,
Andre'


