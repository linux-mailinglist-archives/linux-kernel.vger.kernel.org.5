Return-Path: <linux-kernel+bounces-16292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D26C0823C54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF399B24D72
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074F1D55F;
	Thu,  4 Jan 2024 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aetCW2OI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42121DDEE;
	Thu,  4 Jan 2024 06:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FB2C433C8;
	Thu,  4 Jan 2024 06:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704350731;
	bh=HGvQAbj7vdZsR7FPaga75+bgAWN6OGdRW5CxcWOmWaI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=aetCW2OInm1yCVrlyftLLmPJ+zyE1snIsoXSCLiZ7OGBhFzj/3QejAe9B6sL2a+MS
	 hiC8oDKDmKpzIPCih7uCe43zqqN+eycO5mELp+1WwrUAjjF7mOUm8qOdZ79EIs5uRq
	 pnmOzOFOqVtviIfKnEoKWoIYTSNjuorxvVPnaTAt/k6obMNKxqFlPLgRN6i4HsNACL
	 e3jSn7mnBITQVhXi6clJS+D8Y3sx1ez56IQnIY9MgHeLjgxAQSdOn7sJ6WvNcz8Jod
	 uhTQaNDkAh4nhm6yXmhe4jyTK79Is2R28/QzQCQohgFVsgweXdojE/Wrgph07a6SlN
	 On2euhK+Bj6gg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-593f7a1afd7so96602eaf.0;
        Wed, 03 Jan 2024 22:45:31 -0800 (PST)
X-Gm-Message-State: AOJu0YwCHd80IB0mLC/cUSzvRqOnnTtuN4NWfKPh0UcZetvrKM1/iuxD
	sDeiXC2/E3xfo7BvS6sQQ00OQ5J0AF8VrjnGYRg=
X-Google-Smtp-Source: AGHT+IELiwVkzsZGvW6sqO6fdix6qtpPSxBC8xNCpB5TVDwLeW2HM2iEpDuv1LIbnfKDOIAfoksCAYpQkz8Omdyc9mA=
X-Received: by 2002:a4a:1407:0:b0:595:87a7:26a5 with SMTP id
 7-20020a4a1407000000b0059587a726a5mr175376ood.18.1704350730783; Wed, 03 Jan
 2024 22:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:c13:0:b0:511:f2c1:11ee with HTTP; Wed, 3 Jan 2024
 22:45:29 -0800 (PST)
In-Reply-To: <20240103164853.921194838@linuxfoundation.org>
References: <20240103164853.921194838@linuxfoundation.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 4 Jan 2024 15:45:29 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8qswi39L+FLRjXdhv_0ziS+xKg_pKbUB_D0srNj7Bc8w@mail.gmail.com>
Message-ID: <CAKYAXd8qswi39L+FLRjXdhv_0ziS+xKg_pKbUB_D0srNj7Bc8w@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/95] 5.15.146-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

2024-01-04 1:54 GMT+09:00, Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> This is the start of the stable review cycle for the 5.15.146 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.146-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
I have tested smbtorture and tests through windows client against ksmbd.

Tested-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!

