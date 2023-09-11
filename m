Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB9679B3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353608AbjIKVrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbjIKJqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:46:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC32E4B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5009d4a4897so7121741e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694425584; x=1695030384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVd11RHi3QFilUBHjU00d5ZhZ23EKtBEFJIkR9qPnqI=;
        b=p3Yft8uZgnqnlV0n2qBp1KG8aWzm6GwMEF5m4LwpgH7j59aNMPCv4/iOHWgjvAXBMR
         4h3sX0ySoIhDxEoe5W6NyxMGIHb/iESoe1E4p3awdKpo6s9CzwN0dqQZrHlVsImU0clU
         G7bbRlVGv6DwPQJ2BENA93RcAw+qpldvoE/e7eZndeseQy/nRfDtx3CJw+cenObY+ZRJ
         OZwWFVi7L3ZP+c+dfZNKWpDSy0vFX57kVkomLRuj9Clf2TaFlj4CfM0KQrHf+Ypc4knF
         lFs7O36nIMfmF2aV6QsqPMIA4xngAwaRUKI2PX44zMEp9x8TqBCT3e6YzBUamf1Ntf+V
         gV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425584; x=1695030384;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVd11RHi3QFilUBHjU00d5ZhZ23EKtBEFJIkR9qPnqI=;
        b=IGjNHFRR8En/fCa+rLLduqutX8MYQAqT3kTY8kvsz9loD2XKwzn33H4b9XrKyq5sL2
         n87caMV9OVLlzh/OCyQe6AUqY/yPwBBXCaql6TCCcrtzLr9Xw1L5au8HhOMZvqtlYAiF
         202LQrw1sbHehpFDjYzDJExrPAeDUB645MM7rOIybR824YPD7WPYPec+au5X4SqFW8aq
         l57ofOU2hhfEdfcuwkE2dmbyPxz7+XqR3fKfHN+lDPMfM2oRCdXYD7B8sMf8D0Cdx9xY
         hr4eoMIYGUk7kxjlrcwJDKBGc54oM5mYQFAche+AsKuxd41n34u8BrzvKdJVbj712FmE
         PKTQ==
X-Gm-Message-State: AOJu0Yz4zsfGNOhb8yWUxGmBLWFTVyPSyDCGHlMsMyOow8cIs7q0xVeo
        TTd6BKDfjpviEzha2XqiTBqpKg==
X-Google-Smtp-Source: AGHT+IF6e7LCXAYSeQSvEKbbuvVGlfF4fTaSqGpUJS2I7Qrq7ixXgSnRRAiOQ4jtvT1DD3aHjqTJmg==
X-Received: by 2002:a05:6512:3b25:b0:4ff:a25b:bca1 with SMTP id f37-20020a0565123b2500b004ffa25bbca1mr8830096lfv.33.1694425583740;
        Mon, 11 Sep 2023 02:46:23 -0700 (PDT)
Received: from [192.168.37.232] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id x18-20020aa7d6d2000000b005257f90c976sm4377665edr.3.2023.09.11.02.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 02:46:23 -0700 (PDT)
Message-ID: <31823dc4-6f50-435b-9a20-66471209ec31@linaro.org>
Date:   Mon, 11 Sep 2023 11:46:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, mani@kernel.org,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-3-git-send-email-quic_cang@quicinc.com>
 <6055cd57-4de7-4b7e-a4f3-68a7de1aef28@linaro.org>
 <6225a132-4b7f-bbb4-e863-4e62b99dd79d@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <6225a132-4b7f-bbb4-e863-4e62b99dd79d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.2023 11:42, Can Guo wrote:
> Hi Konrad,
> 
> On 9/11/2023 5:17 PM, Konrad Dybcio wrote:
>> On 11.09.2023 07:59, Can Guo wrote:
>>> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
>>>
>>> Retrieve UFS device version from UFS host controller's spare register
>>> which is populated by bootloader, and use the UFS device version together
>>> with host controller's HW version to decide the proper power modes which
>>> should be used to configure the UFS PHY.
>> That sounds a bit fishy.. is there no bootloader-independent
>> solution to that? Can't we bring in the code that the bootloader
>> uses to determine these values?
>>
>> Konrad
> 
> 
> Agree, it is.
> 
> 
> All these complexities come from one request from PHY design team - power saving.
> 
> And to achieve power saving, Qualcomm UFS developers are requested to use the
> 
> lowest hanging PHY settings which can sustain the Max agreed HS Gear (btw host
> 
> and UFS device) during UFS's lifecycle in High Level OS,  whereas the power saving
> 
> request does not apply to bootloader, which works for only a few seconds during
> 
> bootup. Hence, there is no such version detect code in bootloader -  it just uses the
> 
> highest PHY settings to configure PHY, boot up UFS and put UFS device version in this
> 
> register.
First of all, your email client seems to be inserting 2 newlines
instead of 1. If you're using thunderbird, you may want to edit:

mail.identity.(default or your mail identity idx).default.compose_html

to `false`

and add that to your internal wiki page, as I see many @quic folks having
this issue.


Going back to the main topic, I don't think we understood each other.
The commit message states:


"Retrieve UFS device version from UFS host controller's spare register
which is populated by bootloader"


Which means the bootloader is able to somehow determine the value
that's in the spare register and write it there.

I'm asking whether we can take the logic behind this value and
move it to Linux so that we don't depend on the bootloader to
guarantee it (e.g. Chrome or some other devices with more exotic
fw may not work this way).


Konrad
