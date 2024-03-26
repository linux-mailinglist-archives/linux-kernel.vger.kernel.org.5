Return-Path: <linux-kernel+bounces-118880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321EF88C095
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3641F623BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C585475D;
	Tue, 26 Mar 2024 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYZFfsHk"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A228A53E2E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452278; cv=none; b=PABR9yK1rDMssnpWn76oeycn5+yN2RAO6fSh9laiBh9ennybhhgZt9ckjfoRbQjEP/Db/XFzMaOhm1eNIiYEuHTqWYTTCuCfp4WTfO54m/b58MhIaMM5JqcjI9K/mj4VVM++SBtaSA1NMXJRXzFTBTkeY+gJb02Jk7dgGysrEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452278; c=relaxed/simple;
	bh=SFnUOfDdBU1QEnc87WhWOnlkhgpnUSM/FP3ES0Az8rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SippxVOZ1gw0L/SRlc1NEV3H2rT7mMHElFJIIjeLfQvoO1yVvxCBraIzuGQD4O1xqgGIe0zX1on2I/+C/J3LE25B5ujK/uoph1NxrybgA7t4OjO+SeEVX4pNP0ipA8OKzn7PQ3wEnsyv6dYpDWIz6yFQLucIStai4u3xdJ+qpTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYZFfsHk; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso5509095276.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711452275; x=1712057075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFnUOfDdBU1QEnc87WhWOnlkhgpnUSM/FP3ES0Az8rs=;
        b=pYZFfsHkiZYhOxFoYSH3YbltEp7s40M3/FO0PZhxTpGma6QM9LlyIujMO5zkhOCG71
         ChAPPjSypxLy2JZqUe6dT9I3GlUnnsRFbSNRMu0FyeYDcT7d8sbcldFoI04uob+SdVcJ
         W0N8dAh8Y1zb6sJUNRL6IY8SUkdCh/ZB4SNVNf9CjhvUxrZmweTIjElJiD/ZYKRyJpvG
         i8BRb1ukYRQy1ut/3dWR1cxXisffrYLDIwIESGYMfXnJGRLcOtKhdf+Fy5PZZY92tOfq
         Wvrpmwv8hk8L9HjkF2GTtUNv20Ha402McJjF8xfCKWLh3maL+82E+o+B3NeT9EIAoYES
         9ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711452275; x=1712057075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFnUOfDdBU1QEnc87WhWOnlkhgpnUSM/FP3ES0Az8rs=;
        b=JBqzD7PAVNgndRpbRvZWSjJrgGkfYN/8Chv99TZuGMOoDpW9okh3xiaA7R+8zl9uIm
         nV1QdORnJ4QIWHaIAXaAEgtGOWknVQcNtnWXvHQFrJpejkqnw2MXBtTRYA/EJ44/8daF
         L+66URmXlJ0QXPMWoWOW03DuH2hbHm9eRB9P+htoFpnHWbhEi8HcXyo6+vQfZn+2PMys
         vevCry/EQqCdAieUdJvYgmQ1ehGI0Ns+W0bFV7DG3OGzGbYV4FYCRv9UtvxN6GAXSBNT
         q98XfZofM4whDCr6WJI2ESktLmJrY7eVXRdzwkf/qXV+DZqZmFwWyZCeegJxJrgp61iR
         EGug==
X-Forwarded-Encrypted: i=1; AJvYcCWBzWW7pE3pz1gBgRefG53rk/L1LTf5OKknDNU/fxiT3g9PEQgSIM+EGs6C5nRV81VeoM5j6YoISeiPDu57hHNkxaK6N8Hmds0Lm9Dc
X-Gm-Message-State: AOJu0Yzf4wa3pgv5A/EosEf4MmUkMxizmz8JCMFGZpJfh7xKNlKew331
	hr9KiyqapYX/iKORJpPCa7DYIgew2qCTk91+QuyBFUk3SA1GUnF5WScgzmzNnQ4xj5vdgzW8gLb
	WgC0mb5ocVT7/0w8hqUOWBjd/wSlJKd0GK+15Og==
X-Google-Smtp-Source: AGHT+IHVA51kd6vokBv+tMXjaQ8yW3caIslHt2ATnAepJP8JfNzsuIR3AjQLivmAMwHIcOsMZds4lgdKs7qsvmS9Vlw=
X-Received: by 2002:a25:26ca:0:b0:dcc:99b6:830b with SMTP id
 m193-20020a2526ca000000b00dcc99b6830bmr862332ybm.19.1711452275673; Tue, 26
 Mar 2024 04:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326103620.298298-1-tudor.ambarus@linaro.org> <20240326103620.298298-2-tudor.ambarus@linaro.org>
In-Reply-To: <20240326103620.298298-2-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 26 Mar 2024 11:24:24 +0000
Message-ID: <CADrjBPoGX7Ot=9esu_wFbhuqiVO+anr-PnpxGjeXFG7NR_kP6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: exynos: gs101: move serial_0
 pinctrl-0/names to dtsi
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	willmcvicker@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

On Tue, 26 Mar 2024 at 10:36, Tudor Ambarus <tudor.ambarus@linaro.org> wrot=
e:
>
> The pinctrl nodes are coming from the shared gs101-pinctrl.dtsi,
> thus the pinctrl-0/names shall stay in dtsi. Move them.
>
> While moving, reverse the pinctrl-* lines, first pinctrl-0 then
> pinctrl-names.
>
> Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter

