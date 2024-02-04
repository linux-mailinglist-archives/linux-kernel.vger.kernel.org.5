Return-Path: <linux-kernel+bounces-51854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF95784900E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891C8283635
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C16825561;
	Sun,  4 Feb 2024 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OoyrtVtH"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9C24B23
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707074340; cv=none; b=DDdKtoSn2jQe5JdCQ4eYSwoRpiJUKdbyJGfw47b/yAf+cL35YWrC3MOUIwrRCchsJNuAnBOzKpL6W/a6vZbpKrABNyy3qdHmVLSHgRzCJGUFQ/m0RsC5PKliZCkyx3dKQOzijrE++uyPUV6eWqT/i8wyohyFlrbcVQ65K9KBedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707074340; c=relaxed/simple;
	bh=U7fuHKCS7P0gibNRuhCi/+lWNbl//hi+bf2tD9GrdHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEO5j7K2ghBGEyF+3R/Ioj4x4Q3/BkTgPEQfDCz3DShE5KGXRaazWCnWJmBTA4F0CLd+W8XymOLQ/k7dlqimRZwmDSG1tM2W6+ONP9ODzc9lMagxlEcLXJFxXpkyDmGtAft/2OSExJca6494PT6y4FeTjwhZn67Et8E7gsRdFto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OoyrtVtH; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c00ce1e005so142381639f.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 11:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707074338; x=1707679138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7fuHKCS7P0gibNRuhCi/+lWNbl//hi+bf2tD9GrdHo=;
        b=OoyrtVtHrVGc2XeI/zv7GteSD0rgrVV7Zm1CKj+zBeRYXCnoqxy4GZvG395QtuC7/X
         g1/T27YUxx0t8Ua3E8lghdv0Hd+69QaWAjOePCbSxo6Uppk0DsuFN2WI+6C2EO9px4PN
         eyrsYFqKPl74A5ktS2WvogEmKlMkugznf7jQRyk755BFPktvr1ce6GLWv7od0EipZ3DN
         xe/SB0vHCxS3oOL7qSr+Xmvaqr4KdWqEdSr6wOIzbnHcEcwoQwSLiY/flcOa+1wVnson
         DIjdM5C9cNypkvbwtSS6bhNuYixH+PmkQcR7VKsGPayjha7oFSwu6RmTNRoqj4IOj2Er
         in0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707074338; x=1707679138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7fuHKCS7P0gibNRuhCi/+lWNbl//hi+bf2tD9GrdHo=;
        b=ZKRsiXSV/ux1aQlw5FJP9Xs8tOTj+vI4G255SVaEu+r7rp7GkJM/R0JXCSMTZCLgsY
         KglEIp1IWg3y9HBlw0o/OGbk45Mp7UYHlsDd2b4C7b4AOeRhuCr8Px9qZ4bpTAXvAns9
         5IkHzEJznFfjdupfS1vuAn7A3Q1QHj+bvFYVRuB3Qdc2y2FbCExUiYaCQaOCO8wsuTfM
         84SwYXI/OW2nlxcN6Mfgo3mhUM+zzRS8nDoHf7nCUe0gGo+Mn6eNmEftJcjgg0ChKS0N
         sHZVYWvCSrboN0M/5MsrZBZVEfayy5iMQrQh0+HwjHCxTcTvGCyZPugtYJNIsLEIV2KC
         3BpQ==
X-Gm-Message-State: AOJu0YxBzm8lTIt3HxU4JjhghrUQXhT4WmpZZocfM+rfFejEkM7NywDv
	ZLw8rJZ2loYf+lsjO5P/UgUOYwlEJ4DQfJbrfFUfdAAdFC3y4+bX4rci+uhsmJzdTBLsREFOj6s
	wZSmSAppkWK4iwbNd9BJqf9k8Slef3km+xltihg==
X-Google-Smtp-Source: AGHT+IG030GFNoRO+D9HsQtpRkpxOEHuKCB6i5c74CD190x3V48aR41aB7RFrMKEewt7N4ui/ox4/rbyj64984Kw2d8=
X-Received: by 2002:a05:6e02:2184:b0:363:bf96:560 with SMTP id
 j4-20020a056e02218400b00363bf960560mr4301345ila.15.1707074338436; Sun, 04 Feb
 2024 11:18:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201155532.49707-1-brgl@bgdev.pl> <20240201155532.49707-2-brgl@bgdev.pl>
 <CAL_JsqKq8AngeC7ohsbYB0w70uALD+PX-df53cswTDUY-Rrdgw@mail.gmail.com>
In-Reply-To: <CAL_JsqKq8AngeC7ohsbYB0w70uALD+PX-df53cswTDUY-Rrdgw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 4 Feb 2024 20:18:47 +0100
Message-ID: <CAMRc=MdxgETs-Zx3Njao3msmE3T+DeKkPc0YMD3CvVW-Lj2qoQ@mail.gmail.com>
Subject: Re: [RFC 1/9] of: provide a cleanup helper for OF nodes
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 11:18=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Feb 1, 2024 at 9:55=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Allow to use __free() to automatically put references to OF nodes.
>
> Jonathan has already been working on this[1].
>
> Rob
>
> [1] https://lore.kernel.org/all/20240128160542.178315-1-jic23@kernel.org/

Thanks, I will watch this but for now I'll have to stick to carrying
it in my series until it gets upstream.

Bart

