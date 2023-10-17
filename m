Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8DD7CC89A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343584AbjJQQSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjJQQSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:18:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839CEFA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:18:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d9effe314so3504486f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697559522; x=1698164322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lF/xhtEmkt32W02v9Ks3r21OU8ykW4jEkwDZ1zIzjDs=;
        b=mfL6LNBeAXxrXh301emgtLaoO9VZhEM0nvDiHo3ovpxKpJN5C/I6g7zWXOLlNn7TKz
         fV2utESbVU+Gw07jNUKVLWdMNetbguFGusUnsYInzvQzNm9Uf8xcLxPycFAm4/4Qv/43
         0iDFrdFhOAyOg95PG8bJGrvbvkniB0zDCwPb2aNnpX7Yd7rFJK6NzT2yA2aaDLOknYAg
         WfbaG29mPKZqa1b+aPKwzP/bjz0DWwHEPSXnlbEpRAADf6sJozLouRRnIUWSTU1G8IfP
         p+ezMYC0LQL6nDkFWYFlhQBZLuUCywmyng4HorAe4blLFYUcm66zHDnulHqzHxwF2HPe
         m9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697559522; x=1698164322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lF/xhtEmkt32W02v9Ks3r21OU8ykW4jEkwDZ1zIzjDs=;
        b=AR2dyAmmDdbE6OA9dHd67xsscabtOLE9cwZEksypAzQGBOqbjrzMjB95TKnITwFfCd
         JRr82CToZY3O04ORglrPXfzECZT3FbLGrdwW0YWLJLsINTZglDHD/fVkz/uTKqFLWjcz
         Vxd7Ow//WRhMulRSdSKlVY3Q4eKiUU1kfzIeMQV5+oH+TsoaaMMS35d0VTNua1vuD2P4
         jjMwV7h42ldV/qCnxl+UioLLofRNCksG6/Ywt/YiaZO0fumBQ5OeSYXrlSMB2oTD5ogI
         w0xa35YYtbsjWJ+UgPN/qQzSBhxKTrkyx99SvcLg474GABbQgPtfUATQY2gXMKChlnPy
         3lPg==
X-Gm-Message-State: AOJu0YyXwDrcQQRVaeCTer8TDhP0gwLVALP2axEI+ifrnLjNvGFtQm8u
        gbkgYCEFggClre04meEcOxu7yXOyX2t3EG096v4=
X-Google-Smtp-Source: AGHT+IHNYU71aP1f+DVsqkhe9ad773k2KY0LYMnkOZBZdzjSEBq6OefuWUqQzYnepa60GVzU06Lr3A==
X-Received: by 2002:adf:fc91:0:b0:32d:a7b0:62b with SMTP id g17-20020adffc91000000b0032da7b0062bmr2275425wrr.26.1697559521926;
        Tue, 17 Oct 2023 09:18:41 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d18-20020a056000115200b003217cbab88bsm112516wrx.16.2023.10.17.09.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:18:41 -0700 (PDT)
Message-ID: <9008f2df-9936-425b-b702-02f720dcd5b2@linaro.org>
Date:   Tue, 17 Oct 2023 18:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] usb: dwc3: qcom: Inline the qscratch constants
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-8-ab4a84165470@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231016-dwc3-refactor-v1-8-ab4a84165470@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/23 05:11, Bjorn Andersson wrote:
> The two constants for the offset and size of the qscratch block within
> the DWC3 region has the same value in all supported variants, so they
> don't necessarily need to be picked dynamically.
> 
> By replacing the lookup with the constants it's possible to reuse the
> same code path without the ACPI pdata structure in the upcoming commit.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
If we don't want more non-flagship-SoC-based post-sdm845 ACPI-supported 
platforms, using just one of N USB controllers

which I am very happy that we don't

so much so that I'd be even happy to drop this acpi thing altogether

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
