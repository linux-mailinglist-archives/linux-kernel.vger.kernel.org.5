Return-Path: <linux-kernel+bounces-111310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7878D886A81
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CD41F23AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3B43C684;
	Fri, 22 Mar 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JiihL1+/"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D063B798
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103927; cv=none; b=EYHUwZmbEdBa9UWfW/okh7oaSWNONvWamK6e94aD6IQR33JJNaqYtJHVMYGltDT4LiEL2VGc0bDFigR98TfBe0gtgPfo7AqgziK43Zs738RLn1jSpzqwnVvimU1FXhCIEA/fe6e6CeGTCVFYzI19+leaxDdnQWouUFVJtCaTap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103927; c=relaxed/simple;
	bh=Hq2/eEOuWhpmKCsuwoD25OCbkTU9eHjsACQjFbIL5J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD2RSogTzaNDoriK0p4BFnmNWeD4ohv6ux8Tr0Ky0VaWVLX5TejPu+naV69E1QYK992d8hgEDlh9wp/9dLrvuPeo36fSlZs8IEkU8EldpOrZ5Od8MOCR/9DJPqo4MTTn3wwZ5+hUPzQsuGgJfeq78vIrLFW5NJgUPexR16VJHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JiihL1+/; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso1874136276.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711103925; x=1711708725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EW5QX/PBiLajaatZ/82NErGaCFABadkL02aA8JURVjA=;
        b=JiihL1+/6U2Cx7eJN6b4Oe67iNFFFwpMCixX/BSNlEZziujtNC4bsDiR9/+lxJy7AU
         rhESgenhwWlEL6pwXxuSKhrD88LMs5SO/ztC1aZ8D7V3oLww0qjE4XWA2kZgjc6mbsas
         ytdavUNjY1u2pDaiNesQGnGiJDq532WBuZudF1qkTElflgRSWQgZf67M7ej3kqhao0jx
         jDwxeTLj3YRuG7SwuntosDcRg+U1OCkZEhKRvuU2AGYktjqC347VbPZu1wzginm7/8L6
         qRDUy6AH8GmHh6qUOakmNrWj6QcY9HXDADUt+gWDIpZOpzJw0tQTO0+gamIKnhygF4rY
         +5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711103925; x=1711708725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EW5QX/PBiLajaatZ/82NErGaCFABadkL02aA8JURVjA=;
        b=XOc2Bdak623wlU6EYkftMilvpw3qlVF58u1xshCIqXnJvy+ncmbP1XWOt6TaLMAjFR
         +u43Z2hxI6OYS1f6KwW5GPI0UldPqPz20AE8DXwpnq8xladl6MCIDWvGZW+hO6+bpMRc
         SUcTumtjSYe+uPQvSZBzYHB4fpBAi4cAtSzXDR7LVUqR3qUQxfm0RCSbQhu+LQuyq/cG
         2WDBEXABkMYNrJwxlXQ2Hx/T3556y6TaK0dxr4G8dFLxZ/e2vGwQtOAwRuUwb+o7rCBC
         an6w0+8nW9wIZWbBdVpYOkTUzP09ReAE6GW4G5BC0b5NZAFhhrIeaAmyZpY/wNbUTUrM
         lAmA==
X-Forwarded-Encrypted: i=1; AJvYcCVZfwrE/IsuIelb6Fxbyun537lWtyX9jCSSkxCb1wNPjwXPPAwymQYWSsji/+pvbFTiZzvQd+SFyvC6Cjp0hyHEjsTQA7J8OTZxiArj
X-Gm-Message-State: AOJu0Yw5Qpg0nd29FhB+akcpANFGdIDP9D1SlmIe1dnPE4yC3rZqAZZt
	55dGnkP8BildOT/s/nJ+L1LxeynCLw6K13mN6oGI43+AmnsUluXk2kUlIlK/NsGbWMdPCW46IpT
	UTGOuKP60pvmG+C+dtiTgNRgBBnCvaOtpQnQjkQ==
X-Google-Smtp-Source: AGHT+IHSKsoTSx1uARV4yY9pfYF30+iJm9yZmLK1Rm0y026834WCXCVGtwW6NoGV0aiUmgbWwwTt9TMD1a0SiQcBybI=
X-Received: by 2002:a5b:651:0:b0:dc6:2e29:4262 with SMTP id
 o17-20020a5b0651000000b00dc62e294262mr1579006ybq.58.1711103925350; Fri, 22
 Mar 2024 03:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
 <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-2-3ec0a966d52f@linaro.org>
In-Reply-To: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-2-3ec0a966d52f@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Mar 2024 12:38:34 +0200
Message-ID: <CAA8EJpq1JSLdzpkbjSPjfFWvMEKgFBifjkOjAMQJUO40-bFnSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] phy: qcom: qmp-pcie: refactor clock register code
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 11:43, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock,
> in order to expose it, split the current clock registering in two parts:
> - CCF clock registering
> - DT clock registering
>
> Keep the of_clk_add_hw_provider/devm_add_action_or_reset to keep
> compatibility with the legacy subnode bindings.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

