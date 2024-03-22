Return-Path: <linux-kernel+bounces-111328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB872886AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02201C21C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1113E479;
	Fri, 22 Mar 2024 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1FXu7VY"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A563A8C3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105049; cv=none; b=hYzlqYHaLKRzsnXcCg2094vycD97fPOHupXdjFVBFfiUz3gX8ekgMD2FKfnafdSBodrIUXOGo1lj/DgZBCeJBhK9LZ3FidCjDMw9OZSgbTUdOT+IlW/0303r2LZxx7O47/ea1DuSu2l/cx7fAOsNtQnri2LKd2LS1q9M4i15sMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105049; c=relaxed/simple;
	bh=Cj8CW05WFikXqfvjU+HNE0R+/A78r+ijywBO0mXjTdI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IhoC3tJoTHUMTP/ciBae5iRIEm4OtT9d8+ZYqut6tLBqcAZqjoyMu0GkDcgwMUKN9IQrdDM6ivCLTEYReh2DpMWTe+/0btUgyZn2CuwEWKyI4nR0c99q2lkJK96+fZbx8LT8HT0RSUq6+CsNAHkBZElCM2ubpto1NKqmNilP53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i1FXu7VY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-414700cffd6so15602055e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711105044; x=1711709844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZLlkmNPx75eHGWlfmm8s0Qd4svN3CYLNYxvTdYFd8c=;
        b=i1FXu7VYT65IWqKTe3zOkoRaA9VJPiGUosovVptbytuLLYUc/5iT9+rq7RJqi6H6WP
         gt8xYw9TnCHTDS27pgGI2qhFVIOr2L1o826bME28+01RA4ephhp+O3j/AWDgdw84PFsI
         VT+iwSNxzAmjFsdtZzrO8nSUdK3COwViH8geMZzxKnF7exLGW4eJXOB2oLplZwq6Mbh8
         wkz+MZN3lb3hfM+GacmgqjmG7jJC6+xgezfLllTNK+Y5eIz+zNQx/YuEKto5CZSG97oS
         Q3lCHvTHlb8TXQ011orLo+T53hlxQxemxqeGByEU0tJHRD1oDTPI+mmt9le+tRFAv0qU
         N1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711105044; x=1711709844;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xZLlkmNPx75eHGWlfmm8s0Qd4svN3CYLNYxvTdYFd8c=;
        b=sibz4j1w0GF4TCwkSJUimSGoLkuiz76wUd41iiRYFICu+oZX09byjbzHuyR4rT+tD3
         LrlEz+/X5B43n88f2vte7ODOG4sg/+UdzzL4+u8IougD5DD8+2VcSEusIA9GxYnHGsPj
         RL3DWws3C87DMPqf6golOs9LVZoa2MrUBTST4e7DGwmH0Ik+T2EKNnF/e1YnvUHvYF/I
         CtjKePp6ZhWvQD/Sf+obt1HXltHVRKwQpI3HwPCMu6P3f9OL0TmzmTpOPmRX7NqMK24o
         0u1UQOQA0iCSEuaacy2o4HCpBp9i5Hc9rAEgHgX9RxT/bqL/suKBOXrNcJouSEAsf1Sk
         5kcg==
X-Forwarded-Encrypted: i=1; AJvYcCVwCyGdSwRYCKzYzNSwOPWdCvbUSbhu78S+m0VFrG76I8g3aWvOHFcCHqfSAQypOgpSVxzrVcvPQWxQozztJ62B/YXX+Pa9Atiu1qUf
X-Gm-Message-State: AOJu0YzWpZSYJEQYUAXDpW4/435feS71B3qXPx2B68H+VFVDZjbmzUOU
	oq/F9TMuEqge596nNjJvY0rNrlbtcqOGByI2O7H1wk/hiNS7c64Xa9xyQCjgFdo=
X-Google-Smtp-Source: AGHT+IG/EZKQRSLX55zopIgDS9o2qD3oCSZTXiicFNy+friKvPgI3RgZS4Z2vxdn5IswWtPlmViBzw==
X-Received: by 2002:a05:6000:402c:b0:341:b88b:1625 with SMTP id cp44-20020a056000402c00b00341b88b1625mr951641wrb.47.1711105044385;
        Fri, 22 Mar 2024 03:57:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3ee1:a278:2b57:55f7? ([2a01:e0a:982:cbb0:3ee1:a278:2b57:55f7])
        by smtp.gmail.com with ESMTPSA id dj9-20020a0560000b0900b0033ec812ee0esm1798226wrb.71.2024.03.22.03.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 03:57:24 -0700 (PDT)
Message-ID: <ccb4cb7e-9198-4c2f-b66f-014f596b657d@linaro.org>
Date: Fri, 22 Mar 2024 11:57:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/5] Fix various races in UCSI
To: Kenneth Crudup <kenny@panix.com>, "Christian A. Ehrhardt" <lk@c--e.de>,
 linux-kernel@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Prashant Malani <pmalani@chromium.org>, Jameson Thies <jthies@google.com>,
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 =?UTF-8?Q?Samuel_=C4=8Cavoj?= <samuel@cavoj.net>, linux-usb@vger.kernel.org
References: <20240320073927.1641788-1-lk@c--e.de>
 <fba7503a-7947-4487-95e6-9d41d636b075@panix.com>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <fba7503a-7947-4487-95e6-9d41d636b075@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/03/2024 11:53, Kenneth Crudup wrote:
> 
> Applied (cleanly) onto 6.8.1; I'll be testing over the next few days, but a few connects/disconnects mixed in with suspend/resume cycles shows no obvious issues (and everything seems to work).
> 
> Dell XPS 9320, BIOS 2.10.0
> 
> -K
> 
> On 3/20/24 00:39, Christian A. Ehrhardt wrote:
>> Fix various races in UCSI code:
>> - The EVENT_PENDING bit should be cleared under the PPM lock to
>>    avoid spurious re-checking of the connector status.
>> - The initial connector change notification during init may be
>>    lost which can cause a stuck UCSI controller. Observed by me
>>    and others during resume or after module reload.
>> - Unsupported commands must be ACKed. This was uncovered by the
>>    recent change from Jameson Thies that did sent unsupported commands.
>> - The DELL quirk still isn't quite complete and I've found a more
>>    elegant way to handle this. A connector change ack _is_ accepted
>>    on affected systems if it is bundled with a command ack.
>> - If we do two consecutive resets or the controller is already
>>    reset at boog the second reset might complete early because the
>>    reset complete bit is already set. ucsi_ccg.c has a work around
>>    for this but it looks like an more general issue to me.
>>
>> NOTE:
>> As a result of these individual fixes we could think about the
>> question if there are additional cases where we send some type
>> of command to the PPM while the bit that indicates its completion
>> is already set in CCI. And in fact there is one more case where
>> this can happen: The ack command that clears the connector change
>> is sent directly after the ack command for the previous command.
>> It might be possible to simply ack the connector change along with
>> the first command ucsi_handle_connector_change() and not at the
>> end. AFAICS the connector lock should protect us from races that
>> might arise out of this.
>>
>> Christian A. Ehrhardt (5):
>>    usb: typec: ucsi: Clear EVENT_PENDING under PPM lock
>>    usb: typec: ucsi: Check for notifications after init
>>    usb: typec: ucsi: Ack unsupported commands
>>    usb: typec: ucsi_acpi: Refactor and fix DELL quirk
>>    usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset
>>
>>   drivers/usb/typec/ucsi/ucsi.c      | 56 ++++++++++++++++++++--
>>   drivers/usb/typec/ucsi/ucsi_acpi.c | 75 +++++++++++++-----------------
>>   2 files changed, 84 insertions(+), 47 deletions(-)
>>
> 

with [1] applied:

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK

[1] https://lore.kernel.org/all/20240315171836.343830-1-jthies@google.com/

Thanks,
Neil

