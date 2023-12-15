Return-Path: <linux-kernel+bounces-1726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E332F815338
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EBC1C23E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F41C18EDE;
	Fri, 15 Dec 2023 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7+8u+Pp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480318EB0;
	Fri, 15 Dec 2023 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7b6f19f3af9so43279339f.3;
        Fri, 15 Dec 2023 13:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702677598; x=1703282398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+o2vPOmzTka+nWw8pzxJ+sUTAkkv28Vapnb4OBgttM=;
        b=O7+8u+PpmYb+ZPc2dbukLFk4/jRAsJt9lo7e70tPfr0o2nrNX0yQdDZG0n0tEtz7aJ
         C9GXvavmFooDagjB8fVw/n/OU8Gm+yVYsD+TPGU8wxrBRNkjZS58x7ZiUEFtDwQpODNF
         1mXWkQHTDKwQpEGlhc7jIlkSRCcApiE1aKPjMPXOA7WWubVJC4GP12oG+TkU0i0prkQ+
         LHrZ/wjffMWlTguAN5MQd4V0SPOdXahn6KShCZuTJI9ZQADCzoIwxE2+29sTlNuHWEo8
         84dJqHzXxfFLbwN+zBoeY5r5dPHv4GrSmomvValuEFrGF9IUz9gqA2TGriTSZ+3JP873
         QAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702677598; x=1703282398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+o2vPOmzTka+nWw8pzxJ+sUTAkkv28Vapnb4OBgttM=;
        b=VbQ9n1m+HLGr2HUKL5KdKvtSJYmwFVr+MOKR0A+p9HcloxT3RI+a7lunn9Vh3mljlH
         92E+Z2M2ZUuOqJByKhUxjIvAj493a5677tci9Qq6liWt35m4Mu8xmwZSc2E7RWVRRFWb
         /nXULtwje9iy1AZu4NqlvSExkQ/MqWdrchyraSr2XFy7TGJ3NKWqNt7B6SjStLSEHFR5
         /l468OP4foMZ2S4yRGtLZyONqlY2L25+p8iXkQKl8JVczfip8OsBSmzA8ojRpA2rt9dZ
         eyqSuhRShvqSpEMd2Vux7JU63QWbuEEskps1ipuaDNuprt0BB0m+oKOkBeKGx4cb/ok2
         oGOQ==
X-Gm-Message-State: AOJu0Yy0/VIPlOkT4mfjTbat89hGQlfisMRj56QJ7Naa32ydBsnzFkwO
	RQbEt5I/8N5Ue14bJ4SEtDk=
X-Google-Smtp-Source: AGHT+IEGxSpDElEMH0e5PuL0HjabpcYJbt6Y50sh3KqKaAsRBXy1hjNsTMC39RZ56Qum0h0lkVGFgw==
X-Received: by 2002:a5d:8853:0:b0:7b4:5583:30b8 with SMTP id t19-20020a5d8853000000b007b4558330b8mr15069113ios.23.1702677598304;
        Fri, 15 Dec 2023 13:59:58 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:7c7f:3273:a81a:4618? ([2001:470:42c4:101:7c7f:3273:a81a:4618])
        by smtp.gmail.com with ESMTPSA id ge25-20020a056638681900b00468f0b59f31sm4151200jab.31.2023.12.15.13.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 13:59:57 -0800 (PST)
Message-ID: <edf15619-8f31-2a30-d92e-997bc1464c58@gmail.com>
Date: Fri, 15 Dec 2023 14:59:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] Allow disabling USB3 ports in xHCI/DWC3
Content-Language: en-US
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231208210458.912776-1-CFSworks@gmail.com>
 <7fdd62c6-f492-1f7e-9eca-9f965cdd73ef@linux.intel.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <7fdd62c6-f492-1f7e-9eca-9f965cdd73ef@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mathias,

On 12/14/23 04:05, Mathias Nyman wrote:
> I don't think this will work as a generic xhci driver feature.
> 
> Even if we ignore all USB3 ports in software they will for most xHC 
> hosts be powered
> and enabled in hardware by default after controller reset.
> 
> This means they perform link training, generate all kinds of events with 
> interrupts
> (connect, over-current etc) that driver now can't handle.

By this do you mean that having the xHCI driver ignore the USB3 ports 
isn't enough to ensure that PP=0 (and the driver would need to do a 
little bit more to make sure that the "parking brake" is on: e.g. 
initialize, but not use, the ports) or that the xHC's PP=0 signal isn't 
sufficient to keep the PHYs from trying to bring the link up and 
generating those interrupts (PP=0 really isn't enough, and there is no 
general "parking brake" to be found here)?

> Sound like the setup you are using has a very specific issue, and it 
> would need
> a narrow targeted quirk to solve it.

I infer from this that you're against having a DT property added to 
xHCI? What if the property were to be narrowed in scope to "ignore the 
USB3 PHYs, they're disabled/absent" vs. this iteration's "disable the 
USB3 ports" meaning?

If this quirk ends up landing in the dwc3 driver (since, arguably, DWC3 
is the real misbehaving hw block in these circumstances), what would be 
your preferred mechanism of signaling to the xHCI layer "the USB3 PHYs 
have been disabled; please ignore"?

> 
>>
>> There are other ways to disable the USB3 ports on RK3588, such as via 
>> some
>> syscon registers. I figured I would start with the most general solution
>> (benefitting other SoCs) first, getting more specific only if 
>> necessary. :)
> 
> To me a specific solution to a specific problem like this sounds better.

I am starting to think so as well. I may shift my focus to DWC3 (with 
xHCI driver changes made only to facilitate them) for now, since 
`maximum-speed = "high-speed";` very reasonably (imo) should prevent 
registering the usb3 rhub -- though something may convince me otherwise 
in the near future. :)

> Thanks
> Mathias

Thanks to you as well, this is exactly the type of feedback I was 
fishing for!

Cheers,
Sam

