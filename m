Return-Path: <linux-kernel+bounces-82724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 657858688B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A711F232CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A405053366;
	Tue, 27 Feb 2024 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fStzRphD"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49D52F6E;
	Tue, 27 Feb 2024 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709012409; cv=none; b=IwO9DPYyy8IbAXigVf+y/uoADTf/YT6BUGIxLhHV4nDi12mfZZlCJmY6mdA0QgpXE/ABTJJ15SnqAmzrikbt4MfXzBetFHt3GiUsWyhMpI+2dHp5KGYlWzm3URCwhL61yedWYrLmSygGPAS+nkbBxXEGVCdaQEHFbSF+IsVwUqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709012409; c=relaxed/simple;
	bh=wn6WyDQ+QCTZgdpTCiohhRqSl5xr6Z1cWOOB+YO2+Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oX158EuBGcAXpl0AlamXgMRZuNl2s+MVG8kKpjjx5xs75PKoVj0WsJMnZYHeUfVdN2G5pK4L3o+65vVg8SjxNKn41+2SN5B4SNPIXXFfIL6ALQ6pLx6ExulBs082g7iQOiZME3NoI2tRpFpycKaI8tuWC8aZSHOdhqk3R9V3kWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fStzRphD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d27184197cso46305001fa.1;
        Mon, 26 Feb 2024 21:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709012405; x=1709617205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wn6WyDQ+QCTZgdpTCiohhRqSl5xr6Z1cWOOB+YO2+Tg=;
        b=fStzRphDrK9m4hBDCRDCWY+TfUYSZ9gcUQRuNNSUKotGnKLZ0CZ33y3tf8ZTxsbfOb
         mAKVDW+Vwg45pjqPMV1VlRYQsBzIhxwOCpXHvJx4mMR36gb7pqeGvIHzVBHZjA9DemNS
         bHyNh3DZFXGq15uFRuYWF/bXHEdUXH+6UWAen91eAauqMUNLz31nrfXbVwCNhmNS73vj
         pfo64H5uvdqyBZo/Yiruf9vD/dOuGZfHwSEjwIsXnFhRNTiguWSRVVlTMAmGeuEg+tEf
         wDNDB/GNY2jmO8XfuOGO6o0L8kSfP9jBKPeFzg5fwWdh6SwkOj9WiGiEAKUlnZ1nyPjX
         8Ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709012405; x=1709617205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wn6WyDQ+QCTZgdpTCiohhRqSl5xr6Z1cWOOB+YO2+Tg=;
        b=sIxEcu8rBVhB1hvMUxJmVA+lk8cTOlqcv+6oLRzf2PIlcTQtbauuUgjDHCXO1qzmf/
         Q0cLUhYlOSRMuvRQGxj2IzIY8rH3ZibETRgKoaM62EoTTjl5JG4bsb6oQCOgKgfeU3Il
         6sTYpl93+EOPKKzmUjgO4ZAn1e4IE9DLgzjBpCfY1ijZbOZMccWI6XxzoI+U7ZiZF9L6
         QKM41MvHea+8wx1n7GcgJLCU0slV3KrXYa/RPJqwOkLR5lIK+RqMJVFJVBWEQGizQew/
         uSm6gkafEy/QCqjURLnUILijP6Y5Z/d0LqOa/RzrbHp4bqBsKZ2VQhttPA/rE5AQnmAc
         e7aw==
X-Forwarded-Encrypted: i=1; AJvYcCVQGhbs7bjjL+PXCTGNLsWO3DRnJcf2i9Zm5B5CKxMJK7+7s+CooVinE2UAlzijuHwG0w30ckxaLkNvgT2OOcZyD3Z/5nkFtMWmMn+Fw1JC2iukhBsqScu2YRG78r7+Nr+NxGWzLK70WstGT35au7Ilo0AGhP4X4Sxx0ym589DUNYAWa9eOySX9cQV/fhL2UpWxfFMfdZ77fetaiY6Yy391vwL9NlTAWnM=
X-Gm-Message-State: AOJu0YzZzzeXUZwXBwBhc525q+rf2bFHAP945tXAECqnFc2H+4WFIXX/
	3gjtkYph7tMqEEz14Vkz5vRyfZQlGW4mafFZw14G0d2ZkQWnYSnvVMZ9j0tUWq3JnavuhTtANGz
	z/sxLN4eGHdG4bgZQ9s3+oNdVd+o=
X-Google-Smtp-Source: AGHT+IF0pISg/Wj307ixj1jIc+wdFd/bWw8aU+wr23F63gviWlDhD8OZ11VV5CnVYmUFM++oaQPOue6gi3xCrgvKYS4=
X-Received: by 2002:a05:651c:1994:b0:2d2:7cb9:8d21 with SMTP id
 bx20-20020a05651c199400b002d27cb98d21mr5775823ljb.16.1709012405155; Mon, 26
 Feb 2024 21:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226055615.79195-1-raihan1999ahamed@gmail.com>
 <20240226195516.174737-1-raihan1999ahamed@gmail.com> <20240226195516.174737-2-raihan1999ahamed@gmail.com>
 <CAL_Jsq+Z5UA1jEJSL0tRSXrC+Juud6ZMXtvR9ne5Cn_-cw9UzA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+Z5UA1jEJSL0tRSXrC+Juud6ZMXtvR9ne5Cn_-cw9UzA@mail.gmail.com>
From: Raihan Ahamed <raihan1999ahamed@gmail.com>
Date: Tue, 27 Feb 2024 11:09:53 +0530
Message-ID: <CANt1HJtm992N-t0uHsU6t+LG+bqW402-1cHnRMj13Si6n4mfqA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: msm8953-lenovo-kuntao: Add
 initial device tree
To: Rob Herring <robh+dt@kernel.org>
Cc: krzysztof.kozlowski+dt@linaro.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I misunderstood the fact. Is it necessary to change the tags
only by sending another version?


On Tue, Feb 27, 2024 at 9:25=E2=80=AFAM Rob Herring <robh+dt@kernel.org> wr=
ote:
>
> On Mon, Feb 26, 2024 at 1:56=E2=80=AFPM Raihan Ahamed
> <raihan1999ahamed@gmail.com> wrote:
> >
> > Lenovo P2 is a handset using the MSM8953 SoC released in 2016
> >
> > Add a device tree with initial support for:
> >
> > - GPIO keys
> > - SDHCI (internal and external storage)
> > - USB Device Mode
> > - WCNSS (WiFi/BT)
> > - Regulators
> >
> > Acked-by: Rob Herring <robh+dt@kernel.org>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> We gave no such tag. I'd suggest you go read what these mean.
>
> Rob

