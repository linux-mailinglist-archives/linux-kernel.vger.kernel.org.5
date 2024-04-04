Return-Path: <linux-kernel+bounces-131027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD27898227
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0324FB23DB4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A6B5A10F;
	Thu,  4 Apr 2024 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7jy9uU6"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9458ACF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215415; cv=none; b=qenbC1TKt6RDukZqusV/xN0ug9TcfqxkbDPcuoGftpe5Fi7jIXijuNqeouhKQEMeCpJ+um9Pa4XaU2F0dXdT0j9sq2YXxbRUGyha7/LcmXH1P9gtINPjNjexABodmMgPQfwEoKCkVsZIlKgVZgqPG6GaTl8qHOtwfFW2Iqf0XTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215415; c=relaxed/simple;
	bh=IrcjDwW2go+0W9hIALaBib0t3+sE41yHO3viuD71acQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoZgDwLyU5u85mratIxxUpjEVxIr+jIAn8MzpF8pEZqDDhLmGRh5Pm0fN4MgIeTt1l1nkZem/s35vHs+JGTN1PJFOYBBu6rnRSk98WHEngJ2hMv45r1jlw7e0yEpmoJb2EDYLYJIuiGE+BYPPWx1dCxjiKrLWfTNU6ZIMhBwslM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h7jy9uU6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e1e6e1d01so326009a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712215412; x=1712820212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qoKp3ietYjXVwlK1qyyowUsmILGtAZ83ZV038OqgG/I=;
        b=h7jy9uU6M/rJZRdfcSeS9U+ZAEM47oS/giZIq16t1avV5MzffiicIlVAemp4uM/qee
         jR+e56Jl3HpZaB7b56LLSMVlYN2RwLiuI0ggOMR3drlEzNM7l4kRoTz9PVOTsM1OMmTf
         e+OeFd0mbbgDjv8I69Xd1WCoPaOW/WSo/ILNQ7XygL2Am2qEdEtu5Y0mx1bk3fVaTnnc
         yJ+5DaTytYpIcgCI4HPcRQpiwOIR2l8lHj00ckK/8qyPv9ODKuKZreo7bX1wSBoVJ0LP
         sVdPz18w0kmIuAenCv1noEHSIarXsouLixl9vJxeH+jD0CL9lR7ooc5zt76Kkp0qkMww
         U4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215412; x=1712820212;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoKp3ietYjXVwlK1qyyowUsmILGtAZ83ZV038OqgG/I=;
        b=GAi47177xrhTFqgdumyw6GEYFE3HUM92qnlaQJnFg7w+XhDIK3Ccp1g8t82UeGvXYQ
         Tdjan0emvBs1H2Vy21y+8kCGdVGUJVNE/N/598UCd+cr9twhfN8akZm9uCiW5S/iQQbt
         d0lzviicmlRLosDS57PIsh9rDjZ+v0m9o9p6oQl61UGLgN0gl9X1wiwTLNa69lA7jIj4
         GR9tDkU+mbBBpe+S5X0joL//lOky/Uq+H0Zrkf+mkIDHbVDyfznJcweZzKD2PC95auF7
         SElhmCk/R9CKhT+vQ3hlEzowmdgQeJnG/++oCXeUI7RbLeQIaFKTHL7BU79mv1rIQ/Of
         neUg==
X-Forwarded-Encrypted: i=1; AJvYcCUTnrdxjmPKZwVuoujP4I7+YOTnNxL1HpC4+DBn4I7W4EcjpICucv8tDuGj3pvUl26DTAwLtl+/KF07hDW3fnpTLN8YWZX3ZwHNVwCq
X-Gm-Message-State: AOJu0YyY5DmfFW8Ryrcpg8xHryTef4G5LvUMTNEuDjz3YnAlSnrRLkQC
	C/20mpeToHYWZcGiPyTurwheHwU0laLE2RjQpVHxNnp1noCwtir54Y1RUYKb+G0=
X-Google-Smtp-Source: AGHT+IFcJeD2EvWnHL85kO8MUwgmZU5Y0OIrgm8eUvLfu9ihlvaIopRpMGfP5G9oEemWuCKoLa7gGQ==
X-Received: by 2002:a50:9f22:0:b0:56b:a077:2eee with SMTP id b31-20020a509f22000000b0056ba0772eeemr1125203edf.4.1712215412338;
        Thu, 04 Apr 2024 00:23:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o2-20020aa7dd42000000b00568abb329a3sm8856010edw.88.2024.04.04.00.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 00:23:31 -0700 (PDT)
Message-ID: <d6d5f6d4-1d34-4d42-9afc-822a014063dd@linaro.org>
Date: Thu, 4 Apr 2024 09:23:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] usb: dwc3: exynos: Use
 devm_regulator_bulk_get_enable() helper function
To: Anand Moon <linux.amoon@gmail.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240404071350.4242-1-linux.amoon@gmail.com>
 <20240404071350.4242-6-linux.amoon@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240404071350.4242-6-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 09:13, Anand Moon wrote:
> Use devm_regulator_bulk_get_enable() instead of open coded
> 'devm_regulator_get(), regulator_enable(), regulator_disable().

I fail to see how did you replace open-coded suspend/resume paths.

> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> V2: no changes, did not find any regression in pm suspend/resume.

No, that's not equivalent code. No explanation in commit msg.

You already got comments on this and nothing improved. You just entirely
ignored received comments. That's not how it works.

I don't think you understand the code and Linux driver model. This patch
repeats several previous attempts with similar issues: no logic behind a
change.

NAK.

Best regards,
Krzysztof


