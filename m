Return-Path: <linux-kernel+bounces-3781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD38817118
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E5D2810D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C3837869;
	Mon, 18 Dec 2023 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRbC2DA4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A6B101D4;
	Mon, 18 Dec 2023 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2343c31c4bso167016366b.1;
        Mon, 18 Dec 2023 05:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702907655; x=1703512455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CbtU5Dem8n1ByRGdHfRIcdaXiqJKIZaXjO9MiKCPxSw=;
        b=aRbC2DA4RCGnOCbpTUGe3H2+8A3AvSzghu3VoH8878v+Bsz8Vvsm2HEV4DkJo7d6aD
         fg2knaCoSpfiLPIsb2mXkZwqImIRsMCTaaApnxPHqKzj2dFoJGPZrQ0riyregW7q5yAd
         ztaa2P9wZvJVURnJajbQtt/Hoa6Q+62sIZmRknBzh3XWqwX2bz3Bv7sFZ+UBP2KXD2FL
         +3gKbAZHvRhM6ZNYzxoh1S57NeDlF0zJIWNWkBIrgAQ+kH3GT2NbDWzQW07DoVVMwKWV
         eLK9cNqfEKR0lHw/r3TgZJLV2Aac6rHwy/T3CK5qBWmTfqPKP81RG7xBo8+aRRG+2wxK
         7Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907655; x=1703512455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbtU5Dem8n1ByRGdHfRIcdaXiqJKIZaXjO9MiKCPxSw=;
        b=WWWldL3mFEVEOpFa8wsPmQmBuoMPWh17mnDMlcNAI+Ns5Tic2zhgzUvMVVcxPnfQQX
         HDz9d2wZuUhmZNnx3II/cDgmGUk+SBAHVkKNe8WjMEi/M5BbgLwVENCjpPU9+FEBFsLu
         1joV1zFs5ibOyTin2JVCVV+6KdzJbSA4UR9d0qRFSThy1Os5mVwzR3aJVGexcLcxVzt5
         dIPDBLQSRDP7U4182YSTh9dTu1b8QSa0egqAzu+uUUjozTT3pSAyxSUWnySVLymHcXZ6
         xl6PkYY8DJZ2j64yUrX45YbvsiGsCPRbyAMKxznxVNJnTC1ttOgMBdcJ0DZMKPL9xTyZ
         frHQ==
X-Gm-Message-State: AOJu0YwHWxQGujaAEXQ/vQgAFUF5z/CpNr7dLibeVDwQyNywcs/hpmpq
	SzxE+xf6BzJd25tlcjdU4h+rrH3YCvDu5yzBPq8=
X-Google-Smtp-Source: AGHT+IFccjuA7oI4N2vZVaD408zkZGajffjClRfWqmjz7HiPSzp9vIfLO0uacCVtWGKz7UbIXxVfUaYcwBaZqHng/s0=
X-Received: by 2002:a17:906:1083:b0:a19:a19b:426a with SMTP id
 u3-20020a170906108300b00a19a19b426amr4772325eju.213.1702907655325; Mon, 18
 Dec 2023 05:54:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218124058.2047167-1-elinor.montmasson@savoirfairelinux.com>
In-Reply-To: <20231218124058.2047167-1-elinor.montmasson@savoirfairelinux.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 18 Dec 2023 15:54:03 +0200
Message-ID: <CAEnQRZAwk-USZqXwLOVuN3iTn7r-55BJH=Sqq5+2Od+DhrK0iw@mail.gmail.com>
Subject: Re: [PATCHv3 RESEND 00/10] ASoC: fsl-asoc-card: compatibility
 integration of a generic codec use case for use with S/PDIF controller
To: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
	Philip-Dylan <philip-dylan.gleonec@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"

>
> * fsl-asoc-card.txt currently follows the old dt-bindings format.
> Should we update it to DT schema format in this patch series
> before adding my new properties?
>
>

I know this is extra-work but we would greatly appreciate if you first
convert fsl-asoc-card.txt
to yml format and then add your new properties.

