Return-Path: <linux-kernel+bounces-4500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E843817E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AE81F22BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B8F768F1;
	Mon, 18 Dec 2023 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="FdTlk4ZO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB91760B2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9da137748so1634645a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1702943058; x=1703547858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s38PvxZbBMTVGvQ0kbtSdyWDBrmSjvOO/03Z8xfaLco=;
        b=FdTlk4ZOwiAaifg5lHVTamXACv8DPiF6EhrqN47ViXVGSStKlcLFl19VkLDWguzQDk
         r4aOghAPLvojhZ6qWq/1lPTMfi43Qg+xLXFVCcfCCaZjidUxeAputYgEDrv+vEC/lgoY
         aNz1XGDYscuWbfGaal/+iJn4Zg3KxqQEWZr28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702943058; x=1703547858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s38PvxZbBMTVGvQ0kbtSdyWDBrmSjvOO/03Z8xfaLco=;
        b=Om4dChNcGoHJhqm5gIxAfrjlfzO78A9XDLq3VP9+N2P8yC5bAtr7egaDwm7MhTf4E0
         goMW2kjL0hJoMJKVLDfRsit7bYfrnUQvlicu+Mt0rSvtzUDLn5NKOVxqjyEDNs3m81CL
         9HMlByeBpdUAIzXl5CKxmI7ATONZ/Js2eVpLqFx2zmPT4uK+lz/EFmzDQZCLGM54A3Z0
         oSAB2gZjPw8a6VTa96YVfQzJ/utmPi6k6auoaSoMWAOe5T/QgZ6OvFLee1WCOsMh9+ZU
         5S12uBtIkCEEWwwq/7rI3GANdl6cQSHbe2ny729sDFmYN00FwxANm9YhrmeiTwS3Zxyl
         Liog==
X-Gm-Message-State: AOJu0YwwTuA00yZ3zca0Ft0lze3tlsH1ABKd9E2BMUfPb137s+RhGI/F
	iKeg0wmWpPIPfFLtbwQBn46aKA==
X-Google-Smtp-Source: AGHT+IGRv7a21r4zLDBsHKyuUtnKJGh7ThK4XMmPsNxiSeiENXirtAI6HZ3j/MXWq0z0MRxacOfwNA==
X-Received: by 2002:a9d:6e08:0:b0:6d9:e61c:2c8a with SMTP id e8-20020a9d6e08000000b006d9e61c2c8amr69003otr.6.1702943058308;
        Mon, 18 Dec 2023 15:44:18 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d66cf000000b006d7f41c7e11sm4792433otm.33.2023.12.18.15.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 15:44:17 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 18 Dec 2023 17:44:15 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/166] 6.6.8-rc1 review
Message-ID: <ZYDZT1sLD1D9Kcjo@fedora64.linuxtx.org>
References: <20231218135104.927894164@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>

On Mon, Dec 18, 2023 at 02:49:26PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.8 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

