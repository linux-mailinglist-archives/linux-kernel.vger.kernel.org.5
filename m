Return-Path: <linux-kernel+bounces-19082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06E82679C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 05:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FB7281D9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F8D79EE;
	Mon,  8 Jan 2024 04:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnYnMp3k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F9749C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 04:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-555d89bf8f4so329291a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 20:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704689188; x=1705293988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBQoCtGsAlNdiuEM9BfbadXmqeot2938UuOpdhMoIOA=;
        b=QnYnMp3k0/0EQgksRVQXAYzXVt4NFM9eDUY0v0bEliTxPaG/pyFx+DBeBtpzh1/ACJ
         Z4bLn2CVIaUO5I6KE4Z3kXU4G7pqjaB9sgFFbUbOuvLP9KBhsVCCbuQ0PBzuVJmF3+uH
         ljur369sqViGFixOTXGngfVyylNEQwtnkQvlk7JD81E90Z12iwTCD/j0Mq5x4PWDCfBP
         j5fheImjB+3piQ+ppjP1htdhaP/muv3mms8NAIJ1ypeRXMD81UPXNHtUxYYWvxZahAdP
         5p+CboHCr9Tv3W522QQp7Qs5aypV7mAu3sTE9Xt3PVYSHDUS6vaVCmPZYy/BlX02Cipa
         1Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704689188; x=1705293988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBQoCtGsAlNdiuEM9BfbadXmqeot2938UuOpdhMoIOA=;
        b=rPZJ0Z15nBF6DvlrznF69B8Csm5qUeE8+aAtC7+SjkptI8VPmEnaFZxK0ABTXYrnJg
         K1qFa3Fo+248qfGqBZLCGRtODvGVLBpItRh54d2DacJRsuTj4oDt6yBz2QDirDmQ7fOe
         o8bzkLpBApbyvbZE/4g9QnnyuGnDfnlGC2+34/W3JDvGOPGFvqQX34cp4pNWa3ZnYsfZ
         p27MQM9x8ZELD87d4fw7TkBbN7oAeUCB7zWcLGyiiPIQZxAebkQDJAIL+B5M5uUwppbH
         9JlD9NK8uEK1vo4lXiYlYZ0LzF9V0nhNKrT9yT9eGWinSo5MH8LO6ek4xHvVdd57AjXv
         SFcQ==
X-Gm-Message-State: AOJu0Yxrz0cNMk8yNV0NMT3iOrirovRo8hdEW1GQVPqzxuOUR5drOi1w
	vdphTo/LXjERZRYUIwAA+ig=
X-Google-Smtp-Source: AGHT+IHgJxrZw0Dn+jNq/CXNJUNGp2UOlFLAKsAsrPM7qMuLtzQBCVmyBRzb8LA0OacxnfNOXCQ5kg==
X-Received: by 2002:a17:907:a0cf:b0:a28:34e5:b86e with SMTP id hw15-20020a170907a0cf00b00a2834e5b86emr2738438ejc.2.1704689187935;
        Sun, 07 Jan 2024 20:46:27 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906550200b00a2a4086c6b0sm1412269ejp.82.2024.01.07.20.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 20:46:27 -0800 (PST)
Message-ID: <9be7603e-1a94-4077-80e0-091f863e7b72@gmail.com>
Date: Mon, 8 Jan 2024 05:46:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] staging: rtl8192e: renamed variable is40MHz and 4
 other
To: Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240108032233.4280-1-garyrookard@fastmail.org>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240108032233.4280-1-garyrookard@fastmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/24 04:22, Gary Rookard wrote:
> Hi,
> 
> This patch series renames (5) different variables with
> the checkpatch coding style issue, Avoid CamelCase.
> 
> Patch 1/5) rename variable is40MHz
> Patch 2/5) rename variable isShortGI
> Patch 3/5) rename variable retValue
> Patch 4/5) rename variable EWC11NHTCap
> Patch 5/5) rename variable AdvCoding
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> 
> Gary Rookard (5):
>    staging: rtl8192e: rename variable is40MHz
>    staging: rtl8192e: rename variable isShortGI
>    staging: rtl8192e: rename variable retValue
>    staging: rtl8192e: rename variable EWC11NHTCap
>    staging: rtl8192e: rename variable AdvCoding
> 
>   drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 58 +++++++++++------------
>   2 files changed, 30 insertions(+), 30 deletions(-)
> 

Can be applied on top of other patches send in.
Is working fine on hardware.

Bye Philipp

