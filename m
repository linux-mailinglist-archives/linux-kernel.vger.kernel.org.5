Return-Path: <linux-kernel+bounces-34959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B2C8389D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5B41F21DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3433057313;
	Tue, 23 Jan 2024 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wVxu5pWk"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE7A56B65
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706000338; cv=none; b=k8jtFhlfjn8VdwdBtRKgZmwoOHy3FEuNW78rooUa8SlshA7gx4HBzsNYTAfC6ObhPCghTVlcgoPICnVRDzptsFzXZ54M6kKZTAdRQO6AQAiHz55iQTm6N6VujpldWh7W8+HDUH4LgaVk3wS0hlyc7+WTeWQnRJxs2tPmCBWco4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706000338; c=relaxed/simple;
	bh=GdENzMYn4lktZHY4KmY+kX1Nank39qBXFG/o0ROvZNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bc0vD678N2C49gV44SAVam39PODmCNTVZhFRsgTdmbKL8mqkCMOwOls//OTjzKB9SCo458tQZC20npyec0J5to0PoifonaVGuEaNXqlFOOE+oMeV2ElBj7NxYYElzoqYetv5QrokrlmqTJmpjoiDt784fvHbtmQrl0Mc7SAGGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wVxu5pWk; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ff828b93f0so34604057b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706000333; x=1706605133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd8+YHFNJMug/HTkqV82yzOrM3/5Esu8/DX82CjRhUU=;
        b=wVxu5pWknd9HOkJozXVxTrd9yovv2IN62w8SGAPQriPTWTOK9UGIBmRW3V/r5T7rHo
         DoFeRrbaBDnOFK+5SkzGhLeQP9ZERWVF1WH/zzx4CbFMsvWIpnkpopRSAIllM9LuAXE6
         09sQ4ex2Y5HRwcTqlthmmp4QhXt0gNx8Jll5Vhz35/AbM1lpXd5GP/cN3iOGvrLFEJnL
         GmfYWQQlIiMwt4mMwbYg4KTqRC4ZTD1PNKz40+45+WN3bUPY5CyMhnzRbvmowjA06Cgn
         zKjqJd4fE78dT9MpYnQpWZME5AwTxiJDZi6a1uFu2E92Us6tS0KJgaexkrIVfS04xTAo
         i7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706000333; x=1706605133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gd8+YHFNJMug/HTkqV82yzOrM3/5Esu8/DX82CjRhUU=;
        b=DUxRnodPizByfIrj7OhCfDPNk29/JBHmJNwCHUgq1Qx/mXla0iGt51wP7+tn9I9N5t
         M92KqOTE9SR9+RsHnZI5jTTPZDiQZi6L5TjJiD1CmOB/52vhC2btOvTDy8gGHtyJBZD7
         6gK1h9OIkd9/lg04aeP+6Bc8hynmF+wExW4O9I0ki/n+qorh7IWDGwMeaTn4FexcuIhx
         4B0S10kkzOktAJTei4W8WraoEIQ0vIdkk3diIwNqxHHI6j7n0ZszVKoqHOr3qCewsRV9
         ezRtokxbHbacQXOW0g4zYisHir5rz+uotfzSM2Iap0I8iidl+wU+Zi9DAp1AjOexq5fq
         pUzg==
X-Gm-Message-State: AOJu0YybtDMJI5dvbIvkX2BSHkF3EiO2/4w+vZ8q8tNNQ/CbNmrI1reI
	xnXwweWPnGmk2znJJ0A5M7SeN+xzofYtKz2Y6rkoVEz7KvAMN18C3C8ANNhoszcJujZTjystZPU
	aMxuQW7YVY/BeZymFls+e1hRrZVzPoLj+2KXQiw==
X-Google-Smtp-Source: AGHT+IFf/yktetlkF3njKK8Z1wzoUWcmawotJ8Ye1DL57gIxMBOqjlwuvWsRSA1pLmywAxwnZS3wOD7ICeW8AzNHXL0=
X-Received: by 2002:a81:bb4a:0:b0:5e7:57df:6341 with SMTP id
 a10-20020a81bb4a000000b005e757df6341mr3802936ywl.38.1706000332818; Tue, 23
 Jan 2024 00:58:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-sm8650_pm8010_support-v2-0-52f517b20a1d@quicinc.com>
In-Reply-To: <20240123-sm8650_pm8010_support-v2-0-52f517b20a1d@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jan 2024 10:58:41 +0200
Message-ID: <CAA8EJpqfQrwBdpAeZGk0+ejwhr4G375Y8gRseGBbJDcTzDKQQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add PM8010 regulators for sm8650 boards.
To: quic_fenglinw@quicinc.com
Cc: kernel@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 10:49, Fenglin Wu via B4 Relay
<devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
>
> Add PM8010 RPMh regulators for sm8650-mtp and sm8650-qrd boards.
>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
> Changes in v2:
> - Added Reviewed-by/Tested-by trailers

Please refrain from posting new versions of your series if the only
change consists of the updated trailers. Such changes are handled
automatically by the subsystem maintainers.

> - Link to v1: https://lore.kernel.org/r/20240123-sm8650_pm8010_support-v1-0-dec2224d5740@quicinc.com
>
> ---
> Fenglin Wu (2):
>       arm64: dts: qcom: sm8650-mtp: add PM8010 regulators
>       arm64: dts: qcom: sm8650-qrd: add PM8010 regulators
>
>  arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 118 ++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 118 ++++++++++++++++++++++++++++++++
>  2 files changed, 236 insertions(+)
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240123-sm8650_pm8010_support-750c05a5cd5d
>
> Best regards,
> --
> Fenglin Wu <quic_fenglinw@quicinc.com>
>
>


-- 
With best wishes
Dmitry

