Return-Path: <linux-kernel+bounces-13599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1519C8208A3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 23:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4AC21F22451
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 22:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92486DDC6;
	Sat, 30 Dec 2023 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGNnpcV6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C3D26D;
	Sat, 30 Dec 2023 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7810827e54eso741364185a.2;
        Sat, 30 Dec 2023 14:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703975043; x=1704579843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Ytqw2FHmhrz2Q/Vvd/gZICZv8ex4sbCt21vyO6FDogw=;
        b=iGNnpcV6PGi/HH0advNart2vEnLIH16GLqd/o5TY6K+mDQ3fNqkLG2Byzm9HHy67/h
         SAeBF2JTjogEyf/y0uEWeqx6UNM1xqiEsbl+HE6AB5vCQlUmv9e2ndR1dEaDEM2RAINy
         4RzTPIKA0ITCTpmLpE1kHUQSjjf/aLxsABOOgeuk0Ubdc/HhJzmpsnBDKdcxRh/5490D
         gRsZs2/eQPBrp/KaEsu1ZyC5UKDTiO9EPzJDEWYNFlxr7XxbGeTSvx5Jq6O1MRSnQnI4
         terliPgxCZIQj/tw5AYg/gGxyu6YGq6BFwg3gsTavyAHr7V278IZXZD11MjNLwTaZR8G
         5TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703975043; x=1704579843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ytqw2FHmhrz2Q/Vvd/gZICZv8ex4sbCt21vyO6FDogw=;
        b=KiHXPlOK0cjFFXOxv7uR3w0SiglZpZ64N4eAR9gYdMNmohOgA2Y5AD2W+p1RwW5UdT
         XmooAtIGuDr1wgkweswfinHC+AzJyGr7RWPvO680UweCtSWFMH1HCHrTmaDlmD5io2Hb
         aZiZ102NA9VieFKeGQQ29AutC3gswR4Sq/MqyxQg5DNfERRyWs+Q+n/FWZI6XXlJ/Z05
         eoeIvJ47SZKOsbTaNsVeRrTu9qZpFQTAjD8pv/leMOaoxmjS+TRUPy7yVx5LkV6KUYt6
         1k+Fe7qmLBajth/Yj/w69KqRnY0bPX+98losrWtDqafOSXQlFSICFjZXaUx0hju7QqLx
         vj2Q==
X-Gm-Message-State: AOJu0YxhTocbdyWR3GT92+1XzDhW74pp78ccVvz4hVgHhrGaHZiBdZAd
	p8E/VSpcJwJuPtQv1+WbRzw=
X-Google-Smtp-Source: AGHT+IGTWXvfDNFHuJs/2JwYmQDseU7HorFDI4IceT3cAbf4f88WDlSNXxN5ZhWt0jW2njXpvMCx1Q==
X-Received: by 2002:a05:620a:1aa9:b0:781:5c68:a5ee with SMTP id bl41-20020a05620a1aa900b007815c68a5eemr9616536qkb.45.1703975042959;
        Sat, 30 Dec 2023 14:24:02 -0800 (PST)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id u11-20020a9d4d8b000000b006d9fb0458cdsm3232223otk.39.2023.12.30.14.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 14:24:02 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <ca357d13-7da9-490f-9e69-4674c6ede057@lwfinger.net>
Date: Sat, 30 Dec 2023 16:23:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless 3/5] wifi: b43: Stop/wake correct queue in PIO Tx
 path when QoS is disabled
Content-Language: en-US
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231230045105.91351-1-sergeantsagara@protonmail.com>
 <20231230045105.91351-4-sergeantsagara@protonmail.com>
 <cb9dcb49-ad94-40df-9f01-a28df3daf6c3@lwfinger.net>
 <877ckvwk5v.fsf@protonmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <877ckvwk5v.fsf@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/30/23 13:43, Rahul Rameshbabu wrote:
> Unfortunately, new firmware would not prevent the need to fix up the
> code with regards to QoS being disabled via the kernel parameter or
> using OpenFW. That said, new firmware could help us drop the fifth patch
> in this series. I am thinking about using b43-fwcutter to extract
> proprietary fw from a newer release of broadcom-wl to see if that makes
> a difference. That said, I am a bit puzzled since the device I am
> testing on released in early 2011, and I used firmware released in late
> 2012.

Unfortunately, it is very difficult to get the parameters for fwcutter from an 
x86 binary. Some of the other architectures are easier.

Larry


