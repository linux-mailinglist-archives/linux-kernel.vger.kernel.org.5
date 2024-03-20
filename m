Return-Path: <linux-kernel+bounces-109256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B228816DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5191F21BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D36A35D;
	Wed, 20 Mar 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKiTqPRU"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4269DE4;
	Wed, 20 Mar 2024 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957313; cv=none; b=p9xdAINXpZlFlkHISk92BtLUqslOC/rpwFsYlTYMhJHMYjQiNlGmnealEoyI88ubP3XmG2FAySo96WSpCcrzXRaUezzQZwrPtsZy599thcw3h7IblC+14k0Ya241E0xnnP7YReHHZ/lqZeXr/dhBSfQ4fZT64INrkGsXWxoliyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957313; c=relaxed/simple;
	bh=rCNMBMu8fQpwrXd/m9/xsyeE/QLxw3BCy3uZoZhw4vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYoiHhVMNyTA74uxqWxz17h0IxW3N7QBL0oIweke4R7TlMLvkuICRVnGFOnIQYVQrhCrnuWLcuWEFDTgmuk2jq3ozQG4Elu4g+/cQ8SlfVsrTHoaIknHt0DnVubcM5zzduoI2xt6B8/ghIwnPqjTUUMi3edPx32tY9/s6fkaick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKiTqPRU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso62326a12.2;
        Wed, 20 Mar 2024 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710957311; x=1711562111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zjv8XCHpcg6s9nRJ5tVGIKCPsm+AiLcgIe4CWKl0nh0=;
        b=fKiTqPRUHuk+SiDxkA7xE4Qbv1U+ad+uhFa6RFt0ZzV8v9JZvGZH9UAU9EfMCJlql7
         /6kX5H+04IyOlSoXPGiBPi2G410BBMoNQ71BySdgIJWnozUuhpaSS/pPX910flMGAESN
         kXQ9yC7pectZIZbQpOGJFhMmlEVqBr15mO4Rx5l3RLNDu6FqHpLAIjV7ZN/E6y2oFD8V
         bABLUtqUO4+5toocYwUvsyCVeC7C5eouIWN4Nnnyko+aYHAZzuarGEZnWr2uqd7dOMlP
         i0db0v7sCl9ZJcHf69TF3Ovzh6Nw4zxWXTHewZxIljO0/3sRHyJRluH9419kO920GaGC
         qE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957311; x=1711562111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zjv8XCHpcg6s9nRJ5tVGIKCPsm+AiLcgIe4CWKl0nh0=;
        b=agRB/0xpgTWb5/ugv/ZIFKRgafx/CYNB1cWlb52nq+tu42BvR8e9+A6GALqCdZUlho
         0KLJXaKdrepmjdcHRFK0eLu4K+dAoiS9daRXamFOD8c5uENKsvXRXtZ8nCvAniW00NLF
         5uBU/pyQfSzzO5MczYxMEMzmEsRrOXdNAT7Ix6pKveb7HSSGxx5sGuS5F9IOhlQ2zFDa
         c33AG3Ee8NvNg/r7NU3bah17psNXvQSBr+vW80DQ9aotPxpU/mhWo7TH3EEb7ahjQq59
         7yCaB9RIGXqkCRrF4kDTYPCoU3pCIaB0V9rBK0C5oIp2WyGS1LuU2eooY4TsER3c3FWq
         ksaw==
X-Forwarded-Encrypted: i=1; AJvYcCVClWB6YhKeIfMMiuQXPfta9ORkW9PQVNZfKmAhsyaLH/88hQwErMh6z6kg4N0tkoLz7UbuYw3a/+OxmMdzOmv9PXX7bwqzPIH6P75oLC3dXhTedJ6nXMqKPJLY+v2KJGL/6BYV1tC/LBjUJ90Oxcna5gS9SPX4CU5mLlZkoSRy2p1qWk01
X-Gm-Message-State: AOJu0YzDgJ2ZIjevsgDK9yfooFyMkqEUz8civ9uVd8gZNmcTYQEjN31F
	XdPZYOGe75v9RuxsoCcBHxcxulg7qDR6t79xqMVGYFr++1d/aBQK
X-Google-Smtp-Source: AGHT+IHI4A2ZmFJtQOglBk0ZqF74aoOeRroVRr+nrO3blb2vQiFyFuxerZbdQnLhovemIxXFf4vYNw==
X-Received: by 2002:a17:903:2282:b0:1e0:11d8:7898 with SMTP id b2-20020a170903228200b001e011d87898mr14112565plh.47.1710957310866;
        Wed, 20 Mar 2024 10:55:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b001deffc90392sm9998704plh.35.2024.03.20.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:55:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Mar 2024 10:55:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: hwmon: adc128d818: convert to dtschema
Message-ID: <62712a43-fadb-4a44-af6a-d863a7049ecc@roeck-us.net>
References: <20240319-adc128d818_dtschema-v2-1-0824a6d69493@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319-adc128d818_dtschema-v2-1-0824a6d69493@gmail.com>

On Tue, Mar 19, 2024 at 11:00:10AM +0100, Javier Carrasco wrote:
> Convert adc128d818 bindings to dtschema to support validation.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Please note that I'll push the branch after the commit window closed.

Thanks,
Guenter

