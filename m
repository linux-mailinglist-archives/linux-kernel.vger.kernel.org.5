Return-Path: <linux-kernel+bounces-53169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C07284A1A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1701B284D90
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323B347F41;
	Mon,  5 Feb 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4HDs8Xi"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0D2482C8;
	Mon,  5 Feb 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155881; cv=none; b=UjjqlgSUTw8phNLSK9TzwSOTYR+vzKMf7hTBKR5NPzuQw3MtJY6mRCWyhkxdcbb4L488r0aMwIXZe3+cwgkh8ed0ZxIYDtnRJMDiiTfE6vG38qlXmA2eSvq8YlQjGTrCVHnAkdCNck9o8qNOX+uufkexYjaNHqk/WDPugfGBzEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155881; c=relaxed/simple;
	bh=lWrSbc8jUA99N/jOBUbCzu+w8Kzz0sAL1zOSR3c7zHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVglLpbInJEOJjtJTD5T42oqFXhP/n005oPklsN/ACoHgDDIxsfzpWyj7L32vVoE7ECn2M4SuDzPsUo8ntuQsXS9v0n8jBgNV5vX4BPn+zql1eF8IcKxoVMzH2ALJ9I9YrT7AiL+aG2isNd4nOdE15Q3oo55TjgfCXjiqp62E0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4HDs8Xi; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5114b1e8819so2185749e87.1;
        Mon, 05 Feb 2024 09:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707155878; x=1707760678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i34tZ3FFPbhGf8aLiNBH7cN2Fd7/KOwTUUwg6OHr+K8=;
        b=c4HDs8XiehDUboC5zLwUFy+CoNQQ2jCtNQLybAOnaH38/VqIPHi36c61wqBfRmBfJR
         SOwfef+PntmZhXqNc8PPaLFT767u5QtuN02ZKkVs3Dro8sxU7a2V2LdyYyNFTRFjbR0i
         a1U/MyErKLMIB4LE7KnviQqPI02Azh9rMp2ho9z9vzvUtqYL3paD8lQGE+Vw+4GFdz/j
         0jCJdNQKiSxnQc+Wsxy01p6EbpH+iVI54aOBDz70FR6yqVAN/EgJcnpPpD7P8tY238DB
         8mr3GTaq1mpiWosIEsRdFdSFkMsjMk63ArXhimmPhVILCNMQuWBVNdWUTwjl49GLEZp9
         VojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155878; x=1707760678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i34tZ3FFPbhGf8aLiNBH7cN2Fd7/KOwTUUwg6OHr+K8=;
        b=iSAX/ybTzlghbxXc0wuKUrbTrKQZCRkKmCYaL9KjbWbsx8iCVKgSOTVkZ4ai0FuysT
         ZRujfBnC14A3oPHceZ36LaMqev+INSKWee8pQW6MlT0TcZS7DcOigA881zSM2uOf6YBf
         FhTiCpQgXsYwWcd7TpZorowwI9RSOqNzOOJBzL/o1RFNWoV5ICtb44rwttJHZGO2ClSU
         TxcsJIObCxFgsEMyh5Xykkz4Bkn9Db/2n4dMwJD9mKXDR24lUrrWQK38OMuNz01HXWqv
         du0XAsMVaxIbSdRq9ISiWw1qY8rsc9ji1MSfLAbO2e27N9tZc46spQWCpL+jnRP9AFm0
         vNjQ==
X-Gm-Message-State: AOJu0YxRRzVPn+1N+Jlrh4WnXgUuf4ZoQLZFUnOEnW5XiKIygkysMnrM
	yvsJWbxap7cYpdq1A8vjOCbJHxPOAcxPuPxY9B7rbLjOEkX+8EO9
X-Google-Smtp-Source: AGHT+IGoPOkUhCufoS6lCIs5EGArZvJVv922FEUcsxMUGIhQXY+AjR81U8jTSaoj3gJj/4rMS1O5tw==
X-Received: by 2002:a19:6451:0:b0:511:49d9:fedf with SMTP id b17-20020a196451000000b0051149d9fedfmr251422lfj.13.1707155877476;
        Mon, 05 Feb 2024 09:57:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGCK7tf1Ptyz6HmhmmygivSkZttogyHu1TyMDdDQ5Nu8eevB8TjC9ST/lb4I2sK2ORVanShf4tAR8h+88kfXIXB7IedBlO6CdVJTs9VbezYULqUYzMQt5n4PD4A7MsN3Fa6KsCPQMzz9tMOhlKZaFekVgW2wlECNYyCRFLwrInpCrUXkvaHKm4LFzTyVyCbG0d2ApzCkMTk6XK7sYwpllH0iRhxhGVmDxPcrozhyj+VvHLb2WyR1qXuMV+bGFM6firFlILkD9zesHbMrG/b0/FeqSifxG/2UYuX3eqPZyNyY90Z5srLZC9V0BD458p2oUE4snRo9BRj2qVKksVB0/R/+RqIxOaDUlxURN2rmXd4OQFyYsWU2ZL0/bYZjT0GUf9Kk0oJ9UPSfP7o95qiTDOACza5f7mc0cJ0ebko6KKCNkUXGzptbKQ+T92kFH6XPZVVPoUAUj99fRlwAkflkqraPD5kuIcOfX32YJ+mkpFeFoY2DreE6/cfq5hRo/vnZoL8kKsOsixux4ip8p8YeK5cf8afv/p1dRllJ6p9KDBLNdamy7kdAXdrCzXlbZt8dGcPhVkMhh4mBoKnuBkRpw0jX+zV7GRhwtJ53lU9VEle4navhVDjF5Y/rtrNu9e0D9YDMKCccO0bBinK68q2A2Wjw/1070BcyyM2pxBRuh3FTqYMQLcao7vo/yCuCzj9aphfjcEi531FnGXoEdnC0ecyojAG7cIn86l1Jfb3K1Z+eHwE2U10AT7QPWlZHFxrhV90LswemmmJg==
Received: from jernej-laptop.localnet (82-149-13-182.dynamic.telemach.net. [82.149.13.182])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b0040fccf7e8easm9068610wmq.36.2024.02.05.09.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:57:57 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Oltmanns <frank@oltmanns.dev>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Frank Oltmanns <frank@oltmanns.dev>
Subject:
 Re: [PATCH v2 4/6] clk: sunxi-ng: a64: Set minimum and maximum rate for
 PLL-MIPI
Date: Mon, 05 Feb 2024 18:57:55 +0100
Message-ID: <1877423.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20240205-pinephone-pll-fixes-v2-4-96a46a2d8c9b@oltmanns.dev>
References:
 <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-4-96a46a2d8c9b@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 05. februar 2024 ob 16:22:27 CET je Frank Oltmanns napisal(a):
> Set the minimum and maximum rate of Allwinner A64's PLL-MIPI according
> to the Allwinner User Manual.
> 
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej




