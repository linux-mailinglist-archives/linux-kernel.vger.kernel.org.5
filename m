Return-Path: <linux-kernel+bounces-91927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957B1871892
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365E3B21502
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1990A4F1E2;
	Tue,  5 Mar 2024 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhCmYfAn"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8D1EF1A;
	Tue,  5 Mar 2024 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628617; cv=none; b=TG+O0/J9x35DSVGEFap5dof12qOnUwz7IyHwylHqkfTH6TqGGOn3gLSb0RO+EHJUhRPyTWn1Gi1oFh8UXwX0URogfGNkkMz+qXDPB9MoKryfY6zh2TOsAPsdLyrCisCc2dHiZnzxeJ3O7lcowXXvI/D1tv5hZ2+juzVDRdFphUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628617; c=relaxed/simple;
	bh=hh5Yt2+C5G/DRXfFFiUAUKFq87qFNmGWL0CwCF2X4n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tf5Ybt29En713isdeAt1B54FmI9WD9OEgORXmiHFnD4q1HMv3t8PMLQ511KnBFpHgU7qLzXvTP1TJ+gHEx+wryLt6Mt43qAOT+OTheHG+qRwA8VmG8W1xCgUmt+JpzPNcTc7odK2NExN0cpxWQcZq7m3tX5E75jRk57JHrd70Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhCmYfAn; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d7b8f563eso3567717f8f.0;
        Tue, 05 Mar 2024 00:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709628614; x=1710233414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtaGl0DA/gjjX0rqwfZsWY9xK2jLOdIQuJ24dXQLPCs=;
        b=LhCmYfAnqPWc8SbOMwEjHDnhkq/1y8osvGLmIIzYIHvBphRHTud9Q3X9FrZDUXVHpw
         4erAtDaOKcu9Dnwmhyb3NyoLNyzb/8hIGN5Y6k+HcLroArL0Ss+EucRDhkPEcfrwLDKX
         vRsV9FMUlLIDjHx0u4zOmcDy7UDNSocnavCbgG2Uexora6t8dtYKJ/jEZPMUhBoMMMPz
         dB2sg7ZW4af61oKGOWft2N53cKE8BEcnUJT9QLr8k1tjPA+JcQd9FODC7eZ2o54aU7XO
         47OPDsiPwQeuvRbH5zPa048Slqxj0B+YIg+oYVyGsijpFDFKrGT5VT8AmH17uNYJYUHO
         +hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628614; x=1710233414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtaGl0DA/gjjX0rqwfZsWY9xK2jLOdIQuJ24dXQLPCs=;
        b=k0iKDnOTkDPHW75o6doMGPUT4ozsLtTyskqLVrCYz81RJamF646rUizwCQg0qa1t2B
         JmVPVOJqtHrz4q5Nq/LGbJFkGmU6Js6YXaz/iuEoHeqVvh+HaT99dprnE0MG3qMYqEdb
         Qf/d7LyA1On1xwDou3TwSFZrvGgbynZp62GbHK0UmLjZpFwq5r1XP6+cC1TWCvmlVGdC
         NDzvK2cglNu5NGapuW0UjvZs8dJwD9uzFu3QiJUImOT5cixLMjYU5h2VgpQKDCc+cSoy
         8VzH0SHeKyMOq78DoasdCnQ5EZCWk/0oh112UJBwcBg5jfKRv/LL0gvJd9q/jfOhnnBF
         reIg==
X-Forwarded-Encrypted: i=1; AJvYcCV8uQYKExHtdz3WYH2/wqd0I6yuY3SjuNaK0xNiqcAhU5lXp56f87QXazAeW2iV+TfxXBjNo1NPpoofMzs5h0aq1E258aSRrji10YKjMdmWjonvOuLA5t6trt7ASeHLBi0NWWXa1eDukUz9EIOWGfTaFIQ6IsLPYYO60CuG5sDX+bpSIw==
X-Gm-Message-State: AOJu0YxtLP+hH52zmNznm3dQps1oQzCxSpSWXV7BcwD9qADJlBvltTC3
	xvJvQ0vo18at+7m/Q/C6n0PGtZjr40ao+nOaDyXXGaKZlmRcuZuS
X-Google-Smtp-Source: AGHT+IGNyCKmgOiHGC47gbGGns2eUULjJjXroaTJGyPKifHxVRP+GOFFgQlA7cUqCqGkoEh+w5jRDA==
X-Received: by 2002:a05:6000:1110:b0:33d:754c:86cf with SMTP id z16-20020a056000111000b0033d754c86cfmr7327049wrw.35.1709628613858;
        Tue, 05 Mar 2024 00:50:13 -0800 (PST)
Received: from [192.168.206.22] ([46.97.168.41])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033e052be14fsm14311214wrw.98.2024.03.05.00.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:50:13 -0800 (PST)
Message-ID: <ff8c92fc-10a9-4cd4-b94e-861b65028e0f@gmail.com>
Date: Tue, 5 Mar 2024 10:50:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: ad7173: add support for
 additional models
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240228135532.30761-1-mitrutzceclan@gmail.com>
 <20240228135532.30761-2-mitrutzceclan@gmail.com>
 <CAMknhBE1dO921gCudJMiH=HhMpgNsORwaejw7z-O2gCbLbrdCg@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBE1dO921gCudJMiH=HhMpgNsORwaejw7z-O2gCbLbrdCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/03/2024 01:41, David Lechner wrote:
> On Wed, Feb 28, 2024 at 7:55 AM Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

..

>> +      oneOf:
>> +        - required: [vref2-supply]
>> +        - required: [vref-supply]
> 
> Do these actually need to be required since avdd is also a possibility?
> 

I added this constraint based on this mention from the datasheet:
"AVDD1 − AVSS. This can be used to as a diagnostic to validate other
reference values."

If you consider that to be unnecessary, mention it.

