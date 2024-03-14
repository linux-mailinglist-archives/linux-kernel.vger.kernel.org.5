Return-Path: <linux-kernel+bounces-103733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB3987C3BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CB61F21FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B532175813;
	Thu, 14 Mar 2024 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2JqGJTL"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B802E410;
	Thu, 14 Mar 2024 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445101; cv=none; b=B0sXVk8Kb8KFYCjhwGdJQMrE8zlQDp12pccgHOeoDOW5/QlCI0rNafQzWcUvX5jDT4BF/ORhh8urKRgi90dLSskwm2q9GG0TyBAqucjUFDj5nOZOmpMx+Cbcd6KJuHaeauJ02BrqdHPMCuivKdioA2dwcPotgKCpXgv5W+wf4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445101; c=relaxed/simple;
	bh=2ZdiD1IoUseLi2z6Jn18hB92ejMwVgbyw7tciD+Fnpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Otk9VOu3hetcJl5lXnMK+V+l0AIZigU6Pvtpbhza+fu6rmE+V4ZAgTD2sxUq0u53U8Xh4lSzmVpEw8xuaxpTY04fQ7gRqMqWsud+7iEmmVCRCQHhQQ/XNNPk/2oU0H1b0agFc5cWKWn+CFCgfOtnYHfCpyXvlRsRRWNnIz41pf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2JqGJTL; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-789db18e24eso54239985a.1;
        Thu, 14 Mar 2024 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710445098; x=1711049898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QM0EpX+2nRF6kqssGaNMOIy7olhnPJ21fD9kE6DtD/0=;
        b=Y2JqGJTLn1UhJZttV9BRDCcxu/mYL4UlCparLl5g+46Fh21jtTmPzHanohNAb8eME/
         m4zCn2QlI5cxwUBVvx+fvLa1AF7kOa9y9apR5zQISFeQ0bwwrm2P+wn7zE2NpnzE3QfP
         9DTOPXk7UOpRLgA3Ek/VU1sDR8FK6Nbu3wEWmB950OzZNWjkVZswPe3bnQiWAEu6Rfq7
         D+N6O4fFLwmrZqFpMkrT2+N2OGhoBYE0u1oRrXVDYTfNDA9o9kiBqvGaXSQMRd5xXdH9
         3GOMMcNjjEDZO/VXcPVRUHylt9jtmiUGs5DtemtbHQQvWJu6xfDDwwRBWSNUSok8dH27
         nEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710445098; x=1711049898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QM0EpX+2nRF6kqssGaNMOIy7olhnPJ21fD9kE6DtD/0=;
        b=H4Z4EmBByokUwVMjcr0JjtCK+eZTit6WxArR2ic2BQAPwYTBYda2cn39WBvckBxFlh
         uQaOTc10o5RxY+ej2HDTMFoMZNmpI/gJ/muCxXbFdV56i5gLLRNmcrTww4/ywgYmZ6cX
         qInQGL+1z/vJ68rClktfzmEikk7z2V4pfFbF8VLDOM0dC4uJzByk+fVJvQmR4qKCxToN
         DEhj22HYfBkwgUdZPxbCAkV0TUCOmNwJzolKbhSLAjIREJoIsj4zkqRHsV2a49o7q9yJ
         M3ncrOy73ikJ404P9B5vUSt1xB7ZFsiPfQQVI1XhiX6as1Q3FV56DMwuArEYXrhkIaKp
         GWbg==
X-Forwarded-Encrypted: i=1; AJvYcCUI3mgMSWCpdyaJwvT8ZtIjKqWnDish1MdOJzoS8R9vvyFJDA43R6XReajoRbvazsklYtvuXavCTfkUkSAqIINEnT87zAZ7YzTlRRUqjaFSi6xUpWj6cz2/da2Q+oLaaVcV/DwE
X-Gm-Message-State: AOJu0YxarzeA89nru1U6kEsaVKBskRpwZ7jYYNvoOkmvTCDVJefjvFZP
	dF1dKkFxKYlBD8Ao142UZC0q1sxusr2VW7DtAB+jGM52X3CewvGJ
X-Google-Smtp-Source: AGHT+IFd0HbfX2lksd26KvQNXcItlwpCahQ4dfZn5vRuJfEpk8cclOMq694BPylw2ZuXl+Px+HlNhQ==
X-Received: by 2002:a05:620a:817:b0:788:2e47:b297 with SMTP id s23-20020a05620a081700b007882e47b297mr2964412qks.78.1710445098425;
        Thu, 14 Mar 2024 12:38:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id vq23-20020a05620a559700b00789d0189eb6sm1160085qkn.117.2024.03.14.12.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 12:38:17 -0700 (PDT)
Message-ID: <ec2707ea-0586-4218-8813-7a43885616e2@gmail.com>
Date: Thu, 14 Mar 2024 12:38:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/51] 5.4.272-rc1 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de
References: <20240313170212.616443-1-sashal@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 10:01, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.4.272 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 05:02:10 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.4.y&id2=v5.4.271
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


