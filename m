Return-Path: <linux-kernel+bounces-127023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BF48945F0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC21CB216F4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB04353E1E;
	Mon,  1 Apr 2024 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vAp1fWyI"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A602E410
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712002981; cv=none; b=K+xpn1bbmDgt/oHMXkaukH8gHHcwsK7AQhU9NOOmfaLx3s8INdER/OvbeX4Hys/I5P0KxMcE/79p5dfXcg8MIvY192iTEedfi3x9ysaRPy8TWiCuZFpEUzzWicHyReHavwOTdrN5ocfxlct0h5Jj/c8SvgW6lcmhe8vg1FLe/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712002981; c=relaxed/simple;
	bh=pTckc76jra1p4YfT6sJans2kodnxohGel0d8lmhfhBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9zl3YgzozrULNiAaGyk+x+5dX+vOwhZcs6vpomHYiduQO5VlTFCm9mkdNRQAqylDzWvPr+NWme0BYO6qWrpOCyQKudaPhE7K3677/UN4Z0YIrZL0wojiLvat53U6IRduz8dBDqhozLNzouiqpOIRosOPVdgtkn2GUvxNDmMkQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vAp1fWyI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d6eedf3e99so49219301fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712002976; x=1712607776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+Pkd+pnNIvLV4XvYMElmbyvB9teJQxJ5a1nWqDqW8Q=;
        b=vAp1fWyI/gOTbTUSXojvuj392O3Oj+iDzb+Sn2U6OZ7Wgih7SnS2qTSTi+xHcsT7VO
         uiSRsHO4D5eFaCWGiHctc+xOox+5IW0RWbuPL8Q8WF3KlntF9lRY9EGy/c6y/xWMFGTN
         dPwlCSIrC1Ux9sX2xTUHW+9+2on6Dh+xGtPNIoG58DYuRFz4H6VZnOlZevtvTv5Bsiwm
         xW8v2aEYueDbo1F6qz4ODckGtNn1Rj32Lt2Qjydwoa4EBLxXG64lulYEYhi/LGtIAnON
         okqx4ZpdwJCxBQpoxXobMI3Aq9q9KA9YHweasxdGBgY51bnpMXKcLCT8UF+TJGNR0QpA
         Cy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712002976; x=1712607776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+Pkd+pnNIvLV4XvYMElmbyvB9teJQxJ5a1nWqDqW8Q=;
        b=YFH/H86FlBTUYQI3ogpVuhpvxvG/Ck8PvbldVu5ecQnG8ugI7DTjN2c/cyb7A512Ro
         jWfheC9ktpET715wBf/Z9MRHY936HULqnq1RG7RwVzcA7xNQA2R7PKgq9zeRdUpLYJfT
         L030Ckj2tRFh6UGQ5OfpSuc+7rjfOtWrv1dAJLciW3/m8KuWhteriFVh7GfqGNLknHi4
         lvQXfd/hML8s0kuhw2KIJK0HstFBzmucoC7IoK1ZBPLvO6OXuFMAa8vRjSkvrVxNQMZF
         CGBTI5zOd4pb9N27ovMYtAzDOtD5+twnMZdKuSSNERYO8MwN0jZk507z7iRjukFCfnYH
         +S7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUQ5+Yc7ezIi5AKh8PsW3T0/yibu06aYWhRlk5XB4Q4+ff+jrpEkkcBhjyH/NmzSjPB13Nc7iOLTf77XfqHDOYqwL0FnUW7uTl1jaG
X-Gm-Message-State: AOJu0YxWR9imPk+iZAbOPzYoRtE2eCE/JuDnAz1vKHPqEslgSVY0infl
	iznEVJqhkG3Hv74YRbHEGdzypoLo43sxZy+MEUBYbU3Ph1vmorxaMdNGzDDYdIltWdK+nzARMlo
	TlSC4DOOclwHw7csGfAk1Cz9m+Mm7fhAhRAkyXQ==
X-Google-Smtp-Source: AGHT+IGpR6Km9u/y6Bv8P1q5AaUH2Lop+WAEOA9Qu4pIhLyEUSPoVij1RwxOm/lV5viXWbxn3z6viFJzlC5mFlWzPkk=
X-Received: by 2002:a2e:8899:0:b0:2d6:fdf0:24a1 with SMTP id
 k25-20020a2e8899000000b002d6fdf024a1mr4566384lji.18.1712002975886; Mon, 01
 Apr 2024 13:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-1-34618a9cc502@analog.com>
 <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
In-Reply-To: <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 1 Apr 2024 15:22:44 -0500
Message-ID: <CAMknhBGJt1TG0-UXMqqCT6nxJKAX7ZbsPF19eeWqwKsXbKOQoQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 2:37=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >
> > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >
> > Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
> >
> > AD411x family ADCs support a VCOM pin, dedicated for single-ended usage=
.
> > AD4111/AD4112 support current channels, usage is implemented by
> >  specifying channel reg values bigger than 15.
> >
> > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 59 ++++++++++++++=
+++++++-
> >  1 file changed, 57 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > index ea6cfcd0aff4..bba2de0a52f3 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml

Also, I just noticed that AD411x have only one AVDD input instead of
AVDD1 and AVDD2. So we need an if statement that says if properties:
compatible: enum: - adi,ad411x, then properties: avdd2-supply: false.

