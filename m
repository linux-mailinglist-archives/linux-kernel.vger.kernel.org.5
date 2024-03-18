Return-Path: <linux-kernel+bounces-106484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8430C87EF45
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E66B21766
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033BB55C36;
	Mon, 18 Mar 2024 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUkS7Fv9"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF555C07;
	Mon, 18 Mar 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784537; cv=none; b=ZHvGlhJAoFPW9CUnShoW/SVm1a7O1lmAWixGOElhFRMnJQNdh2oZLzLg2by9wJ80TAGDMzTOC/wA9poXD5SFXzVjUzYnxyQ85vbEUDjbPMRc2oKpYTW8sIs5GoTL+eCmMP3FGb3Quw2bKITe8YE/Y/DJTN6qYSRCAZ0JxmAfZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784537; c=relaxed/simple;
	bh=luCLWL8jt2tyA1vzzYCOza2mM80vbEB1aXXzn5B2KaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gr41pAnEQoKTa+9Oiwh9VI97MIri6PZgPks+V3AVHSdkim9WFL7FMN+JtbjbL4Ore0RbpQ4OBqGEP9/g4hy4poEcfqpJm/61XFshjKopCcQGnCecqhWJoJgfdAfKtqvl5JOOmJsuyfDe9IpcMlnC4SZNmNx8fhUXMkuxWpGFg6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUkS7Fv9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1def89f0cfdso20470845ad.0;
        Mon, 18 Mar 2024 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710784535; x=1711389335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ugtNKvEWhKahexW21JocIJIgyuuk6NSblG+6GtESTeA=;
        b=WUkS7Fv9PKFGHeuop/40T+tPU/36iIwAdMosOPA2FlUiHvFJN9xQwS0p+ejzPsOGS6
         /BiRY7kUjHUeCOS7DjoBPedC8AMtFhcBT1big/JnHmda5NRxBJpB9hM3kFtLm8nwkMqV
         xGZgSU1BiWoLTB3vh0VZZPPbCNyBJwQBJinsApiofp7eURLjHUCUuzNUYRq8HGj/ITZy
         QmQcxrpnh/I1cq7v8pUBRhTx7kO4w5DefsM4efm+0u207ngu+/4TLzG+GlSi3EoGTq8C
         el2JefItecH8lkHmHUm4USY1YscEsgupFrBWbgNeVjD/XZ4+e/+p7NWZTRgySnS5iOEX
         Qy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710784535; x=1711389335;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugtNKvEWhKahexW21JocIJIgyuuk6NSblG+6GtESTeA=;
        b=vssoZYrZA35jAm9HbplEitgd/ubgoRiB1024xOEyKia5PYjF7E6CC29qJJhVLWx6id
         bYLB3m21a2SmRyd3+CDMHYR2cVfR0BGbw8Q0dMNtLkdxH89pYwFDfWApFs+F1sYAt2oO
         LSm5nR3fugcajt0ls3XDJpKo/mGHCKi6Ngi3rTKLibJgeI2eWYvSBjIE5Hq6Z2lZj5gS
         LYKUxZhEVwz/eG4CZhfDVe/PkX/sTeaZYMS5LPSaVOVrP1olrWkp2z5kAl2F0zRnreih
         s7zxn+/+XvBEDSXAxKU15c83DHI4I1axFczZA5+zWHNymH/yWEbpSFFPu1RIM6hSNvIs
         HuIg==
X-Forwarded-Encrypted: i=1; AJvYcCU/f/LKS5qdrEB/0YbQcVgasEGb7dCOGVyEEImGygKXxIP/EIRpkYOpbovmCcFUXuPwlRecoKq0EDWOFWaAXe1onuaZ/o6QyPtjpAvL1+DoJ+8s8m7m4u6WRzqp3TlfbDhee/w/Ns3ClFg=
X-Gm-Message-State: AOJu0YzAljtG77O9hrV2ytY+5bmN6Un+mL1teA0kY86HAF2k3SgJPF6h
	4vja36JJDL107Hlt9t9luLzOTYfNEcjdwTRQ5u+hX1w4maxEd0Ysrk8sdeDr
X-Google-Smtp-Source: AGHT+IGwVjixpFXH1YPhj28hgzOHO3DpPmOF1X2xwOZi8VTtcO7n9MwvUtJpMYYR+9D5VbkosQDcRA==
X-Received: by 2002:a17:902:fc87:b0:1e0:185d:a73 with SMTP id mf7-20020a170902fc8700b001e0185d0a73mr485128plb.9.1710784534737;
        Mon, 18 Mar 2024 10:55:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902c70a00b001dbcb39dd7dsm9571406plp.125.2024.03.18.10.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 10:55:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a5fd5590-f5db-46d3-ac94-2672b898bfe4@roeck-us.net>
Date: Mon, 18 Mar 2024 10:55:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3] hwmon: (pmbus/mp2975) Fix IRQ masking
Content-Language: en-US
To: Naresh Solanki <naresh.solanki@9elements.com>,
 Jean Delvare <jdelvare@suse.com>
Cc: mazziesaccount@gmail.com, Patrick Rudolph
 <patrick.rudolph@9elements.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240318174406.3782306-1-naresh.solanki@9elements.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240318174406.3782306-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/24 10:44, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> The MP2971/MP2973 use a custom 16bit register format for
> SMBALERT_MASK which doesn't follow the PMBUS specification.
> 
> Map the PMBUS defined bits used by the common code onto the custom
> format used by MPS and since the SMBALERT_MASK is currently never read
> by common code only implement the mapping for write transactions.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> 

One of those "getting burned either way" thingies. We are not
supposed to apply patches while the commit window is open, but then
we get resends if we don't. Oh well.

Yes, I'll apply your patch, but only after the commit window closed.

Guenter


