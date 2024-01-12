Return-Path: <linux-kernel+bounces-24263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB482B9EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE878B22B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810D21848;
	Fri, 12 Jan 2024 03:20:48 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42521841;
	Fri, 12 Jan 2024 03:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67fe0210665so31821846d6.1;
        Thu, 11 Jan 2024 19:20:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705029646; x=1705634446;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjSZW8FnU+OrzwsALUbbUaF+dnHxygb6H1sJlT6LvIE=;
        b=NVDgfN89LkE73k3iBohCCwUAv6aSd9wSHcUGW6F9odTmLE8FYVBW7oO4AnLHXa4aD1
         6fMEOWMlswvjLJXOy0wltDy5p+p/LVjEYKJuIwJjlDf/yaePZhonP4GWHo8O1qtxeNC5
         yDckkyox167SzZujC1JxqHEsSahIbxb/edUrCFjnE60lMUiK2brPQ5Tjqu0wE1ZdWOGg
         zOb2SyHmw+PmY1LMEC+HEtOunDVMTqd2sRmgqy15fAryvs9DosATWilIrEbZPAq0XyUg
         6MQni+cA7MvCa2E53Adej93ui+z8aHKAOfzWMNjhuGOcivJ438ndbSAoLI6cfC1jmLRa
         9NGQ==
X-Gm-Message-State: AOJu0YzipwMRB3beT5b8Rr3M6VFy4wLh7yqffTzaH/ZSJk2C/6Vkujjq
	uQCsbieWNBvBSLGjwM4Zi2ME7xXnIIk=
X-Google-Smtp-Source: AGHT+IE+IjGMHZFRTO2SsMQm57qvjPv4hTZEK4rGOiUbRXGOPUCiSpYiymbpFBky4s8Qucq7uOeIHA==
X-Received: by 2002:a05:6214:2aa1:b0:681:304d:6712 with SMTP id js1-20020a0562142aa100b00681304d6712mr275862qvb.77.1705029645689;
        Thu, 11 Jan 2024 19:20:45 -0800 (PST)
Received: from smtpclient.apple (pool-108-4-150-17.albyny.fios.verizon.net. [108.4.150.17])
        by smtp.gmail.com with ESMTPSA id t18-20020a05621405d200b006810a0ebf24sm759708qvz.33.2024.01.11.19.20.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jan 2024 19:20:45 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 5.10 0/7] 5.10.207-rc1 review
From: Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20240111094700.222742213@linuxfoundation.org>
Date: Thu, 11 Jan 2024 22:20:43 -0500
Cc: stable@vger.kernel.org,
 patches@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org,
 akpm@linux-foundation.org,
 linux@roeck-us.net,
 shuah@kernel.org,
 patches@kernelci.org,
 lkft-triage@lists.linaro.org,
 pavel@denx.de,
 jonathanh@nvidia.com,
 f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de,
 conor@kernel.org,
 allen.lkml@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D11BBDBD-C19A-428F-B459-95B0761EDC16@sladewatkins.net>
References: <20240111094700.222742213@linuxfoundation.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)


> On Jan 11, 2024, at 4:52=E2=80=AFAM, Greg Kroah-Hartman =
<gregkh@linuxfoundation.org> wrote:
>=20
> This is the start of the stable review cycle for the 5.10.207 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, =
please
> let me know.
>=20
> Responses should be made by Sat, 13 Jan 2024 09:46:53 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> =
https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.207-=
rc1.gz
> or in the git tree and branch at:
> =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git =
linux-5.10.y
> and the diffstat can be found below.

Hi,
5.10.207-rc1 compiled and booted just fine on x86_64, no errors or =
regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net =
<mailto:srw@sladewatkins.net>>

Best,
Slade=

