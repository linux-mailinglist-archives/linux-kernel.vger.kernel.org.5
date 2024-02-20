Return-Path: <linux-kernel+bounces-73776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD15685CB04
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8873B286609
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E126B154433;
	Tue, 20 Feb 2024 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9ip4Daa"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AFA154425
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469083; cv=none; b=Pq1OoiysuNm9RD2iho6pED/QGluGr+P2IxCjR9opOCNsOhQh7mAa+M5NPhwH5j7LArvVp8Vv6UFvkPBaLxtNHEDycQ80tcm2hZ+K4+PXwebU1K2tbjadsKk/UXi+m7BKtbrxmMouTKBSaC9pFbZpxezmVW7XR+BBDOIVu5Ktb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469083; c=relaxed/simple;
	bh=KmMay3AHFlc1aguHp9/TkpQKADQaXT/Z55LlMD/bDfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sssf5M5WvgkCn8RhxBKUw86NJSInPok1IZdQq34Qq4VKfh7KI4DYtRQnN01lZS96RE/LPizXOF/KKA5isDnAi/HBjGmRk7tVGcmZmdHRKUd6ACoj2ZgcLwvsGqQzCgLtDa3+nGmR6x9CcsiX8xrYV6ehvoqAr7JKZHsM7wy/lqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e9ip4Daa; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso4951489276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708469081; x=1709073881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Er5VAYhNSWIzSdSLpbthmXT3VmJJOcraX1chMlaJ038=;
        b=e9ip4DaaSIucVffpkgI6MWxcAOLvGY0wW07tlfsseyNTUWjG1AvBjxcs1QB5bxJvFC
         ZjHPVV5JjmmgV7D4Y9g0dxorryX95X1UASUAk0KGSkinPrKt8CqTws2MDFQXwo44iuV4
         TAwoLW1XrgAW+T1pS/c/fSb2Zc1ZF/X028CNuFIIjsOjuuxEkUvTkZ+6lwcDyjeQ9U8B
         PdMYxFGqo6ZQYXqci+BPH8jSZQuKTpZIPqT/ZBFId0qBSkS2aP4DXk109jstHF4M7IPm
         OR1ZwQgKA2HdQPYXXryUwEaV5/H7l0M1WCI22oTkAILykFeLYvylhwRakuMrbTCObP8M
         aE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469081; x=1709073881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Er5VAYhNSWIzSdSLpbthmXT3VmJJOcraX1chMlaJ038=;
        b=QNocmXPg1KLEWncvCsxeaMgG1IOkODJfCcdyBRjg7n9G+l9qapXTPl+JD5gVdK1jyk
         nVt0wjUzjDIL7YlO4y/aIZELbnf88+4g/nwSZ5xtg6eXzFgo13U3qGtnY7Z9XIkb9Ix/
         FjycykxFHlZyJtJuI0UidVc9BJW/gb/5XeARRiJrEGiaZxz/cqGQaRee9JnGIFp/IOij
         tgRYJ27sTqxcUJJxFLnmPLvlygSf6rXhTm5g9QUvHf53z3lakVV/2WGHn8JteiHqRB5s
         43j7mQyNPoIyiEebwCPDkSNOBkMNYzHhnU91MsNRy7fWZgHZP0VD4PA9ppoC/E8PjXHU
         FQVw==
X-Forwarded-Encrypted: i=1; AJvYcCVz1drEARgyNXltelcBWe1krZDbhOilkmH8hlOHYbRpVV4Vks1uE37K65sURgSJPuz3QZpwS24xu+ZVSFka7NGJ9GIN1zhnQS6D7oKB
X-Gm-Message-State: AOJu0YyUbTfnMS7X8aoFLVpYGpKUzjyG83XHa7MgrJ2+RaH8SQdD4gEB
	KonjHyPUZ2SHPU/rkzTnFNWu+mt1o6Fsxbm12M+T+0ypxMvGmGj4espcuidmhjZjJH5bmifcjlY
	oCa5ox2jKAunP3LXy0Fux98eRv6ljxCBSEzoH3w==
X-Google-Smtp-Source: AGHT+IGck60Ujjz3YKtMApNGN0o7Q3lIs5rKyd+3XwSWjBY5bnHdduoZvVu6VAT2sswGZi36nYAlChFKILL3g+wOCIk=
X-Received: by 2002:a25:d6d6:0:b0:dcc:7ad6:24de with SMTP id
 n205-20020a25d6d6000000b00dcc7ad624demr15259122ybg.0.1708469080739; Tue, 20
 Feb 2024 14:44:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-phy-qualcomm-edp-x1e80100-v4-0-4e5018877bee@linaro.org> <20240221-phy-qualcomm-edp-x1e80100-v4-2-4e5018877bee@linaro.org>
In-Reply-To: <20240221-phy-qualcomm-edp-x1e80100-v4-2-4e5018877bee@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 21 Feb 2024 00:44:29 +0200
Message-ID: <CAA8EJprDzKJgU5OfMoDG47KDp224mT8V+-q3cVvGjQmPjho8rA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] phy: qcom: edp: Move v4 specific settings to
 version ops
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Johan Hovold <johan@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 00:05, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> In order to support different HW versions move everything specific
> to v4 into so-called version ops.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 183 +++++++++++++++++++++++-------------
>  1 file changed, 118 insertions(+), 65 deletions(-)
>


-- 
With best wishes
Dmitry

