Return-Path: <linux-kernel+bounces-80286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0B2862CE8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500021C21332
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B161C1B81D;
	Sun, 25 Feb 2024 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vduig1bT"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1817BBD
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708894004; cv=none; b=GWeFEn5T9YY8sFRE3jat+ePYrIKM/moyTDVaY5caHCvz/ye6+hsCuQ4qpeYAZz8W3XykHOesBUveIPFSVTbOfvLy+UHHeUH/Q0HhZM0a0FBLQnbNGcDv98SpCJt/cwH2DETkY3WEhhhWMQVzDv22OoD/YnauBzLvhQWixvXhq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708894004; c=relaxed/simple;
	bh=SrPQRCzhMvMmii9hQdPXD1YvNqRI54qycQwonRLO1ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEaR1betTMXo1/YktbJTKGQv61n2STsbLNu7o6XkcLGbxtm3zf/EP+cznkCcoojQqn48TTHplXkrEXyh1g63Hr3WpeItL5RRXcxxHlWTyBmqOPb4lflVIA7hL/WsJwB39Xa80t4GNNaxVVkDj3sstBFiskrhlP9Kx8sShHvvjB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vduig1bT; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c1a172e46bso189857b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 12:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708894001; x=1709498801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jaoEWYXtOjOULbW2yMrOmnPYIPrfPlzxVubLNRsgJlQ=;
        b=Vduig1bTlKQbu0yvrCM/lHROy/o0ypR163cnclNvudv3dUoUjENn0cFSdPIeQm89s8
         q4btaB2uktWptukeVFh/71G45Z1czfj/K3/XagmBfqv/sWCbG+uWbv7xzGv2vxxJWsq0
         J9+eXFOoWaer0ppit8cWeRTwY25TQ7qDS73DvvWtSMx6wLWzEq3KI5Ci3x85MbrZO3fo
         svQ2x81PE5dKpA+XFlXONBlVrq8JWLynaA9C1/TQFa5ZKqpufA8wA6U6INGM4Kr1qSOb
         w5HM9ksyVKdxyUZaO3RbhyWXWoTH8qtCuoB7f8eIJdH2FAd7SaHG3RBBavDT16+ClqIZ
         F6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708894001; x=1709498801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaoEWYXtOjOULbW2yMrOmnPYIPrfPlzxVubLNRsgJlQ=;
        b=u4JFIMZFtsy7BFlmjEeKOsRVONoC8gVG0pARiFK6Rkb9Rlg/EWnl3+Id8kWZ62SPba
         canE8yO85URK28L21FydcmLuWTKU2TQAvBtOlxY0Oc6F+J4zmvhSwaMjwxPHRAC+MiK6
         F3FC6YzFoviFqoqk0b97P5QKlGKqnReK4WujUllJJjsEyVeISYv+ZAPuF+n2vbjGZjt6
         stPuaq0UT9QXIUMUNJzKlflsc8dOiRCu4ks345M8Pb4nSwaOSkfyhKEiQvr5L19wEuFU
         VM1iMNqm5jsDX2L5QByN0AxfEqT4W8mEaZE2PBFfxzQAB2K4XjkjGcJukslAAgcJ05L8
         TWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb8E06c6l7ycO31d8aEpiQ7aOr/fQKFJxWGzc3BTrwmwj/rY194p4vphNM7yTYBkHpeUw1jXNc/isDk1t/SnpNdwyM3OjOOC1EIOD1
X-Gm-Message-State: AOJu0Ywi4sc5+6DxwMOb+cy0oGzuglxeoI34UVDM2EJQfG54EC5IYhjA
	D/W6X07AWjfPJAKbauCQgLJLakXU1TjPWj6c3Zp3scG/Tu55QX/QPN6AchY9c7l0ETTe+p/L4/D
	ns3mdbQ+LQzcZh6GCTlrHFGYJs8HEV5FMl/MpbQ==
X-Google-Smtp-Source: AGHT+IHiHD4DCI2MPVcMU8ZdLBW9A24hnVLA6ZCjQvJY+jivSwWXTU1+Dm3VJmojw/adwKuuhVJDjGQVaJJkaIHmpPw=
X-Received: by 2002:a05:6808:d49:b0:3c1:9caf:c0b2 with SMTP id
 w9-20020a0568080d4900b003c19cafc0b2mr3215443oik.7.1708894001601; Sun, 25 Feb
 2024 12:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225202744.60500-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240225202744.60500-1-krzysztof.kozlowski@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 25 Feb 2024 22:46:30 +0200
Message-ID: <CAA8EJppAKRiSoHi3icFymSQjP-TQrOF2LcMEnE=BmK+=nv330w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: qcom-pm8xxx-xoadc: drop unused kerneldoc struct
 pm8xxx_chan_info member
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-arm-msm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 22:27, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Drop description of non-existing 'struct pm8xxx_chan_info' member:
>
>   qcom-pm8xxx-xoadc.c:386: warning: Excess struct member 'scale_fn_type' description in 'pm8xxx_chan_info'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

