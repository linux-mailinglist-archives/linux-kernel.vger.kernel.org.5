Return-Path: <linux-kernel+bounces-105183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFEB87DA3D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7E11C20D67
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FE418B09;
	Sat, 16 Mar 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH6RohCX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F117722;
	Sat, 16 Mar 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710594431; cv=none; b=bhDQcuS1fv144o7gyIxny+UJ1ww8IFzc9hcr2nrWdEpr8gWMQ/nscL9ll+CBvUfopzCoPZKzaDd7W6kWULny2umrlNA5IBFmGWZj8yVUsqFue6Og4FynyAhME4Zl5krtl8rvMnBB5iYw00tM4jiiJ1ujr4Se5440DVzQm1plRDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710594431; c=relaxed/simple;
	bh=Kkwv7Fnmn2+BnIp98KsOR/7orH5EqMLTknixPdx1hRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jmx0tXoT/hk71rQmLhYXqs6EHf8x8aFfmi8rSmXeobkHoIfFO20jT2TKROWXE2ETHB2yaGgffna+8oUYTlTMMk7OIpplKxTA/xtA34DKBjPEV9sVjjUkzmLetIcsT5lU3uBZlmKPsAZh5BZX1UUqO+NnHRFgwFWHcj1O7RZijlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TH6RohCX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dd10a37d68so25115765ad.2;
        Sat, 16 Mar 2024 06:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710594428; x=1711199228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O29l49W9XGARXAl4J0N7LLsgN9XT4ySMJ5Apk0iOPvg=;
        b=TH6RohCXO2dzSuPJ58ic0kvDvIpP9y3PcKmCPnkKYxltbdlgPrnLpZ4KMWzug1028U
         uUSPWJJLQKmtVZjTEx5TJV/Rw2v1XZ4jEdx9a9+wZuP7CIGBRyDktgIM/Yrqesi2XPZh
         9fF2Lb5xKEJnWdqjin9zUptWTKfRiyhCPelKPQJ9I55ERIzXEmU0qYuSkF2amodA2R+Q
         UTUbcDA2N4EomAEfz9SrV4qSZsEs2XWN3f0mHV+OX+mxZy2JRs8kLaiPb7p8gSQ1uJZ9
         sxa4G8qauORI4/FikhwEDdEgYmlWkrya77QPyKnYoHWdYhfrOm2ANFpBxwDXtnqGrFdO
         lJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710594428; x=1711199228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O29l49W9XGARXAl4J0N7LLsgN9XT4ySMJ5Apk0iOPvg=;
        b=B/hZDEE5tEdACcZpW+sw64X1f30ZVHn5+x09PMsintYR2dWDBZ6nH5lEHwpjR1SrOW
         6h90BJAmaVwikOknUntymPEGA5Bf+iy9OCfkiSadlXqYpw9vouiVwPA/j91wVwrw/1B2
         W0mVMROjSLxYHHkZlVenLR5v7OQNYjwniZe6qPf9y8qDBOBdEjVmCBrjdGSxQsP+cz9N
         Zkqpn7xhPv+1UJV0nuOL3OHmVjeZ+TGmBP3U/fn24bBEpHRIfKQQxLPazgSlEvJbmLop
         JSnRJGxIUnu0GY5FRqkqPNJdy1yFqL+XQMuxp3R0sT26WvImJLdVG+xVrAPEFUUZ0+G/
         3GpA==
X-Forwarded-Encrypted: i=1; AJvYcCWhN8+KVfft6nkxNnqxLm6B+5PGMU7k343yHZbtM4aCfptiMEn/vTeVsVFFK6P0OEAjoM3H47HWemTCh5tIBdFjaXnz5CLavFrFDzxXrmIe+jL+7sVA3MqQgaJyNRhsyJgfqlGjRMSPLoQZCIVpkkygjdT8lV7dY6UNeVtAsaycFmzjyoPlhLJwTgjBbJRrC97IW9JQ6z5tNtsvcssytKQ6Rw==
X-Gm-Message-State: AOJu0Ywm2CSyS0l5IG5oe0JuxBBK1IcLntWhTjEhrY0uzT3X0GEYywIz
	Wv+iQ6njFk07A2eWd+WdihtjIO9POsBKNskZ8uRzYASWe5/y0VNd
X-Google-Smtp-Source: AGHT+IGPmM31pP4/EeJlrKrXYxjvW5slggKxA8CfUGLf9CovlmWxJIz6/FceDn5U368qBNv0iNC5FQ==
X-Received: by 2002:a17:902:e88f:b0:1dd:6965:5888 with SMTP id w15-20020a170902e88f00b001dd69655888mr10251961plg.47.1710594428433;
        Sat, 16 Mar 2024 06:07:08 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001dede7dd3c7sm5277814plb.111.2024.03.16.06.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 06:07:08 -0700 (PDT)
Message-ID: <402d1296-0a0c-4f85-a096-be7993869f94@gmail.com>
Date: Sat, 16 Mar 2024 18:36:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] mikrobus: Add mikrobus driver
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-8-ayushdevel1325@gmail.com>
 <8799b216-57a7-451b-80a3-3d4ae9693e0b@linaro.org>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <8799b216-57a7-451b-80a3-3d4ae9693e0b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > Are you sure this fits in Linux coding style limit (not checkpatch 
limit, but the limit expressed by Linux coding style)?


Well, I am just using clang-format with column width of 100 instead of 
80. The docs now say 80 is prefered rather than mandatory, so well I was 
using 100 since I prefer that. If 80 is necessary or would make review 
easier than I can just switch to it.


I will remove serdev, pwm, clickID and send a new patch with the minimal 
driver and better commit messages as suggested with Vaishnav. It is 
important to have good support for mikroBUS boards without clickID as well.


Thanks for all your feedback and time.


Ayush Singh


