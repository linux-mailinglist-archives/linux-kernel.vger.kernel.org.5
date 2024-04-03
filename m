Return-Path: <linux-kernel+bounces-129768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E06B896FB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40FF41C26264
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F01B1474DF;
	Wed,  3 Apr 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7pIZred"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015413775D;
	Wed,  3 Apr 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149258; cv=none; b=J0JgCOam7Vhjy720itFT0H5gdfvgXf3etOwPToPgnzIRUF9u6VOXZ+1Jh885Dcr2SmOM881egqLpYZ4UHqu6bIeIRn3skB0pwIFl7UxkRSkzjjM1fzUH4xacyGj//sn6qJ6W1sPJ8FFK7jUZAASFVHsEMRFhxxvVgcyGNGeQG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149258; c=relaxed/simple;
	bh=16LVT++7hCxJT/DtJ4w5xBA8tUHSe3fqP2Lif0mfet8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALBSsghBon76IZFcmM5tiAi3P7fBcfzp5kBsDOZK4DPYm54b/MEtkP+r4w8OYI7bX6sGXFpH5b0uAvKDhLvm4VbHE47KhKRyBlMvGzb5j6nyVY2JTHgok8CBMo6PYKlq9iSBktLaOA3IsSC/5auZG4nF+5Yt7sT5BVFnB+wYQNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7pIZred; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a7c3dd2556so1473568eaf.1;
        Wed, 03 Apr 2024 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712149256; x=1712754056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dIgQrEY6TPgQ+hIvMFxPD/CgS9U4iTKbFmnudRwHnGY=;
        b=I7pIZredKrE9qjg9hh1xYz+j2pM1r4t6GIO45KZx9OhEOCcJgqgeCbQVSX1h8ZRyLk
         GX64A6VQR2Kh+5RlqgPnDjs0l6P/5ROIEoLTbfIcvfp+72pYAo/Z4/hOOL+YJN9Dab6L
         Q/4Q7uoO/V5HalGfh6yA21OYdM6r3M5QPY2vv1ZldgJyVBl6dE5kMre+iFbsH75ZLO1t
         CFvcUZlnKgMJPkQVMo7+x+ynsjBLVMMUbg8OKSiee1nKrg3YXQr8yiZPosfD3qP9HXWi
         zBpCMV6qcF+ND1x3YikOycdlx/KASFHaLKNNOTH8IU66MQztfXD4TebeF7D7LeX//8Ko
         J17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712149256; x=1712754056;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIgQrEY6TPgQ+hIvMFxPD/CgS9U4iTKbFmnudRwHnGY=;
        b=IVRvk0Yfw9+O+fCKC3Hv9s8hH41ULV8oXwj7SDD6NtFlYpEIfsNZN6a7zaewTzN47q
         xACncM4zIh0x/74Iq2grPBtaIU405fHb4gHLkbFTl3r2M6xkFkCu/78bqJmKttILRhOB
         mBy+vXBnTy2wCud0FWqfmuMF0qxBVx/rqXZgjwI02Nle+pIceBymsKFd9fIZBRbDUsFv
         D2p545XQo/dTq6G4DrM7qT1HFnaHb0Wg40is/y6DDyyHUaPV3DX/vuOv8Hb8f69aCUnF
         ngIQwK53wpyh5AfGZMF+d9Hr2Gp1FTDWDplcc0CLbwQwaVLZcnVHL/DKf4T3O/uNO7gh
         VwLg==
X-Forwarded-Encrypted: i=1; AJvYcCVCktT38nZAC0jb4+3io0MYxg7g4Pg1Nq/T+GHEqsjA1/dUcEvc+/fotzC3fzmMp1RXWFA0n5OPDfPd9YovgKKN1bPEwFp8Ek/i5+u9z/vUcdIFXmnHVIv2sHzUoIRwgORCOgKW
X-Gm-Message-State: AOJu0YzT5S5iyWkKOdmsXmN/KVKh7HoKMI0SEfqew0GDSq9bv343QwAp
	zWGpZ8YsEbIZMZTdOpPV5vC+FWnrvWxO27STOb5Hbn/PZ6qhzFCW
X-Google-Smtp-Source: AGHT+IFCpFlfL0sLQFo+2RApChaKoRenFCVrrKMBBDh6xDFwEikyct1C5roISUQa0F2CnAl2sdFHHg==
X-Received: by 2002:a05:6358:6583:b0:183:9ea4:74a8 with SMTP id x3-20020a056358658300b001839ea474a8mr2816424rwh.15.1712149255765;
        Wed, 03 Apr 2024 06:00:55 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id e8-20020a0562140d8800b0069918064e9esm1590264qve.41.2024.04.03.06.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:00:54 -0700 (PDT)
Message-ID: <a732f5ca-4e88-4bdb-ae3c-26a69208266b@gmail.com>
Date: Wed, 3 Apr 2024 06:00:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/8] net: dsa: microchip: Remove unused FDB
 timestamp support in ksz8_r_dyn_mac_table()
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20240403125039.3414824-1-o.rempel@pengutronix.de>
 <20240403125039.3414824-2-o.rempel@pengutronix.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240403125039.3414824-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/2024 5:50 AM, Oleksij Rempel wrote:
> The FDB timestamps are not being utilized. This commit removes the
> unused timestamp support from ksz8_r_dyn_mac_table() function.
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

