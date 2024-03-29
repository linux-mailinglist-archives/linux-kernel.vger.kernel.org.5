Return-Path: <linux-kernel+bounces-124095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9D389122E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814FD1C234D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382B39FFF;
	Fri, 29 Mar 2024 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3iISElt"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1121DA4D;
	Fri, 29 Mar 2024 03:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684167; cv=none; b=dD77QxaGJoZkqtC4Paev9MLF+RbuJIIRGLfCa/gmtf8T/JpJ6dtD4ozxTrMAzMiMVm8VHkbZ5eCMbtTGrnuj6rzs1hF7XT4VoKOa8VnXyIYazQ0o1nyvAUC2NPwhYB92bD4LVO3Ixc3KOznU1Hk8UamWJcP/ZIAy8nXCLvCjm9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684167; c=relaxed/simple;
	bh=rbYNru4FvZk9/qOjGtXreS+71shEPoNntVgIjjLgs3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWVEqGR3VVLGolJNLKpoEIOF8cvcCDAAu0dE2XirxMmRH2QqY52zfdkEz5KNmBfrvlAgabIpO7jd8qZywP2rRcv3JT1jvz/PClnxAXw2EeDgWzlC+v4wlE6mZqG5DL67KQ2uBcEyQChNRBfHGpnRszuUN6b3JmfkQFYukVI0qOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3iISElt; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a522ae3747so721733eaf.1;
        Thu, 28 Mar 2024 20:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711684165; x=1712288965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbYNru4FvZk9/qOjGtXreS+71shEPoNntVgIjjLgs3Q=;
        b=i3iISElt9bZINTFR/6KkisXu99/RDm5d7LtGz19WERl+zZ5x6lU1OcKKa5rtL2UM6a
         47SHgd4/nwkPOFyMlb/P/L9Y5YkMpL5CNGL3lvqFjNcE+wyzqWQLyMzBElke2vTHLFWc
         1rFsyqM4yGyLDMh7bnNJT4+cvUH+ny1sgc2fRt6+1EBnSbTC4isl47vKtRAWZLU1S6S8
         qgdm7qaDBWvyUmjpt2J6hC0JDtL2UoAeTbatS2XAje+nsSalcLJzYxDaiXauI/NEeQM9
         AfdbQoif+VZg1q7KcGvUdgHe3dyjUz6CtFC9aoH48voyVIiPazochwjv6LcUTHd0lsst
         PfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711684165; x=1712288965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbYNru4FvZk9/qOjGtXreS+71shEPoNntVgIjjLgs3Q=;
        b=N6AWNOAB/akqRicEfrRFzly2SMSAR8aEcW124AdUxDJBWwYitwjedZpgc0u200Jn0E
         k/V+zCQxOoMoQsp/gCqY2aYB0dRZU10WW+uBqaK8rkKQgdp3oFi3jIlJBRRQ5ZklIGfk
         ux0KHyowqp2DE5k0B6gOOc/vHMmYxTA64ER9EyJrAbW4RvDFxY5gy/IA4SZJ+ZkWuCPu
         6q6p4OP+PB9tBazejQSJri73arkC2IVvShkoEsJdez7ja9hzbEVOilI4NOX45UONpXPK
         mSOrWZ6Qyb/z9RFDRiRBdRFogvlWaT6JON++9s+C9mhHJMMNoQFUo30RTvb1e0dWArCM
         gxPA==
X-Forwarded-Encrypted: i=1; AJvYcCVm/2/8YVJP27VvdONNbhDPibe4yQBJHu3npL7QgloDXEYGquj2B/9gdb4cga6MGr2boPBH8ALBcqrN8dhHKPXKt2TORCXg1vd8Gx1Jfc6s1M0qTUawt/qwokI0oi/93dvXtddY65hx+A==
X-Gm-Message-State: AOJu0YwrBbx8NMBSJ77gFUJEA2EvH15GrwgQ6rzjEnFOGUm9iPFBnyM3
	O1i9RYDxvASlNJtXZJYtaJNF/ZNSy9NOq2RM9saQAeIuooeCMJWFnSjmMoNclwuPinruuKzh7Ds
	fJaYMqjmjy5e/BVJAgbeYaCjFCKo=
X-Google-Smtp-Source: AGHT+IGY696uQzEFN9nM4AzEb0MgJ37NkFzNoqo9gX0ZSgGVDWoHvK0+IqwNyDR0VO7NoE+/Zw1U+8f4i1NvVIgNIgQ=
X-Received: by 2002:a05:6870:972b:b0:229:7f31:6877 with SMTP id
 n43-20020a056870972b00b002297f316877mr552817oaq.4.1711684164989; Thu, 28 Mar
 2024 20:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328014029.9710-1-animeshagarwal28@gmail.com> <5b917ec7-f8f8-489c-a804-70ea603262dd@linaro.org>
In-Reply-To: <5b917ec7-f8f8-489c-a804-70ea603262dd@linaro.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Fri, 29 Mar 2024 09:19:13 +0530
Message-ID: <CAE3Oz80_GuCJLNSPz1AL194-jFKPowxkJ852T90CjGfP+=nYfQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ti,pcm1681: Convert to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 2:27=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Why not existing driver maintainers? Do you have this device? Or use it,
> or care in terms of your projects?

I'll change it to the current maintainers of the bindings.

> Missing dai-cells, $ref to dai-common and unevaluatedProperties: false,
> just like in other simple DAI devices. Mention briefly in the commit msg
> adding these ("Make bindings complete by adding #sound-dai-cells").

Sure, I'll add it.

> Datasheet says it is dac, but we usually call it "audio-codec".
>

Noted.

Thanks and Regards,
Animesh Agarwal

