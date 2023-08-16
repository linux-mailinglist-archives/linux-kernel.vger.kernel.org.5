Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CB377DB37
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242459AbjHPHg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242455AbjHPHgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:36:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9420E10C3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:36:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso58541635e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692171376; x=1692776176;
        h=content-transfer-encoding:organization:autocrypt:subject:from:cc:to
         :content-language:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVFR2mk66kDJZxjvBrEwT33QDlRbkFQrANG0dtdmM64=;
        b=aSBCLGrIoVjMOpZForqAJ3kQeAtpPB7geoZHvMvHnRPpajcSIi0F/bIpt1anONbFJ0
         R/fHR7ulieNwsmTPTchW0HnMrSNBnM0XUwBf47bjOAEW+7lwVFHj0cqaMPPB70UD1ANc
         QwyB1HaRXi8d6lhk9RtlzV9Mh6+Zj6FOHIInchggAacP6vAlTuBj8OquFfYv8mkO0K9t
         EMMieEaOGRCt4RA7RCz6G62xX6cOFEo7tBZrjq6iQwmSrz8P+UZfJQZfewEvoaH841gQ
         LOy7SPoHj8zpbRUWzhz15OihycbQXH90Y4dM1mZ0sMtqdWZqXHtrqsnHD7trU3QGeGO/
         en9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692171376; x=1692776176;
        h=content-transfer-encoding:organization:autocrypt:subject:from:cc:to
         :content-language:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVFR2mk66kDJZxjvBrEwT33QDlRbkFQrANG0dtdmM64=;
        b=PHRhJIP3ivm9nNEY8P0Av4oQ0gHX0RSi6KNrmB2jGl1UoO6rU/VLH1H/Rj9jxEw4jg
         tWf3NzDTEjUgs11mVM0ll00vZGe5x0SmARW3GCKBg7/eXKPPfES+mIGWt1XWLhJT15p5
         lFHHeJvNCFOM2ZVw+CBr44Wfe6I5YrbqHJuVJYehiqTzpSHTzdDmR2Z9RGqNP6muHbkC
         RkdJ1atxJU6nT0YIAhUs2yN3DtFfUM9R+9EzXnFaCLu6bEifnCi8tOpVmtVQ/lAnwH5z
         9n+a34qNJTZtUMObBADP263zW7kV7a/iXrUUugIyTzbbfQJoaswXbseZ3bGNsOxN5ytI
         OcOw==
X-Gm-Message-State: AOJu0YyRXJWI6Z5YjKl9qUCq6j8yX1uYUzWKgiJYV8RqT8MOUP4nz9qp
        071RK6sHrylxnmdr2JMpYAMzDA==
X-Google-Smtp-Source: AGHT+IHUtfOeK4lw9OBhuMUzkSmWLND4TqqwpqGHAhIPHORtbdpA3VF36VLOYwLzgm1JnBVgn8JnqQ==
X-Received: by 2002:a05:600c:b58:b0:3fb:ac9c:e6f with SMTP id k24-20020a05600c0b5800b003fbac9c0e6fmr665309wmr.38.1692171375452;
        Wed, 16 Aug 2023 00:36:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:60eb:1b42:890:194? ([2a01:e0a:982:cbb0:60eb:1b42:890:194])
        by smtp.gmail.com with ESMTPSA id c6-20020a7bc846000000b003fe0a0e03fcsm22837334wml.12.2023.08.16.00.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 00:36:14 -0700 (PDT)
Message-ID: <8ec6b604-f1b8-4178-8bb4-9cd504f381ca@linaro.org>
Date:   Wed, 16 Aug 2023 09:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US, fr
To:     "linux-oxnas@groups.io" <linux-oxnas@groups.io>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: Final removal of Linux Oxnas support
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

If you followed the recent events, the complete Oxnas support will be removed from mainline
Linux tree in v6.6 following DT & arch-arm removal in v6.4.

The Oxnas support will still be present in the current LTS kernels, and I'll be
happy to help if someone wants to revive the oxnas support somehow.

Finally, huge thanks to Daniel who kept Oxnas alive in Openwrt based on my
mainline work !

I will leave the oxnas mainling-list and the kernel.org git tree alive for
a while.

Thanks,
Neil
-- 
Neil Armstrong <neil.armstrong@linaro.org>
Senior Software Engineer - Linaro Developer Services
https://linaro.org/services
