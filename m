Return-Path: <linux-kernel+bounces-77938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB753860CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801E51F29072
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428FB18E1A;
	Fri, 23 Feb 2024 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMZInjpm"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE68318039
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677347; cv=none; b=azP/9+6lyS9auCA8warVaYr0sEvaiU8eGY8s7CNcdzBRb34KyCmYMI6QLj5skEJJNdy+h7OXSDlCjybB4jxztFbZPLPzylgyyjjjrzM0cw29Q//ATG4I1Ddl9uTxE+SRULDeWh9ZlEImFbv0egTuyDft+aUP4okmzP+opjL7niU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677347; c=relaxed/simple;
	bh=BDJzrankMyMZocCjXVCHMyuvOlOLvr1YP5o6PLfU+ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9QmgTe1gsAaAUwMbllkLQ14QMCG8l+JtLUMfXdHCbIWZcG73yVgopHvHgtDsj+LO0FhwNrUPW3rlpKXOzkz+pUf7JnDfShMRwaeATDHEJORvRm2ovP0Rdi59iWC0z3uL+8KRItp3SWFzeyMxib17A8aBEWxqwijx2+vMqjsKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tMZInjpm; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso540195276.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708677345; x=1709282145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDJzrankMyMZocCjXVCHMyuvOlOLvr1YP5o6PLfU+ng=;
        b=tMZInjpmvJaLXfTZUAyBYdoUEgLN6Gv4iM1TlgdiLl86hAZ4i06pu9+VpRILXkyTd0
         ePOdUzghIovQD69xdxbTNooHA/QbYtr80BBmZgDDiJRz7AJplv7G4+tSdQiIxRh59+hc
         Hl4pbQtC4rBGbFMiuh9hNxYP7lcLLUiEBX3Wxri99LXxSGD8I/Nxp0RecK6zYWRGTl/P
         Zb7akIT46GajWyNfawR+LIDRXr0PRTna7Uzt2ig5w+PIsnwqrPnYWfsJgXG2rRPHfHLB
         IRz1JMVnqQXlx1vxHkBtyj/nQFAhcVk8pCopOEo7vqw2lKd+cBF01eMTRkN39l99y/Cc
         JSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708677345; x=1709282145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDJzrankMyMZocCjXVCHMyuvOlOLvr1YP5o6PLfU+ng=;
        b=T7Y+WE5uHXnWK1hJYKnM0/CcHGOXA4mP1Ja6Fd7nMix8JQvEHOuY+Eoyk3DF7PPrfn
         fGOs9thLxiiGNV4QiqKAnpeje4Tcob3e3/KXl18tu+mHtqFbHd3SjpYKvV2ZtEAXddfx
         +kegtcWwd+VaD5FZXybc0Q/T826UyLcvG5OylmMuA3uYtdDWKKw9UDVzepISfrjigKCg
         EscFQliYXHFtMA1lEJ8nVGtW3C+C4xb54H90es0hFChs6/5c69GSLw9FHd8bnvviFRVH
         R4is8jxNgI9EHIfSb5upIrGbnuBR4xkzK1JdsFZh81M9eeH5Im91UsWgQ8Fl2Z8us5nY
         JTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV3NSfPMl6cOxIk9ig10XKvas19wiHyfLQm8lvjV0RubEgHFbTXwigoAS2lgJxLLq8Tx4scfeFZs3uYUprCSE8MWGUGgF8BF/+fGki
X-Gm-Message-State: AOJu0YxNLQiojAgM8/TmjubZyj9QgAmNl7LGlMSRnAkWeQ1lDl/HuPmZ
	QpeFLXSGYtqaZOvfuC0YBaH58ruwmWdrY7+gOaNM9+phrWO8nlEJagJHxoajY+PJR7Q8pQYY5q9
	aTrGOuSzQPuTtUxiKHVLYO605ON6B7dchQpxVnbRMI+nQKIOG
X-Google-Smtp-Source: AGHT+IGOlBpYdtZ4/p5L/TR0zjPYT869hfBVTynTZpUrGGbxeGr51rjvskBAzAxe2aQoNBXBzWL75316K2e/O2MrnOI=
X-Received: by 2002:a25:2045:0:b0:dcc:ec02:38b0 with SMTP id
 g66-20020a252045000000b00dccec0238b0mr1342720ybg.64.1708677344960; Fri, 23
 Feb 2024 00:35:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com>
 <20240223-pinctrl-scmi-v4-3-10eb5a379274@nxp.com> <CACRpkdZLuWwecacBAimT=Vj67dGabzBH-7aaqzoyj1B1sY6o_A@mail.gmail.com>
 <ZdhYc90uy7yuYrx2@pluto>
In-Reply-To: <ZdhYc90uy7yuYrx2@pluto>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Feb 2024 09:35:33 +0100
Message-ID: <CACRpkdYZuHh4JuwwgUEeVR_0jG1DPtj212AMOgnaxWdkT_sowg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 9:34=E2=80=AFAM Cristian Marussi
<cristian.marussi@arm.com> wrote:

> Well, AFAIK there is another upcoming change in the v3.2 SCMI spec and
> I am not sure if this series accounts for it...indeed the v3.2 -bet4 was
> still pending fr feedback AFAIK (and I doubt latest changes are in since
> they have been discussed like yesterday...)....but I maybe wrong, I will
> chase for the final spec and look into this to verify if it is
> compliant...
>
> Anyway, given the particularly long history of changes in PINCTRL v3.2
> SCMI I would wait to have the final spec officially frozen at this
> point before merging....

OK fair enough, I hold my horses!

Maybe we should mark the series as pending spec or something.

Yours,
Linus Walleij

