Return-Path: <linux-kernel+bounces-105891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3D387E613
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4E81C216DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD482D05B;
	Mon, 18 Mar 2024 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZon5mgq"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA86A2D04A;
	Mon, 18 Mar 2024 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754823; cv=none; b=fDWLtdgqiHO9nCr8/EmZte/Y34zf3g6cLoN0xvi0mTzntNOA+9Nytjb2uVcv1OzKs4xgl+jhxq75JvsHvL8OrgMleNDa2LP6n++b8b16I+HaXqGz9hW4ekA6Prtsj+3Cl+Sxo+fOCweXURuMKEVa3xN/fIbjy0TxSTtaBKHPFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754823; c=relaxed/simple;
	bh=bEznuMA+1zD98Hw8ywoN0Uc2fkSmDNXf8LAQqCKlFzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvOAxM8cCTsDuESVBgIowg+hOwtLkwGZDrn2NSm8aCUIpgyw8HbG7sUbv7LvauZ95Zxgmjjyz45xXNL+m8gXFxEbCJCljZwSCJYarPmsf4R4s1yYElh9iDGc6hoPSQiCJ55hiXbFknvRWHPLqleJ3m1sH39wrp3a+xHELKc36hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZon5mgq; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513d599dbabso4397194e87.1;
        Mon, 18 Mar 2024 02:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710754820; x=1711359620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIQCJ/OsqAraYCUqvyhok/Yclx8bJxWBxE1EUszmreg=;
        b=fZon5mgq/B6QeWk9JqdBTBqlaDEVV0sL2sWqAT2Wu0dnGUNXXghIw5eeGfDhpmy5Sj
         S42j6bR3JQmiavJtKU+Yb/yEFUMQWhXX1geC/SqeGhBj2S5L5Sa4nmfOUexDPJ6QhVp1
         MLRFwU3AAfVqv9N6dzVxHbs/DlLF24IhEEn4IqKxeSjmr/KFkzd4TVqjhMmzphHmlPls
         nesDoX4tyEbRZXwkVlOXuc2SAoAaNdvnkTOTtAZ86yDFvFPoEjnnSackpvHJXB6i1CPr
         YxkECemU0z2tSlOR2uQlaG08OcIbLGVv1C6zBTGd8BzNLpEhgmn7HWr0JeezITwQxsTI
         uUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710754820; x=1711359620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIQCJ/OsqAraYCUqvyhok/Yclx8bJxWBxE1EUszmreg=;
        b=UsbMp7ClHBHaRD9FfLlZ5bWyKnY0odwQdExClOlX/KGSVT5uj4rbfX45gsqbNQEUOV
         unIZ8z9GhJ0G3AAaBdsUccq2ERWvi3s1wVC32UvmyJqa/08DAUQebJkVtGTN7zNRNS1P
         66ZA9qkRhCrVUJgUhHCm5+iA+X8I5cFHY8S/OVlEt+Zfjfvr9xEBR4/waU4+Rb8xr1Iw
         ns73PLrLQPfeimv9dbcxZwh3uubq2i1fqe0jLPVaze4T3PvLm4/05GW74m+VWb4hOLZZ
         FkqV/FS17lBvZ5dRIZcN+ANF8ddglnwi6YqTaKv7Z/zPSN9qpfw9sZQSaHlPQd+NbpCr
         1zLw==
X-Forwarded-Encrypted: i=1; AJvYcCXAG0pN0au4C/DiuTmgr8a1LGTAatIgOre/8ABmVI3MUPOVwgMjfu8waMy6aCYBj2NUJgI8t6sTPIvN3zoGQRNPasmM84WgClHd
X-Gm-Message-State: AOJu0YxzYg/UlNH22tOd+jsq2BcVet8WN6itI0zJbmkXefTSAS9N+NUP
	mPNk5Xv68zIEcs0CFyi29FUsK9LzAiR+KBYgr+KrAj658c7dNmvw
X-Google-Smtp-Source: AGHT+IHlG0jLb8/d60aF+YVkDif9YyCdRn4xn2S1BdwgErAiuJn3lQxqfCp3rdZ2sH2Uxw9A/Ucnjg==
X-Received: by 2002:a05:6512:32b7:b0:513:c9d2:e1e1 with SMTP id q23-20020a05651232b700b00513c9d2e1e1mr7591669lfe.66.1710754819778;
        Mon, 18 Mar 2024 02:40:19 -0700 (PDT)
Received: from [192.168.1.68] (79-139-148-139.dynamic.spd-mgts.ru. [79.139.148.139])
        by smtp.gmail.com with ESMTPSA id x23-20020ac24897000000b00513d3c1c7c7sm1370328lfc.191.2024.03.18.02.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 02:40:19 -0700 (PDT)
Message-ID: <56fe9e1c-80a5-47a4-b5e5-610c694db152@gmail.com>
Date: Mon, 18 Mar 2024 12:40:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin
 <shawn.lin@rock-chips.com>, Jyan Chou <jyanchou@realtek.com>
References: <20240314141440.3305802-1-serghox@gmail.com>
 <CAPDyKFrP1XgJo_zDDunpzb6g8QWo4k3Ye1dJCWBGVvhdprCCkg@mail.gmail.com>
Content-Language: en-US
From: Sergey Khimich <serghox@gmail.com>
In-Reply-To: <CAPDyKFrP1XgJo_zDDunpzb6g8QWo4k3Ye1dJCWBGVvhdprCCkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello, Uffe!

Thanks for the info! I'll update mailing list in the next v7 version of 
my patch set. I'll send it anyway to fix last comments from Adrian Hunter.

On 15.03.2024 13:55, Ulf Hansson wrote:
> On Thu, 14 Mar 2024 at 15:14, Sergey Khimich <serghox@gmail.com> wrote:
>> Hello!
>>
>> This is implementation of SDHCI CQE support for sdhci-of-dwcmshc driver.
>> For enabling CQE support just set 'supports-cqe' in your DevTree file
>> for appropriate mmc node.
>>
>> Also, while implementing CQE support for the driver, I faced with a problem
>> which I will describe below.
>> According to the IP block documentation CQE works only with "AMDA-2 only"
>> mode which is activated only with v4 mode enabled. I see in dwcmshc_probe()
>> function that v4 mode gets enabled only for 'sdhci_dwcmshc_bf3_pdata'
>> platform data.
>>
>> So my question is: is it correct to enable v4 mode for all platform data
>> if 'SDHCI_CAN_64BIT_V4' bit is set in hw?
>>
>> Because I`m afraid that enabling v4 mode for some platforms could break
>> them down. On the other hand, if host controller says that it can do v4
>> (caps & SDHCI_CAN_64BIT_V4), lets do v4 or disable it manualy by some
>> quirk. Anyway - RFC.
>>
> We have just updated the bouncing addresses in MAINTAINERS for Asutosh
> Das and Ritesh Harjani, that also helps maintain cqhci. Would you mind
> re-submitting to allow them to have a look at this too?
> Asutosh Das <quic_asutoshd@quicinc.com>
> Ritesh Harjani <ritesh.list@gmail.com>
>
> Kind regards
> Uffe
>
>> v2:
>>   - Added dwcmshc specific cqe_disable hook to prevent losing
>>     in-flight cmd when an ioctl is issued and cqe_disable is called;
>>
>>   - Added processing 128Mb boundary for the host memory data buffer size
>>     and the data buffer. For implementing this processing an extra
>>     callback is added to the struct 'sdhci_ops'.
>>
>>   - Fixed typo.
>>
>> v3:
>>   - Fix warning reported by kernel test robot:
>>          | Reported-by: kernel test robot <lkp@intel.com>
>>          | Closes: https://lore.kernel.org/oe-kbuild-all/202309270807.VoVn81m6-lkp@intel.com/
>>          | Closes: https://lore.kernel.org/oe-kbuild-all/202309300806.dcR19kcE-lkp@intel.com/
>>
>> v4:
>>   - Data reset moved to custom driver tuning hook.
>>   - Removed unnecessary dwcmshc_sdhci_cqe_disable() func
>>   - Removed unnecessary dwcmshc_cqhci_set_tran_desc. Export and use
>>     cqhci_set_tran_desc() instead.
>>   - Provide a hook for cqhci_set_tran_desc() instead of cqhci_prep_tran_desc().
>>   - Fix typo: int_clok_disable --> int_clock_disable
>>
>> v5:
>>   - Fix warning reported by kernel test robot:
>>          | Reported-by: kernel test robot <lkp@intel.com>
>>          | Closes: https://lore.kernel.org/oe-kbuild-all/202312301130.itEZhhI5-lkp@intel.com/
>>
>> v6:
>>   - Rebase to master branch
>>   - Fix typo;
>>   - Fix double blank line;
>>   - Add cqhci_suspend() and cqhci_resume() functions
>>     to support mmc suspend-to-ram (s2r);
>>   - Move reading DWCMSHC_P_VENDOR_AREA2 register under "supports-cqe"
>>     condition as not all IPs have that register;
>>   - Remove sdhci V4 mode from the list of prerequisites to init cqhci.
>>
>>
>> Sergey Khimich (2):
>>    mmc: cqhci: Add cqhci set_tran_desc() callback
>>    mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support
>>
>>   drivers/mmc/host/Kconfig            |   1 +
>>   drivers/mmc/host/cqhci-core.c       |  11 +-
>>   drivers/mmc/host/cqhci.h            |   4 +
>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 188 +++++++++++++++++++++++++++-
>>   4 files changed, 199 insertions(+), 5 deletions(-)
>>
>> --
>> 2.30.2
>>

