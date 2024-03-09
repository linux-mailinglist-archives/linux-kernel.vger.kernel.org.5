Return-Path: <linux-kernel+bounces-98056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDF4877489
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 00:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 695A7B213BE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE368535D7;
	Sat,  9 Mar 2024 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZwRCWm0"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7785544C9C
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710027861; cv=none; b=GLhYtfY+r0m9CZb96CDFHLW/v83OgndWZjyR60C2TU0enm4ZelJqBXQXWjSUmX27usLnDtsZBawDz8Ce6CHul4IOlvFJKsxsEFMxNMKcAzCo4goQToBg80sReQyk2eG1HRxeOO/K8iMr+mGAjcotbE1TsfMX8xNdBLJo9OFn32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710027861; c=relaxed/simple;
	bh=op0Qt9OCIGPxK2ftDO9wvFEBViOhpXRW3d7uj0uwz/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UktfKNd8brqshpx1r9CNzut2Y5j4JDVT+L8KVcHRrrMwbFBNlAbfVzbWgRU770ggHqwwIXKEQoAiRqxmfWmtp2LxD0vD1HJV9zA2nO/rlyw/+TLSOFVjw6lCHcZR5cCVkIeiEwtipDlI4yNPA+iJgsijS2JFwqZFQouoLJjJ6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZwRCWm0; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so2639217276.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 15:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710027858; x=1710632658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=op0Qt9OCIGPxK2ftDO9wvFEBViOhpXRW3d7uj0uwz/s=;
        b=NZwRCWm0wQ0EFQLu2jbWSdvoYzgpkhhhrNN0CK/9AL4p+EcnMQZGEVyUxoAINCgdfS
         NaeXsKlTijotf3F9QQh8p0tDCBUEJVVf7Ti5ccD4sNC4y86KT804dVqMX7MU/p+SpSwS
         vogT4Ct9EKRnMSaV3p2UGvCE3ALl3XYIdYnE4Aesamq0hZMrrxg3VfeJ9KusHFH1EMsB
         vVH4ve3tVpDxn3Q8ubXn693aiBPexcisTzMQyLRMEaAfMt+1mSVV33fCjXGhGqzbDdsV
         bE9m25w6U7L4n7D3spebKexHAb01QI0DKUGhS2/tgrFKQ2wvvqq9dYGeDSMk+CQzE2M8
         5yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710027858; x=1710632658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=op0Qt9OCIGPxK2ftDO9wvFEBViOhpXRW3d7uj0uwz/s=;
        b=VoJo2Hro3Un/llp+mWezUeSNGlvqvd2BBSS/EdELlmh0NFv+yohDa7ut6+w6jGAwMK
         wPL1mLmCACxE0QjElWcXSUnpSqp4hLYaLC/twIXqLAwIUtfCTcMs/5GS97xZL8qtoWhK
         41T3WHSDJiJv1OJlgw97hgK/FM5qK1troFpdnXajXsUc9EeW3A2p6qE6pCMsOyDgPzDn
         /zr+8MN1LogkkBbmGo00C0cZASx6fyljT11VesuWs2puqdSNWhpZpOh5yZZcFhvrhYeH
         eaS4l6Rogqi0hAqN/lGcLMsRlZbktN8ptW5Y9zTAvLQXLjAq4+XTCheL4T6L6Xsyh07m
         rAZg==
X-Forwarded-Encrypted: i=1; AJvYcCVMlSYwlyZ8Fl4/FOYVcfpp2V1maplWzT6mbVMxRoEvuSnqDgxTIr4bc4NUZdZh8O0Q8QBeo6qp8hIigBJWCsKFmH5ViBlSfiI4CgKz
X-Gm-Message-State: AOJu0Yw2jzLeJpYXm7FERl3TSjvNOyH1LP8BWoNHZukcJOrCK6QKej8A
	ATWX3yB68v/EmYIJH1FUAK30h2v7HhRcoCPu/yB3/6QITbeyurV0ky8+6848g+YsoYk8rV86BCL
	Y6n+rBpkp9WqgfsV+ETkMpKYnf/15ix589Uau/g==
X-Google-Smtp-Source: AGHT+IG/G/2HnmXxlm98q5LWWzZBF4TgRPGOq/HsZonyF8llr7y9Cgv//r5JxaNkjnhcwXZFzlkz895oBDCCxsJd63o=
X-Received: by 2002:a25:6a8b:0:b0:dc6:e1ed:bd1c with SMTP id
 f133-20020a256a8b000000b00dc6e1edbd1cmr3212980ybc.21.1710027858382; Sat, 09
 Mar 2024 15:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129092512.23602-1-quic_tengfan@quicinc.com> <20240129092512.23602-2-quic_tengfan@quicinc.com>
In-Reply-To: <20240129092512.23602-2-quic_tengfan@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 10 Mar 2024 00:44:06 +0100
Message-ID: <CACRpkdZ+n7qeYOSvfWPt2=yfWihY7cGQmnnMyDuB5O3yxmJcbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: update compatible name
 for match with driver
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 10:25=E2=80=AFAM Tengfei Fan <quic_tengfan@quicinc.=
com> wrote:

> Use compatible name "qcom,sm4450-tlmm" instead of "qcom,sm4450-pinctrl"
> to match the compatible name in sm4450 pinctrl driver.
>
> Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>

Patch applied.

Yours,
Linus Walleij

