Return-Path: <linux-kernel+bounces-73850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C085CC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427C81C219C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43291388;
	Wed, 21 Feb 2024 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npbY8xox"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B9193;
	Wed, 21 Feb 2024 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708474065; cv=none; b=Nf5n5Yq1BZ+wLJPwI2gkDJV6STVSZZEHUDwgEcKLy5RGRiKnRJlcOSg0UKmXZHg0yBwAfQkW3kQ0PjxdrhUOLtd8aHMy9B8IW5/mtpyeNa47cUd/dxaDRgXEXdaFfcF4aoIQ7XpoRFEzJluow7n87vBgxi3VxhcG7PDP0pRPGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708474065; c=relaxed/simple;
	bh=iXE6+R8ASa+RDcoAvHrDmlfm6SXejlgM5QbL0gV5rQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3YOGkXQmIwG4I7699FjzD35BqwheZXdbXf/3GcR2CwJs8RyyAxTtvqEkEMMm3yw6qy2dnbsFroh4a5INn3an4S0jXLqUwrBoNcXnvSBU2c9rCNq+5WWlcspwaJASy6Td4LNHjCslosf/ZsWLsmIcLQFQSbnmCyCLjxg50fvv7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npbY8xox; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33aeb088324so3242129f8f.2;
        Tue, 20 Feb 2024 16:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708474062; x=1709078862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJEzqI5ur+SbBoa1SbqduYIKj5d2G64DD1tgTxLxA/Q=;
        b=npbY8xoxWtqTDtAABQUSRPS0EhhYEh3mqgztGAVP5USFQQIOI7nU5Gl9sgRV5X82q5
         +fWhZa09cL/QAFWA6sf4UoDhvldkwcD9G4mjYsuyaVG45vm88xjKaoCQwUXMKvdvuh6p
         dpj8gtB8kCniok0KtddADcLKtBN4PlRVIG4GtPh1dvHcP1YgCpVVzXexLaCEfmTaYQ5q
         wpppvF3QUbp0zPz/tGYgDxoU0eLT12f/YtFhE6w2s+tahdZU+9weM3rW6oOYsx2kIT9J
         L/IprYVbTj7eo1nhrO4DhrgwcvTT6VdNSm4zjVrDwQZtyO1IybQMLMsT4oM8sJhF7f09
         SaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708474062; x=1709078862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJEzqI5ur+SbBoa1SbqduYIKj5d2G64DD1tgTxLxA/Q=;
        b=HgHfOFShwaM4VXzzUjS0tdtc+8P+MlCUMmUCG28tm6JH+sD7X+a15uv5vgMM9jVcw0
         XelwliwWiB+L62gCFX0+HgxZE3MPnoyJBuDxcV/klX/tR8q4aijpPYXVtFdeakxgl39n
         loGYAK/qVfYqsJxfEFMRjrE//qlNbTzRtwWs+dbmNQ3dy1i5mTdoqsFYBMzSQ+9waaaE
         LApvrSW5qjepIR9hAiWPML1uuwbHjNRfv5eYNd1umZUw5twSndwkXU2+cTE7dx3TUIGA
         2pKeaMNAPQKqo4BBNf4hm7rWl7YxICXrgRiEK+qAgKkFGQmhyXr0MTOwEjws6tyA4T4K
         PrIg==
X-Forwarded-Encrypted: i=1; AJvYcCUnq92fNEl4x/SPN8NBcKDjqq1X0WCWwyWv2pLPBewH7maMbzif6Pnx846s9BGne2s17+6m+U0iY/8iDQV/ajOHmYtMRjPODER7RW5YWGaDm1BllZz8w5h50srSLApwxFC8KzjeLIhFRPGVquhOH0bl/iI6KZ/T8epqHQdMui226xQ9
X-Gm-Message-State: AOJu0YzOptBseaHK2d3KxlgWIyyJ4dm0g6jmGF6wXxxWV5F8SJedSSXm
	OfRn9CEB+JwGlG3uC/ZCgUqKJwEvFalQZtXOPzEZ8i19om7DmJwZ
X-Google-Smtp-Source: AGHT+IEjN/4x8lMxmDXugNXlFWRbk0nwkpz+fRchEALt1xd2cYaKzfO49MmZPW8WXFfsgYFsCm3SEA==
X-Received: by 2002:adf:f6c8:0:b0:33d:714b:f3bb with SMTP id y8-20020adff6c8000000b0033d714bf3bbmr1560887wrp.26.1708474061669;
        Tue, 20 Feb 2024 16:07:41 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id bs17-20020a056000071100b0033d47c6073esm9134362wrb.12.2024.02.20.16.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 16:07:41 -0800 (PST)
Message-ID: <07fb65c9-109d-4dfb-ae60-c4a1ce99876f@gmail.com>
Date: Wed, 21 Feb 2024 02:07:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] net: wwan: core: constify the struct device_type
 usage
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Oliver Neukum <oneukum@suse.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-ppp@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-11-1eb31fb689f7@marliere.net>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20240217-device_cleanup-net-v1-11-1eb31fb689f7@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.02.2024 22:13, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the wwan_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

