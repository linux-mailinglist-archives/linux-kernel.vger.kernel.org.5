Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989797E82D8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344954AbjKJTeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjKJTdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:33:47 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B761924C04
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:35:24 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507962561adso2599990e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699608923; x=1700213723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtekfsW92aAxO5tWYqkwt6k/7ffnjhMdgCX0hkH5iHo=;
        b=L0F6wMNLBopXmUfOxm1tmJsOXeo6bpgD2BupYBAqTxQjwZfMzmGyBJt93HcOBgCy+D
         BnNyiNUmcRGRgdUA68B//qd44Arpvm1FcWHnzMJpU3wHAHb/kR0WWWbKf6NjUkvw29Ev
         khaXQdU68W7d3RcFsTFvntCEFUJDS1CHG6jq3T5VAHYF1ImsHM9jMTN8TgGURbAt5Um1
         jZOz421YHgwYoH89IyVxbVVPlyPVMcy8MUIg3GJZ7WeE9qLb0nKXM6KJcnWK4FKHnFH+
         BKywlYPDBqi9GP+gahVPTuiT66VokNEsUPLPJEqrjpksP7oINUB0af4tcj2GPN8yX5zH
         vHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699608923; x=1700213723;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FtekfsW92aAxO5tWYqkwt6k/7ffnjhMdgCX0hkH5iHo=;
        b=OPkvIDZHpNQ2aZRDl8fTBufXZvkkqvVxtt9igzT99A4cBXbk0Z9uEXhRlND/1VbNdl
         gsMr2fjJB82PQu6QpvUrtUqgRq5vDMB7Bx9yKPfrG1HX7yggd7mz6OqOo0/K38h8KAHK
         9bWKfhiTryiUfVwfXHjEt3zq39s4BykD5t0iSrixzcc7Gmsi8kWYiVRz28joOpY1pg6J
         9jhPDSNTevku0I6sJEZz8kR+4WURzbaOXTfKabfShIwikkrrSIlhGIrbenl5yBpEbUBW
         EoLiyL6QcZgKpIFVjSCrVfOoKinAwNG08XhMWfzjrHZhUVZ1pyFVlwr8Mo1DeijeJdU+
         4voQ==
X-Gm-Message-State: AOJu0YyPju+E/tVv/7PyzaKYwGV5EsEbWy2DxMysEAOFcLyey4xUuaHj
        wo6IivGxmo4JLiUILrVAxEnBHQ==
X-Google-Smtp-Source: AGHT+IG2+V3ovERFSNRh2TJnHp7bmnc2t+ohxyCJ+0Ga2lzbOUtZb2Vh2Xpa+KUMrIz6w31sbVO6Mg==
X-Received: by 2002:a05:6512:313a:b0:509:3bba:e8a with SMTP id p26-20020a056512313a00b005093bba0e8amr3570628lfd.39.1699608922950;
        Fri, 10 Nov 2023 01:35:22 -0800 (PST)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id g5-20020adff405000000b003313439c675sm1511328wro.66.2023.11.10.01.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 01:35:22 -0800 (PST)
Message-ID: <bdc876bf-78a0-4dea-b090-5fbff5917deb@linaro.org>
Date:   Fri, 10 Nov 2023 10:35:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 6/7] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
Content-Language: en-US, fr
To:     Can Guo <quic_cang@quicinc.com>, Can Guo <cang@qti.qualcomm.com>,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-7-git-send-email-cang@qti.qualcomm.com>
 <e4bafeaf-bbeb-4990-b6f2-497159995910@linaro.org>
 <c3fb1fa1-4ba6-613f-a545-79e0e4b2658f@quicinc.com>
 <10cbb859-bdbf-4763-9887-fa13003b58cd@linaro.org>
 <44554283-8436-2208-ab75-3e61d89dc96b@quicinc.com>
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
In-Reply-To: <44554283-8436-2208-ab75-3e61d89dc96b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2023 10:32, Can Guo wrote:
> Hi Neil,
> 
> On 11/10/2023 5:17 PM, neil.armstrong@linaro.org wrote:
>> Hi,
>>
>> On 10/11/2023 10:03, Can Guo wrote:
>>> Hi Neil,
>>>
>>> On 11/10/2023 4:47 PM, neil.armstrong@linaro.org wrote:
>>>> Hi,
>>>>
>>>> On 07/11/2023 05:46, Can Guo wrote:
>>>>> From: Can Guo <quic_cang@quicinc.com>
>>>>>
>>>>> On SM8550, two sets of UFS PHY settings are provided, one set is to support
>>>>> HS-G5, another set is to support HS-G4 and lower gears. The two sets of PHY
>>>>> settings are programming different values to different registers, mixing
>>>>> the two sets and/or overwriting one set with another set is definitely not
>>>>> blessed by UFS PHY designers. In order to add HS-G5 support for SM8550, we
>>>>> need to split the two sets into their dedicated tables, and leave only the
>>>>> common settings in the .tlbs. To have the PHY programmed with the correct
>>>>> set of PHY settings, the submode passed to PHY driver must be either HS-G4
>>>>> or HS-G5.
>>>>
>>>> I guess I'll need to rebase my SM8650 UFS PHY driver to support both G4 and G5 modes
>>>> at some point ?
>>>
>>>
>>> Thank for reaching out. Yes, please.
>>>
>>> I can help review the PHY settings.
>>
>> Ok I'll try rebasing on this serie and add G5 support.
>>
>>>
>>> BTW, are you enabling MCQ (by adding MCQ related DT) at the same time?
>>
>> I tested MCQ but it triggers the same issues we have with suspend/resume on SM8550 & SM8650,
>> and the bindings are not present of the UFS qcom node.
> 
> Are you talking about suspend/resume fail with rpm/spm_lvl == 5? If yes, then Nitin and Naveen are working on fixing it.

Exact, if you have some changes for me to test, I'll be happy to have a run on 8550 and 8650.

> 
> If you have plan to enable UFS MCQ on SM8650 later, please let me know, I have some BUG fixes for it, we can co-work.

Yes I plan to when basic SM8650 support gets merged, same I'm able to test some changes if needed.

Neil

> 
> Thanks,
> Can Guo
> 
>>
>> Neil
>>
>>>
>>> Thanks,
>>> Can Guo.
>>>
>>>>
>>>> Neil
>>>>
>>

