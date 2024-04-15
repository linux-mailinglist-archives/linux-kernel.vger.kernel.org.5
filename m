Return-Path: <linux-kernel+bounces-144590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB9D8A482C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBE71F223B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6C329CA;
	Mon, 15 Apr 2024 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Geqt+IpH"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2182F18E1E;
	Mon, 15 Apr 2024 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162911; cv=none; b=hK8JVoO4Ky47hA4r3kFLIlY3WDbqtmPGyWNLNTDm9dG4CtlPpouf3Utd+U0HxWh8zek/jQfXYQF6JJBVXFFy3n3M+1G43eGeP/Zma48aA1Ickg7C72zC1JgJt66ajDuM7EcV+0xoWPW0Q6YTgKRkgU6yHPMltHG5DW8UYeFHr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162911; c=relaxed/simple;
	bh=Q5TbGZ1jPTv4uMeeTm7Q5TrJJ+oKc4OwR2nN0yuvZHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8SER6kfU9I3S8E4+a7vhUzL9fGRWGzmaSZVTg5oBxswyRG2Mop4lJ3mOawHtinxIEL9OhpwuszFuPCeGT3GJHBnigMVZRDYztHqC/FzfO5wfDB6rBoMfQ71gb/X+wyw9DL6/iiaI1aEUhey0T/5toU//H4qD7NRF0K+Cu5wSdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Geqt+IpH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a44f2d894b7so286446866b.1;
        Sun, 14 Apr 2024 23:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713162907; x=1713767707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eO+zx6q8xRqWwJnnrLSN3wSPdu79Tj6Uc62vZSkTLvo=;
        b=Geqt+IpH3EHL65dkbPMIdxJtBbWUeDjDyxVJMpvVQYprDlTpX1nSZLSjoXdyinz9oT
         rVwn7lRt1wHzUMLSUBCW1upaamy4pMrekpmSb3wKjLgdkfLDAQ9+fuLhPEV8AByNl+RO
         VR2TlT7wUadE8+UbzwSxsKx/0Ly3/2gcQasxQKXpvLBCNSX2laSRLgpWDe8B8DLOuHR9
         8AhS/70/xLNdOtVcpGOHaj05nXw/uFHvDYKX14C0IKYDHCFxaBGpKK/nJGKpu6eS8QTs
         B7Udtj+OBy56Op1kP34PsVlIzoD0onvnr06gdfaDO7sqUlV1yRuRqCtNefhcRcUuD1/N
         +ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713162907; x=1713767707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eO+zx6q8xRqWwJnnrLSN3wSPdu79Tj6Uc62vZSkTLvo=;
        b=rCT4sFKkie96B0Yp43UMSjIIL0Tq+/Q//8bT5Dle1BgG+ppa7yl4oHoe7d4MFHbYeE
         KNT4WMyQlpGHxfZD4FzbwefLzaWKL11KzJxkd6FnyjmGupXWj+ZyVUg2RxTw/75JHuOC
         CnkkE+pXdQa4kkNUfWuz04v/GAJu1uKMZpzoTuwhoDV29EGh6xXBx9hktESW874wGIUG
         1+6HaQ9WiKqRCXSrfNySUNo10vkRySBLhTYRN1wIEruDgpIOTXWQ0jh3wVIVCKNqo+hq
         Ocu2Xl0FDoqhVT43KuzEFIkwVGgR/d6eZ7paGBpc4CQSSrXsBP00em3v9CvOHHXQVkMK
         FMdw==
X-Forwarded-Encrypted: i=1; AJvYcCUQH/7wmgJo33rrwtbGmVf0XlTyAXvk9KIPwrLqEPim6wCHwM6sRnj9gcYKNUP+uQPRlHk6evCND6ddZ4Kj7NicNCECmjlGDV/OAtLL1PPiimf7/0yqrkCxi1hgvLsIIhALx8mRYVL1oQ==
X-Gm-Message-State: AOJu0YyfNVYanic5P3KJDmmAYnWACS2UtzTRSkHcGnEOfIHscdBhMF/v
	WHY1Q/9Qtdx/JHJc2TeCjTsis/sJUAEmnDY2SzSGFGWfu/Dfhjbz
X-Google-Smtp-Source: AGHT+IFBOaepaDHEEJj8Porx550BDTPgEDltcVsWd0z0QitZDRqQ83vy5NmfqW3SvdZYQ/SrAz8Q5A==
X-Received: by 2002:a17:906:b80c:b0:a54:3e6c:c9d7 with SMTP id dv12-20020a170906b80c00b00a543e6cc9d7mr271692ejb.65.1713162907275;
        Sun, 14 Apr 2024 23:35:07 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id ae12-20020a17090725cc00b00a529aeb4eccsm412271ejc.140.2024.04.14.23.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 23:35:06 -0700 (PDT)
Message-ID: <9b33192d-6245-45e1-bcba-c2339e18f77c@gmail.com>
Date: Mon, 15 Apr 2024 08:35:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: rtc: convert trivial devices into
 dtschema
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
 <20240413-rtc_dtschema-v3-2-eff368bcc471@gmail.com>
 <82fcd7a4532df119f82ea55208f592460ba5358e.camel@codeconstruct.com.au>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <82fcd7a4532df119f82ea55208f592460ba5358e.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/24 02:09, Andrew Jeffery wrote:
> On Sat, 2024-04-13 at 22:22 +0200, Javier Carrasco wrote:
>> These RTCs meet the requirements for a direct conversion into
>> trivial-rtc:
>>
>> - google,goldfish-rtc
>> - maxim,ds1742
>> - lpc32xx-rtc
>> - orion-rtc
>> - rtc-aspeed
>> - spear-rtc
>> - via,vt8500-rtc
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> We have trailers above but then there's more commit message content
> below. Looks like what's below should be trimmed out (bad squash)?
> Maybe the trimming could be done as its applied?
> 
>>
>> dt-bindings: rtc: lpc32xx-rtc: convert to dtschema
>>
>> Convert existing binding to dtschema to support validation.
>>
>> Add the undocumented 'clocks' property.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Andrew


You are right, the commit message content below your comment should not
be there. I can send a new version to trim it away if that is preferred.

Best regards,
Javier Carrasc

