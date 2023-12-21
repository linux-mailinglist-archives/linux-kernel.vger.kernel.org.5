Return-Path: <linux-kernel+bounces-7866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245ED81AE78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4264288A33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57CAD59;
	Thu, 21 Dec 2023 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyw4n40+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3FAAD53;
	Thu, 21 Dec 2023 05:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12CDC4339A;
	Thu, 21 Dec 2023 05:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703137287;
	bh=mIi42XPel+rGMek5ax2xp1+ciMxsEzHSYpFKaXe4RB4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=hyw4n40+um0QCu7sUaLRIDquTZrIep26J/ValMgu7oTQsO7TEJJueOM2SkQgyd9Ba
	 qvrJRHMzJm+GhpnNJOEqsXtI4OvJk33LhXZ6Ofrb7dZHnR4MmocDj6Hiw4FecJ2OOF
	 isf9MUiP0byeDo6lCn/KLT7rrwWUf1z/UEdY8A9sCYp0DM3yCJ43QnIsck2dv4vMiM
	 xSye0qCtfKnJkM1M+zdLDUzdV9MwdmTrOHmpgR0wo033I89S5Fb+VNgUM3M6PMSrFP
	 4eCaX4JmsXRi22C1jmzT2R7y7WVhxX/MAhNpcfo6AO34kgO07i4YFw232+WwCSu8pq
	 pO1cWpQ1kn8TQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5941f390701so272273eaf.1;
        Wed, 20 Dec 2023 21:41:26 -0800 (PST)
X-Gm-Message-State: AOJu0Yzima6BHPB/AqLxDuvFc6G2QicD6M188nzbkVSPMK+W/OgOjeMj
	diSSc+mEfSpIYbQ4kgtkvNsUIvZxyhjSe3NnCo0=
X-Google-Smtp-Source: AGHT+IH72jfKE70RF1Oa6frBAhrkdskftu8m+MAM/A7FQbZKX74yiySVenp9il2eRaFUaw7reE5LKXWJYPxYeSmRZBc=
X-Received: by 2002:a4a:682:0:b0:594:c1:2bd8 with SMTP id 124-20020a4a0682000000b0059400c12bd8mr1560281ooj.10.1703137286088;
 Wed, 20 Dec 2023 21:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:6686:0:b0:507:5de0:116e with HTTP; Wed, 20 Dec 2023
 21:41:25 -0800 (PST)
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 21 Dec 2023 14:41:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9cd9hZmtLc2zyuVbMOKw216bX5fNvo_=SZUtj8YkwkJw@mail.gmail.com>
Message-ID: <CAKYAXd9cd9hZmtLc2zyuVbMOKw216bX5fNvo_=SZUtj8YkwkJw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/159] 5.15.145-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

2023-12-21 1:07 GMT+09:00, Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> This is the start of the stable review cycle for the 5.15.145 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Dec 2023 16:08:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.145-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
I have run the following testsuites against ksmbd.
 - xfstests pass
 - smbtorture tests pass
 - file operations test through Windows client pass.

Tested-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!

