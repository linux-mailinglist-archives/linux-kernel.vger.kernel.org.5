Return-Path: <linux-kernel+bounces-64481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25BB853F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D91B290F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C8D629EE;
	Tue, 13 Feb 2024 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq8N/7YA"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D321626DB;
	Tue, 13 Feb 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864379; cv=none; b=csUMN2n8Nm3V1wUYF+AizW5gvvWZtp6spHG6doZmPOt063yN0TxMoRYYua0bcGbnGkv0M979JTxcZ52/luERgR6o1t6DZr0A9oRKGYzMVmyUe9346XfrqoWhEnQcynRRSK5AD6pKZMum5Kzgh6oWxWSAaqBlq3TrqPHqoc0CYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864379; c=relaxed/simple;
	bh=nhQahWR8qxaBAcqLn38WkwfH3WZavzBYN8qTFJQXPx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpnSs3gNfv/WRYD+Jh2+DilDM4VePfyRUs/w9MZwwSFDfYekK/ElX0hDKNO/bf8hkpf+CrWxJ2zlMoDrDhLCOp4coB1VP6VqBePBGccbiMrz4SuPcFIZrfKIEBSaaMa13F9qGBjJUddhVjpxwNLSgjscSAXaqA+AWOdzR1vJhec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tq8N/7YA; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c02a92d563so537047e0c.3;
        Tue, 13 Feb 2024 14:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707864376; x=1708469176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GVpdqfFjdBVaR9nwEwM/0QGjipjHAXDN3BcD9vceeaE=;
        b=Tq8N/7YAcgYFhkaCKD8sdqvN1yIUORveC9OtWnvT9VF4to102wEBC0NpU919Bpelhi
         ZjbYBGVbs8qpsHL27Y0dhOLygXKalZda80gjpLm9FPlvFNM0YdJg9avnpKVt+HsWN2U+
         Txsq918kO12F4anRcP0hKnfLlDj5Bn8W2+HuBeooMI67Pf7EOUaRP2fVqietzbp+Enh/
         jbze1DZm369x66Z01vNXKbWGMH7lJ+NtSuEkXMV9g+WJp6tWPdX+OQVHPThyqTtzniEc
         UsNPGAydqkSrEkicoVwlpcl7vKcXsjrP1b/+OlBMZiLYKz0j93aVBYJuhPSfrsLTQ6tN
         +yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864376; x=1708469176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVpdqfFjdBVaR9nwEwM/0QGjipjHAXDN3BcD9vceeaE=;
        b=bfUAbA61B1EawkPnaXPsRKnyOoaKCHFtVWxeSH1cNMrBiKr3pMjEIbU6R3v8EhdrrR
         1FZ8imm9o3mlqZbklag3cdhnIbvGa/g82A82oC39u8k2VZqoG3ipGZBOdlVwVUTh58/W
         24R2BkSyMzzojlbFztcTKoJp3rdRb82irz8sbSCYKNMDfTHoTOkyGnNveDWIaGyXRJPQ
         5KmbnS/2qUMF1Yoc1yV4GDPBduqLtPO7htXhdrUIXpEyGtOKl+oFF8E1Z7H0E/5sYJ6c
         LZ30hj8UJN/6aWY99lpg7hzHnkR9s6CBeKXZMynv+kPG0jNbMwavyYROc5eArYNwRqqg
         aBwA==
X-Forwarded-Encrypted: i=1; AJvYcCWrem4rMhjmA1nlPJfuv7TRk09T2EkQ7Z4CcOgbZYu8vPKoi5O1RCtkyBQcdv+9je63AT81g+8zrNEaDAh4pFOpCjM8fuNsiSufvmoH
X-Gm-Message-State: AOJu0YxICFEI7hpBY8zsCMloEmFZnLo/HpcjRZwCxzR9FzzR2Fy03yhS
	lS4kPtXlVce7RvHfagLYOxjKT6U/iGzfwG/zgNMWWn7EFZn6Vra+LAfdFexXG9pZ1Qy3ypT1rVe
	YDBenwYnSni/OMHxehxvDoMQAFHM=
X-Google-Smtp-Source: AGHT+IFr4MBTJKL2nB1kW6w5abiX+mdZ5GRxVWRdrOLH2lAoHrSyGQW1BfYX0o+Ye3+dgWTiyGU+ANr1XAuIGwUtD5U=
X-Received: by 2002:a1f:eb04:0:b0:4bd:29f7:53c4 with SMTP id
 j4-20020a1feb04000000b004bd29f753c4mr1014391vkh.1.1707864376266; Tue, 13 Feb
 2024 14:46:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213171844.702064831@linuxfoundation.org>
In-Reply-To: <20240213171844.702064831@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 13 Feb 2024 14:46:04 -0800
Message-ID: <CAOMdWSJy+-KrWK5P0JKMjS=j=fCONhLiR+sLKB4vUSo5R2M-dw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/64] 6.1.78-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.78 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

