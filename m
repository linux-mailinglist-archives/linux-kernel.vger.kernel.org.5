Return-Path: <linux-kernel+bounces-112231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E42088772E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440481F22D87
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5557D610B;
	Sat, 23 Mar 2024 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="N+9QMxOp"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2385382
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711174633; cv=none; b=Ri66juUHIwxf9vrHMRlTdiNn3TSyQaRCkw85m1siKJPxYw9D+12/RMFl9uc3SzrHYBn9QYLCf77mYSmX8V1TwGonn0vlPY4nSyu4GCPbP8HTrd+/0JmrdaYY1kG2Fcu2NSeHv8IWr/9NAhqAGzm9Vs4WZ7eVRrAaqvofAmLgxzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711174633; c=relaxed/simple;
	bh=dqG0Z288zz1kSYusNKw5auggaqGEU0D07aewlJFuyP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJyO1/vXL+oIvSDAlwxm++lKmndAJnSoAgE1NCqbXJ5Dfa8KBu3xAYJRZvPSkR71nG7tc7CEB5ZHJS16B9Isz+/CZDLVLSIfUAprz2Pl78Vu1kUCwf0CoUL/jt57RjjvDEg9r2ky0MQ2GreKCWk2p0eKBSL+id88YCZEFi1TdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=N+9QMxOp; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a029c8e62so21325631cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 23:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1711174631; x=1711779431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUD52ht+HR3l3eedQqUGqKmwp+yFV4q4zkif3Vs2Vr0=;
        b=N+9QMxOpE0VJj9HzfPOcRHSV6xmUV/bor65C35aNwmZxESfBFPV0AEBi++5mqP0UmB
         9fTFz2RyhrPeotg95inB9669MVDiP7Uc6RyBIDyRdACUUdDBDCS1IACWuDrQG6OJwg8K
         5zTDiIkh+RT90TNKdnUwcubnQ5aW5R9nDtkS3/iXNpDX84mZnXry75hFWr+2VTzZyL2f
         i69Y5MNkTETI5j6z1Fo2rRNsNIx6jS9CfW34mwC8N7BThAbNyp5KJ/r2zQmPSSPJVbux
         PY/T6xp2SuiVh9uccdivjOvDkLw9o4BZLewGj3sK1HFXsOw4autrDA9e7Kv8bcBVyVP1
         Dlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711174631; x=1711779431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUD52ht+HR3l3eedQqUGqKmwp+yFV4q4zkif3Vs2Vr0=;
        b=WrctcvgUF3LfS9D0veRpsODYDkks4vj/kbn7L1ep/FtWxAtcwklDliTu8GGN8ZLZ19
         dY/swIWCwlrTkzeN1NabSfGX5M53YNn6TLO+nOctYjxzdMaWRj39uPguUNJvVvIfOa+R
         AbQMIfD6WolR92/WRc+CucNEyl18riwJz0d3UNdpZy2jzlWsmdA+7s7KV9pbBg2oONhL
         n0zZ0tVZ/Vgb3t8+ZrESAUZR+zxCZOtqIrFHbO8bUG6UEHX2lIWhTaqWd1RCF3byULRj
         VM6U1zbHrlG9piyiIXRPKfd/sOog3oemx3qxcMn7TEK3OXFcU0tLIeUxba8v5Vh2t7C4
         dv2w==
X-Forwarded-Encrypted: i=1; AJvYcCVXQnfF0thv/mnjtG6k6PG5hZ85h5JJNMnDpy0oulhoBMxYP8OeazwDRNRxiWms1oty7yyKgh5KhKMoDFt8NJPaCMWVYsrXfhWT7ZJl
X-Gm-Message-State: AOJu0YwbChrfKSu3hQgK6kBxBjXa8wPVZeblZVhDpTuZ+Vr/NwblDE88
	PbBYIHG8HRFOV6zS82o+mUnqzOorjdWcmHP1nENNmSsQwTIYm9QyMu+szSPgvNE=
X-Google-Smtp-Source: AGHT+IHsW+rCkfYvisR1ygy31z8BZc9G7J8m+4nL2/pwwjaGvRY/EyVRR4S6gmRAATdetLzbqae2KA==
X-Received: by 2002:ac8:7c47:0:b0:431:458a:8ea5 with SMTP id o7-20020ac87c47000000b00431458a8ea5mr220141qtv.55.1711174631036;
        Fri, 22 Mar 2024 23:17:11 -0700 (PDT)
Received: from [192.168.0.50] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id bb40-20020a05622a1b2800b00431435c34b1sm196691qtb.60.2024.03.22.23.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 23:17:10 -0700 (PDT)
Message-ID: <25ecf18b-7533-410a-9b1f-6c11343b8565@draconx.ca>
Date: Sat, 23 Mar 2024 02:17:08 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: Select I/O-memory framebuffer ops for SBus
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, stable@vger.kernel.org,
 Javier Martinez Canillas <javierm@redhat.com>, deller@gmx.de
References: <20240322083005.24269-1-tzimmermann@suse.de>
 <877chu1r8s.fsf@minerva.mail-host-address-is-not-set>
From: Nick Bowler <nbowler@draconx.ca>
In-Reply-To: <877chu1r8s.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-22 06:43, Javier Martinez Canillas wrote:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
> 
>> Framebuffer I/O on the Sparc Sbus requires read/write helpers for
>> I/O memory. Select FB_IOMEM_FOPS accordingly.
>>
>> Reported-by: Nick Bowler <nbowler@draconx.ca>

Applied on top of 6.8 and the build is successful.

Thanks,
  Nick

