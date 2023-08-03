Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A512976F058
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjHCRKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjHCRKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:10:13 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4B3C16;
        Thu,  3 Aug 2023 10:09:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe1344b707so1996222e87.1;
        Thu, 03 Aug 2023 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691082577; x=1691687377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdX+NfKio0pdth/b1d1o4UZ72iZouUkmJiyFwK8qVRA=;
        b=nksi91tjevvMMgNWYlvmcgOmPIdGTqnFBRLPCT4P4lOdETDuOkwWnO1rHuCIfdw4CU
         GcZ4/CN57hMzWYbmPQywctjcJiI6QLL2u2cW0ZoTXswXkLWmHQXGEJRorLkVQx4DdS/9
         fTR1zwTefMbODzpnwr0ea1j+KnCP1lVgeFeRmR1ahJdNHssrp/+w7Zv8EYy6JzzOQZFL
         WDsPSgZDXxS5qPjVOOm3DAa72J8KEcK/wPQN8f6cMTCnr4EE2RjQjmxiskVQTsZqGzTP
         fDYQxueX3vSXC17ZthaXEJpuMVsUTKS5YFORjBJyJvGph5vXDuKB+HgTdCS7+OfcE4A7
         C9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691082577; x=1691687377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdX+NfKio0pdth/b1d1o4UZ72iZouUkmJiyFwK8qVRA=;
        b=LYHmlLkDRQvZ5v68BiEB/Eukoft1KTg51LAPknVv6qFZz+FFi2a6ytTsMnVNMUSmhV
         sxoHam72V7u9Qu++x1TIw4RWyANVjUS/ZzXw5mr+EPjxNqwdvvK1xtdAX8Lm3QqYtIMO
         5EzeU15YEPvSoWyAOcqpdphxNF/6aPIbcmDS5sFtciUSp4FthVQEVDPy3NazbRix8pBt
         Dwyt4uSpSWVNQ/rBsvZL5ox9ckRkNw7cASyDs/YCKW1EMTv0toDj7FhA3Wwin3339efr
         S781akRZJFsm4cx7nSzle/2B+Xyq8yluWTUj4aTn99izQga71oo2TGwgcJU+mngDFn9F
         v/ZQ==
X-Gm-Message-State: ABy/qLatb61zhHqweIwx6MYn1myftQgA6t36/swc3KlBF1L72dVN+4GY
        TfSfHYYHnlXpSH7CtyI9APM=
X-Google-Smtp-Source: APBJJlGhRWoXCW3zb8xv6o2L/pb2FkVE77i5R/jy7yvFiOJbKfQhEbkYqdBs0TwL3XUgT12uDeagtA==
X-Received: by 2002:a19:5005:0:b0:4fe:19ef:8795 with SMTP id e5-20020a195005000000b004fe19ef8795mr7081713lfb.64.1691082576831;
        Thu, 03 Aug 2023 10:09:36 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id d13-20020a50fe8d000000b0051e1660a34esm49538edt.51.2023.08.03.10.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 10:09:36 -0700 (PDT)
Message-ID: <b8b82aee-45a5-5e56-1737-4ec78f6279c2@gmail.com>
Date:   Thu, 3 Aug 2023 19:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] firmware: Add support for Qualcomm UEFI Secure
 Application
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
 <20230730161906.606163-4-luzmaximilian@gmail.com>
 <CAMj1kXHOaEuP2Wds9ZU4RLx9oKhthvE=yR-Ju_Ka2boqTmTYNw@mail.gmail.com>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAMj1kXHOaEuP2Wds9ZU4RLx9oKhthvE=yR-Ju_Ka2boqTmTYNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 17:44, Ard Biesheuvel wrote:
> On Sun, 30 Jul 2023 at 18:19, Maximilian Luz <luzmaximilian@gmail.com> wrote:

[...]

>> +/* -- Driver setup. --------------------------------------------------------- */
>> +
>> +static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
>> +                                const struct auxiliary_device_id *aux_dev_id)
>> +{
>> +       struct qcuefi_client *qcuefi;
>> +       int status;
>> +
>> +       qcuefi = devm_kzalloc(&aux_dev->dev, sizeof(*qcuefi), GFP_KERNEL);
>> +       if (!qcuefi)
>> +               return -ENOMEM;
>> +
>> +       qcuefi->client = container_of(aux_dev, struct qseecom_client, aux_dev);
>> +
>> +       auxiliary_set_drvdata(aux_dev, qcuefi);
>> +       status = qcuefi_set_reference(qcuefi);
>> +       if (status)
>> +               return status;
>> +
>> +       status = efivars_register(&qcuefi->efivars, &qcom_efivar_ops);
> 
> Will this also work if the EFI runtime services were already
> registered by the time we reach this point?

That's actually a good question. In short: No. However, let me explain
that a bit:

First, we assume that we're the only other non-generic provider
(arguably, multiple non-generic providers don't make much sense on a
single platform anyway, so I'd say in that case it's okay to fail here).

Second, we assume that the generic ops are not going to be registered at
all on the platforms that this implementation is used. In particular, on
the platforms I've tested and heard reports from so far, "standard"
efivars either aren't actively advertised as "supported" or they return
EFI_UNSUPPORTED for all calls. So we assume that either the check in
efisubsys_init() or in generic_ops_supported() prevents registration
of the generic ops.

Further, I'd hope that the uefisecapp would not be loaded if generic ops
would be supported on such a platform, thus preventing instantiation of
the respective client device.

So the only issue that I can see is that if uefisecapp is loaded and
generic ops are supported, we would need a way to choose one over the
other. But I think that is fairly unlikely to happen and I think it
would probably be best to sort that out then (e.g. by refusing to load
this new driver with some additional check).

Apart from that case, there should not be any timing issues that could
cause registration to fail spuriously.

Regards
Max
