Return-Path: <linux-kernel+bounces-86131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5850686C01D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4841C20FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3428C39FD1;
	Thu, 29 Feb 2024 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM8gQKCO"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C246939AD5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709183861; cv=none; b=g5/CPcUIrYIAPxldG1OvOItTNm8lapBoRMvTZH+dDqkc44HUTN3CHoQze1mxVxADWRhDG4HUUDFeMHtQrq84ceWM4bxA+nYMxR6ljZmEJg6PM1I6LjA/UmcnPDjXPwO2yz/WwkLZkO3Uf2gKwHCThKb0wsDAj0+We3KCO4KWQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709183861; c=relaxed/simple;
	bh=QLdvRcyiMne/VT/oSplWRmRIFKGFh7UjVB3Dd95hIss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l45FG3Yu7RHZzTLNwrTeAwz1bGNw5UGJ3EwTCMX43km3p3xJw8bYmqnxeatt94tQKr20vEx9fx8qpnxnZ5DNkeVe2pBui11s1zhoNh5aXbM2WVHg82lTKdbPoG7t0F7J0k3IOovw4Ztk8WQow7DMHrdN0MPchj84fpBXflAzgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fM8gQKCO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51327cd65beso47365e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 21:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709183858; x=1709788658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oEDigR9B35jgh3NUhIDi4WoeBZW/WlBf7UzIlNaTSiw=;
        b=fM8gQKCOShiWKrB26gzgpPYI/kJ023iAn4RikPbYSOQdmn4Al4Rb2h5AG7wbGip2X5
         HUHbrErzE7QPmkDWCOiz6Aby9y1IgD47lNGHpO5wst/hgFLZ1pUAoLfpW3rFGCyVgYmG
         hVTMm4/CHJWhDw2lQ4T6lPeC9Wy6ctOO35+1mXFa/HYTNMkulUy5WblMgdFTQBJZ3ZiG
         u0TZzm6xkCAVt0lv4Lt++sLaMR9yuyLKspo2cb0vcKZzvP4EsNXqshqc1SJo/XTDE1Ll
         jdDMdEgGp22Vpya5k2UBVM8EJEUlIyKneeWgyKFWeyaSiXVBoDAw3iminNEqG7gy2CRS
         3hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709183858; x=1709788658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEDigR9B35jgh3NUhIDi4WoeBZW/WlBf7UzIlNaTSiw=;
        b=VoDb09/xXRijktpZtPPl2nTsA5zDJajq7n+ipPr9N9ZvloqNx8xdINlKm2L9V2ziJN
         LtqEtrTQoxhIfXaILVkepW3K3VMzQhyi1t8Eb+jJspFSxuSU4jpZcCprpnkgVRJTkDT7
         kZ1dDUbSnW+319NSUp378RftobnhkCfsT+uYixv2T/7ienFcOiS4tW0NptqY6ms+J+7E
         qYyKSK3gvJxAV9RrLl5bhRKiPQnlVZVr4qa8sarz67gBOEYRiiTj1dXvrjyVlk0wnAQE
         sYKRsOQsdjJ/QZbLM42W/wmrylmb/b2C40HOCihj0whZUhW8ik2Bj1hepfFQJBeBkI9H
         WQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR7K9CpMcKm6QvnwdTBoIX2reJlt68S6owA1p7S5b+Oj62EgNHK2QdbJyGNHSF9M46ph6nb+BCGssW+WViK27YjKz3/3LLRmwz3UPl
X-Gm-Message-State: AOJu0YzrGT0JUTtn9Y81YJdlF1rA+QQpnWByZR/UywDRNGQ/tRUr5c2q
	iS9AIBh6QkybukPtm2NQJlZXMljRHTTcoSLAnX3ig/1/SadIkb9W
X-Google-Smtp-Source: AGHT+IHxbIGnVddxTEb8eZVws/jmRpTTm4E/db4m/qINhv+hBD1QscgPzEdEUCBi9/LxGQEwXYBn+Q==
X-Received: by 2002:a05:6512:10cb:b0:513:1cc8:6d05 with SMTP id k11-20020a05651210cb00b005131cc86d05mr666989lfg.2.1709183857655;
        Wed, 28 Feb 2024 21:17:37 -0800 (PST)
Received: from [192.168.0.102] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b0041297d7e181sm858237wmq.6.2024.02.28.21.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 21:17:37 -0800 (PST)
Message-ID: <5b9b2619-eea8-4b8f-8e66-e343272ab51f@gmail.com>
Date: Thu, 29 Feb 2024 06:17:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Staging: rtl8192e: Fix Checkpatch warnings in
 rtl819x_BAProc.c
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
 anjan@momi.ca
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240229024325.453374-1-tdavies@darkphysics.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240229024325.453374-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 03:43, Tree Davies wrote:
> This series fixes the remaining checkpatch issues in rtl819x_BAProc.c
> These patches are to be applied after patch-series: '[PATCH v2 00/20]
> Staging: rtl8192e: Fix checkpatch warning for rtllib_softmac.c ''
> Thank you to all reviewers
> ~ Tree Davies
> 
> v2: Change commit message in patches 7 and 8
> 
> Tree Davies (8):
>    Staging: rtl8192e: Fix 5 chckpatch alignment warnings in
>      rtl819x_BAProc.c
>    Staging: rtl8192e: Rename variable TxRxSelect
>    Staging: rtl8192e: Rename function rtllib_send_ADDBAReq()
>    Staging: rtl8192e: Rename function rtllib_send_ADDBARsp()
>    Staging: rtl8192e: Rename goto OnADDBAReq_Fail
>    Staging: rtl8192e: Rename goto OnADDBARsp_Reject
>    Staging: rtl8192e: Rename function rtllib_FlushRxTsPendingPkts()
>    Staging: rtl8192e: Rename function GetHalfNmodeSupportByAPsHandler()
> 
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   |  2 +-
>   drivers/staging/rtl8192e/rtl819x_BAProc.c    | 66 ++++++++++----------
>   drivers/staging/rtl8192e/rtl819x_HTProc.c    |  8 +--
>   drivers/staging/rtl8192e/rtl819x_TSProc.c    | 24 +++----
>   drivers/staging/rtl8192e/rtllib.h            | 10 +--
>   drivers/staging/rtl8192e/rtllib_rx.c         |  4 +-
>   7 files changed, 58 insertions(+), 58 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

