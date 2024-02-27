Return-Path: <linux-kernel+bounces-83599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFDD869C17
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247C31F22189
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD31487D5;
	Tue, 27 Feb 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAj5g07b"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E57145321;
	Tue, 27 Feb 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051291; cv=none; b=NRu4t4KpM5sY3kdaDGPVbjv3MBZHvg9r0jFFW7NasQjJ9RxO09UVhICrWhtcBntgQrKMXRMuxalTKEeToxPiN/quvrDYwenH8zHG5mFupP0TOZXtiC/Us29dxRyEfunggWxLGmOy+qW1EzzPf40GYWlZ8RxOv3Ggp/h4D+W1tmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051291; c=relaxed/simple;
	bh=gxRtFtSYjnlTrJJn3q7eEW0xJvelWZEgyZ88iY2xwfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQM3XyKXrJC3JyoFZi/x7bFmJ3FEeYEghd7MeLibxZj+ozJrLHledjCR7reLxunMIEc4XiCRwIhLdA65RxwcEU6irCDqY1qLjeVIc8H9m5cCmqk2uuN2JdyQ9VE3QfsT6cDieFtZY+yTcxYW53diNyVgPEF809+rCZGQMX8QsEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAj5g07b; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so5246451a12.0;
        Tue, 27 Feb 2024 08:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709051288; x=1709656088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0dTpHR1K23pB61bzvysNHvrksQiS977Ao80yDg/2EM=;
        b=VAj5g07bYTxruMJ1tS1EuN4sc1+h9xFPBX1J4SW9aerhhTbeBp6dXglHlYZ4Y7jcev
         lQb72QQfTYqDCzKIidma5Wi/KLPiiuUwEgcIHVPiPzQA6Y2N5t0VfEArQ+Y+/ihwr+3b
         LqUqfmVCAGNDG7kF2Mj/a7y9DbragoOU5jzeFg395CEa9Oj1Qi7JzUDpvu2hhqPUq2UX
         QvwKgjK2WrHr3Nxd9+DzTKsCY+Gzuav65q7y47La0r53+gBTHo/EWjF6VVMeqZ1khiL1
         ggnq6RGWbiXw4vp3lEPUtrC5gSZceJlt3rBDzNeu9hfcDIhkisZ0Ul+2nvtLme69hJ6b
         gPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051288; x=1709656088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0dTpHR1K23pB61bzvysNHvrksQiS977Ao80yDg/2EM=;
        b=VIZxYjyLythc5S9/gfddo/5uvboI26guj/WuSZadXnSVvrLLLeaEg1r0dKDOJQ8BN7
         nwThDEmsMwltMTEgH/fjwt/BC2ZqwvjibKnxkNucQT3nVcvGZAvJp9RJ+Q8Y9ag4KGuM
         2+cDsFNCZ8ZxOkl1Jki0jdKNiLsgaCmB9put/nu8VcMlKuL6PCZbLJTXCG7WSojklS/j
         qk7OjKX/vnk76ZMdfHGGXwZnoJQoLQ7o+o/mIkF8GwlmRrNakMWZwQLmwDsLk8/4EXRw
         FkqHzJ6DRaUCvNqH/gWoQhADhv/x8K8AzTFM2kauConIfOdqHPoXAMuIwqSmYsmctKPp
         BU+A==
X-Forwarded-Encrypted: i=1; AJvYcCWAN2QZivaQkHETFgqi/blMelIfTfSwSUVI40fkUqfOGL8tz35SMR/hVg56eMcSKXrT+t4CPWqZqv0FbLAapWzZEtP7J8Xd7fmXNisKsyyIGcvqDLrRSOtOz0oPgrFiWdqo0UN8YpbBFA==
X-Gm-Message-State: AOJu0YxpEan7hBfthZ2PMkQzUAoVImANxwHje9DUFah/heFO8UhQjGbI
	3xiHo9F/qKbTsS3WP1ZD1IlHjm1nqGhs0Qf0mHqGj3ZMFUE+LqjtMVvW39uNQZCYOdpNw5OaMmq
	UxSDBqoDb4iPzHQzxaTQ/TIN6AnU=
X-Google-Smtp-Source: AGHT+IGzJBW8k7ldwen5EXjuSmgR3l2IjW+yccX6qBQwDIsY+xoBXnRY/aIUOm+e4NHYEM1QabbatXe2pbsUDCTTnSo=
X-Received: by 2002:a17:906:5804:b0:a43:a7:c683 with SMTP id
 m4-20020a170906580400b00a4300a7c683mr5916386ejq.42.1709051287508; Tue, 27 Feb
 2024 08:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227123602.258190-1-javier.garcia.ta@udima.es> <20240227160952.615291-1-javier.garcia.ta@udima.es>
In-Reply-To: <20240227160952.615291-1-javier.garcia.ta@udima.es>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 27 Feb 2024 18:27:55 +0200
Message-ID: <CAEnQRZDY5Jfj6d008goccsWwwUuUuryw1s8xJH6EyGXEiqnovw@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: img,spdif-in: Convert to dtschema
To: =?UTF-8?Q?Javier_Garc=C3=ADa?= <javier.garcia.ta@udima.es>
Cc: daniel.baluta@nxp.com, broonie@kernel.org, krzysztof.kozlowski@linaro.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Damien.Horsley" <Damien.Horsley@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This looks much better than v1. Make sure you have addressed all
comments from the previous version
and add a short log under the scissor line explaining what you have changed=
.

Few comments inline:


On Tue, Feb 27, 2024 at 6:13=E2=80=AFPM Javier Garc=C3=ADa <javier.garcia.t=
a@udima.es> wrote:
>
> Convert the Imagination Technologies SPDIF Input Controllerto DT schema.
>
> Signed-off-by: Javier Garc=C3=ADa <javier.garcia.ta@udima.es>
> ---
^ this is the scissor line. Here you add the change log.

Changes since v1:
- re-written the subject inline to include relevant prefix
- removed header file as it is not used
- ....etc


> +$id: http://devicetree.org/schemas/sound/img,spdif-in.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Imagination Technologies SPDIF Input Controller
> +
> +maintainers:
> +  - Liam Girdwood <lgirdwood@gmail.com>
> +  - Mark Brown <broonie@kernel.org>

Please do not blindly add people here. The most proper candidate for this
is the people who wrote the original file.

Using git log we can find Damien.Horsley <Damien.Horsley@imgtec.com>

Damien,

Is it OK to add you as a maintainer for this file as you wrote the
original driver?

Other than this looks good to me as far as i can tell.

thanks,
Daniel.

