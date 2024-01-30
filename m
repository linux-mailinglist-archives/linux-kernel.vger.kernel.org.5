Return-Path: <linux-kernel+bounces-44575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEEF84247F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A45AB2D986
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4253B67A08;
	Tue, 30 Jan 2024 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wI809zVk"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F55C679F1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616394; cv=none; b=TVvku0eZ2pY2yOJ/M9JWuwhHVIsnxyhBm+87JIUmn4rzWIuNFMNZ3nMEHbmrrEGHXwyahlTKU/u08phlFftro9mA5HAQ5OAmgAcb5DS6YijNv8LU44s/couAsQJbSd5MwdxmAX72p56AGayFptTbHNerimKdnOvHEWnjw9oLWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616394; c=relaxed/simple;
	bh=yTaqD2pQrVgSKsDtOXIwJLOsM6zTum1gRsH8KFTyS3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTkb+/PPMYOSvR0hpxBU+9nWwzuQYSLy5BSIWPTZagu+cSKDpUQcLn8agZ2+ZUu+3DbXSJnjqBUw3BAipPOL74jHVr1LcHme1Qd7nCfDUQq5Wg36i607wqn2g/H8G09Hrvc/YgIoRc+XBhuZhtpsUlfEXsQx2UY2bJPkq6CJ1nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wI809zVk; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e11faeb125so939970a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706616391; x=1707221191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VQPImZ/4IQm9KIxbi2fxjRtKvipwSecgsg8i7If4Jc=;
        b=wI809zVkzlLHQHJ33thWfJVWOmEp7vWXo6jENvSbqwTOmEtT5wpfLVjiJNvnufY3oV
         hoeB6S7GjAFfGVTfzKGcGs/8irLV7XKiapT4JafqHNEUhKWw73MyQ3wZ90kjhb2+DWir
         Scra9Rzmit3jmaAFMz4cKyDonIMzTgHrzKQFYFC2JokQe/sB4HSZuCgBHSh421w4Pny+
         L6Zg/fLE9kYtFBygcOoyRcliQNYP8MbKMBcufLAzLPivaj36ovv2C5SWj5pFKo7mjQGa
         lWuDK9BBeUZIvm9yOm5j+M3rG/zrEHCbjGvDwqLyT38og9zZHvymlgRL36MxlSRsT2M3
         QvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706616391; x=1707221191;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VQPImZ/4IQm9KIxbi2fxjRtKvipwSecgsg8i7If4Jc=;
        b=UJZneQBok84fkGd+l8yi10CzEGC/N6U6qbfDfYsxvC3ENds7BKSQUgYlIm//j4O4li
         py+KkYk40xhPF8WjkBr4TuKsNm+d4YvRDKqUuwJf/rpU0LAeu2tvTJc4N4E7V3GMFr6/
         Hx/ziKiqfW9n342NqvaQoz7EcalMRgHMK7ZABbhNPmYimXuQ8nOdHccItubeqmt5OmdZ
         LzUB5Vwh89t0hdvw9fbtr+ofIrsZ+SwNCbAGwVf3f+oXq7eEkBtSp3iBhUDkwGuAUXgM
         gMgoNsHP8vo9qJMWbYLD7TOH2sT4SNAu4315xDuXYjFI6dkuM5vFBPbqkyOXfUTe1FXD
         sTvw==
X-Gm-Message-State: AOJu0YzqdenPuQnxQ5Yf7pBln52KZiCAx51ZnEP7e4nx0DRX+vpCQ7aN
	jiq4ThxkNSANakT+cNMo44Sco4Sk+Y4fbjywmpUSvJp4IiZ4SuQicYhH1dzb9Ro=
X-Google-Smtp-Source: AGHT+IFaIOEigDgFT/5QQbdDQk5NbtpmVP0pGHFyvEoSZT0SYMoAUi2j7U7q3LV4g9f19uwS7KMz5A==
X-Received: by 2002:a05:6830:14e:b0:6dd:c918:b9dc with SMTP id j14-20020a056830014e00b006ddc918b9dcmr7418443otp.22.1706616391729;
        Tue, 30 Jan 2024 04:06:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVGnfi0kUIop1brl7MA5GjZg4Hw9TytnsDqbLapiK3kXUSDG7HIOtJ+zmS+kiSUnGuQQsLeCNB84sYNk9QT2NE5s5ctcFERZByhCLCOEX7kPZvc2S0gauu1N8noBs3XWLwhu/zzj0JTy79UwF/LzO1oSPZYRp6oYuVa5Hlp8obk4hbDrjTmWzef18XayKbXWY7kHpq5CfI39fgjqDmFOw5lJ+AzvfNW+4BckdE+qRIlblnNDlGZUer5e0/m+qNMIXttziXduQdfBKw7UNyakEiC6YUavD9rBI6fXF5qq98CMDujml6O43IQ66sOuY28Rl3Gqz8tYIUyyO3ezKIxdmIJWjWhQ+ujO5i/rJosI05KuBx8kdKn+3dH7WPKXWolvXXbQHvu+YLuT7QH+4m0a2fhwZ8V69pVxFBkO/IsdcdBpcUmSP8amgHH2lzoRo0UIQHJIa5XHnMlopry3MRebqNiFVxEdBiXKpNtaAbO4rnXyyPGITh7PssRnTMFmHSrgV3hY/dQiCqlp/8LbuQtL5jQcEMLnTg8gkfrH9Bs1jXd/BraW8lfynWw2O7DJqUMYVgY4loU3T/dhzeWq5J8I4RNfYyUgs1tgnJSFLBG7E5SAMGaWzmVjohJr4dhochatS2rMNqFqHyeVsA06AcdQZdk5whs4dRvZ1PMHvdfzy0D/4mFc4ny3XilAulwFwNt0y6x9TvY/3vwsjErFQObohLH9epGVbBzgexznhUKXhfkaOeEe4Rif9Ivcf6gnqf1ppPsXYHtD/J9FlXPfg==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id bz9-20020a05622a1e8900b00429d3257dd6sm3274367qtb.45.2024.01.30.04.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 04:06:31 -0800 (PST)
Message-ID: <a320fa4e-937e-4ecf-9d28-54cc999dd334@linaro.org>
Date: Tue, 30 Jan 2024 13:06:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 2/3] arm64: dts: qcom: sa8775p: enable safety
 IRQ
Content-Language: en-US
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Prasad Sodagudi <psodagud@quicinc.com>, Andrew Halaney
 <ahalaney@redhat.com>, Rob Herring <robh@kernel.org>
Cc: kernel@quicinc.com
References: <20240130120306.4120632-1-quic_jsuraj@quicinc.com>
 <20240130120306.4120632-3-quic_jsuraj@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240130120306.4120632-3-quic_jsuraj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 13:03, Suraj Jaiswal wrote:
> Add changes to support safety IRQ handling
> support for ethernet.
> 

You still keep sending the same and ignoring comments.

Still NAK.

Best regards,
Krzysztof


