Return-Path: <linux-kernel+bounces-74884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C285DEE8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005691C22D61
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645077BB1F;
	Wed, 21 Feb 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9i923hU"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7969317
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525365; cv=none; b=Q7+ZRHiHMKVs+o8EAbWIzXSmbHK1I+Gin0bHZO/JsFkqQMUeD9rRKOpfjG0rVHfPTCD2Md0OkZj2lERtEsjQqz5o8KOO6n5qYLyzpm+RN59qyKppFFs4dwnGqNu60pRqYdGlSIGV969eHQE3lNg2bPl2MSlax/JyR6EBk36P9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525365; c=relaxed/simple;
	bh=+/oEf0SpCdr8BvNbadki6ggGM+Xm3jGvvb+UR34Vdn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEEF0YFSclEg/+BZE3oDqQJAgo3Va9DAAg88OsaiPyqaTRmP2l7pf9SsciZhUyLfQM+wpYI8qFIPDSiMegJWclZMsMGgIo+Hcl+DHZrtLizHhfS6rRwn682qTOOxTNEe5OI+F4EiV3YxHIPi+HFUgFfulNHjDsCZ79FV8YDxo8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f9i923hU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e72ec566aso88172766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708525362; x=1709130162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+/oEf0SpCdr8BvNbadki6ggGM+Xm3jGvvb+UR34Vdn0=;
        b=f9i923hUux89/qRuO+UK6EPoDiPrbvtFsPQBTHsuKHgIeItA/a+PzcjsUBqmLy10nQ
         qt28fMb1EQY4rYWcIX/Da/vfUgAlTDPV+4VViLgVrUVbUaqBNX9BfHfmWWZyNmVGV5CZ
         Jjyjcm2D/v4IQmHJXTipSia38y/uA4xmjOk4fkzCepgH6Rfuzt1OLNIO8ZuywNg2e9+m
         0MbZKW2oe7lQNpMmbhletBXNHqYIejBLHf+2GZnvemuntoviKGge52QXhB4ydgh38nd/
         C8wtJvaJ2ZfF3XPbx1JESS3mCGrvefBIo36/ST26rjQLll3iJycC810edVn7abSMV5/8
         9TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525362; x=1709130162;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/oEf0SpCdr8BvNbadki6ggGM+Xm3jGvvb+UR34Vdn0=;
        b=bQcGpUE8LA2w0ESL0oM1NnOBt4ZNiWSa6mMjIeasqNcHemU12XoOMUjVUsOkviG/EY
         rG+ekAVx5Dy93Guzd2x1qsgLSLlgOf/MPmsINa4R5oWj8JA8jPOpOfj4QwDCRpdO5VdD
         XG08rmG642yU2c9cW61qtMkwb7hrEiDT68AgB1EsimXCHvclrJolExGdgzgp7MhyILdM
         g/IjxI74nYbISAf93mU+0kW3SB63hWfX2qAJskMvPxMz9GKAOjqvjCkcO34MjoJPo0Bd
         0XMOWK2fYhsf4JI4+RZTqkF0lyzA6hK5q7Uv1iOdnhaGEMA9gWYKdFucNVIutqqIj88U
         saqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYTyoCeqrSeq+9Qn170A5RwUeNYR0LdQ1dFd/7Cf+nW36PMiUvU0us4WbpwZshqUQKaDJNm3+GBIKAeYC3kAJxSWHuxjAedoT0BbQv
X-Gm-Message-State: AOJu0Yz4HAKNHc9A9hkJVNmSDGMkikqvoK3GyGP4hgOLABgmnmxF7z64
	6TLiAbdmn7mQcDQxkIUaqWUQLQc5w0WhlXG41HbTHQGVpwSHRs4+CWRTlfLxVd0=
X-Google-Smtp-Source: AGHT+IECeEoTzaH4cCNs+sQ+qLZT5x4mlhw8kfNjMiB8IqJLEjwMJf8a2zJiWrqO8MWf4aiapd/7yw==
X-Received: by 2002:a17:907:1704:b0:a3e:b0ca:5d2d with SMTP id le4-20020a170907170400b00a3eb0ca5d2dmr5424527ejc.55.1708525362055;
        Wed, 21 Feb 2024 06:22:42 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id vk7-20020a170907cbc700b00a3efa4e033asm1659575ejc.151.2024.02.21.06.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:22:41 -0800 (PST)
Message-ID: <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
Date: Wed, 21 Feb 2024 15:22:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@redhat.com>,
 Maxime Ripard <mripard@redhat.com>, Erico Nunes <nunes.erico@gmail.com>,
 Brian Masney <bmasney@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240221141350.3740488-1-javierm@redhat.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240221141350.3740488-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 15:13, Javier Martinez Canillas wrote:
> These options are needed by some Linux distributions (e.g: Fedora), so

How ZRAM is needed? Why Fedora cannot boot without it? Debian, which I
use on my arm64 boards, does not have any problem.

I kind of repeat comments from similar patch earlier:
https://lore.kernel.org/all/fe1e74a2-e933-7cd9-f740-86d871076191@linaro.org/

About XFS: I don't think it is needed to boot anything.

This is a defconfig, not a distro config. Please don't make it distro.

I will gladly support things needed by systemd or equivalent, but not
unusual filesystems needed by distro.

Best regards,
Krzysztof


