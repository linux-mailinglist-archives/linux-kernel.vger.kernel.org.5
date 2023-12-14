Return-Path: <linux-kernel+bounces-135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE11813CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F6A1C20896
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F284F6D1BC;
	Thu, 14 Dec 2023 21:36:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C35F1E2;
	Thu, 14 Dec 2023 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5913b73b53eso40364eaf.0;
        Thu, 14 Dec 2023 13:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702589762; x=1703194562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOfIXMQdmVXtw/LaT+kEhtAy+i/QDIyW7XZdUFyrkYc=;
        b=oBqqr8rwbL1nYnJk0iB64rjFYHcUSEmJM5VCetWd0N2GiQ7zQki6qokVjTs9+XE99K
         tMVDc8iO97kmVnUwZqp6i8klOxQxAB79YXucbiatBMisx4i64ij3SUuZ0ZlJAdpG37td
         d4iLHVWSHidOc5+8SpYLJNtk1K/degl5A+KJBD+T/7NuDlbVgjUDWAvdjOo6XnR7NXaR
         IEUqW4Rm1VfWoYt73H6FI1h8SLOFwQpVQQYz0DmppvurdwTQl3CxbtJAATnr+4I43nkt
         VSLqcZYD6Kq16PopWuWCbyS0/TP3ElFCp32s/tYxi48L6TftRqfKKZ6QYGcWzHiA1ASf
         NYHg==
X-Gm-Message-State: AOJu0Yz4EkAHYBbR8mQA9avziBphsHzn+C9scJ3MECXagp9M3Ab0wfB5
	aQ7VBNC+K6e5W94xCPdxyw==
X-Google-Smtp-Source: AGHT+IGQwAEAEsXKwPod/9C7p+UERtNGBRBhXv6kCpyQfnL61ttM0xzFs0wx/qtEEGJNigaSx/FJbw==
X-Received: by 2002:a05:6820:1c88:b0:58e:272a:7da1 with SMTP id ct8-20020a0568201c8800b0058e272a7da1mr10570842oob.2.1702589762638;
        Thu, 14 Dec 2023 13:36:02 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id az2-20020a056830458200b006d87b9d84bfsm3359255otb.12.2023.12.14.13.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 13:36:02 -0800 (PST)
Received: (nullmailer pid 978584 invoked by uid 1000);
	Thu, 14 Dec 2023 21:36:00 -0000
Date: Thu, 14 Dec 2023 15:36:00 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100
 LPASS RX
Message-ID: <20231214213600.GA975481-robh@kernel.org>
References: <20231211123104.72963-1-krzysztof.kozlowski@linaro.org>
 <20231211-cardstock-elevator-3e19f9d41ac2@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211-cardstock-elevator-3e19f9d41ac2@spud>

On Mon, Dec 11, 2023 at 05:29:50PM +0000, Conor Dooley wrote:
> On Mon, Dec 11, 2023 at 01:31:01PM +0100, Krzysztof Kozlowski wrote:
> > Add bindings for Qualcomm X1E80100 SoC Low Power Audio SubSystem (LPASS)
> > RX macro codec, which looks like compatible with earlier SM8550.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I wish you'd send cover letters when you send series of trivial patches
> like this that could be acked in one go.

Or just one patch because it's basically all the same changes and it's 
all going to 1 tree and the same set of people that will care to look 
at it.

Rob

