Return-Path: <linux-kernel+bounces-26443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2407382E0E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD692833DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E4818E25;
	Mon, 15 Jan 2024 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMQ6N65l"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2852E18E10;
	Mon, 15 Jan 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4692b24f147so353039137.3;
        Mon, 15 Jan 2024 11:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705348051; x=1705952851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jde4lpmFdsAFmDNQO8S4NfMsn10GcVLzErOQlO9jFaM=;
        b=QMQ6N65l4/91RAhurvMlJxH/KeTgnE45QiTwIw7h4hzqwyrBMReEu5anlJgttc7kk3
         LnByIvkmsCohGKIMsc/dg9xxx4X4JGZei+lxJIxQGr4kNqenrNik1Js6z44x2dRFBHCe
         uhc6UBDsSEl97lPeH9uwqAcFtfSGxJrH5gC0NtA012xjXco8zALrqbr4BihTld9jTQDN
         PHqcJOtJYn07+y4ix5DUAHNtKyIho8NLaSJoXHAior7Q00DyG/sT6x3gsqWbW7MLpwpK
         tEuLlQP18i0D/beig/5RFECA326IygUPnvpKYkQ6XUzcMFNtoC6IiSBhhCHSA4kdD7Gj
         9l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705348051; x=1705952851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jde4lpmFdsAFmDNQO8S4NfMsn10GcVLzErOQlO9jFaM=;
        b=q+EzRqmVlsEktNCM15TQYueDnBhsxXFHtv2lEUXlHTfLuN9BLn48LR5KIz+DoLHnqS
         zS9P5W5uC/jZluKczWz2P0VRECypNmIG+7gcKHq9hlQQyRXIGsdBPgFGcgwXqQnOCJK/
         Ht1RNdgcJfztekuzSWYKMxlKaZX0RfNvjnTaDZYcEYEISbBXEuuoWqBV2GnMgQ/Y5mA+
         HaBiST8XqryMs3Udtg3p1pGfW1we+sSyprqQrCOyf9k3zaXRLrRGrFHEAVclywJHHlH6
         ukLRERfnShCSgoAIXv767vtHKr9It/kPobNqHW69Ck2aj20+66CwJEUrxabJB5Ri7cqa
         e+sg==
X-Gm-Message-State: AOJu0YwbQNfW03cIwTSvxCkdsCLR2XDU/NGkiyVL8iUlyLq07NxgB064
	1sbwVoz8O3oSCOqPB5pHllBzXoxprzGWQv/miJE=
X-Google-Smtp-Source: AGHT+IHregLe8WyP6+3NAesPPtoO6c++SbsJWado1i51htlQ7l0vXhxAKYCYLuD9rgjNGDLCA4qdUnE52WR0+WhgXfM=
X-Received: by 2002:a67:fd64:0:b0:468:df5:2e47 with SMTP id
 h4-20020a67fd64000000b004680df52e47mr3883309vsa.11.1705348051084; Mon, 15 Jan
 2024 11:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094209.301672391@linuxfoundation.org>
In-Reply-To: <20240113094209.301672391@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 15 Jan 2024 11:47:19 -0800
Message-ID: <CAOMdWSJqEfcsrKG4aiijMU0DX_YLZ1n+sQ+g1Va52mq81R51yQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/59] 5.15.147-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 5.15.147 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.147-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

