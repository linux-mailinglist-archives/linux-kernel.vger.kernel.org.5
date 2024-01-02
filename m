Return-Path: <linux-kernel+bounces-14932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931ED82249F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0771C217D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5851773F;
	Tue,  2 Jan 2024 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkOm05o2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F161773D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e76948cda7so64539437b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704233766; x=1704838566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuJtr/eFj8l5yUvmrpmvnpHJm2PY39l6dDM8XPwVvLA=;
        b=VkOm05o24PqBTcmZkDuFYcmORIBE1SI5qVwojgt94TNd1J8akAbTSKYBeEIwFiQdRU
         P/ZM1t8PPWOmGFpNNryAC8OeIYY+LcqfO/pe3ngWvtEX1LFxPtGH2nEjkvUqz/Vmr8RZ
         W1GDswJn54iy/Z5OmuC5fWaqr9SZcCM6wX/l54l7uIyvABzvj14CcSdFT7ehYVtKZcR1
         ndOaJ1mkua+qwERYQLurDpsTiortj5sgS9aZpJJO4VrJ77fSLu92IiKE66JcqKmMXi4D
         y4wwDUTB3sulF0xaKZih6e+mvWusrALoMIX52mLxcPCuNT2bympC6aamQ+0kzkyIJOj1
         L4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704233766; x=1704838566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuJtr/eFj8l5yUvmrpmvnpHJm2PY39l6dDM8XPwVvLA=;
        b=ee70oeqqR75cTbCpQ1fXpXVb+IG/BUxoAJXZtBuFvW/UmYxGaFzFlP5Bog/9jGkKLX
         vpHffNFKcygdDTiPmYpk+wROey4Cofkw/5tFD6as2GmwXlij+Ab47woBu5kiY847eoF4
         uQT1qfqUwStJIdF6rIMfh95LZb7vM3UKwnUs42AVBOp7jlp/Iiy15LAtOwGlkfNhYJT3
         /E/oIWnfaGCKOgaaeceRracIy7sgQ/S/0bTYvJpHQld5i4JYTET35EMjkx8iwcxg2WJ4
         n3sVclQhqvSTiHrjD5n0OIMKKNYYQMg8Lm7HlFT8BvJpg4iesaCHpL+4hxsK0DbD1rrB
         TRZA==
X-Gm-Message-State: AOJu0YySve0jHUDNuOY+RImBSAkVJLUfMPUz1ui8TnQ1zSjlEEpFaAvo
	jMN0/IY8v3J/NmO0EVGEoDy1ua9kYd902COjroL8/70AcVw7PA==
X-Google-Smtp-Source: AGHT+IGYIlhVkzMxXraSGMBYskllORtfHCp3vfn4WERmi0DREtFOUZfXz/hDVyKpGg78aZO4ZXdz/JoY42VtmpUn6AE=
X-Received: by 2002:a81:aa0f:0:b0:5f2:6cd:3f7c with SMTP id
 i15-20020a81aa0f000000b005f206cd3f7cmr2671421ywh.20.1704233766490; Tue, 02
 Jan 2024 14:16:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102155949.73434-1-brgl@bgdev.pl> <20240102155949.73434-4-brgl@bgdev.pl>
In-Reply-To: <20240102155949.73434-4-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Jan 2024 23:15:55 +0100
Message-ID: <CACRpkdb8idg-rtbxLgGjGmfLN3SUWP4Wt4SKfuHd496P+kVL5w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpiolib: pin GPIO devices in place during
 descriptor lookup
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 4:59=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There's time between when we locate the relevant descriptor during
> lookup and when we actually take the reference to its parent GPIO
> device where - if the GPIO device in question is removed - we'll end up
> with a dangling pointer to freed memory. Make sure devices cannot be
> removed until we hold a new reference to the device.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Also looks right to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

