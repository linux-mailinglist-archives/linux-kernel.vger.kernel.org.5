Return-Path: <linux-kernel+bounces-99233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CFC87855F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5591F21E21
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964AA57306;
	Mon, 11 Mar 2024 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ExQ5/Xjt"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F948787
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174158; cv=none; b=OYZQDQ/Ssqt3HPfA7XHIb9z6ZxG7fGODaF2L8CB9NgXuvZFpbRYOZbq+7nhmYapzMsv7tcQoeqwReunE+mJyCu1+PO+SWrD+AvFGNGYfl77iQbRaH4U1acDcveVxesbt6R6WltdysyDE0f766pswHc9QCSxUTLkEFFKl/xcCko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174158; c=relaxed/simple;
	bh=TGWBHdhRObFJXZsN7lz4Jh4gFRP1ik+fiRvx0Bj7OEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XM1Gq7hvC/VD30lQjIFs3Mx6+TaUQ5x4fkR+KLLG5umBoZHKcubO2n0sJo90yJunx0RpzE+309WBJHSqvw3PzqbUgnbY3PmVhgsgCZpRs4h6VkQAvlNAKZyfx6TpEOrjXFQXjTQDMG85lWsy7tSZYi6w0ZtCpIp/OE7dYp7nkuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ExQ5/Xjt; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso307432666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710174155; x=1710778955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMW0usQA+/2JDgwiFHaoEUsMDf2P4w3C5kIjpwHZkUc=;
        b=ExQ5/XjtHmCa1RwzS90NWiAM//fTp5HaQ2RQt0Dwy93ty2OFCM97P8JJC4h7SqXE8a
         Egg5oxL2fy4hYe3km0oBjuu/nuw1lAqPa+gOLPyw1sPxn0hJ/gaHDv/dHqnpKreS5b7b
         SnT9sNLpnqTiBcRimXGmp/yvr/rjfDZCxBqvNleSYGfBBirjChBTVoQN0fWOXw/FkSDg
         A7izvROYEBGyNOG+ofXWIcZuUTNjV0EfG+S4kLo/89EI0TQfc6iQfk64LRweSZrsqZku
         u7zDj+kFktKyZh15hmc5NRB8svidbvmgPYj2CRaDFdPrGRSpRcn59zx7Va+UQJ6XFyej
         VMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710174155; x=1710778955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMW0usQA+/2JDgwiFHaoEUsMDf2P4w3C5kIjpwHZkUc=;
        b=qPMJuDWWZepSmNvcVVBVan8j12N1vDXSENIg2Lup8boT5dXexzLK9jpcMHJHVrNvAJ
         elOIl7PITn9lkJQWk4Nis7kNXA0B1Sv67p8NyiruQV0Ser9KzZBjKmMB2cjhVvNPUbRU
         HubRFiNKEQ7OJWF8sidrKmri1wA09sTUt3dClnqDG9Jxs/3e3DOJ39o8sYfgIggn39fK
         R2vR3zCmblaT7bP5+eeLHvGkza+eeNW9NAHtPJ+Wg4SCeXphPR0nEhNb5B8Q7xu3Tukt
         ceB7IFrx31jWsp7rffKBHBCMlf5b+jcfmr0posxWgsZZHr1Vn0oTUxg2YGWo3Pg9O3hd
         mU3w==
X-Forwarded-Encrypted: i=1; AJvYcCVSpTy5mUCY+RnkaKET4SneSUq3nJfJ3y4DveeCx5alyxghU0QdH5oxVdCIWlzEEeQIjPiOVbOCuIV7umgJXFyjT+7TxHJd7UwYLsPF
X-Gm-Message-State: AOJu0YzeGicVSEOi/13H6ZU4HAYkQkSlVISC8ZZVrRuy1252igg3AyeP
	iTIZnaa3+iElcboLPVtnnABaEnFppTlY8B+9S9pZtHkI7f1opK+PkZivzsqH2IM=
X-Google-Smtp-Source: AGHT+IENgrDH5fiAmB/1105qTepyqCD7Hz434Z6EiqT/FtseXotKqyuwYDqaF3lUkw+P5xEEJ4kX1g==
X-Received: by 2002:a17:907:96ab:b0:a44:17da:424 with SMTP id hd43-20020a17090796ab00b00a4417da0424mr4858235ejc.56.1710174155578;
        Mon, 11 Mar 2024 09:22:35 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id gl8-20020a170906e0c800b00a43e8562566sm2960425ejb.203.2024.03.11.09.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 09:22:35 -0700 (PDT)
Message-ID: <5800231f-633d-44f1-a056-58f87f1d5c67@linaro.org>
Date: Mon, 11 Mar 2024 16:22:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Move camss version related defs in to resources
To: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 hverkuil-cisco@xs4all.nl, quic_hariramp@quicinc.com
References: <20240227122415.491-1-quic_grosikop@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240227122415.491-1-quic_grosikop@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/02/2024 12:24, Gjorgji Rosikopulos wrote:
> The different resources required for different camss versions are
> split in to two groups:

Pardon me for not getting back to you on this earlier.

Would appreciate if you could post this series rebased on sc8280xp 
patches which are @ v6 and ready for merge already.

I will find time this week to test your patches on rb3, rb5 and x13s 
with the SoftISP patches on libcamera.

---
bod


