Return-Path: <linux-kernel+bounces-80207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5431862BDB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C631C21042
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5D17C95;
	Sun, 25 Feb 2024 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neG5QkzO"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35896125CD;
	Sun, 25 Feb 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708879626; cv=none; b=sglMk4/7by95Zs9d7CemIs2tjfOnSaRwyUrIWPj+qaGk8ORsRtvQN+d4rDsmORccy8HvS+IL8eKlUc036ODCfRJVSsI7xR52CiKvaMZBVC+1aylkpMB/bdUTw1s+CbWjx7ZQenCy3TGD0ycITFYZ/V4v/VY9D29hyhFC4xoAPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708879626; c=relaxed/simple;
	bh=oHFuvFIbyuifb1IfxbA0QJfSY1OIHY2vHjkTUxN4Vl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5mxVkvS4CwB1qtLzzeGPDxVt4GoH2FfwSqelLoRkliryQSW2s3Idz+nZGmgVUPCCybKwrkMAxY+diJVatklvod3iMqoIO8XvTRvFNxmMT6C/83gjjsqL/v1f+aUxIW3oiYZ/wxTzebnq11CXRG7V1DuHDxHimOMEbQef/tYl2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neG5QkzO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso3156058a12.0;
        Sun, 25 Feb 2024 08:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708879622; x=1709484422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTJ/2sbZu8Xl5LKEUThJlLy2IUqFITvOG9DeGSFG5Sw=;
        b=neG5QkzO5VFx5zS+icmanTmlTyioOrtW8ki4MfqgzuvrU6js2hbCB3dwEb0+Z2UAxR
         /oDVB3iA03x9cWIDcoFpLUJiqA6cpLUnWH8G1XnbCz9GPUMuP29hPQtUUshNNHcxShmH
         MP2c74gdo8aquJfexdPgi0Yj6wtT3Nv8MdzKGZenRerNBrouFwGEcgcSevBxMuYhIVVW
         Rrg1UUO/eW5kCHHAdtP/xWZRzYNLnop0SBi1PPKL7uIbyLgMJiZv4Sdx1PhUCjdlEWUB
         sC764t4C6juWHE2F1qTaP0IiD9uGlQRQ0qxh/+KwQ7ooP443/+cHWT+kIhpnOM2EFtq0
         bvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708879622; x=1709484422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTJ/2sbZu8Xl5LKEUThJlLy2IUqFITvOG9DeGSFG5Sw=;
        b=GwA8eu9338KvVu9xmqRAAlE7LnIvacMf/DtP/brpHaJoZO1LxpP/YjeT03Dsm2PA2F
         SHPv7opTqOgsdpWU3hkwabU31dTOsyzh0Rcx+otj+1Imi3VeEYsEUeCBCPXs5uGyFWdN
         zreSw6SAqRf6RYSrBQHgTjanGwId9gvA04rGz1Dbp0TlOQQTrORge3cIPPWSwMTtlM+O
         RMyoyi4oGjxPejf7e4hAeAa8aa6OGV/vt4jtIlnjYi1cjNDFh7ts7zzuOTk0bUs+QhrG
         E8u1Qiypq4WGBhkunajZ3W9X46v0fkDe6lxwg7CQOiPeC6QKdd4atbUeCPlyiNO1cGkT
         zgFw==
X-Forwarded-Encrypted: i=1; AJvYcCXSY66T8e60utwYAPFaKcGkHsqkNNT+Y+F5MDYuEy2tf3H8ztcBfkA3wBOlN3EQnk/+Cx8vw4n2nVonaTKE6JrJixUXoMZpKbTd4LWc9VuP2gZvpInvGnHWVK6bBHSSm/oCDWWKtFJ7rt8c6dJCpK7ySXlhgmG022pXMjVHnTaucNmIsVOny4Y=
X-Gm-Message-State: AOJu0YyO1a3zQSu0SD1Rw6362FLUNseoK0oGQ6YLDs6MyCAbL2Aw6I6T
	NbV/kdm5j3ZamKS03NufJUsFmlDvpPSj7sp8f07rYZb7Vggy2+UP
X-Google-Smtp-Source: AGHT+IGCsJnb1EjoTPequaCTzQkEN/R1+zL+LJh7iDOJtQVZ7e4AOPZGfVksISA0eEyPZoAPASsqVw==
X-Received: by 2002:aa7:d5d5:0:b0:565:3aa7:565f with SMTP id d21-20020aa7d5d5000000b005653aa7565fmr3156986eds.8.1708879622286;
        Sun, 25 Feb 2024 08:47:02 -0800 (PST)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id fd13-20020a056402388d00b00562d908daf4sm1537101edb.84.2024.02.25.08.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 08:47:01 -0800 (PST)
Message-ID: <b214bff0-5c5e-48a0-9ec8-c0daeeb99165@gmail.com>
Date: Sun, 25 Feb 2024 17:47:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: add TP-Link Archer AX55 v1
Content-Language: hu
To: Conor Dooley <conor@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com>
 <20240223-archer-ax55-v1-v1-1-99f8fa2c3858@gmail.com>
 <20240223-enchanted-marmalade-04effab0909c@spud>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <20240223-enchanted-marmalade-04effab0909c@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 02. 23. 19:39 keltezéssel, Conor Dooley írta:
> On Fri, Feb 23, 2024 at 09:17:44AM +0100, Gabor Juhos wrote:
>> Document the TP-Link Archer AX55 v1 which is a dual-band
>> WiFi router based on the IPQ5018 SoC.
>>
>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thank you!

Regards,
Gabor

