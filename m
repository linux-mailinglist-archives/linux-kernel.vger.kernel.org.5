Return-Path: <linux-kernel+bounces-136293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E73489D250
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032DD1F22147
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6620D71B3D;
	Tue,  9 Apr 2024 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlednAEh"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D76EB72
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643834; cv=none; b=Tzf4pe/hBfm9RMs6dTXF4ENdJHFUM1KU40X5dUCwNRlmOQQlw2QrSMNG3gj/+I+gNm3NlNOlzOy93qrYCSm0Hevhef9QDPhKZMXLi9lZB3WMChrgouGh9ikorBEArFc0lMLHFfqa/2Hc2cuSFR7AW6BfltOjaA8EHUgXNnTvggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643834; c=relaxed/simple;
	bh=4FCqcdUY4noIr3hyXGLjsXuMQ28NOckQh0S4mytZc+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDbKlUyza/LIJI0x62OTYBUO1gB8BtPqj6iEi1qgHQSOhUyPSCp7M520tse2ZZikcm8odP8edvOEhQOIQgm56zXQx+QFoQX1o3x2JB580fPjENito2yRyAN7hCUW2j//ycL5cuvsrF5EUQSMTQuf6r4vqTQOz7l04pIBiaFRCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AlednAEh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d1c8dc79so5616823e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712643830; x=1713248630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGaOLMAwWEbHzlVvJbIY7WaGUlj5DXjFn2iEaNlsiUw=;
        b=AlednAEhe1YT/OUUncjleNOiANU+v9UAJUHmuERK2kA5YVb21ZP3h9ZdEfqgN6gX+u
         u58l1M/90pb90gHlnwV284hq3bJxLJaJZKcjUlRaaQk12Aj80rntU0v3yhr/hQ13IEW/
         wsKzyn9XA5oa4MhlNaAEByv7GBt2XlG/xm1RcDYMxJcMTcQ1RTDbsKy+xC08q58AQGoP
         /7A0KMx8EvtXYn6RjvhHuKeIxcLrn84aYjUfFDGx/sdSQPpgJJf+wCm5X3Chda4/hCz0
         CL2Zg98y2Bz+MNi9v/DjLAxg8my8XqY59LbdKHINNWWqDPmsG+euFern+oFDO4zioiUz
         IfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643830; x=1713248630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGaOLMAwWEbHzlVvJbIY7WaGUlj5DXjFn2iEaNlsiUw=;
        b=vL1NKuM429iaxo699jQ0lR83Aw9tANVPyqsXAf5SqVbQNAVXIAxtLgFhFV23lJI02S
         XfuPpJiqKW1IlPmfCB9HuSFbK2NtUOEwbAQ1MVHvO7ouYOXL2mOEIvNrwp0QJGsk3Kdb
         IZT9TCWXL8y6LSRhlhhli7HRXnkQ2K2YLZghtssQUjGiSQsgfTwDpMGyjXPgHA5K6e8e
         fMGVohwxEeXhqlGJ2ba8nwd0rgfZx5FOCdrU65/EuUZDeTQgqDP2lg0yC1avcTuTsyQf
         8U/BnIZNOFFT285x8+2KzKm+8uS09JZEZT42BpCjAp/VY3ETK5Hzx5NqPPNPPpD9RjqT
         6mgA==
X-Forwarded-Encrypted: i=1; AJvYcCXG87igFchHZ8QUr96r9J283IqG4MQY+ylSX2kE6CXwh02fygxKiAH7IBjCZh1HUejA9I2W1yzkMuN9bqCzH//I8SE2TgR1FGcpfAPY
X-Gm-Message-State: AOJu0YzPjGDTDbfuUb4OcZur2FeIV7cl2jDVmUEGB7OyvjSsNGObekQk
	qDqRLJmmsjx2CDNh4W+FCEzRldXNwLP6g4A/Im3iOhvu1M7B+22GAMKw0vWzFUQ=
X-Google-Smtp-Source: AGHT+IHic/ZFaZhwMq0y4OXitpFTOZ7AWtJP5xJ2fYwTZegcmgvKhST0G6zJfdaUu3/vRXpLi4IcoA==
X-Received: by 2002:ac2:59d0:0:b0:513:30fb:d64 with SMTP id x16-20020ac259d0000000b0051330fb0d64mr8012172lfn.44.1712643830122;
        Mon, 08 Apr 2024 23:23:50 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id b93-20020a509f66000000b0056e0376286bsm5021838edf.24.2024.04.08.23.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:23:49 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:23:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Justin Stitt <justinstitt@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] [v2] staging: rts5208: replace weird strncpy() with
 memcpy()
Message-ID: <bcef5496-31e7-4fe9-ae4b-b1e335eb099b@moroto.mountain>
References: <20240408194821.3183462-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408194821.3183462-1-arnd@kernel.org>

On Mon, Apr 08, 2024 at 09:48:09PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When -Wstringop-truncation is enabled, gcc finds a function that
> always does a short copy:
> 
> In function 'inquiry',
>     inlined from 'rtsx_scsi_handler' at drivers/staging/rts5208/rtsx_scsi.c:3210:12:
> drivers/staging/rts5208/rtsx_scsi.c:526:17: error: 'strncpy' output truncated copying between 1 and 28 bytes from a string of length 28 [-Werror=stringop-truncation]
>   526 |                 strncpy(buf + 8, inquiry_string, sendbytes - 8);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The code originally had a memcpy() that would overread the source string,
> and commit 88a5b39b69ab ("staging/rts5208: Fix read overflow in memcpy")
> fixed this but introduced the warning about truncation in the process.
> 
> As Dan points out, the final space in the inquiry_string always gets
> cut off, so remove it here for clarity, leaving exactly the 28 non-NUL
> characters that can get copied into the output. In the 'pro_formatter_flag'
> this is followed by another 20 bytes from the 'formatter_inquiry_str'
> array, but there the output never contains a NUL-termination, and the
> length is known, so memcpy() is the more logical choice.
> 
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/lkml/695be581-548f-4e5e-a211-5f3b95568e77@moroto.mountain/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: remove unneeded space byte from input string for clarity,
>     rework changelog text

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


