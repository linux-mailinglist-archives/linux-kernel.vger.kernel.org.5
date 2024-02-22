Return-Path: <linux-kernel+bounces-77317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCAA8603A6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C57F1F25A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB986E60E;
	Thu, 22 Feb 2024 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaC7jyTb"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E106E60C;
	Thu, 22 Feb 2024 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633683; cv=none; b=j70QSYPbuHLN1bujdmKAbaNqc7Dk+D8s7a0eqqMvwlxz0Bq+2znnn+JioHVZAc4WMJFcyBjstCCVJQHzPwXrGTomylziLMZVq1jhITbBPijWiR0o/gHU4M79tLm5eSeQleLmIq6RaSB3RxfsP1gwNWGcrtCQN2L3J704dxrNgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633683; c=relaxed/simple;
	bh=Q0oE6TAKOeGg7TRSoz97WttfP+sVDr0TwCb22dSeOhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSMgMhajN8G4eDdyx1vBa/H/gd42iIo51cZPMV7ce/zF5iPtTjaHfkeJ+kMzJyVC7bR0Wk2HY5/5OlJcCjIjg73YvjovaS45rK+UF/F7JV1TqkkyWvojzBnQujMx4v041r3wnKbEAyN7BgEDdxjpZ9YutO+CzoUsfaBDwXogiqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaC7jyTb; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4cb26623d0aso54442e0c.1;
        Thu, 22 Feb 2024 12:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708633681; x=1709238481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XUGFYzBsTBnCe9D+1RLKs/AQxHEx3a1SbCVCaYcyXs0=;
        b=JaC7jyTbkxbGRw18RqYzdTa8epsq/vGcM13z3SK1oc6CausX/huu+jsytd+QZAoiOm
         xzSSeEw1tw90WK6+gOV5FOQbolf44eta1g03r51du92H3uYWKP3k6GyWbQt3oJMSq9C5
         bmV27NnxQTT4RRo7EweAF6ueuv2GkeYaeLZTpMP+6xqosgQMtjV6NmdLVP2owQX+DjYi
         o5al7RqTyltfcoISKP0wFaVClsElH69JSUdkG5KH7b4wtYvm1eQts9KZLQki/FhuzH5q
         sU/G87VFmqf7Ivt1Z7N8AyqUvRCxdHZ7BMiiS1nmwgUxfmViiV0dbGdxaLiADLSBTPz3
         Q6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633681; x=1709238481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUGFYzBsTBnCe9D+1RLKs/AQxHEx3a1SbCVCaYcyXs0=;
        b=aT4/blQIY+0H/7i0NwPFkexKgOa/ZYTuqQUqPiI6/IpxFyP6F0UDf7SBPCPP+FV9js
         Y812NHNwERzvuKwhCMd8NwVxlorB//U3mrJlDbcLyVJcPO3Edl3aOYH9w8djdvS/IluA
         QeHMa6sPJYi+97qlnTbY7qqYKxePXshRFDH4tm2gej4H4rwJLYsylOhM2zYeVjrvCWBY
         SZStxtGnRwMQ/sAunnJnwz+RD0/S977ESe2O2WK0kvn++BcdUnEv0ZCecw+ibIK3VUkr
         MI9WOuZQw+5mxQCEMzkAnJnfBzVWlX1Zj3jQNB9XTJtVDJPbLlKtV6/fVqyd4shRFeaM
         9rag==
X-Forwarded-Encrypted: i=1; AJvYcCVyLr9r8yfzbWKBrWdC0GmYYSQN2PEavdSxpzAaUTqt6lZHPINTcRLd2fQE/ue9RumWbXXrUzZMvgp8yLefxAqpa3kBOSjuj4fr2vEl
X-Gm-Message-State: AOJu0YwaPiVanbJzONWhgKbOZuT8KDk+NDPYUaA/YKQjq/bmhWS0d/p9
	LacC6dBrmnfk8oNxdMXJVIvEw00AgSKp2Et/usR8dznAWljgs3pIWegCKgZMg/B3hsUX6pA10Ds
	5gSQ5MrOXiBnZHFF/2bR5eMLXjxs=
X-Google-Smtp-Source: AGHT+IGzcm51XqB/4oshCKEPTQnf9f7vbtkjyf06veyI/L/glAwnKLL6O3gAs2pu8wsxMkcreIHmxBcsoK+j6SvxbLs=
X-Received: by 2002:a1f:da81:0:b0:4c9:98f8:83d7 with SMTP id
 r123-20020a1fda81000000b004c998f883d7mr188242vkg.0.1708633680846; Thu, 22 Feb
 2024 12:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221130007.738356493@linuxfoundation.org>
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 22 Feb 2024 12:27:49 -0800
Message-ID: <CAOMdWSKKpAV_q7q+mbRo=DQm9KJp_73-Q9-Vpgz9bVv+TDCEUA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/476] 5.15.149-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 5.15.149 release.
> There are 476 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.149-rc1.gz
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

