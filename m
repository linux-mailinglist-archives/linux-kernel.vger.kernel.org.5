Return-Path: <linux-kernel+bounces-98258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD704877788
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773D51F21272
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28288383A5;
	Sun, 10 Mar 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGwjMXeq"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2FC38384;
	Sun, 10 Mar 2024 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710085918; cv=none; b=nwbIyapQ2nX0ka7FReObnMiBNIErLf3PtRJHBfQ6qBbtE7LXAPgCazOEMu0rQ1wgfS5dXZYjdi/8hXZIWAsRkJNxqVXwMbIHHgL14QPpQ1N9Z03HfYM6Ev2VF37rAZfeCRnzS8R1gCj1lDxGed+ksT4DmXp4pSCScUvxgGS1ueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710085918; c=relaxed/simple;
	bh=FFd3DcW0VEW9q4PY+3fjis2BdSm7XjuFwi4yhcFrhU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkytQcwVVL/MwiyFwpQ76ShjizoN4dUZXMLbcfD3YOurVgz8fbIkeWBI+8FOhHYZL5qBWUoLHqljCMzh81h5V3MbeORc+tgDtG6wRYm4q3611+3I6yje4w0Fqk6xPh4IfAIdqw3P3vpyLn9uefsswDNq3pteY6I55xnedDivwKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGwjMXeq; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c19b7d9de7so2458735b6e.2;
        Sun, 10 Mar 2024 08:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710085916; x=1710690716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFd3DcW0VEW9q4PY+3fjis2BdSm7XjuFwi4yhcFrhU4=;
        b=iGwjMXeqR+K2iDCc7ClkRmXvKuOkF2A5SfK68aUgKeGOuTUO1zLrlKUcYGD/yVZoFe
         16w1aE5XJTLBgxHEVV4OULwCfglx1G/hSRg/bwJGStGBg6+2AdifsJt37hlB2G7OHhoh
         /9y1H4CfHo+i6cqekfOcIdGmWs6oh4rtVPhE9c6Rbk7FT6KKXLMhT62lUHGa/uG3Yg6e
         lqhFa5WgQJZUsKKkZhwa4SI76OA786zvtQ7XbUszWkkg4PSaI0PudTXCiwt5rn2vr1XO
         xXquW4EwfAZbKHaDyPGcKO5W4myseukLX627bzIhySCxa0vTg/yVpRP4EMNzR/TXJlLY
         SeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710085916; x=1710690716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFd3DcW0VEW9q4PY+3fjis2BdSm7XjuFwi4yhcFrhU4=;
        b=a521Sp1PYfSjnib/X10VO/bNU+3C12k2ZPnJBIrsC2J01SFzK3dWneRxLqr/M2z+dr
         KQrnXwmzlDlVMU24QMWEsGuaI2jsCiGi6u4Bof8DYNQ+vIji+f4LhiZdwia4GO13tlhg
         anTkp2PzjF5i/OxWcC+eJiLNG+2BfPmBztxSGneodsSXFCgD0bVscO/FEL22lxv0htZS
         TZRM5HnDS+KUJtY7Fnn1l+wKqvYu2R9JMa6L8ulnS5IRqHdzV/0wiPq56e6fQnS//V4K
         o4IxA0nyrwbhlEbUB1UfeusStGeeMGaGaIsLo3Dr1w8IosWdAPxJd+Oi6CX500/y75XR
         lPfg==
X-Forwarded-Encrypted: i=1; AJvYcCUkh9Hx4hRUPwDLTFIk0dyyeg6y/7KEycNZDnZF+X7aV8wGAjrvWWe//P/aG2cy3YboE5wsDeSctqj6qipJ4vgEfrLFyzXv1s379QUokTeGoMj8RawmZ5zKSVbvY9rbX39vj+aAyjNgSLJzhEvTWRWp8WxSdpSD7dKVQEe7Zgm8c+KsPw==
X-Gm-Message-State: AOJu0YwrhXKFd1gEyMVDWDer4E7NcdH0sOVviG7p0SQP5mgA/ZJEfcp5
	QrT49KfkgM4nWI9LUtR9EctP2jNr+7myl5rl3jp/zrJwPinO1Ox1nheHCI7XdDQuseQwX+KIaE6
	yN9NeMvvzO1vw/bmpQ0jYwagNy0E=
X-Google-Smtp-Source: AGHT+IH/bPs+BskZRMjgFJT5/0kkUalFAj9DSG+q4hWz4JlMQZH0XKTvdFt9qWH5kpdERAjxBvzgZTImaONF2Unqsmo=
X-Received: by 2002:a05:6871:5806:b0:21e:7b5c:60fb with SMTP id
 oj6-20020a056871580600b0021e7b5c60fbmr4348693oac.11.1710085916074; Sun, 10
 Mar 2024 08:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309160741.54096-1-animeshagarwal28@gmail.com>
 <a26689a4-1c8c-4458-bb82-137cd1ac21d0@linaro.org> <CAE3Oz80TByuu6=U4PTOHO6k1=KjjRKtPPf7ayhSMZareXP8vdw@mail.gmail.com>
 <6b065dce-5271-4ea0-b291-a7aae8e71d20@linaro.org> <CAE3Oz83uiCyxV3u1C-5=vmBt6RxnTM+LJCw4KWyJDB2OLn-dRw@mail.gmail.com>
 <f7d94072-eb4e-4d67-98d6-8090362a01e2@linaro.org>
In-Reply-To: <f7d94072-eb4e-4d67-98d6-8090362a01e2@linaro.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Sun, 10 Mar 2024 21:21:44 +0530
Message-ID: <CAE3Oz81B6uhMu7B0S73Sd1jx-7JNhWoccDkFNn5L_PT+P_-2Rg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: imx-pata: Convert to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 8:04=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> I don't see anything about this in commit msg. Commit msg is exactly the
> same as before. Try yourself - use b4 shazam to apply your patch and see
> if commit msg contains that information.

I will post patch v5 containing the proper explanation in the Change Log.

> You mean v5? You need oneOf allowing usage of imx27 alone.
Ok will modify this in patch v5

