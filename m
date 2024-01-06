Return-Path: <linux-kernel+bounces-18574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8717A825F87
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264481F225F4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 12:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220D6747D;
	Sat,  6 Jan 2024 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrN7Uv6P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C46FC3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cd3aea2621so871021fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 04:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704545224; x=1705150024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zsO/+64idbZilW8qozlP/EFQixW3V6s4CGGRG0UI8MI=;
        b=ZrN7Uv6PZRJGi/CtWZEfjYaujadmJBQvGk9mhF37Ta58o1aOCFAvGMpScUlYF86ths
         kXLrmgTudTGfrWfWKkm+pN2savdvk/JMVXBgVzhKSY+w3Q2DBuNWKlvXgAKttpb7hgXU
         UaSoJW1blgYc45vE98VGBw/rFOeCqH6c3CYRWoP3kLHeVfuKsu9ofFp/TgFThpRQDFvj
         rWk2IDSCEOMZE3P5bgT7hI+51XNl2rwNsLsKfZRUbmw7xJqM0VR2cK0CM1uL+hApVHIV
         LwUgGmNDE307FKWk+sUtYxwxfLGxt16dPttLOlsBhi9NVLBSns0vupCphA7FZBMxDbHL
         pDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704545224; x=1705150024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsO/+64idbZilW8qozlP/EFQixW3V6s4CGGRG0UI8MI=;
        b=Fh3k1hNhdObQEuwz7C0kHLIhflwhpY6/G5oUXaEAkjhtmR6/rQuiouSldRGtcU0Sux
         vBNK574MMr5lJ94XYQWZbdPDnH5Rj7FAgsOkFjmiD6bRke8ML74F9In7HFFR48vF7hO7
         xXTbwp5bNCFRVhe8V9Dq15e0RiHUgKcFB5v/jTahoUgOFbBaCvV2wC0kaJTCfjGYw2Jb
         cTEUafPoslBouL7/FvWXqGOW0FAIvKgA4kcRiBY3ppxDKRByJp/LPkgnnqa+Bb37Ff6E
         uVuzpP/scaRnrYyeRFgR+s1BoSav6sU8rcvc6NOtMsiyCNF1mRFfi1I80nHERmQbglsp
         WxGw==
X-Gm-Message-State: AOJu0YxfD+MYbk89nlzdAoAfDlA0D4TJpJBQSub/nTRfvBPeu46SZtwm
	pBZaqVgugX2ZRtA1oCqHzW8be+smpEzY+Q==
X-Google-Smtp-Source: AGHT+IEJj+WI4BTSVat3LiOlKwD3Sz+ByErlpx6sAPXp+Pz5/mt4Pxiep4xU8HSCDa8DAQf/Nt3/Uw==
X-Received: by 2002:a05:6512:2806:b0:50e:7719:4693 with SMTP id cf6-20020a056512280600b0050e77194693mr883100lfb.0.1704545223675;
        Sat, 06 Jan 2024 04:47:03 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id z11-20020a170906668b00b00a26ade46619sm1912043ejo.121.2024.01.06.04.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 04:47:03 -0800 (PST)
Message-ID: <0d79f685-e54a-4d83-933b-2ee225bca5d8@gmail.com>
Date: Sat, 6 Jan 2024 13:47:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] Staging: rtl8192e: checkpatch fixes for
 rtllib_softmac.c
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
 anjan@momi.ca
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240106055556.430948-1-tdavies@darkphysics.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240106055556.430948-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/24 06:55, Tree Davies wrote:
> This series' focus is on fixing checkpatch warnings regarding
> drivers/staging/rtl8192e/rtllib_softmac.c
> 
> Thank you in advance to reviewers
> ~ Tree
> 
> Tree Davies (21):
>    Staging: rtl8192e: Remove unnecessary parenthesis in
>      rtllib_softmac_new_net()
>    Staging: rtl8192e: Rename variable SlotIndex
>    Staging: rtl8192e: Rename function rtllib_MgntDisconnectAP()
>    Staging: rtl8192e: Rename variable bMulticast
>    Staging: rtl8192e: Rename variable MaxPeriod
>    Staging: rtl8192e: Rename variable bAwakePktSent
>    Staging: rtl8192e: Rename variable bSupportNmode
>    Staging: rtl8192e: Rename variable bBusyTraffic
>    Staging: rtl8192e: Rename function rtllib_MgntDisconnect()
>    Staging: rtl8192e: Rename variable bFilterOutNonAssociatedBSSID
>    Staging: rtl8192e: Rename variable array Bssid
>    Staging: rtl8192e: Rename variable NumRxUnicastOkInPeriod
>    Staging: rtl8192e: Rename variable SlotNum
>    Staging: rtl8192e: Rename variable RemoveAllTS
>    Staging: rtl8192e: Rename function RemovePeerTS()
>    Staging: rtl8192e: Rename function rtllib_MlmeDisassociateRequest()
>    Staging: rtl8192e: Rename function SendDisassociation()
>    Staging: rtl8192e: Rename variable bHalfSupportNmode
>    Staging: rtl8192e: Rename variable PMKCacheIdx
>    Staging: rtl8192e: Rename function GetNmodeSupportBySecCfg()
>    Staging: rtl8192e: Rename variable AsocRetryCount
> 
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  8 +-
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 32 +++----
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  2 +-
>   drivers/staging/rtl8192e/rtl819x_TSProc.c     |  6 +-
>   drivers/staging/rtl8192e/rtllib.h             | 26 +++---
>   drivers/staging/rtl8192e/rtllib_rx.c          |  6 +-
>   drivers/staging/rtl8192e/rtllib_softmac.c     | 86 +++++++++----------
>   drivers/staging/rtl8192e/rtllib_tx.c          | 10 +--
>   drivers/staging/rtl8192e/rtllib_wx.c          |  2 +-
>   9 files changed, 89 insertions(+), 89 deletions(-)
> 

Is working fine on hardware.

Bye Philipp

