Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7651B7FB6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343949AbjK1KE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjK1KEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:04:24 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A413BDE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:04:30 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c897ba4057so63458351fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701165869; x=1701770669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqZNlYO+4fXm1Z4ILbIvuuTtMTy9j6l7hH3PusjR6BQ=;
        b=zY03bC59vAxcqGDsj1IWehPDQHJxf7bYxfftwLJjGWqMDQpbZCRYYyOviNmwRjZ4NR
         FN+r0ewhrQQp3wvy29uvTaz6izw0XqPuQpi4+YFtMI8sBZGNwpcuyHNdWrV8xM6DxfoK
         MJCAh8LXJh6OLeZOvZ1Y7+2JdF63whRqRsfCTl+PlNt5v4+1bQ7g1Dy2H0tNlVuYka4c
         L6qnGMSSd8DxbWb6WgSuA2gJ6KGwAptEt6Dd4vSb+mL1ELGFSCaQ6cH6Islmqdpn9EP9
         gMQ/LQhz7yx83rjFMdVmcibmbKeAxCOSuAiIgSefwzAD7gmYnN2X3jNnc12ohAl0uTji
         Kl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701165869; x=1701770669;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uqZNlYO+4fXm1Z4ILbIvuuTtMTy9j6l7hH3PusjR6BQ=;
        b=YXY1/vmhK63PXziILx00JSoKjCJ81UTyE0fnbP/GSXwdNUG13kq55iMnja5vH1SpQ4
         sxO3+h+jHfrJizMb9oNgpCJYjj9BYyg62b0LWd4ZxBhRY4cZWAjEp9q9YZS3fQM1dc0Z
         JTX/0pmlY1QVdatoO6XAw78IcDL3VBQJ7HKeVCW0L56PN2eiwiveKyrL/qyESDdROGbJ
         Ah9oU+LXSdvgdzlFrYiemQuGL3mOFhOFGggTamZRE8F01T1HsNdPCFb4tFEFIHPWRffL
         870TXsJJEBBIm4xcenD401BMxhC0dS7xbxtVI+t2HTJrGD3Z8fPy1mFwttfsyyTKHk36
         M0oA==
X-Gm-Message-State: AOJu0YxyL7fYxb7m4gDCqS9BSrtIifZQympTXHXb8P2uSl8s26pZc4+2
        qNcgi5bxhL0Shuy84PydQj43Uw==
X-Google-Smtp-Source: AGHT+IEtwDkK+p/g3380X9UdQJDrGWwB3mLB36GDGD9BTyNpm+IlezcMvViInhOwqMgnmPIm1BWDQg==
X-Received: by 2002:a2e:a48b:0:b0:2c9:a0c8:b688 with SMTP id h11-20020a2ea48b000000b002c9a0c8b688mr4227270lji.26.1701165868753;
        Tue, 28 Nov 2023 02:04:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe? ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
        by smtp.gmail.com with ESMTPSA id e15-20020a05600c4e4f00b0040b40e3f877sm10329497wmq.6.2023.11.28.02.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:04:28 -0800 (PST)
Message-ID: <4e7ff29e-3cac-429b-932e-c9c79a319d4b@linaro.org>
Date:   Tue, 28 Nov 2023 11:04:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/3] Revert panel fixes and original buggy patch
Content-Language: en-US, fr
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
 <20231127232542.GB25590@pendragon.ideasonboard.com>
 <CACRpkdYWjHbgWQc46hGM3bg+5nf4NiveEZJmHrnx0X-=XsUDLA@mail.gmail.com>
 <80be087e-0341-487f-b6d9-8772d7c6128a@linaro.org>
 <CACRpkdZmowhDhCgnEYokjQC8T0930ZKEr18f5ZsM=ZmD0PDGig@mail.gmail.com>
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
In-Reply-To: <CACRpkdZmowhDhCgnEYokjQC8T0930ZKEr18f5ZsM=ZmD0PDGig@mail.gmail.com>
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

On 28/11/2023 10:34, Linus Walleij wrote:
> On Tue, Nov 28, 2023 at 9:30 AM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
> 
>> You can apply them now, or tell me if you want me to apply them.
> 
> Please apply them Neil (to drm-misc-fixes) order 2, 1, 3 for bisectability.

Sure, doing it right now.

Neil

> 
> Yours,
> Linus Walleij

