Return-Path: <linux-kernel+bounces-41234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD8783EDCC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6CA282EB1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44B128DD3;
	Sat, 27 Jan 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn34+7DM"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18111E867;
	Sat, 27 Jan 2024 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706368252; cv=none; b=LIt9Lt++lYYqHpp7Lg3coceaCBAsdQaQXiM0P30NK7o4YZ80dy3pfTE8LAIHYJT2USX9tgYVyvIkQ/nRAs4bzVCEZEuwgfcEa+qMlv9ffeNP+g9qeNn3tKwlK5c4DDnKUSE9JD6PPjpQJ/nr27GgRLOnthQnUU2gvOj34FKuER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706368252; c=relaxed/simple;
	bh=xKSFQmVxtAOGPGJAPLF0MbzfXrKik1GUQcQRydHiA7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W03bpjii2DC3sRbGHT3zzb2XzYDlDvrS0kdcC2pV7qMMkICdcbYMHLBj/mDdNpQnFMKpy5GumgHfoPIAuhre3qoe7/4j/Y+G7HZ5l4/RIykzV5MBEFnApgbjmGxsHb3subHSZS5RT3mX9Fu3Vfsh75avrKaLhWKELXxnHaXymm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn34+7DM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-290b219a60cso871296a91.0;
        Sat, 27 Jan 2024 07:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706368250; x=1706973050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exa8lnhZ2cdqFsVJ6CIdmdXQHog1PRg+qoh5FEBSti4=;
        b=Mn34+7DMvVBEV3KTjJ/CBE9yZnwdeoJeAmtJKuoP1SumB1BH3E5bgdvAflAzjTgbLr
         GWse6yLwW+gQU4RJB22CABRvxnywr6KrnzDy+Q0aLbQg79NXYZN1JQDI+y4QGDrFU4Ya
         WDE/iudrvsx8Ox9iJ4f+2l7UCsCgPb1hIThzA5YIB1V0Yr/N3Y+6WJV3RqcFXvWAkEql
         ItQZoxh4VO4oj84OJYtAtFLQEWQvi5Wbw0D8WbW5JUnnBCETS3NQdClVl7DCoQkyV+db
         qfVQCQ6aYh7VuT0zCEJN1fGKefEivo2EZ+iIQaYSVWSfzQ0M/G1cQRxMf7guxT6K+ezu
         9FQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706368250; x=1706973050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exa8lnhZ2cdqFsVJ6CIdmdXQHog1PRg+qoh5FEBSti4=;
        b=iurLjuQ4tpqXPU7LNyOZ79QL5lCX+/8a4vyYIWWdhJzoUl8uUSnobKXJ7XSagloCF4
         fbVsunmqs7btIlAQWUcomEdr+FoHymOdX4J0gOqYcNocT0633iVBhIog3kBRrruYTypy
         eKefAzof4SynAANIg+qZTuvfE4EsruS3zdNQpso/bZGIoqJspw0O9ICQ5LDA4v39S6qI
         m/OLPjd5EzhyjCStNTY9SAQHYgyC6UwEyAE0QYCLo4sXuakFp1yGDxwcRw0pYm6o2cSg
         FIBs+nY7Vz0eCncpGBcp3kq8/uqtgSfWyiZ+MFbiezo6/ZJ8Sg8VFoksgIReIzMvhxdx
         4Zrw==
X-Gm-Message-State: AOJu0YxUYx3M/FDEi5sMcjM4ASe/miMC3FEMSs+5G9bGzzYwokz343XB
	KjGVKc3WcfqU9qO/FrtVg5HYmJ/SFQ6E9SQyMBy0MXuDsVsno6Xr
X-Google-Smtp-Source: AGHT+IGqg56oo3QQenahTbidUTI/Ew8TOP/y1ircg+yxKqqi7ET5EOIIK/EtPLpDEtku1kR4/YpFWA==
X-Received: by 2002:a17:90a:de85:b0:28e:7baf:6fb5 with SMTP id n5-20020a17090ade8500b0028e7baf6fb5mr768817pjv.64.1706368250117;
        Sat, 27 Jan 2024 07:10:50 -0800 (PST)
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id x34-20020a17090a6c2500b0028c465b050asm3289818pjj.54.2024.01.27.07.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 07:10:49 -0800 (PST)
Message-ID: <a899a90b-39f0-43ef-8cb3-bd706d749fe4@gmail.com>
Date: Sat, 27 Jan 2024 12:10:44 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] rust: error: improve unsafe code in example
To: Valentin Obst <kernel@valentinobst.de>,
 Valentin Obst <fraunhofer@valentinobst.de>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240123150112.124084-1-kernel@valentinobst.de>
 <20240123150112.124084-3-kernel@valentinobst.de>
Content-Language: en-US
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240123150112.124084-3-kernel@valentinobst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 12:00, Valentin Obst wrote:
> The `from_err_ptr` function is safe. There is no need for the call to it
> to be inside the unsafe block.
> 
> Reword the SAFETY comment to provide a better justification of why the
> FFI call is safe.
> 
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

