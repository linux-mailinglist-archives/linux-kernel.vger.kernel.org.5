Return-Path: <linux-kernel+bounces-71950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC7E85ACF2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C421F21BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C669353370;
	Mon, 19 Feb 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zom3KWKI"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFEC50267;
	Mon, 19 Feb 2024 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373861; cv=none; b=Jv5fynjr9haIjym6/cHiKs/xZ2y5BzEu7/KXw112dSG0aCgNsOnhTEqnFAIA6kbNfmz+zZ0Msjg28uklgu76xYYhfMgOcqZH/+ZAEuMAy0RfngoZrsyRW+GpefRIlxg8BMDMopktfIsPxyjys3M21HHve4GbwcZDJ+6boLO8SS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373861; c=relaxed/simple;
	bh=esYPBp22VpAbZlps6iyxKog0fWFcsxgtwTYURk6yaAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfEbETO1R8DYbEK9PbRn6Xgv+ubyNHmwpYoa7HXgEYkGTHZyQ7VsDRJ+cyLtWUNvqXLwT91d8Twj4dJcm80XsyEb+5lETs4Fq5J38MvN8+dNsl2h9vRjSk/m2d8Jdgk781y+NPLQu63pnQEa9VXIdehC1TUyKSUWbA5RnmJuHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zom3KWKI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d91397bd22so39821975ad.0;
        Mon, 19 Feb 2024 12:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708373859; x=1708978659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rONE3Abn4dO/b9f7QenLonwDofv6vCpXy42uqDKlHxo=;
        b=Zom3KWKInXXYV1GV3/LHxaqkSxa+iYdqkMB0nyX4mOLIVP0yddluc+LZ+b9zJaNEX6
         Plu8YlPC9rw9PNea6cOv0eCkMBp37xRl/Rnxln1Wj2uGmtG21mcKUD63v81NCovKI/PT
         +PYCYJS2KtMBYayWfBCIKomR1tAgAyU6PAYcYbT8QU8r3d8V0yLmzKbg+YvSc5DlqXPs
         ah34pwUKq6DWT0D2Lg3eqpDI3d+3/8tbCvFzzkqPZYdwMdD9VJ9vE/GPBVb+m479PWVk
         pn9BswvvUyoCpK8mZdrQyRV1zBXMYTYI40DHg8qsdkpz7W4JiuSVpTrsydkw1cuRpgRW
         XPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708373859; x=1708978659;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rONE3Abn4dO/b9f7QenLonwDofv6vCpXy42uqDKlHxo=;
        b=foS++7/LppHr4JrudwAGnRnP2mAa+PLfPqGiOvgxukvoKCowh+bjx9nM6qL3uj+c+7
         y31/0cFauO+Crv9gph/xA2yYrLFgsUZd613TwN+JGOcv0/aiPkC7+1wzFSrjZD4ndq7J
         fhQbX+eAsqp3t3dCl7QWCpQcT57HyUUXBkecIKue67ZEgkcEpRM+YxCwDuzA/PJRdqw/
         LuT7CTFmrS/+LMLU+hog2DFBcWiOtpLUA5aXL6tQoJY23Vsrx3O3oyctSZclXiRI83MR
         S6zz8/+WTPX2qnk34p+qdPAoaNaDQrpGR1jEuycPbmkp3i4iP2HVS/0XaUZtcxRc4KHk
         zIXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTF2ICAqERRbkusCAiCiu5v1QBe+/89l6M7VqBEgL6/tRYfTShcLwDwXoYxx1t989mNbtoCnNN+eyq2sBecC6rTWXnbL+plwUCmqNxk6iZAcgYanS665saNcaSb4Y86ONBLto9
X-Gm-Message-State: AOJu0Ywil1wA2wrVepm1TK3MCFrK4S1V0awt04GMB29ccuVGc/QO52a8
	dVuyxblKqFMaRbRx2JHSeGFmZrbc3Io1+qcgGITIV/rigeyQ0RR4
X-Google-Smtp-Source: AGHT+IEf41VN0cQCRsLyrwiGaNtQCiBDuirdu+fKuIUuNKMJOBH3FCxl/tzPUzaptxBRzL9nvHiI2Q==
X-Received: by 2002:a17:903:491:b0:1db:9759:f716 with SMTP id jj17-20020a170903049100b001db9759f716mr10190731plb.55.1708373858716;
        Mon, 19 Feb 2024 12:17:38 -0800 (PST)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902d28b00b001db616fa11dsm4837055plc.238.2024.02.19.12.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 12:17:38 -0800 (PST)
Message-ID: <7961378c-9d4f-419b-bf86-4f5e55b3839a@gmail.com>
Date: Mon, 19 Feb 2024 12:17:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: mmc_core: Assign, don't add interrupt
 registers
Content-Language: en-US
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@axis.com
References: <20240216-stmmac_stats-v1-1-7065fa4613f8@axis.com>
 <61bdd802-abe4-4544-8e48-9493a6bb99c8@gmail.com>
 <20240219104025.GM22484@axis.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240219104025.GM22484@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/19/2024 2:40 AM, Jesper Nilsson wrote:
> On Fri, Feb 16, 2024 at 09:13:51AM -0800, Florian Fainelli wrote:
>> So in premise I agree with the patch, that incrementing those is not the
>> right way to go about them. However these registers are currently provided
>> as part of the statistics set, but they should instead be accessed via the
>> register dumping method.
> 
> You mean extending the dump register code to dump the MAC Management Counter
> registers that are not counters?

Yes that is what I meant.

>  From what I understand it's only the Rx and Tx interrupt and interrupt mask
> registers that aren't counters. Oh, and the MMC control register itself?
> 
> To be honest, I don't think their use can justify the code churn.

Fair enough, it really depends whether they are actually useful in 
troubleshooting or not.

> 
>> In either case you will get at best a snapshot of those two registers at any
>> given time and I suppose this can help diagnose a stuck RX condition, but
>> not much more than that.
> 
> Yeah, their use is very doubtful. For me, they only introduce more nonsense
> data in my logs.
> 
> The Rx registers looks to have been added in the first version of the MMC
> back in 2011, but the Tx registers never was.
> In commit 1c901a46d57 Giuseppe mentions the MMC interrupts as something to
> add later (if actually useful).
> 
> So Serge's suggestion to drop the entries completely is actually quite attractive.

No concerns from me to drop them, not much value in having inaccurate 
information.
-- 
Florian

