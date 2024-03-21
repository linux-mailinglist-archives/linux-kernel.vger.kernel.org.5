Return-Path: <linux-kernel+bounces-110068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D89C288598C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3241F21489
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04E283CDF;
	Thu, 21 Mar 2024 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joRUocov"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B55474D;
	Thu, 21 Mar 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026413; cv=none; b=JD1XPBK5/kba0img+XfmmceQyzY4zm+cyE4ivcu+4ela9ymqh0rrGCiqvXhQR8rub3Sf8+I0VtcKfqoylaAOtfqXyzwmvaEZk6WGcWuCptXWaJP3ByLaEZQROy05gkpKZXeC4UYaqd9fH7jSf6PUgUAR3qEfy93Xl9ciCZ56tq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026413; c=relaxed/simple;
	bh=J7WM9ULq1ctPdLnRjs/NRSRzZV/Z1VC6LsNLeIwE95Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PnXWDn29a3+tjWjl/ko8Xt0Kk3Ov8iyjkMKkV66FYJKPoXPql2c1PQC9aAyyv5h7dozS3NoPLTHtydmG6eSEimww+z+dbekv6ZI7tPrb18g4b2u3p1heAPjBxtN+9grk0lpJZ/HGH+44UWU/JMG7fG2g9h/dWCFlF/5UL53xxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joRUocov; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29b7164eef6so710796a91.2;
        Thu, 21 Mar 2024 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711026412; x=1711631212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6lQU1dHKYz0aWn2kYVD5L2i0npLLqY0Qe96LtlSMcqg=;
        b=joRUocovLyuQ2Vhh0HKfw0Nx6zwyQNqFgwiq4qvc54jPMtrH8rGCD/ZKXAzOVtOQK4
         iaEUXmSotV7wZ8P9CDoKJLcBbrapfbkkaScBAWSF72UpxPiToUk2tVj3Me2ZifKttZh0
         9eRyp2czdrqwBmuKBTFzAsFOD+/MN2ZngqhUMC4TugHPXqKMkBTT/FL6bC3/VszjeAdz
         9GvP1px4Jf9S8FpoQrNaz/xSoQPpmZvcBRM5fNOv2tVqBxzhOlQWpQcXr0h61Tq8HGnk
         0HOHB4mUSt7FTwsVfBNpDRLvJYaQPhWsBjVMkuA18WrEDyJM6Qgh181ykEOHSWoXO1BS
         jNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711026412; x=1711631212;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lQU1dHKYz0aWn2kYVD5L2i0npLLqY0Qe96LtlSMcqg=;
        b=MzuDPr0o8LqnyNEmfpCeRCkq9h5rcyYeOwqhSa6AcY+UIGy/fv1fQ8wmK7d9dZMFUK
         wVEylyyisYOR7/bxWXRpQLqHmPL1LQxfcU5ua9pla9KUI5yqyUtgXFvR7I7Fkwshgcat
         9A2Nc20jccDCV9T+LEaSLzvBXnTd8RXR3E3zZ6NcF6n8FKIJTWI7Cx5Vem+bUD8SFrmK
         BG4dGaI9WEbI27GcvPMK+FoMwT6BdvbSjeOSN8WG6Ocz/atUHoVnRS4O1u1JhYTW0Asr
         yQBuqvNWDAaznqiszfDE85hkoCE6uqlx019K+Yxg2OJ8TNtxqSvrD2TbJj52VeO4zm2B
         TSPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHbzYzmv1wk0r7OI+TYGi58zlaavRw4GE1v0/R3QeTyNjfh30+DqZ80pWekFjY3HVSnYjvWm8T95wPzc5cGatzHwzhoborsoUWCRv4redvJtygCNYJWt9ORqF7E7emWBF0+0Rr
X-Gm-Message-State: AOJu0Yzk2uboOwhxZhLOGWH9d1/bXVWn6MLtsrxuAeIsB+vRptP7TKtZ
	iDTtGbCyzJHqb+RjtY9wNEXd3NiIa/gz8J9jmP9lyFhSQFehHpEo
X-Google-Smtp-Source: AGHT+IE3DONaBayPhy5iD3ilQlhpUEBuHPdRJeoebi0FhDK3USPJAsaLs0eDXEGs1nV4vHOopk77FQ==
X-Received: by 2002:a17:90b:b07:b0:29f:7672:7fee with SMTP id bf7-20020a17090b0b0700b0029f76727feemr2058506pjb.31.1711026401913;
        Thu, 21 Mar 2024 06:06:41 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id w22-20020a17090aaf9600b0029fbfb620cdsm3496931pjq.28.2024.03.21.06.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 06:06:41 -0700 (PDT)
Message-ID: <61624f55-2f1f-4cb3-8845-0dc3988a849d@gmail.com>
Date: Thu, 21 Mar 2024 06:06:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: txgbe: fix i2c dev name cannot match clkdev
To: Duanqiang Wen <duanqiangwen@net-swift.com>, netdev@vger.kernel.org,
 jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maciej.fijalkowski@intel.com, andrew@lunn.ch, wangxiongfeng2@huawei.com,
 linux-kernel@vger.kernel.org
References: <20240321054742.446481-1-duanqiangwen@net-swift.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240321054742.446481-1-duanqiangwen@net-swift.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/20/2024 10:47 PM, Duanqiang Wen wrote:
> txgbe clkdev shortened clk_name, so i2c_dev info_name
> also need to shorten. Otherwise, i2c_dev cannot initialize
> clock. And had "i2c_dw" string in a define.
> 
> Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")
> Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>

When Jiri suggested to use a define, I did not read it as meaning a 
define local within the driver, but rather a define that would span 
beyond you driver that would match what is expected to be used by 
drivers/i2c/busses/i2c-designware-pcidrv.c.

As a matter of fact, there are quite a few drivers that expect to use 
this driver name:

git grep i2c_designware *
drivers/i2c/busses/i2c-designware-pcidrv.c:MODULE_ALIAS("i2c_designware-pci");
drivers/i2c/busses/i2c-designware-platdrv.c:MODULE_ALIAS("platform:i2c_designware");
drivers/i2c/busses/i2c-designware-platdrv.c:            .name   = 
"i2c_designware",
drivers/mfd/intel-lpss.c:       .name = "i2c_designware",
drivers/mfd/intel_quark_i2c_gpio.c:#define 
INTEL_QUARK_I2C_CONTROLLER_CLK "i2c_designware.0"
drivers/mfd/intel_quark_i2c_gpio.c:             .name = "i2c_designware",
drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c: snprintf(clk_name, 
sizeof(clk_name), "i2c_designware.%d",
drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c: info.name = 
"i2c_designware";

so they should all be covered by using a define under 
include/linux/i2c-designware.h.

--
Florian

