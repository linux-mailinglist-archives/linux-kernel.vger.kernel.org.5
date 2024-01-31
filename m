Return-Path: <linux-kernel+bounces-46939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C69A84469D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0842528D32C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875A612F5B6;
	Wed, 31 Jan 2024 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtDoqSJ3"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0484A3A;
	Wed, 31 Jan 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723921; cv=none; b=j77WkQ2b/qmV2f9FYFn2FeYZh68Q8UKzUgN4y+h+kDrG/aSJ1XD1+dJDsffkewT2pZ1DSQhntjoN7G9XCd1hVyAJuOInK+IECHPrdZKSRHgx+wQQKXxNYUDGD3tKwfD8tCeDo8jVZJCyp7kqTduaICNHWqGMOQgPEvCNgmt7rqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723921; c=relaxed/simple;
	bh=uFR6GVn2Sq6Y1ruCZ4JNcGInfnD7sqgpELocJVlBTV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5hJXvrSdFPBIeTEUBqa2BA3t+QJCFbpMnKDzaTZV1VAwSznJRsF832iN8EbLdSlI268hm9R4t5uZunBY6e7nMbSlcMWpCZVa88n8QPO/Uq8aC1RRBg0+0O6hCfMh8Tru1VlMONoelw5/FZzVODYhCbEq/XYDSQ0BmdjIfwu1lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtDoqSJ3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so766185e9.3;
        Wed, 31 Jan 2024 09:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706723918; x=1707328718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHPba7GECW3MbfJEkXlgceb5irO1sp+Y7PoxlaVu36A=;
        b=FtDoqSJ3pzWWzRlBSyOiXa+8/TK5zqCANp3vnYgD2fckplkmkMgg9jfgDhdNTD80gF
         dNkfBESGrkrz5e6/FXxKZERSll81WyZYa9l27lYISwfDkzZxF3tdCKZbbM5y9HhMr9Tj
         TggZ6D3D7YW74uAbJOhOjYk6jZNMJt6UEPSTjeRrLwYm2wVfmllqF7uKdZbWocQRPNpE
         kUEp9SFPK2HPupXSzqAdWvO2xt7nbLh8EQ3MgG/rTcYIp/EM5MD3o0Jf/96HtJpXidGE
         csnK2OIbY1zbtxy4gL1s5UQI+eE9QPXnCMY715nRCsSBuvOzD4bRtKAFQS1O11AjIazu
         BtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723918; x=1707328718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tHPba7GECW3MbfJEkXlgceb5irO1sp+Y7PoxlaVu36A=;
        b=CNxURTBE80b8j8+TkX9zPwDPc7m7B55Hj/ThM3yvkDrxXoY3df1d4m13a+ze+XqSXB
         8yBtn7bJmREOriHiLFyWeg+fzab6B5ChxUHLV/h83cfuo24zIjLRH5xyB2+EH3fceeqj
         0qHTukMS1al77NCKBX0rQ29DvtSulhEifeRh5KPXVD94CJRIFXNhULnZ7sZTIIcVB8NI
         KV4NouO8F7IyHbIqjd972myiFaeWdpzAqwRo2oRdYxNAxUvam7lfI3BblikAg8HJEnzM
         i7L0EwowX+WyHm3KOF748J/1spSghuPA2l3Zv3DIuQFj6Af/LtOQ4PrLLMKrVcHt/oyg
         nFgA==
X-Gm-Message-State: AOJu0YzFe3ecROuAFxe6faqJyUDevuOI7drL5pSckjtct4+Q3NsolzpK
	+JKMqveDm5YLOHU+6yUjdnWlgrYKBkbfvPQlmnHybGYJq3uEAW4k
X-Google-Smtp-Source: AGHT+IGF8Ai0KYZmY3xXvwexRApEnp4Y99Hm3QdZNj83IyO6Upc6OUgLGmsBlTZ+9DGp0MVISMQJOQ==
X-Received: by 2002:a05:600c:4e92:b0:40f:44b5:1135 with SMTP id f18-20020a05600c4e9200b0040f44b51135mr2301796wmq.16.1706723918147;
        Wed, 31 Jan 2024 09:58:38 -0800 (PST)
Received: from ?IPV6:2001:7c0:2517:e:c08b:c62:9a65:ec91? ([2001:7c0:2517:e:c08b:c62:9a65:ec91])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c351200b0040e39cbf2a4sm2232053wmq.42.2024.01.31.09.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 09:58:37 -0800 (PST)
Message-ID: <8552a795-9ce4-417a-bc71-593571a6b363@gmail.com>
Date: Wed, 31 Jan 2024 18:58:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] platform/surface: aggregator_registry: add entry
 for fan speed
To: Guenter Roeck <linux@roeck-us.net>, Ivor Wanders <ivor@iwanders.net>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Mark Gross <markgross@kernel.org>, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240131005856.10180-1-ivor@iwanders.net>
 <20240131005856.10180-3-ivor@iwanders.net>
 <7e392c1e-2cb2-43e4-804e-227551ed2dd7@roeck-us.net>
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <7e392c1e-2cb2-43e4-804e-227551ed2dd7@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 1/31/2024 um 2:24 PM schrieb Guenter Roeck:
> On Tue, Jan 30, 2024 at 07:58:56PM -0500, Ivor Wanders wrote:
>> Add an entry for the fan speed function.
>> Add this new entry to the Surface Pro 9 group.
>>
>> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
>> Link: https://github.com/linux-surface/kernel/pull/144
>> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> I wasn't sure if the Reviewed-by: tag means that I should apply the patch
> through the hwmon subsystem. If so, please let me know. For now I'll
> assume that it will be applied through a platform tree.

I think it would make more sense for it to go through pdx86 (as usual
for platform/surface). That would avoid any potential merge conflicts
if we get more changes to the surface_aggregator_registry later on.

Hans, Ilpo, could you please take this?

Also I just noticed that Ilpo wasn't CCd, I assume because of an older
MAINTAINERS list. Ivor, please add him for any next submissions to
platform/surface.

Best regards,
Max

