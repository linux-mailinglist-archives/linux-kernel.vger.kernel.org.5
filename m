Return-Path: <linux-kernel+bounces-2325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96321815B16
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B091F23D9D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106732FC24;
	Sat, 16 Dec 2023 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVJr2pn+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B81A29D;
	Sat, 16 Dec 2023 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so1265797fac.2;
        Sat, 16 Dec 2023 10:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702751735; x=1703356535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vyGJh+oLCg2opE9iZKuTamXk3uGWDZ4BeXKLK0KVs/Y=;
        b=eVJr2pn+L9gQUQIgVhRfr1tgIwr5EBRYm45wsYTezxodqJnP8nfzurmFIgLPMjyvNq
         mWdpU/04BGHa8Tr+5fbwAnP303iK+TDdxNzbbhYX39vhUs9M4jZRAMQLV3WN3hFotrYF
         i9kel/ncGhhXG+RHDdbc68TZmNLcGTFLzU4jdP6K/GgdkD0YmUNfsS0NC26WNY5F/1ve
         3IAayhHb/sLlgUEa7FVH9k9pkGSYoycES25ROrti9zDgcYkGPhE+jO6Y8ASuLpoGZzWz
         4PuXZWR5eODe7ogjdIZsD3M7M7hi2QqJ3CC5ZGw0Sj8pz/breHIPHUmctR08LmDMudTy
         E2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702751735; x=1703356535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyGJh+oLCg2opE9iZKuTamXk3uGWDZ4BeXKLK0KVs/Y=;
        b=c1A8G0/PB+/PN6t7SFGCFwHKSCiCVIlQz9t1ju3MBMYLn+cQD80kwxGpopoA67kqlK
         Nq/yvsKhASGppyEMw57KEHz+NJVJHyjSwPsxB691yChgc2qwktZtJrMSWtMw5kf3rsi1
         HnAfdmzKL+lyKfcMPM02yNMUlVThW0518Z2oPFkqphJrzr9UT/XaArvnS4+9VLmgCu46
         j2DEfJvkSPwZXTNwRKKP9cmNyaGusjKJ5wFxpF5MdEDCb2o1f9jl6dV5AGJtFCTkwR5X
         YdjH3AIm+i1opDIMfvvut0vK4cKjaOhNIKFFfCle1XSzIS2MdPmdZUmp/CT9W3WrWOjr
         r9Hg==
X-Gm-Message-State: AOJu0YwmHJRIcL7XzAwJ0deEztSS0O4WcWNca/OjW+nmGBaUqMod7ZYC
	/L+R080fQx53+mXhDTvmZQI=
X-Google-Smtp-Source: AGHT+IEYfMjQqALBoB0K9HmeyBytRJKkN4Rt+thWJXgUjf2Sp/Rc9wSBY3eE4sRkxwhLYefZJnpLWA==
X-Received: by 2002:a05:6870:32ce:b0:203:4935:15d6 with SMTP id r14-20020a05687032ce00b00203493515d6mr5934970oac.116.1702751735450;
        Sat, 16 Dec 2023 10:35:35 -0800 (PST)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id s38-20020a0568302aa600b006da11489f70sm3124704otu.44.2023.12.16.10.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 10:35:35 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <c1d61da8-3aba-4d4a-a852-3e743666da11@lwfinger.net>
Date: Sat, 16 Dec 2023 12:35:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU
 devices
Content-Language: en-US
To: Zenm Chen <zenmchen@gmail.com>, Jes.Sorensen@gmail.com
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, pkshih@realtek.com, rtl8821cerfe2@gmail.com
References: <20231216165259.5389-1-zenmchen@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20231216165259.5389-1-zenmchen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/23 10:52, Zenm Chen wrote:
> Add additional USB IDs found in the vendor driver from
> https://github.com/Mange/rtl8192eu-linux-driver to support more
> RTL8192EU devices.
> 
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> ---
> v2:
>   - Not to put these USB IDs in CONFIG_RTL8XXXU_UNTESTED

Have you tested all modes including STA, AP, P2P, etc? If not, then your devices 
belong in the CONFIG_RTL8XXXU_UNTESTED section.

I am also not fond of splitting the rtl8192eu devices into several different 
spots in the table. That only makes it harder to see what devices are supported.

NACKed by Larry Finger <Larry.Finger@lwfinger.net>

Larry


