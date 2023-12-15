Return-Path: <linux-kernel+bounces-326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19847813F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B23B1C2213C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC3AA48;
	Fri, 15 Dec 2023 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B75kz4pc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20042A3F;
	Fri, 15 Dec 2023 01:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67efd2cde42so10639256d6.0;
        Thu, 14 Dec 2023 17:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702604817; x=1703209617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zc5Tt4cjVQn6MSgiYjudGcIVio807ZWzbJuPs2L7F3M=;
        b=B75kz4pckbcGyj0zHaNjl/+U24061qx+9udSSNsIwvAzXo1jz6PrA1sIJ314MqZeT4
         hgciU1GSDkRbNCSuT7G741fzDes/Yps2idge2FSd2xWO5D9Kw2PJ7NCIaDiPTmqv2all
         +0fPDGRrxDM55VBnbTEnGLbcuBUKwYJlO9oqoqGUl540U6RsZFsUXLScyO0g0qTjLx3s
         zf/ghcSrVPYktWwDkU22ZYWxeoeNZFeDtt97elVUOlNjwNMPgA5wchmWuXiIi8d7Z4uf
         SvFehVhIJsV5oVKlZcx7fPcNPk95Q7mGU78maGqqrRDcpBO+W7o+7phxfnjDqg2xsK2X
         s8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702604817; x=1703209617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc5Tt4cjVQn6MSgiYjudGcIVio807ZWzbJuPs2L7F3M=;
        b=aC4nYYmF52TG4eXOsMZZfL5OQn6AAY6a6j/V6xz4upf/mbl3qUo8vtm21iTK2zR4Ky
         PzwhZZLcBzs28NsNNgzCCK+q983f+X4bNSeIJGrCbUsgkjtPhp2KovZSYnqEjn6A0RKw
         BkNiSNoj/NlYvlLT89FfMNRAwCO1VMaFxv1zhhNX2pnaFXkAWTMOkxnRR17HC9DNuSFj
         GbL6xdVC5e+01sNQLwj0DcRYbsBlEc4CMaVQc1FsClnUp/w6+RstVZPMIvpoPLwy3gLU
         xdsPnbPzzCxLSkHKz9EgHUru4VtVlyIU/Q0g6ZW9tSlU8oLGFbXQ+kt8/t21A402Qrtt
         TDdw==
X-Gm-Message-State: AOJu0Yz9rrH2Jsx84E3ExPRa1Ep0bCpGjmnUCm7Ly+b4oZCgm1v+KT6o
	3AH3S2epY+oLczX0VkU+5x4YU7yhdC/y8w==
X-Google-Smtp-Source: AGHT+IHemwIjbi9IJKMvNOOoGsS8XZb+vIcqTOdqZhejlHWxJ3n6iVhnITtvarq/RT5tbHcCTlqXyg==
X-Received: by 2002:a0c:e805:0:b0:67f:1ca:8c38 with SMTP id y5-20020a0ce805000000b0067f01ca8c38mr3660984qvn.52.1702604817000;
        Thu, 14 Dec 2023 17:46:57 -0800 (PST)
Received: from localhost ([2607:fea8:529e:7800::a768])
        by smtp.gmail.com with ESMTPSA id du5-20020a05621409a500b0067ef2e0ee43sm2217973qvb.81.2023.12.14.17.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 17:46:56 -0800 (PST)
Date: Thu, 14 Dec 2023 20:46:54 -0500
From: Richard Acayan <mailingradian@gmail.com>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sdm670: fix USB SS wakeup
Message-ID: <ZXuwDtPQZR1waaC7@radian>
References: <20231214074319.11023-1-johan+linaro@kernel.org>
 <20231214074319.11023-3-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214074319.11023-3-johan+linaro@kernel.org>

On Thu, Dec 14, 2023 at 08:43:18AM +0100, Johan Hovold wrote:
> The USB SS PHY interrupt needs to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states.
>
> Fixes: 07c8ded6e373 ("arm64: dts: qcom: add sdm670 and pixel 3a device trees")
> Cc: stable@vger.kernel.org      # 6.2
> Cc: Richard Acayan <mailingradian@gmail.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Tested-by: Richard Acayan <mailingradian@gmail.com>

