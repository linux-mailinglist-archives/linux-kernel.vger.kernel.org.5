Return-Path: <linux-kernel+bounces-145859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24698A5BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFAE282FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B520915666E;
	Mon, 15 Apr 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2+kMCpI"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A9156655
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211470; cv=none; b=nIUh8tNeoGM+eWRIWi4m4F/kvJIRJeYGcf1ldicW8lJHRYN7HNXKkXT44w34lXqYcRZQOhQoV3AGkYrsaStZvx8T/kptune3X+UDdPbPvx9ko7trcEKJOYlZY55Qru2gNmlADIkX4KLqMkX4PubVa7dgc0ZWOTDUzd2ZWaepsgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211470; c=relaxed/simple;
	bh=HKevHeXkZGuoEWykBFrnnyLmHY+4admTUN+lZ7NyEtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuGjlRUubpriigSxWYJQ/WJRzcU0AZbErvcDHaLrW/CYHt25NRLtwPWM2eP3Dhyzv2/nzZ775fNjE4rVTa04b5/8B4RanuJaCEJcv+CZRt4uq3JiBnWJhThzOgAwmZ5dT7pPFovGQu53Cw9lwfMy97sRpqAkDy5QGV3ps7m8XbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a2+kMCpI; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-ddaad2aeab1so3044339276.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713211467; x=1713816267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x+n4yDNeHcrTCJc7XCA965ghIKCFi6oK1ygO6iYz34Q=;
        b=a2+kMCpIIVUrD/mzkxfLOFdfjNSVCTHrvIByBROGwHnn8ZyCZCe4K/QxjDGPx9A3yx
         mHX/UG2DygM/BznGHKBgqdN0M4wrOf830WA6PajdZa7lNamXACjNSpz6TdaYbOz3h6lR
         RJ4/qpr70Jsi5boycQTlvJKEM/LmHY8Ry18EGIa6JWizEunDhBTuyaIvdUE9lArlXOhX
         itvNy8l76aSpUqQaEKOTBZtAGOtxqP6/eNSq0rYoij6oayP/+gjP6yFgAcDEpv77QR9l
         vQI4IswKAzFbwZ4Vh8QWlBVreTDMxOq9zWEUBekG56C1cnWEuWkOJPleqLWsyuDpCFzP
         d9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713211467; x=1713816267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+n4yDNeHcrTCJc7XCA965ghIKCFi6oK1ygO6iYz34Q=;
        b=qAHMG0kzK98H+TarE5okFan/I18l96ES/WQ/BHSN/jjBTErudUcKZrvVAok8BjQvlc
         mDoAKc6dto4Aiq7vH693O/SombV56+zP8YD0NM7bq2+P6iHIBJP4ja5zgyDPToMOvA/A
         eJuP57K6wk7JTrcv93ZA/Wr8Bg/XTymw+9wwdjPbXnlqdvdIyFTLCFoVLZNdYvTngzuN
         Z6Jvo0cwhZqa67E2I6WYkIeuNpgbP5ikmTZRKgqvq+02dlsp977j2TCBorSIx+G1MGPN
         FnzCS/bNy6MhMYht7z5DOOCqG3fRvnMw2BZ0lxQyDa81dCufHjlVse5vkNgOKpDrmd+L
         cf6A==
X-Forwarded-Encrypted: i=1; AJvYcCVf3NjYvqaI6Vl8IJTT5EPNVpkxjxXxu5OXyi9dYVe37QFYSfzSISHReBIVWLN0Eu0Y0ShM2C8giTFAm3/zlbp6ZapW3rRjnvnOVBJE
X-Gm-Message-State: AOJu0Yyxndvudx3aa6JJFT5xe4PaK1vao0EPV8/NJBB7jUSaId4qoAY1
	fAhNxSx9qYNk1I+jYu1bViXrY432zM8ktLqgiKfh4w0kAtKkW/KnHOaBDyHrkjgLiiHMqn3g+80
	754NCHjRKKZBTBZOw0WYlikxj4UFSn1pWTMiB3w==
X-Google-Smtp-Source: AGHT+IFgChYQoIbtXVFNn5dpONcRCuNNKjt9lSve7LdO+2SQ5EoJ4jqt3753eEsEcQ7mld6BIqWcJDJtBnxGz7Zk5/k=
X-Received: by 2002:a25:2e0d:0:b0:dc6:dd80:430e with SMTP id
 u13-20020a252e0d000000b00dc6dd80430emr9293179ybu.27.1713211467602; Mon, 15
 Apr 2024 13:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415182052.374494-1-mr.nuke.me@gmail.com> <20240415182052.374494-3-mr.nuke.me@gmail.com>
In-Reply-To: <20240415182052.374494-3-mr.nuke.me@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 15 Apr 2024 23:04:16 +0300
Message-ID: <CAA8EJpq-UOd4dcuLyEvJNW4zckSGq1LSdq4eDMWPHX_98U8F=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 21:21, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>
> The IPQ9574 has four PCIe "pipe" clocks. These clocks are required by
> PCIe PHYs. Port the pipe clocks from the downstream 5.4 kernel.
>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq9574.c | 76 ++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

