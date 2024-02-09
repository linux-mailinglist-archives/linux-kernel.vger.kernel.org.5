Return-Path: <linux-kernel+bounces-59042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EFE84F045
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094651C21CAA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477B4657AA;
	Fri,  9 Feb 2024 06:38:55 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E248651AE;
	Fri,  9 Feb 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707460734; cv=none; b=S/iDshhsszqaVH7JG12HAoA9pqYNOb0VU/ejRy5VlNJcbgA1HlkiEPImHkoJPjVc1RZ+XcJZdv9zf1qC9r54vdIKiX1/iMsZpIIwCQWDi7GDCZPg0RbPnmOIwu65NMm8xpkHNpA7fjdrrIsBpiyrDf9nZ6AAxWyzPb5s/LK8Mxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707460734; c=relaxed/simple;
	bh=Yo2XvlkHE+onMuqhDZZAzlPBwMEJDxRnvPE5rwHB7fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKngUWGhU230CX/ioeTaM0br5u0368zSykD9VVlMOyjsYnG9zeyGYp/Cs8wsmSoauzMa4NC6zbgXcNfT3HP5P7JkH2BIgbxPky1AMlv2OgouCaJ9j0qYRx5xsTtgXYR0aFmOjNYhu/xH5MG3DwwA2u/Fym1Wp67IC/IRQM+PkOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-511234430a4so1130428e87.3;
        Thu, 08 Feb 2024 22:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707460731; x=1708065531;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtnVDf5IDtyw/KlLL2GLn1KnxThuWHL4m6/SjcU6D18=;
        b=eyVb+sOOCuZaSwmb/eukLQePZJmpokkVNY/wHUD4AY6j3hLcp+1ziSSUMAW44oxov6
         uowkKnOlTUwpG4ux5bexLvJiay7bEeT5OQLZtuAAHjiGGbq6TSPoDhMdScobQ4DwufqC
         BEhVOJUCPGd60b8U33nzQk3V59GPm3nL2pKmf6ZaybmJz+E7WrSKtrMyQbi+u0hyjEGF
         nO3Azu7u2bMUNywyPl+vgJUJL9MwL8D7mJimP+xoDCVDc+bN4Tly6C2Nklv12fZz0uTR
         XukINq5DH5q1MgaLuDdgVZBc47LXFjXfj3GS0rYjI5Bp8LyJgpBbHPvHNNCSL6jGgRaa
         CHOw==
X-Forwarded-Encrypted: i=1; AJvYcCVQpwwqbv2kNDNUGzlNpaDEvAq3LlNqkyewzIF/RZfytSS8seOh8f2ItiXSTAcPGgF87OBxg4yUW5NWBTU8zutMVPVhkh4nCIwaLwtu4O0CBCxNQcxdMQ1R8Npz2aoO8X692KO5AEm1oryL
X-Gm-Message-State: AOJu0YwMCxhmQVBzBu7NExmiE3YOmZX3YZcPxI11bHE4mU4Phuq+9B/R
	uT5BAFR4OdKHRpDZqJnFGzR/DaJhQMC1RFS3MUeMwVTh+9mvpyI+
X-Google-Smtp-Source: AGHT+IGbVC19cYAy/9L0jrbhJhS6UU0hd96vrFrQjeIip/nS9EPYd3i2LdDnxl78oL0XM1FfqWsRiA==
X-Received: by 2002:a19:8c13:0:b0:511:5314:1762 with SMTP id o19-20020a198c13000000b0051153141762mr318917lfd.44.1707460730848;
        Thu, 08 Feb 2024 22:38:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9wZsjnK6opyhd9b0Z0968sFYKeAxSPe976YWlV7PM3WbYf+37umq1KTrYk77Bwa13SlzMySwEHA92RQ71CwSa5g0yq9hKgWAgEGxtFxiYtopZ049lm1SV+y8CXDrNL8FvwrJ37ut92VPbjlUYh3kSul257c7bD2cIiW6rt2JMPGCkHRTidx2isLe3yU8J3orWvtg8dtBD7xuJozljUwK3ke1mesgOP+8iBz/GtKCbxMiR1rrixkueVc61Pzc7a4XSb2DItsl2OQ2LKmGSU0rEMA==
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id d19-20020a1709063ed300b00a3bb5bc4705sm449916ejj.92.2024.02.08.22.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 22:38:50 -0800 (PST)
Message-ID: <0c1e8d38-4b00-4738-bd05-7e36ce736681@kernel.org>
Date: Fri, 9 Feb 2024 07:38:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Add Burst mode
 transmission support in uart driver for reading from FIFO
Content-Language: en-US
To: Rengarajan.S@microchip.com, linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org, Kumaravel.Thiagarajan@microchip.com,
 linux-kernel@vger.kernel.org, Tharunkumar.Pasumarthi@microchip.com
Cc: UNGLinuxDriver@microchip.com
References: <20240125100006.153342-1-rengarajan.s@microchip.com>
 <b8325c3f-bf5b-4c55-8dce-ef395edce251@kernel.org>
 <e7f29dd64829b597f3881abcf4da653156c1fe59.camel@microchip.com>
 <fa17f083805e46079bfb4ed89b83d372cfe7e77c.camel@microchip.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <fa17f083805e46079bfb4ed89b83d372cfe7e77c.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09. 02. 24, 5:52, Rengarajan.S@microchip.com wrote:
> Hi Jiri Slaby,
> 
> The patch has been accepted and added in the tty-git tree and will be
> merged during the next merged window. Should the changes be given as a
> seperate incremental patch or should we re-submit this patch again.

Hi,

as you write, you cannot change the patch as it is already queued. 
PLease submit changes on top.

thanks,
-- 
js
suse labs


