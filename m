Return-Path: <linux-kernel+bounces-1427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758BF814EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73061C240DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DE782EEA;
	Fri, 15 Dec 2023 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PiKYYiJA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95582EDB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cc47f1e829so11257151fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702661691; x=1703266491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/HoRgK92BjH7QovcEi8cDDtZyMd0kZkc2fCOkf2P1E=;
        b=PiKYYiJAZ9u2GHXOzY9FlvBxLhU4Ip8yQ6ARfsWefCCgU3Ja+vOaAJGG4KFYiyLugX
         eRJQ7obsIcdVDajKeJigv9kiaA49kF3SpU1OhZWMw1s4EaptumI2QWaXNJDtnIpDyeta
         owwBzxvZUhRB35UtCrzaVMzqpYco3AikTi2kw2thhf30l5s6LZ/WS9yq/SQt9uyqVVC3
         W+wV5wO3uDfBpYYEiLEdMHGprRo/JRXd5kh77M/NzCWvI2pj4NGHmGQCzrU0WCO33PqN
         nSM6YBZsxLRPMK0nJJZAK27SCBHBjZaQBzRuWT58pb7/NaVJqomz8Xqhc017i5ll1JnA
         5VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702661691; x=1703266491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/HoRgK92BjH7QovcEi8cDDtZyMd0kZkc2fCOkf2P1E=;
        b=d5+g3VTO3X+4GtnvPIsPmxqBKouOjgztQrwZd3mccqOiGp/q1F7q0bGtPIchpVINKd
         +FSneQvViF0ZDsMf8IgD03RbGTTXXOQxMM6eO1S7XObbN3wpSk/dMaWyknVH/4jpzcM0
         LsdpKt4diGzkuV4jgroJpcLyTiEp6svf0bPI51HxYk9Kk8+DaSePli73VOdOtCS6pLkS
         NbeIhVudyKpf1MVEOTBVdApwZD9/pCFHr+alLYN/Drdgrhhml1QC3utq9wILU+9C7n2l
         quHzJCY245R5yYL62DuAL24278qfsWxvq4vaogl/2hvWKPxnroI3Ql3X/WrDmUVmEMKs
         0mzg==
X-Gm-Message-State: AOJu0YyjDLsdcJwC2QdeF2Ws0Hi7daSsn7+zDWkCga7aFwfoPV4sRBiF
	8ua3KRI3ga2E5uqy1bD/w5BLggvWDwpd6+doiiRaqg==
X-Google-Smtp-Source: AGHT+IESHbjGVQ8M8Os54q2PL2fQP0wlu9xEjVWVTRt1ow4s8PhgawTd1HW3ldYOsfIs8ww2VSHVrd2vMhjQrD4K/gE=
X-Received: by 2002:a2e:87d3:0:b0:2ca:246:752c with SMTP id
 v19-20020a2e87d3000000b002ca0246752cmr5759961ljj.70.1702661691479; Fri, 15
 Dec 2023 09:34:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
 <20231215-ad7380-mainline-v3-3-7a11ebf642b9@baylibre.com> <66e9fe7a-927b-465f-aafe-8aea0e5998a4@wanadoo.fr>
 <CAMknhBEPxYtZps2cFk0ZPckbcHenXJ_v4Dv+82ENg47J52gHxQ@mail.gmail.com>
In-Reply-To: <CAMknhBEPxYtZps2cFk0ZPckbcHenXJ_v4Dv+82ENg47J52gHxQ@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Dec 2023 18:34:40 +0100
Message-ID: <CAMknhBG_4JR+OhBU7WPCrS0OPb7c_jebM4AhrkPNvzfOmQ4TvA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: adc: ad7380: new driver for AD7380 ADCs
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com, 
	robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 6:31=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
> it only an int and not the pointer to the regulator.

I missed a word, so just it case it wasn't clear:

it only *returns* an int and not the pointer to the regulator.

