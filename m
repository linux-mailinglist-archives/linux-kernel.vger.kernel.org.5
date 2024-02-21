Return-Path: <linux-kernel+bounces-74946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B204685E058
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F4E1F252D1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04BB7FBC8;
	Wed, 21 Feb 2024 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEkUQiPu"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACFA7F7F0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527286; cv=none; b=XLz0Orzgq6QNTl8oTzZnX5cDRTJ8kWv0HIvkgzZsVJJZA2pQyITx+njzxjgOaqUSWrJs3PpGqI+9izSInAnb6XpxpopJVT3QmHcHM8wAHfMhDQCbHrmgD78LCs9eQxPtHCGpO5RxrswnpOW0y8OQ3DBvq5M4cm414xMX9FtEWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527286; c=relaxed/simple;
	bh=d605qvE8oJLHFh8wYpuXeD8Ss2JHKYc9jQTlWWU/2bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXWaF+IJIzcbVYRHu+TB93tyyc78GbNLPy/+1SGtLoxheb9qqcrrecvsgTrKMt00P3JmY8mVNApWlF8WzBObrnSXWdkHQuHfQ8HNrhVWlT60ReZOEDnKOddBtGpfY/5A9mIwIE7vpzjoLs4yaHh9cuo9fO1yN+Q99mgOjSUjBfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VEkUQiPu; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso1173210766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708527281; x=1709132081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PwDrSDwbjDuhxc0snjMmTqWQWr4yGG/YePGvnYIgDzA=;
        b=VEkUQiPuRTysHhqswZ0Unv01p4biFu22CZMoufZ12rNK2Aofk3L6Pm1+GqyS9YyFlE
         ghwh+rIlsf1L2Ek4khEIWz/bC2mRCoy8uT4dPVaruQZbbwLv/UUwjGexH1DMoHU/h/hY
         VyApC0OubwFJTskhwJYnGI8AFxnc+ERG9xuPVHcGQUa30aJlaAk0s2Y0ZLnJInuMyPa7
         WJm0Wq2NWl0iUOpG8qCBmDCQVnH8fkdIm80UaXggsZUhSL+UD6kh1WNyrIe1tDlWxPU6
         aWwEV+Nshtwd2JDrXOP0422nec9J+ZZvw6jupXRrvoZBraD37YzQf6mexQ97m5SLHqWL
         YTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708527281; x=1709132081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwDrSDwbjDuhxc0snjMmTqWQWr4yGG/YePGvnYIgDzA=;
        b=rJhY2eUAKtTWB3JVdGpk59O1nblFobchQmHQCNeu13YbQ6OHyTvProhMtkIR/zeqz9
         cEtIPR09gVQAxkLnZKdNte1pG3C6OvDtqcWHTIsPo4DEhY4Eyhmg9+lsU3MWivfcmJe/
         Og8XwLHiv4GuQMwvlAscQ4Gjvk8AlljGkG9LYDPz0HdIpKxYpM62FEX2rWiAZbtgx2RI
         awxiNa19g85GI7Y4GuwKwVvJgpr9uhw8PPu9EWMCjqBRYvzY39hQSYqjhuDr4bcGFqnH
         KU0OPTDyjxlvZPy2Gpumtg9LvJb6IZh4cAETJ72eGYxnLRoxd5aLlLqjWeSwfNTE895N
         +TUA==
X-Forwarded-Encrypted: i=1; AJvYcCUzKmFjCw2P8YNUP+zqEyPDJKxxPUqQ8xJ3UxZMbA8LzfX+JAAtW5lbJebaDCFlX1KKetdyXiJiFgFOgNEdoRjCp5ml7jd6GdUZMgsH
X-Gm-Message-State: AOJu0Yxvs6i85WitHcpDjz8X2o4QNlbHbvxVvY1c6SDuZXpF2up5IoZx
	SswNd6bFZuwtHAlWkhuGbDn7BddpZMUPE+k0bRRjboJI0dFh4dRp695EHT5zi4E=
X-Google-Smtp-Source: AGHT+IFa0ka2O3YAMzNW85WaQJjneiiknkL9slfUTJVV+TJHkqkF2wZ1NixE8hX5BSi21jsQvB7kdQ==
X-Received: by 2002:a17:906:fa87:b0:a3e:c6de:e5ae with SMTP id lt7-20020a170906fa8700b00a3ec6dee5aemr7804788ejb.0.1708527281343;
        Wed, 21 Feb 2024 06:54:41 -0800 (PST)
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id mn6-20020a1709077b0600b00a3e12ded9b7sm4755684ejc.169.2024.02.21.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:54:40 -0800 (PST)
Date: Wed, 21 Feb 2024 16:54:39 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: Add SMB2360 pmic dtsi
Message-ID: <ZdYOr6/8dupbMdbF@linaro.org>
References: <20240221-x1e80100-dts-smb2360-v2-0-037d183cc021@linaro.org>
 <20240221-x1e80100-dts-smb2360-v2-2-037d183cc021@linaro.org>
 <bc45229c-6412-4fd5-ba8e-28b293d7864b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc45229c-6412-4fd5-ba8e-28b293d7864b@linaro.org>

On 24-02-21 15:41:41, Konrad Dybcio wrote:
> On 21.02.2024 15:38, Abel Vesa wrote:
> > Add nodes for SMB2360 with the eUSB2 repeater nodes.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/smb2360.dtsi | 51 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/smb2360.dtsi b/arch/arm64/boot/dts/qcom/smb2360.dtsi
> > new file mode 100644
> > index 000000000000..8d7bdb56e6fe
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/smb2360.dtsi
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/spmi/spmi.h>
> > +
> > +/ {
> > +};
> > +
> > +&spmi_bus1 {
> > +	smb2360h: pmic@7 {
> 
> Hm, I'm not 100% sure about bringing in this letter-suffix notation..
> 
> But then, is there anything better? What are they called in schematics?
> SMB2360_n, perhaps?


Yeah, just realized that this is wrong. I need to do something like
sc8280xp-pmics.dtsi.

There are different sources of information for the suffix, some of them 
use smb2360k, some of them use smb2360_0. Will go with the second.

> 
> konrad

