Return-Path: <linux-kernel+bounces-89879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FEF86F6CE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E157D281A6D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD8079DA8;
	Sun,  3 Mar 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKNnq8jc"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248479DA2
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493718; cv=none; b=ora4Iak//1/j2piFhJGaw9dvTKzb9V2u9hUEUkjoRgszI9Z9tAyAeThEX8nwdY5YinPFXQkCg+oy0fiMMCVmpi+4Sfh0heAspvsoL/FRIqh9aJ3y4Dz2sJuvVgaKu+bQc66rMV6cMlnTwb0DiGlYb3RecCZkBKohpox4A5ByKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493718; c=relaxed/simple;
	bh=Z4ARjctXdInaTulfH0l39W/5hUBT3Mx6CnyDsRwi5AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOeWJV1yOyeQxxgDeaE2GnE2CON5RTuaThDyCCr9d65KIlNOV3lHztK87G6mUQk2mOptZCnwu5/FX6PxRubz7sqU4+h/lkkIOjO/H20nlcDVuQxoqhWq4Kdz02HgD06wRYeFqUzO+em1Ezmf2S1NiZlMEzaSkl9d7zCPF64WMFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKNnq8jc; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5132444ac00so1235610e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709493715; x=1710098515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/48/JKby1GAL8JfgGJx3fO2g/mkSQ2r0j63ahzXbQY=;
        b=RKNnq8jcnKDjQMKcGXicW54JgAXyuACC+rvoF8yNR4StyWc9tT/XJfP/fYdiChv3sa
         T/2YaE7qxqAoHBJetnJ1haqBzCtGCTC5sG6LoMVJ0VGh5B+sarpGRsmlVJKFe0a6SU1y
         Lh9drQaB+kezcSWnj5Opscx8qSPQGFZ5t+jjD9WGU3J0MzTZrzVwQKsNTZCud7LP+w5t
         Vmg7o/6vw1oq7XgUpdTY6MzM70KCIW/tmdKo7n9Tw1azSlCanXHe1DQsRuJP4xOzozUr
         uaEUaoqx+wH3wzybvwAykzy6iTH8041Dkuo8D7LE76TCmjJ1L7eotS1Nx7R/rt0TtDXf
         fSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709493715; x=1710098515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/48/JKby1GAL8JfgGJx3fO2g/mkSQ2r0j63ahzXbQY=;
        b=phkRQvG335KdKE3iub2g1APBaksoaCh/EmgbGOUSyiXgO4w/jZcFALmk5uUM+iBoLF
         dpr67mTN/Hb9MFZJQaH4tdSYZm4dYF/OoJSb+8Pzv+UeKwRQukiYxqqivKxoJ+A694GK
         VVNd7b5u+Md4XjN6g0uM63Y/eXQIEXWT753FVDttf7+fGXEhPgcIQb8NgeBr9annjw1h
         BRCWi8XRkrBaH9g63vhVSiWXPWzpBkpNdgdpQdlgGpcMeEC/6Z951mVjqqrJK6BnyNZu
         XwwU31DOR0olV1LcBXlVyffw7eXVZwZmwsAqlyOV6cA4DOlnPKC5XZfPCEqROuQuY8cG
         7zow==
X-Forwarded-Encrypted: i=1; AJvYcCUSN+rHTmLekE1WAfQuUEiJhBB+QUANLEjGJs23cuDcbfOqYblhQM5sqgSELrHbt6QyM/8uyUKcF3yx+G5j6l2n7v5KwfwVw+BJWEn9
X-Gm-Message-State: AOJu0YymC9cy1I1N37mEXXPrlCUbhZ7loBFqqRcDGAxJzTeNPJy68Xhz
	EAXmVyq6H2DSQBGuGKQ5I1PHZ7lj4ODTYFteppTmwds8lplxku4ELPBemcTvaD0=
X-Google-Smtp-Source: AGHT+IEdzvGOfJaJFfR6dGZMvCX4xDWmbnCege8hFqnLHxzPzMwPajFoJC8GzvkolyvM5Mem/j1Bxw==
X-Received: by 2002:ac2:4648:0:b0:513:2fcb:da02 with SMTP id s8-20020ac24648000000b005132fcbda02mr3710173lfo.2.1709493714917;
        Sun, 03 Mar 2024 11:21:54 -0800 (PST)
Received: from [192.168.0.101] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id cm29-20020a170906f59d00b00a3ce60b003asm4035741ejd.176.2024.03.03.11.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 11:21:54 -0800 (PST)
Message-ID: <2df748b9-9a7f-4ae7-b871-a4a9df9297f3@gmail.com>
Date: Sun, 3 Mar 2024 20:21:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Staging: rtl8192e: Declare variable with static
To: Ariel Silver <arielsilver77@gmail.com>, gregkh@linuxfoundation.org,
 yogi.kernel@gmail.com, dan.carpenter@linaro.org, straube.linux@gmail.com,
 garyrookard@fastmail.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240301153128.13974-1-arielsilver77@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240301153128.13974-1-arielsilver77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 16:31, Ariel Silver wrote:
> Fixed sparse warning:
> "'dm_rx_path_sel_table' was not declared. Should it be static?"
> As dm_rx_path_sel_table is used only in rtl_dm.c it should be static.
> 
> Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> index 92143c50c149..850ee6ae1f02 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> @@ -144,7 +144,7 @@ const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8] = {
>   /*------------------------Define global variable-----------------------------*/
>   struct dig_t dm_digtable;
>   
> -struct drx_path_sel dm_rx_path_sel_table;
> +static struct drx_path_sel dm_rx_path_sel_table;
>   /*------------------------Define global variable-----------------------------*/
>   
>   

Hi Ariel,

I need to tell you that you need a change history. There is also the v2 
missing in the subject. Please make a v3 with change history.

Thanks

Bye Philipp

