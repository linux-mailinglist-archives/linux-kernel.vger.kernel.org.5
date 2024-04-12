Return-Path: <linux-kernel+bounces-142773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059868A2FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE7C1C20E23
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4A885C7B;
	Fri, 12 Apr 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLrtQhV9"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B3A8593A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930038; cv=none; b=TK0d5W3buCLui2Ml+0O7HqU87Rumk+GajuSby046SaKhPqAbjRpJjgVzf6cbq/42Id0/9Xa0A9YHEW25l1jplzx87HWxWPklDiu+Eg9nunI+dTIuLUIMO4SXh5xtM4WWHUmmFhFQu4iQPl6iB/DUzahCfG6Vw5NpGWhc3bWnJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930038; c=relaxed/simple;
	bh=9IyAEWlJOaDRc7lemdEkDzM9yIIkXvNqtT6/JdKH4k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myQdlliOBb9YGloIqoM1VZk/zB6eIylFWCXOgoq1/8VK3qfXGxusjB476hMkGApR7sTJYj8hxEntnztaIdOJA5U2b1uxwQ3ee4Yde5ZH79E54ouYhF5Xazo0aOYUwVNssmoT3A/nQLkuwll16YNgowpZaUyyaaJR1/vLmPS8u/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jLrtQhV9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so937827a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712930035; x=1713534835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OZDAh4RJKN0lCfNyM40gq+9n7tFtOvPXFiwnprF//0E=;
        b=jLrtQhV9zhW+Sx6JomjobDVINqxeBiI8xwhf1rJ0I3D953X6rxDWaOzmQFzMid/X4f
         wk4XdVj6+319V79dPiRx7rMBu7MUPFCEoNE+D5yi/jxoHJz/8NKsIYOv7ZoeUdwLjkaR
         O05YfWg8RMQ0l2AA8qWbVXW3BIbBmHnTEpnmcLQvWqaMZPOWCKHpWiusZvZE/NaGVxvc
         7d4uoqRXjTE3p9mYCDlBA60wBxe301/DlKbfIqCqL14ZL9s8tDJo8o/PSp80IWs0Lj1e
         ujJ6M3ugWxo0+/hb53jiKwV5aOQiZarJJHkAlcfy2LZ+s9whaljZWCU32KoDGwERXcWX
         gGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712930035; x=1713534835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZDAh4RJKN0lCfNyM40gq+9n7tFtOvPXFiwnprF//0E=;
        b=BfLkjjN6eHJg1fVtFgB3nLoU0UakhrZ/b7Wo4ruEA69H7ECQS6HZjO+6N7wV33WnOc
         9zMM9f77kBZkuiIpx1oajZwHL1IxMsp1ZDJl3Wp0DfcSVa9xPjLLomWXL2feS+ANdFlw
         khYGrkSCUNmui0dQTUUxaKV1CRtOZyhw1tsMYvY2la5NtP43OyA3TcDt2VbdU90P1eR7
         x7f3+9fKD9YkfMaTeyzk1RlNLDS/C+fhDlk/qBI9qy20dL/yASh31hckdbWgIdpDNi44
         dAibRlcfYWmVO84dLARloc11AK3sP/c4zGn43tCqKAzdJew7BSk/eaGI/9gJLzj3/wzt
         EBJg==
X-Gm-Message-State: AOJu0YxEYfwEr8eG2n5WYu7faT2q9bgVAj+eyoeZ5x79mU70mz5LLU/v
	t9vOpXSBDwz8su495fwjGDiCUgpWCas+jnoOgFTqj9wMBNQ8IEXODWciIahDO5w=
X-Google-Smtp-Source: AGHT+IHGdLT3xh+OfkHFowI0iMM2RnENLU9VQdb2De0ZU6EDTzDcEuMelz1LzDyIXUS/CZzCUCCC3g==
X-Received: by 2002:a17:906:e2cd:b0:a51:b23c:1187 with SMTP id gr13-20020a170906e2cd00b00a51b23c1187mr1700707ejb.12.1712930034691;
        Fri, 12 Apr 2024 06:53:54 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
        by smtp.gmail.com with ESMTPSA id gx12-20020a1709068a4c00b00a522ef899bbsm1046547ejc.7.2024.04.12.06.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:53:54 -0700 (PDT)
Message-ID: <7b2fc5cb-d1ab-4e9d-b955-b88698322057@linaro.org>
Date: Fri, 12 Apr 2024 14:53:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] mtd: spi-nor: Remove support for Xilinx S3AN
 flashes
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20240412134405.381832-1-mwalle@kernel.org>
 <20240412134405.381832-2-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240412134405.381832-2-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/12/24 14:44, Michael Walle wrote:
> These flashes are kind of an oddball for the very old Xilinx Spartan 3
> FPGAs to store their bitstream. More importantly, they reuse the Atmel
> JEDEC manufacturer ID and in fact the at45db081d already blocks the use
> of the 3S700AN flash chip. It's time to sunset support for these
> flashes.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Good, I'll let Pratyush review the details:

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Please resend once you get enough feedback and include in To: all the
contributors to this driver.

Thanks!

