Return-Path: <linux-kernel+bounces-152253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC7D8ABB68
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F71B2138C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACCF374C1;
	Sat, 20 Apr 2024 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uVqX/oD1"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C3A29422
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713612670; cv=none; b=atq0UiYQqkuaa+0IxwiAWNXDSsMAaphTuhwEb2QfyztuAwAtGH+n7HEmFWInBfFfWowtmhS+GgJlIlBpK5G9q4PsFlfa7dJyHLStthGcaoFuTi7PXrCTp6qrOpOfx6UctAfo96S4YgPNtgUif65u1Z5GuDDC96lawjBTkV1/Otc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713612670; c=relaxed/simple;
	bh=pawPlGAegmUcbHOz9d1bltyJzb5yP4n4W4h5P5ZnyJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4uDBcRcikHbI+6UsNjSfO+BJAZfXU1nFOUMtELjB9p6g93fqHVq72HZ3XoaQfrdi1KwdegtO9N25qOATqp92uL6mzWm4aJinRzvPQju23Ur7rN+IL70InwCFUESNwh7+geu+XUbrtdtSiY9k0qEm1LS0qg/bNUVTCIU6D4q8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uVqX/oD1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4187c47405aso19548625e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 04:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713612665; x=1714217465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=juH++PmotbDBKPrtgNOyCREifYMeAZx5cOkMx0r15I4=;
        b=uVqX/oD16IySV79kxGJSDp41PuJa0UmW/a/L8hS4ImoNFBNm9V9+gd0BUar32naxxn
         WqCcv40AQcd+jdz1CBK3ORkqt1mSUrbGcwGotATJwsay1BxupUuNuJCZRiAv47hm8+TU
         TevM6dmV2N6QSbnGgvWc9JnYhPLn5xFtaL+6FGre9NU4UToIrT91cgNayBODJeEfHt2Q
         eiMcVCED3WF/MLOM0UBZigxH/CgC5riIIk9TeBYSQJq5g99NSjoZfOJTmLEjXqmhG9Dc
         5WEDZ44LP+ofrafn8h6Ht4Ct9HlsOehE7AgSW8DWNn3KALt2WsO2n+xdRPES0EI0GVFw
         H+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713612665; x=1714217465;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juH++PmotbDBKPrtgNOyCREifYMeAZx5cOkMx0r15I4=;
        b=jWtEl2Z+62B/n25GCHvAfI12bwzdO0j2wgPyRKEzamwoSkp50RpgHR1yHmmoMa92X+
         l2eDWJWOAonb+HsDZdDLH911TreCW5svWOLDVkowUBxfv6P5rBXedaPHqPSrh2BQJLD0
         Faq+A4O5aen2bdA/HegOfHx4bxITWLCOXYXg76ptbQOK73teVs4IWWuuzHJqvO8TULEV
         85w4j0SL19ybfGfQuLDhfVL3UdGGEwKU8ik9HFKDVM5GlhhmR7wBoYRFY7PgJJkeyxIr
         zcHeBhfj1dES9UuEK+mbATCfOH1otae0nBcU8i4hg4qKZAiM6s+5/1TkjOmKm9E5Vgrz
         HHdA==
X-Forwarded-Encrypted: i=1; AJvYcCVhlopPfjmymK7du9VW5STYjkPyI/NoEjz8rr6cRYSQ5bfxc9FRcPintuDOuhoDNeqCJpUWV7YlBBOgXub5giNuQ6Glst6KNjTQqM9t
X-Gm-Message-State: AOJu0YzMdrv6XR3pSzbMYUwjPptiuZZZPoaMTYmHBoCrqVmiG+fERzsB
	ZA2f67um5vN7gjapTcPRIoIIwmC+mgqJ4OHUMOKiO+kLAZCCP52FhDEMv5Qj+zU=
X-Google-Smtp-Source: AGHT+IEpQxOwPl01GAZYfLQXS5h7m+Das6WRfoys9gwq53gGo43TGH0uMgnPLs6RMT7q5Qc1Ri4NFw==
X-Received: by 2002:a05:600c:5489:b0:419:a1c:8fe1 with SMTP id iv9-20020a05600c548900b004190a1c8fe1mr3328386wmb.38.1713612665269;
        Sat, 20 Apr 2024 04:31:05 -0700 (PDT)
Received: from [10.236.36.88] ([88.128.88.151])
        by smtp.gmail.com with ESMTPSA id j10-20020adfff8a000000b0034335f13570sm6594513wrr.116.2024.04.20.04.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 04:31:04 -0700 (PDT)
Message-ID: <3ca24a3d-e7e0-4f68-9a6f-ebaf83079ebe@linaro.org>
Date: Sat, 20 Apr 2024 13:31:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 5/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
To: Krishna Kurapati <quic_kriskura@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
 Johan Hovold <johan@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_ppratap@quicinc.com, quic_jackp@quicinc.com,
 Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-6-quic_kriskura@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240420044901.884098-6-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/04/2024 06:48, Krishna Kurapati wrote:
> Add the compatible string for SC8280 Multiport USB controller from
> Qualcomm.
> 
> There are 4 power event interrupts supported by this controller
> (one for each port of multiport controller). Add all the 4 as
> non-optional interrupts for SC8280XP-MP
> 
> Also each port of multiport has one DP and one DM IRQ. Add all DP/DM
> IRQs related to 4 ports of SC8280XP Teritiary controller.
> 
> Also added SuperSpeed PHY interrupt for both Superspeed ports.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

v21 and suddenly you drop tags requiring everyone to re-review this. I
do not think this process is working. I will not re-review this.

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.



Best regards,
Krzysztof


