Return-Path: <linux-kernel+bounces-37011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E75283AA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA81928ABEF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67C777F27;
	Wed, 24 Jan 2024 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tgXQZVbk"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931077F13
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100251; cv=none; b=OsKRAkyKemxv9ons0VXPeeL9gdBqwK8dBLgLgo0k+VAjDJwGOv+ivLL81JaWhdAYXTAwvm9WYicNTFMM1PQ/Y+pZ1G2naAkDrdBijEEemsl2qwygkvApVRQqdK6j1oOrlp7aohKyIJVcOtbhG61fTjaT7oFNzbA6cGr86AGwo/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100251; c=relaxed/simple;
	bh=u4Pd9/GQ/D35q1MW5OAVVQkGORRVo9EB40xBQcaVozw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k16PGBaneToDg/hbxaWT4HiF8hFV3MxgHzyvMfOG/C+98XcwAcjcpsFkFoIY6EXnObMh45qzcnEbrlJk1bwnuwUxIvKGKbNdE8LF2opjPo7WtHahnZ3hBlQ5DkZc0ehK/Bd2edDDeznptmzKaeEsP4j4G6Y0jKwBM3Yn+W13Q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tgXQZVbk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d70a986c4aso24015765ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706100249; x=1706705049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqgyZ2Sqd1xfKm+m9+hAQsolUxve6GqD3pgIanjN3gI=;
        b=tgXQZVbkdhs88Upq/Nd3zj1B87PbuGMrRz9GfkMEeUGRjeCHQZvRohe4I1Onx4voCU
         zOFPWJWwhsnnCYAMgL/pK9kNAevWdJS0J/vAc/I4fZ7gd3f6HlE7HaeRnkl9kQ1AJHpJ
         DVwbtpYLHh4UQQNsrprorUpG1z+g3L154VD52SO5RUGGg8tLwNDi2cMjwo0cH8Kfw9iH
         232GeJ9zuxTzfeJPf7Y8o3gkB8JDfdnAmPJxBNSp1HzJDQ/sodMgTeEFGtlsSG+CESWD
         n85BF3NdnMhV9rrbMAuqpAGTUU9jrKh+yY3z4b2f2HEa29wRaPy5AjJhhJHeTQiCryNy
         9Z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706100249; x=1706705049;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UqgyZ2Sqd1xfKm+m9+hAQsolUxve6GqD3pgIanjN3gI=;
        b=pweVha94FDMOv4XUsjRfbHeC2jihreADZ+u9ARlrzGHbCC24LFcs8aSULQZ7xfe1R/
         GxMIxVgn1wcUzLhF//ULhcezNwHCp+N67baw0TX/K1WD1uT7AuwBwhFPvl7QbwMDvowj
         ps3bcBK1v0w7KshJbjH1azCMTFeMnxW+oWd5yFeSKmfPUqvCq9XGUU5brJgjZYvyy0rN
         iMZySxsusOVfmS/2669OFGCKax2k03w82R6OoPJkrtaQxB/3NfrFT/NRXOwirM0FptTK
         lJbK6rZAWwQ0Q0rhUSWDI/DrGCvBbRTqdLpgtackNxqOSYW8KcC7qPA/tx8C0sctvTxW
         wrvg==
X-Gm-Message-State: AOJu0YyUgiMuoNSqgEcskZtCESSa0CujVsiESUaslmF9y0gtFd5qSl9m
	+LacrddV4JQGjwhlOYJa9zYLC08tmGlJ+nE9DmWi/MJH3FmAuLxa7saHa068F30=
X-Google-Smtp-Source: AGHT+IEXa7RfusqR1CTMjKxwfYkcc5NreShNdiyPmCYjDdFQjM3CAZJBYQZApMhGDQO+88mJATMAjw==
X-Received: by 2002:a17:902:bcc1:b0:1d6:f263:5699 with SMTP id o1-20020a170902bcc100b001d6f2635699mr575890pls.30.1706100248630;
        Wed, 24 Jan 2024 04:44:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:fd4f:fd82:e4fb:1654? ([2a01:e0a:982:cbb0:fd4f:fd82:e4fb:1654])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b001d7035b11d6sm10368325plk.254.2024.01.24.04.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:44:08 -0800 (PST)
Message-ID: <f8ec55a3-967f-40dc-9008-b4f5061023e4@linaro.org>
Date: Wed, 24 Jan 2024 13:44:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 0/3] usb: typec: ucsi: Adding support for UCSI 3.0
Content-Language: en-US, fr
To: Abhishek Pandit-Subedi <abhishekpandit@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org
Cc: pmalani@chromium.org, jthies@google.com,
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>, Saranya Gopal
 <saranya.gopal@intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20240123223039.1471557-1-abhishekpandit@google.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20240123223039.1471557-1-abhishekpandit@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/01/2024 23:30, Abhishek Pandit-Subedi wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> 
> Hi Heikki,
> 
> This series starts the work adding UCSI 3.0 support to the UCSI driver.
> 
> There's a couple of pieces to start here:
> * Add version checks and limit read size on 1.2.
> * Update Connector Status and Connector Capability structures.
> * Expose Partner PD revision from Capability data.
> 
> These were tested against on a 6.6 kernel running a usermode PPM against
> a Realtek Evaluation board.
> 
> One additional note: there are a lot more unaligned fields in UCSI now
> and the struct definitions are getting a bit out of hand. We can discuss
> alternate mechanisms for defining these structs in the patch that
> changes these structures.
> 
> Thanks,
> Abhishek
> 
> 
> Abhishek Pandit-Subedi (3):
>    usb: typec: ucsi: Limit read size on v1.2
>    usb: typec: ucsi: Update connector cap and status
>    usb: typec: ucsi: Get PD revision for partner
> 
>   drivers/usb/typec/ucsi/ucsi.c | 51 ++++++++++++++++++++++++++--
>   drivers/usb/typec/ucsi/ucsi.h | 64 ++++++++++++++++++++++++++++++++---
>   2 files changed, 109 insertions(+), 6 deletions(-)
> 

[    7.417925] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: Registered UCSI interface with version 1.1.0

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

[    9.085733] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: Registered UCSI interface with version 1.1.0

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD

Thanks,
Neil

