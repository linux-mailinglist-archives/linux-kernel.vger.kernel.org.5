Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33957F0D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjKTIXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjKTIXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:23:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1AFE5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:23:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-332cb136335so100934f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700468608; x=1701073408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDpNOA1ZQ6fgVY3fGVzzlkHvI60okoLt3vVAIeD7m/A=;
        b=B0i6VJQj8FpNQf2L6SAv/GR/PvMmgYh7/Xn6/ucal3DI+dkmRoo2tBhdl95xk5gUil
         m8G6ScWr8Y/ZY59/rheCAoP9djlQkOlrGqKvlvjiKVnxYHPtrm3PfEqeAerVuwVrSZCH
         5T4d0AlzDUE5o/AfkzeRJyYXH9FJxSQN/nUqcjMMx1LnrQcHc4mHdQSfP1ZyVzQwo7NU
         Llea8AGsYXOvDBursRO2BP7se2rLg+HqG02RRM+544MH6wxHoV6xdgUDiJPgiAvjJV3A
         K+dfinIBWlSN3g6uVzaB3nYWkWXRmt0cTLDlwCfONlPz9BT/6bQOXLQ3Z1ZxAPGK16en
         2WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700468608; x=1701073408;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zDpNOA1ZQ6fgVY3fGVzzlkHvI60okoLt3vVAIeD7m/A=;
        b=go49NpCk0XcyX10s/oVOy/et9a9e9djA0bro5XLdfbk8uR9Asl6bQnIhs4addUtQMz
         CZsEH9cWgWCCOCIu/kNhxVeV2b8MYDygJrIoD2BVox2LjZU1j+gfSszsF1ztrgnCuJCE
         oh0MNmsAQ3y63kE3rgZyiDUyxopMVraDnb3bMnXSWGqTIwz/aABhxjc9L//8hKbvR2hV
         3qxVERfZCexZLXaEqolsjg7gXtrX1gSaprG43Yp/5yCFtsg7ew2Jb3cUD5Gx5zfd6ZR3
         KA40eH4iNWLAeBJDjKTok0/CZEH+sRtzHb21Kw187gq/+tg9J+fhXNAuLKNHQKQjkL9g
         Ju5w==
X-Gm-Message-State: AOJu0Yxn6p8/PNHePyI3Ic1v/Iq52EQoOsnHHJ/EEyH9gyQG8u9abja5
        5g8tb37698iMNL5mnCTL4TjRBg==
X-Google-Smtp-Source: AGHT+IFH+4hs9Z8rfoBt29ysYtj7bV3eaXTJxK7DQ6vcgHZMWl1u+nSsUp7PR9zPmvR/iRVE1l3B9w==
X-Received: by 2002:a05:6000:1209:b0:331:6945:dc33 with SMTP id e9-20020a056000120900b003316945dc33mr3959236wrx.58.1700468608620;
        Mon, 20 Nov 2023 00:23:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f04:f84b:d87d:1d06? ([2a01:e0a:982:cbb0:f04:f84b:d87d:1d06])
        by smtp.gmail.com with ESMTPSA id s11-20020adfe00b000000b0032ddc3b88e9sm10487286wrh.0.2023.11.20.00.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 00:23:28 -0800 (PST)
Message-ID: <58d71614-4be0-4b78-8169-d7e6399734b3@linaro.org>
Date:   Mon, 20 Nov 2023 09:23:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 8/8] drm/bridge: it66121: Allow link this driver as a lib
Content-Language: en-US, fr
To:     Sui Jingfeng <sui.jingfeng@linux.dev>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Phong LE <ple@baylibre.com>, Maxime Ripard <mripard@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev>
 <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <1b59d647-c345-4260-b07b-22abb70ae17a@linux.dev>
 <CAA8EJppY2+ymX0kLY+cuR=SV1Po2J24r=NQecmb3ZhSE9NHG7Q@mail.gmail.com>
 <7b85d057-3d66-435a-a657-dd69067b6bef@linux.dev>
 <b9eacd91-8d6f-4265-931e-bc31cadd54d4@linux.dev>
 <CAA8EJpo1KhzTpaSqjbOuQvNKw4WGaqrtNBtNfdNLn28eZVgwhw@mail.gmail.com>
 <cf27d25a-3e51-4292-af63-37e5bc585d88@linux.dev>
 <CAA8EJprm6FL9_ZOr5uBXNXLBt=scs=FY2o6ZEv5r576iEM5KRw@mail.gmail.com>
 <aa4dd247-0eb1-4cda-9284-98da981bd3e1@linux.dev>
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
In-Reply-To: <aa4dd247-0eb1-4cda-9284-98da981bd3e1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 18:14, Sui Jingfeng wrote:
> Hi,
> 
> On 2023/11/17 17:03, Dmitry Baryshkov wrote:
>> On Fri, 17 Nov 2023 at 06:24, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>>> Hi,
>>>
>>> On 2023/11/16 23:23, Dmitry Baryshkov wrote:
>>>>>>> Then you will need some way (fwnode?) to
>>>>>>> discover the bridge chain. And at the last point you will get into the
>>>>>>> device data and/or properties business.
>>>>>>>
>>>>>> No, leave that chance to a more better programmer and forgive me please,
>>>>>> too difficult, I'm afraid of not able to solve. Thanks a lot for the
>>>>>> trust!
>>>>   From my point of view: no.
>>>
>>> I respect the fact that the community prefer generic mechanisms.
>>> If our approach is not what the community want, can I switch back
>>> to my previous solution? I can reduce the duplication of our
>>> localized it66121 driver to a minimal, rewrite it until it meets
>>> the community's requirement. I know our device looks weird and
>>> our approach is not elegant. But at the very least, we could not
>>> mess the community's design up by localize. Otherwise, I don't know
>>> what is the better approach to solve such a problem.
>>>
>>> Can I switch back or any other ideas?
>> I keep on repeating: create the i2c device from your root device
>> driver, which parses BIOS data.
>>
> This is not my own problems, currently it66121 (but not only) display bridge driver
> don't works on X86 either. What we are trying to do is to provide a generic, non-platform
> dependent solution. It is not only relevant to my driver. In fact, this series made
> no assumption which hardware/display controller will be the user.
> 
> I have investigated before respin this patch, there are other hardwares which
> ship the it66121 display bridge. For example, the Fresco Logic FL2000dx USB 3.0
> to VGA display adapter[1][2]. Even the windows have a driver.
> 
> [1] https://github.com/FrescoLogic/FL2000
> [2] https://oemdrivers.com/graphics-fresco-logic-fl2000

Switching to fwnodes, registering an i2c bus and generating fwnode data matching the
interconnect architecture is the way.

DRM Bridge transition to fwnode only should be done first, this will open bridge
to any architecture and device description (DT or ACPI).

Neil

> 

