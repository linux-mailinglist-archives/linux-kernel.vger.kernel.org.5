Return-Path: <linux-kernel+bounces-134304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF9689B01A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5291F21647
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8451F17BD9;
	Sun,  7 Apr 2024 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyG6n6l5"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670B17999;
	Sun,  7 Apr 2024 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712482588; cv=none; b=cCK8R5evUGLNEmd0LwDXdAJSYh7iLQxlk31zFn1+Cjg2YGERrYFSrj/XYlN7kQa/gJjEVIM1xLEkcAVaW5lcqKsvXUqX11STvQrz2NK5xNYIkkPCR7rGXFq7P6nCnqP8ylZyEtJzHQYceaihR/bqeoqFkMrJu1PBdUwU/o6Ih80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712482588; c=relaxed/simple;
	bh=4p3gqivp3q4YZE9SUTujN/IyDYJz8cPf96naYBFaaQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auXD3+b+tTBNaz9tbeJWH3mfnDMI8VwpVNj0Lesgvz0PVT62Ytokiq7V9lru1MTiLbpHY4WlZOrkKacJkuU/lUT703QJT40Jnpgvyo3mCKQoW8R6acw514bQChdbKnaOvtiWZasKE6t0B55iy5CmnRmAVzTyf9U9rerju9SYaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyG6n6l5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51ae40460bso35342266b.1;
        Sun, 07 Apr 2024 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712482585; x=1713087385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4p3gqivp3q4YZE9SUTujN/IyDYJz8cPf96naYBFaaQA=;
        b=gyG6n6l5I84TWTvSunB59ri4nqJ5dZz3MTBoKm2HucDbbzNxvv/3bULvkRZADmPVbT
         V6YghhbxNoY4G2yDA+o6s8K3fMK1eFVZH22gT/joDKfEA8sgcBVL2V1zmdClNjj10Hm2
         SzMelg8BsCFNWQFFD61LnFfpsnCSAUDR8YPzQyT+Zj1PkShLBCe5TeYeAWADCGULvrZe
         EC5XXRVeoy/an5VgDUoe8hMZfrHSSC5r3xkQ2zfuSx/DlwGto4cL03Tn0NBwc70/zeXY
         EkD4Lwe/evjr1fdiWbhIkHRCNi7XwbfPCSC956LU3G37aQwb4pIDb1NTj+u3tD5xiqE9
         BJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712482585; x=1713087385;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p3gqivp3q4YZE9SUTujN/IyDYJz8cPf96naYBFaaQA=;
        b=qAp6eKyh+hutnSFGLQu9MKWnuVVAW0gxyanqTXXgdAnL45sbBtrtiM2mChvJE17n/f
         DYmiYBaSC5V7bdgwWWJdkXJN7l2VbgTEz4PU5TEgJHLahdGpA8UKYghY+V6ORIO03jfI
         5+MY+DgcITjtY+3DEEKFEo2yYUOyEkS9TJl6Gg8RoEF5q4LU8qZv2H2cWzOJsrP/BPux
         fQFCVojFXRKbUnetiNYrEprvgDXu8UT6HkZuuU7xrzMemBODn2axPih8JZ6sr+WnKY42
         mbja691vWd7ene/DLJss+53UHBR7VHlbSELqNmHTp6xh9N2TcrtgbfWsqPnRnOyXOQ2b
         O3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUCsfFdVByBLAuRFLxhMog3nYGvG9K8xB8ELso7PoF9nr4doRucGgousDYXdfUfestPOM8kXKejsHhcsmPe3V0m4n+UIEb2ih52JutEt7CvpnLN9F6PXWJJ5J0QtRHTrS9QsUUl
X-Gm-Message-State: AOJu0Yz/7L+rOs7Tnn3CmXyScaIBH+PYPmaqDbDUl7BwgZ99gZM/dzsF
	eXXzkkNZOmZUWlGJGT1mNqPhVBOAJ+2N6dpFf4/QLiT+V6XPckj6coFc0sY6d3OnBUun
X-Google-Smtp-Source: AGHT+IGeUtzl+ftXHB+D6b4Quoamt4GxOvDKy9IJCIiaNhWMIwr8D+TYTUtQK1hoAmRtNEdrOOyfJA==
X-Received: by 2002:a17:906:338e:b0:a51:a255:ed83 with SMTP id v14-20020a170906338e00b00a51a255ed83mr3780016eja.2.1712482585318;
        Sun, 07 Apr 2024 02:36:25 -0700 (PDT)
Received: from [192.168.1.2] ([91.86.182.228])
        by smtp.gmail.com with ESMTPSA id c27-20020a170906d19b00b00a51a00142bdsm2952669ejz.212.2024.04.07.02.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:36:24 -0700 (PDT)
Message-ID: <0a716f53-5c88-42e7-b183-fb8ae4d4959c@gmail.com>
Date: Sun, 7 Apr 2024 11:36:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.8.4
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: torvalds@linux-foundation.org, lwn@lwn.net, jslaby@suse.cz,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org
References: <2024040409-attentive-raffle-d9bc@gregkh>
 <2024040409-disliking-mammogram-096d@gregkh>
 <41c2bdd3-9b66-404a-aecb-8633d4aa98fb@gmail.com>
 <762f7ace-7fee-4f61-823b-54a1b7d5bdce@gmail.com>
 <2024040629-bullfight-wind-54f0@gregkh>
Content-Language: fr-FR
From: =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>
Autocrypt: addr=francoisvalenduc@gmail.com; keydata=
 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
In-Reply-To: <2024040629-bullfight-wind-54f0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

While bisecting, I noticed there is now a new configuration option in KVM (support for Microsoft hyper v emulation) which is thus needed for Windows guests.

If I enable it, it works correctly.

Best regards,

François Valenduc

Le 6/04/24 à 15:27, Greg Kroah-Hartman a écrit :
> On Sat, Apr 06, 2024 at 02:42:07PM +0200, François Valenduc wrote:
>> I also get the same problem with kernel 6.9-rc2.
> Great, can you run 'git bisect' to find the offending commit?
>
> thanks,
>
> greg k-h

