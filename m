Return-Path: <linux-kernel+bounces-120025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 521FF88D06E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E7C1F3F4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5013D8B8;
	Tue, 26 Mar 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRywwh/x"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8E13D89D;
	Tue, 26 Mar 2024 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490836; cv=none; b=Ga+QqXz7QuijLSnOcn+bLxu5z9h+9dxlQVJnVshrySgnkn0+EIrtkVS4IaMYpI9H5NXJxNyQh49+hNzM2dQaSJdAhEs/AaX7msH+akw78Jhdzj1SNDiKudWl6XSmpXbn5t9g6pmtz9118u0anDW4o4tnCeuFzs2tUSe8Tk19P5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490836; c=relaxed/simple;
	bh=YGvbIleA0LOhGaqG06ruV12u0OVqKMc60UnttBqAfqg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=p258kqfvaEZH0k0W/Iy5gCtZJBiVbn13pFJPCJuVlUWwvOHVDmfMvkllzlKTT42/jGL/3tQnz/wT1s9pX4o+DGfkX77KfZ/t6QskhimBVrWkjs5XYbSPl6apO+rpnOrX/hpA8idfW8sTAZOeDLcSYQWXJubuU9dZCe/98CYZCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRywwh/x; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0f0398553so11208775ad.3;
        Tue, 26 Mar 2024 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711490833; x=1712095633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3fmf1adB2/rvktIlF/K8tyaOGpYk92mIufdpsSn9O0=;
        b=lRywwh/xVdg6MpwRy3RMmM2+/9mkmeekVvLkMFeXRibZqwCMtixxmJbMhjMJSGtMyr
         dwhj/d0nCaa5hcJcANr0TCwlF9ZpiGafyzwJKIUg+NEs6nqwC5IYjkZ1g3SG6dg35qHk
         x7909eirYPGvqN6Z+0vt+RHzEKsCY6gxPX3feVh0F+KAeSYgpJy7SCColcJLfnXGuKir
         7xnLI+SDkpBYVzT1nlzrv6l2CGbfEs8bjsp8voentUCHYQHKzT6RRYpRfDNSMjrVzjCp
         5jMsvHb4QV0rAUPIy1MttkJQQhGZsZXBi/ggXrVMK7JGYQzmBEDx2aaC74NVB+ZJAyrj
         UMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711490833; x=1712095633;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3fmf1adB2/rvktIlF/K8tyaOGpYk92mIufdpsSn9O0=;
        b=wfpDAPGRtUzzOkUqgJm9Bo+C8lAB9834IEg7FE6Dw5Ag77rpzOb00CrDj3yI9nCJbn
         aSJbX+xMr4jkcjIfuEVhAsdBUqoBoWJt7aHK2sbROAmCbiuhsiZsQTBkshtRmw8VlVwP
         w779HA3dURkzaP5hu9T3z2223X92sfCKZemPdNh/wbrezQA2dh4zrOA1cESUXQNYd/hR
         AAwYYjBYpFwgUeWViLBk4UG7EUNDS9GhNEpQn/6RYsh1wuHK0RmSd8W/k5AeNArUyF3A
         FID+BdbinhRCcYdjRWwC09/+EAkpevXpN3xgX/sPmLMNJpjMZ6x1+cGbNbhFlTO899iK
         Wf6A==
X-Forwarded-Encrypted: i=1; AJvYcCUyhiLY9q148/fzpjJsuGEcCjDfmxFuFhRqERgGNHf5XSlsqtutqeUlcw4sMWjkFqqAv7DQqMNRtlfK448jwYbHrbY/jCtDzbWYW2BBB5/33/gBausKHNrEQEwQ/ZsDwjjSISQupJbcQc+q3rjuypu2BMzSr/5EAwKyD21V8fD8sg==
X-Gm-Message-State: AOJu0Yx2Nlfb60uoEfuseJRrkNJ0L4PeLS2/q/SlaYktDLcAzKEJIPuI
	EB0HFTxMXj+n9OHs5sL/tcgLp7km1sdT244HofzkvWp+m54q2e07bJ9sBgPJQpE=
X-Google-Smtp-Source: AGHT+IFxaXNxU+DnOrLBeSwZcxi9osHaZNBS5Ck+rrtSNCA3ap4piacyMK02b6gEPK269uVMRKmOLw==
X-Received: by 2002:a17:903:120c:b0:1e0:fb8c:f45f with SMTP id l12-20020a170903120c00b001e0fb8cf45fmr2491401plh.2.1711490833528;
        Tue, 26 Mar 2024 15:07:13 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001dddcfca329sm7436304plo.148.2024.03.26.15.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:07:12 -0700 (PDT)
Subject: Re: [PATCH v2] riscv: dts: starfive: Remove PMIC interrupt info for
 Visionfive 2 board
To: Conor Dooley <conor@kernel.org>, ganboing@gmail.com, kernel@esmil.dk,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Shengyu Qu <wiagn233@outlook.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
References: <TY3P286MB26116B828A34D614C09F4E8898202@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20240326-create-motivate-2792be1692c5@spud>
From: Bo Gan <ganboing@gmail.com>
Message-ID: <f472affe-d1ef-cbdb-b5c5-76f6b3ac78b3@gmail.com>
Date: Tue, 26 Mar 2024 15:06:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240326-create-motivate-2792be1692c5@spud>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 3/26/24 1:37 PM, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> On Thu, 07 Mar 2024 20:21:12 +0800, Shengyu Qu wrote:
>> Interrupt line number of the AXP15060 PMIC is not a necessary part of
>> its device tree. And this would cause kernel to try to enable interrupt
>> line 0, which is not expected. So delete this part from device tree.
>>
>>
> 
> Applied to riscv-dt-fixes, thanks! And I didn't forget, so I re-wrote
> the commit message to add some more information as promised.
> 
> [1/1] riscv: dts: starfive: Remove PMIC interrupt info for Visionfive 2 board
>        https://git.kernel.org/conor/c/0b163f43920d
> 
> Thanks,
> Conor.
> 
Hi Conor,

Thank you very much for taking care of this. Actually the PLIC may silently
ignore the enablement of interrupt 0, so the upstream openSBI won't notice
anything. My modified version, however, will deliberately trigger a fault
for all writes to the reserved fields of PLIC, thus catching this issue.

Hope it can clarify things a bit more.

Bo

