Return-Path: <linux-kernel+bounces-55219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C93A84B943
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0B91F23586
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41EA13C1CE;
	Tue,  6 Feb 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KjThfL3J"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B2134CCB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232425; cv=none; b=Tb1IvhzxUV0y3eYdt+Wdj6y9qJjLXJVwySrbF/DOZwSU6/pq23g6u7Lz/F+eFA1L4XkhMfBnjB9vA/hNdOjdWfUFqEbmG0lWgW4ceAvTThIPIym6Po/3WYpSY5snQEwGU2plq9aLMaI3xFtOQZLxed1Gfaes8w+hCw3ghZgUK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232425; c=relaxed/simple;
	bh=S1P4AA6+64Bnd4QfzMrO9Q/Ly6SEZfMLPjm0EVLdqkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQRxTjNX9YD9JIm7P5/kVYRMZXMQFx3pGwSQeMUcm6llZHdE8UlRXBuR/ZflXu5nd8MySjyxFu6I4ul1HY2HUrvMhKQ8v1e1U/xwBHviOlhLEYKWJu5Dw7s5dH4fDTDZz4ZoSFFE+dzbtv85LvxwtoI1SNvdgP0cnLMNB9n2UG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KjThfL3J; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0b4ea773eso21720421fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707232421; x=1707837221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWyaCH5kvW4ESs4M9KfJgiCk+SaUNMNInQ13HAztrpU=;
        b=KjThfL3JcCjpSmcmcsVWRcB3t9dDMEjYUWS07u2kTtTaG1qGq+xJ/dR0eJhIN/9USw
         R3aTJwlyhoM1v7YXferAPcWXm/ZMw2hyW8fwM6mXvfQ2zD4L1h1wu6dPtlEoEO9WpZMb
         vKaWjyRMMnIQAdi4DSIzUeuiBty2igaJHajqZQH+g4hLQ6nyjsj9oIGXx2HP6zPsR99G
         AfBnY5jENU/M312ANShyjoy02Cg0XJZFVSdbkYeSD6JrBSOFLqV8jurV2/StHvv1RWPD
         VmE5mGFBTJ4fj7ZY/+AefzDTiaN71KbTRgNjovU4c9k3iTv99CDJOO1DpwX1V9Mdxbce
         1ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232421; x=1707837221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWyaCH5kvW4ESs4M9KfJgiCk+SaUNMNInQ13HAztrpU=;
        b=QWUBvK41fBazGD3RVUODbT2lBOktCvjXfg/pB0giLLbTBK8L58QfWmBxfkR7lvQvtA
         b/OrSUBJLRi/6geP/0oOnGdy5I7w/2XHyPmJTxGA2OVgabKsuQBertae3RVe7DNQJGPP
         G3pa16u+WeMz4+Ar4QNNACpO8yBw72ZB+JZbn/JZaFmVCTeu1i78DdptNlvFVBCx/mRA
         wb+DUqZY95/biI1wlXDgD/eBFVVeI+RVF+BtIbk6d1AZDjrdWz4cbnPPBj3tx4tIR9kd
         /Ze/JHo50uVsHt5eAB77IBeBwTi9GlFwvlPCqULKsUOdDbUyWXmit5XkoLBka/+BLY/B
         E/hA==
X-Gm-Message-State: AOJu0YyLP3TewJyt+nAWOBRHJx0ZtvGfh7zNYL7eWFkYngeRDpPd/UVv
	lVBcM3s1hwB7gJrfN4RZDXwyTtHl2eFm31BrVQzKB5ISENQXK76Q0MyarXQKiac=
X-Google-Smtp-Source: AGHT+IGixMnuJqGSOO1at9tSdlKV/uRXYeSHD7PzB5wvq+D88CIqZTbaqBdLuk5ykQQYRj9lYwj2oA==
X-Received: by 2002:a2e:911a:0:b0:2d0:94b8:72f6 with SMTP id m26-20020a2e911a000000b002d094b872f6mr1876981ljg.20.1707232420922;
        Tue, 06 Feb 2024 07:13:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWGUn9bDa/+cXpeDv22Bt5ksTKulOOn/dRxfCkNbPExvTOQ8/mbXtrpu7RRJZQHOjOXTlIM8+OEfU39pP0pdAIzfjNpdv3YOY6yhEe2++JI0Dx6STaNnH6EGMU2WZ6EpsX4e4JB5SXR3KzONHQfNt+IMQdI5zBMc5ssut3RJrb3jyiiDigMR7R+JW1iO2JXcwOw0e8a5QEI1d62NQqoN2rf9iJ7ftIsdZPxfsvHwDbREBQu0VCSUGL6h7m0A42MMmpKwontEOqmfvpHMRalFUFTYCQqxVseL+FkyQMl+4elp1rygVUk3j8yKETORIUp/cvJy92eTEsoSOtyj7MWyo8wN91AUX0p6/un/ouuxSlSWLnU1J5vWYPS+WiESocvAKoVuGF8shbNicLltg+Xw0gRolHIFHi2rSRkjQ==
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id p3-20020a05640243c300b0055c60ba9640sm1113733edc.77.2024.02.06.07.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 07:13:40 -0800 (PST)
Message-ID: <2d97df42-1d23-456e-9f0f-36b8aef08670@baylibre.com>
Date: Tue, 6 Feb 2024 16:13:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] drm/mediatek: dsi: Register DSI host after
 acquiring clocks and PHY
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: fshao@chromium.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
 <20240206120748.136610-7-angelogioacchino.delregno@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240206120748.136610-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/02/2024 13:07, AngeloGioacchino Del Regno wrote:
> Registering the dsi host with its ops before getting dsi->regs is
> simply wrong: even though there's nothing (for now) asynchronously
> calling those ops before the end of the probe function, installing
> ops that are using iospace(s) and clocks before even initializing
> those is too fragile.
> 
> Register the DSI host after getting clocks, iospace and PHY.
> This wil also allow to simplify the error paths in a later commit.
wil => will

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

