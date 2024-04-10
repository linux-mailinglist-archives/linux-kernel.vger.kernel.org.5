Return-Path: <linux-kernel+bounces-138365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BCA89F025
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3F928255E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A86E159599;
	Wed, 10 Apr 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="B99zIrzF"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF4E159574
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746099; cv=none; b=ruw/nvMKDJOncmZ0BizDbnABNSEOI/BZGmZ+i6ixZ5r3mNB6L4LForqNXV2VCCGq348upBGhOeh4HD/WcPTV7PszoBFBhWGKSD/DAeO9udybGuUvtDyR/dn+0mwpjyUMysVUxCzqkiGbu+nGthsGunPbvK6zGbWZZoCANLTBxl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746099; c=relaxed/simple;
	bh=eik9m6cp2uZohOzU8Oz+3bZ4OUinbaNDJ9WanhK7KSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srZGwe0TC+Op3lwxX4mND4AEEmZrmqfwMCDJii6GSNMYyTWG1vJgqlpDJzoBp1m7Y7ClQ2r3VarEy8/HCy0cNJz1iqIjZdD+ifQHIbYO+zfWh5ECDDp3hDjn9vbztdOecIE64VxTgy+7NF6liapByzDzbvauq7W3xNr96v1z4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=B99zIrzF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a3095907ffso3359850a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1712746097; x=1713350897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNqD10j5CZpBny7jQPfQMEvtKqWfKf6kWfbDUoXBuJM=;
        b=B99zIrzFlflE2Bzqw9bXXwdpeUXPRgvt4k1P3JL+kXEeZhyvMcvokLmpY5sAgedsx9
         Krtvctsrbn2hfOOP0yWcIqIisZe6+qk4DQQdA2tN4KCVeASk2ss3deTGafUytwmN7APW
         Qp+CLood6X6PbFSTsoV5bR7VXYEoPzzOCkyzgMf8CCtt0XJIiW6iXzqJ70q4LObGnSa6
         C3vukccb7zzx9GczTo1qP1lRW5KKl9GgMWlE2/cCoFYedb9mSCwJvIqIOmUrXIF+PHoT
         8FP6/7UimXXA6DygEM9so9DdHFjQrKPFAi59GORhmvO3fxgGoc08ptBOh/AZgle7bg9a
         nXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712746097; x=1713350897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNqD10j5CZpBny7jQPfQMEvtKqWfKf6kWfbDUoXBuJM=;
        b=jdlQ/W9Q/kEoZIuJ+f7RfjAOMq5tALKIVe71z7A7M2QC1GBEAsNB/WnLb7pmtw08XO
         VLOkwywJnFS5LF9z7sttUFlAsH0ipKD62FLsRD5KP8lz3u9BGUKGi6scsGBUbTDmm4CW
         E4xvLi5E7yWDH7Zgkm/GVQLE0MGU4iD+S2vXAIWM8BEstEwCJgOcxD4BIpelmlJh0bnz
         jNmfLoNLbo4vEpctJGaF1ZX+JID/UmIWUzo2GrTZ8HRZ6nfaDVxp6OazrmFigpF0IMhr
         QqVPLLLmuNeJsQCmaFHkvwraC6DQIJiaaFtd1mVzqp155PBXxSEDf4hi7imUEJq4UmLJ
         fLfg==
X-Forwarded-Encrypted: i=1; AJvYcCXl4p/B6izhV9NGIRwUproxj1lvMhdOUFRTx4vKAuvvAiKY/wh1zxN2DkgAgzQe3MFMNEo5ufCCAoB049MQIJV+NhiovWb3qRQ2eCFb
X-Gm-Message-State: AOJu0Yw53DxJ5nwBYIdURualUGCimG94Ch8cz9MXo7ZEjb5rMZupOLze
	5Ozos3CaohaKB+0Q07sONajOpYgOssQgQQ2FqktCokb7IxK1jVUZLjcX/tg/hTNw7cU8UU5zp0X
	WhECPZ7GbIB35921e4eTFAywBa39q5mJY01H24w==
X-Google-Smtp-Source: AGHT+IEOi7A+jM3agseYiE2tgGFF/lIKAomfhvj5GEMdbiDzHPEJRuS+/3WJ05h17I71ATBjBeaOThBJ5VRShOGE6pM=
X-Received: by 2002:a17:90a:6b07:b0:2a5:3438:a31b with SMTP id
 v7-20020a17090a6b0700b002a53438a31bmr2111883pjj.37.1712746097485; Wed, 10 Apr
 2024 03:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409173540.185904475@linuxfoundation.org>
In-Reply-To: <20240409173540.185904475@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 10 Apr 2024 19:48:06 +0900
Message-ID: <CAKL4bV4Ltkhh=jBBoy4CbnLOG25Eb4eEpLC5usBmeJFXZEf28w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/255] 6.6.26-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Apr 10, 2024 at 2:44=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 255 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.26-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.26-rc3 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.26-rc3rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Apr 10 18:40:29 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

