Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441477B6263
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjJCHRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjJCHRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:17:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F44A4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:16:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-323168869daso642216f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 00:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696317413; x=1696922213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpUUFq9QU9L0qfPCVG8CBY0uJ76VkGAs+iJNl+MP9Es=;
        b=sJhBBrN3GaeDcqOU+p77oBSarlc6PW3ioar4bWxsoAoFz2GosjbFvVd25SNEx2THqm
         Z18tTBadB0XBAw5jXl90yLV5Nah1ALSenD8NNDynn/u3AbxzWu9ljdGBxSr6GpsZCw4b
         E7Lk16MRF99QK7UNjHFHsj1DfQRAXXqCGOeO4StrX+1IcrC0K46Xg4enrKldlw/3EVUz
         BFTKq5VlEKfJYO12wLFBpMvqeS5vDAtUcHauPqpKEB7Wrru5b5xOaCVq/+4bPgoYTB0R
         6NabZIh696r1vfgxAZHwf78A243fIqtRPbsjkLOF8n8gaqQV7RmS6JFIjLm7wOdA3V68
         d3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696317413; x=1696922213;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QpUUFq9QU9L0qfPCVG8CBY0uJ76VkGAs+iJNl+MP9Es=;
        b=HJu1C7QpcnAjQvKQzsHRoWGl8qZ4hSYm8yM7eOZ6NuMCu4Fyp3WNypXBmD0idFhRYu
         MIl+Xd/cyCdxaNbiadpmi7cbSzFDS09YBxjfJYqN3Bqx51prA/fjZJtbA7vgAA3lhsf0
         zvxr+2gj9OPQGtCKJCd+PGIWEnrrDmgFxvokApWBkVV9kQIQL6gsyu847fGgbPVDw6eU
         78hiSafTvzBLyP/nhUGJrGvHj5nLEAfO76PFD+4/P2euL6CX16mdymK81V9omVtFdVcB
         9NkA0W1c1RYeYD3SiQGrVUub4YqIwLMBfcy+5v5Vs2NS0J1swWsBFjHptSeqRoMVwD6x
         TZOw==
X-Gm-Message-State: AOJu0YyVpK/fJw3ejhMUvmTZBnMaeElxpX1VqP4+ngEz/dgbu++ZZZPX
        P59RCu0Lkog75Lj3AMDFKaqyJg==
X-Google-Smtp-Source: AGHT+IEWu0xac32pksXzwZMIWt3brB8UIquOiYKnIp7HkLnrNNbaheTXCpeC2KPbOOWCbiefqofD8A==
X-Received: by 2002:adf:ed02:0:b0:321:6936:c217 with SMTP id a2-20020adfed02000000b003216936c217mr12497257wro.14.1696317413483;
        Tue, 03 Oct 2023 00:16:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858? ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
        by smtp.gmail.com with ESMTPSA id j16-20020a056000125000b00326f5d0ce0asm852877wrx.21.2023.10.03.00.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 00:16:52 -0700 (PDT)
Message-ID: <c6a974ce-511c-47f8-b6cb-baeec5283af9@linaro.org>
Date:   Tue, 3 Oct 2023 09:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/3] clk: qcom: add SM8550 DISPCC driver
Content-Language: en-US, fr
To:     Sophon Wu <wuxilin123@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, andersson@kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org
References: <CAEPPPKu=yxS6SgdLZiuhbF2DRURKVUBNgNbUQ96LxHHbtsJ6Sg@mail.gmail.com>
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
In-Reply-To: <CAEPPPKu=yxS6SgdLZiuhbF2DRURKVUBNgNbUQ96LxHHbtsJ6Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/10/2023 04:17, Sophon Wu wrote:
> On 09/01/2023 16:47, Neil Armstrong wrote:
> 
>> Add support for the display clock controller found in SM8550
>> based devices.
> 
>> This clock controller feeds the Multimedia Display SubSystem (MDSS).
>> This driver is based on the SM8450 support.
> 
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
> 
> Hi Neil,
> 
> I'm trying to enable display on SM8550 but having trouble with clocks. Do you
> have any idea on this maybe? Full dmesg here: https://bpa.st/7E6Q

You may need to remove the cont-splash memory zone and the simple-framebuffer,
if you leave the cont-splash the bootloader will leave the MDSS on and Linux
will fail to take over and initialize the clocks.

This is known issue, and for now we re-initialize everything from Linux after
ABL disables the display subsystem entirely.

Neil

> 
> Regards,
> Xilin
> 
>   ------------[ cut here ]------------
>   disp_cc_mdss_mdp_clk_src: rcg didn't update its configuration.
>   WARNING: CPU: 4 PID: 73 at drivers/clk/qcom/clk-rcg2.c:133
> update_config+0xd4/0xf0
>   Modules linked in:
>   CPU: 4 PID: 73 Comm: kworker/u16:2 Tainted: G S
> 6.6.0-rc3-next-20230929-00006-g019d41d2e78e-dirty #252
> d692e32c53d7001f1537e28f80b45291db95a48f
>   Hardware name: AYN Odin 2 (DT)
>   Workqueue: events_unbound deferred_probe_work_func
>   pstate: 614000c5 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>   pc : update_config+0xd4/0xf0
>   lr : update_config+0xd4/0xf0
>   sp : ffff8000861435d0
>   x29: ffff8000861435d0 x28: 0000000000000000 x27: 0000000000000000
>   x26: ffff0008011da0f4 x25: 0000000000000000 x24: 0000000000000000
>   x23: 0000000000000004 x22: ffff000804f0eac0 x21: ffff800082395f68
>   x20: ffff800085109c20 x19: 0000000000000000 x18: 0000000000000014
>   x17: 0000000043567dcd x16: 00000000c6ba16a0 x15: 0000000040b16970
>   x14: 0000000000000001 x13: 2e6e6f6974617275 x12: 6769666e6f632073
>   x11: 7469206574616470 x10: 752074276e646964 x9 : ffff8000801bfc5c
>   x8 : 2073746920657461 x7 : 6470752074276e64 x6 : 0000000000000010
>   x5 : 40000000ffff0254 x4 : ffff8000848907d0 x3 : 00000000ffffffff
>   x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000801320000
>   Call trace:
>    update_config+0xd4/0xf0
>    clk_rcg2_shared_enable+0x58/0x98
>    clk_core_enable+0x78/0x1f8
>    clk_core_enable+0x58/0x1f8
>    clk_enable+0x34/0x60
>    clk_bulk_enable+0x54/0xe8
>    msm_mdss_enable+0xac/0x250
>    mdss_runtime_resume+0x3c/0x58
>    pm_generic_runtime_resume+0x34/0x58
>    __genpd_runtime_resume+0x38/0x90
>    genpd_runtime_resume+0x11c/0x2b0
>    __rpm_callback+0x50/0x1f0
>    rpm_callback+0x74/0x88
>    rpm_resume+0x534/0x760
>    __pm_runtime_resume+0x64/0xc0
>    __device_attach+0x8c/0x1c0
>    device_initial_probe+0x1c/0x30
>    bus_probe_device+0xb4/0xc0
>    device_add+0x64c/0x848
>    of_device_add+0x4c/0x70
>    of_platform_device_create_pdata+0x94/0x130
>    of_platform_bus_create+0x188/0x4c8
>    of_platform_populate+0x60/0x160
>    mdss_probe+0x278/0x398
>    platform_probe+0x70/0xd8
>    really_probe+0x190/0x3d8
>    __driver_probe_device+0x84/0x180
>    driver_probe_device+0x44/0x120
>    __device_attach_driver+0xc4/0x168
>    bus_for_each_drv+0x8c/0xf0
>    __device_attach+0xa4/0x1c0
>    device_initial_probe+0x1c/0x30
>    bus_probe_device+0xb4/0xc0
>    deferred_probe_work_func+0xbc/0x118
>    process_one_work+0x154/0x3c8
>    worker_thread+0x2bc/0x3e0
>    kthread+0x118/0x128
>    ret_from_fork+0x10/0x20
>   ---[ end trace 0000000000000000 ]---
>   Failed to enable clk '(null)': -16
>   msm-mdss ae00000.display-subsystem: clock enable failed, ret:-16
>   ------------[ cut here ]------------
>   disp_cc_mdss_ahb_clk status stuck at 'off'
>   WARNING: CPU: 4 PID: 73 at drivers/clk/qcom/clk-branch.c:86
> clk_branch_wait+0x148/0x168
>   Modules linked in:
>   CPU: 4 PID: 73 Comm: kworker/u16:2 Tainted: G S      W
> 6.6.0-rc3-next-20230929-00006-g019d41d2e78e-dirty #252
> d692e32c53d7001f1537e28f80b45291db95a48f
>   Hardware name: AYN Odin 2 (DT)
>   Workqueue: events_unbound deferred_probe_work_func
>   pstate: 614000c5 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>   pc : clk_branch_wait+0x148/0x168
>   lr : clk_branch_wait+0x148/0x168
>   sp : ffff800086143650
>   x29: ffff800086143650 x28: 0000000000000000 x27: 0000000000000000
>   x26: 0000000000000000 x25: ffff000a7e7b50d8 x24: ffff80008517ac90
>   x23: ffff800082395ed0 x22: 0000000000000001 x21: ffff800080bb09f0
>   x20: 0000000000000000 x19: ffff8000851094d0 x18: 0000000000000006
>   x17: 0000000000000000 x16: 0000000000000020 x15: 0000000000000002
>   x14: 0000000000000001 x13: 0000000000000004 x12: 0000000000000000
>   x11: 0000000000000000 x10: 0000000000000020 x9 : ffff8000801bfc5c
>   x8 : 0000000000000020 x7 : 00000000ffffffff x6 : 0000000000000000
>   x5 : 0000000000000050 x4 : ffff800083df7e80 x3 : 00000000ffffffff
>   x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000801320000
>   Call trace:
>    clk_branch_wait+0x148/0x168
>    clk_branch2_enable+0x38/0x50
>    clk_core_enable+0x78/0x1f8
>    clk_enable+0x34/0x60
>    dsi_phy_enable_resource+0x98/0xb8
>    dsi_phy_driver_probe+0x26c/0x408
>    platform_probe+0x70/0xd8
>    really_probe+0x190/0x3d8
>    __driver_probe_device+0x84/0x180
>    driver_probe_device+0x44/0x120
>    __device_attach_driver+0xc4/0x168
>    bus_for_each_drv+0x8c/0xf0
>    __device_attach+0xa4/0x1c0
>    device_initial_probe+0x1c/0x30
>    bus_probe_device+0xb4/0xc0
>    device_add+0x64c/0x848
>    of_device_add+0x4c/0x70
>    of_platform_device_create_pdata+0x94/0x130
>    of_platform_bus_create+0x188/0x4c8
>    of_platform_populate+0x60/0x160
>    mdss_probe+0x278/0x398
>    platform_probe+0x70/0xd8
>    really_probe+0x190/0x3d8
>    __driver_probe_device+0x84/0x180
>    driver_probe_device+0x44/0x120
>    __device_attach_driver+0xc4/0x168
>    bus_for_each_drv+0x8c/0xf0
>    __device_attach+0xa4/0x1c0
>    device_initial_probe+0x1c/0x30
>    bus_probe_device+0xb4/0xc0
>    deferred_probe_work_func+0xbc/0x118
>    process_one_work+0x154/0x3c8
>    worker_thread+0x2bc/0x3e0
>    kthread+0x118/0x128
>    ret_from_fork+0x10/0x20
>   ---[ end trace 0000000000000000 ]---
>   msm_dsi_phy ae97000.phy: [drm:dsi_phy_enable_resource] *ERROR*
> dsi_phy_enable_resource: can't enable ahb clk, -16
>   msm_dsi_phy: probe of ae97000.phy failed with error -16

