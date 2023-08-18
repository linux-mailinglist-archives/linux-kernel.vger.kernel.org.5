Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153A5780BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376935AbjHRM3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376911AbjHRM3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:29:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C2510E6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:29:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ff9121fd29so1217674e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692361761; x=1692966561;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j4GDMSuzBUkJN6vb3YDloQ10Pm7mdblojzb+ZXz5JBk=;
        b=X1Y/kmc5+4lIINHmlD0KLxCNbWt5DwPNv7EEXkyIjnS2Ovxvrtzwr3JXIvMBBo6k7R
         /RozwlP+KROydUGTMfWwW8CrtxQ8k3hwntO8oKgQTJWW+HBB66TkE2XYt+Ze16HRZxbF
         1AGt3isnN7h0K3/VYXWFKoQSnJZUewQp32ObBW6U9uvDAwvPvVH6w/jv31kcg6kakvEC
         i2NVBn+rmrxTaflJj03xLpKAwMiHBvTCG3N3jvdbRQ1CfsAHXUixl69vKCZwCsEzbkjH
         7f+Hg4EuI7/2Fwp1nMIUNuTrfPC92zUTWdiplnulG8V86GpiWAstsiTdhx2+LhWzXNSp
         /cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692361761; x=1692966561;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4GDMSuzBUkJN6vb3YDloQ10Pm7mdblojzb+ZXz5JBk=;
        b=JAn4LvfhWf+16XZXT6GEoCnsomk3mc+2Anmm5A8foIjgx3YvrEsNoAz9l5Y9FrdZZS
         DYhJ9bx6kdZ7BlecUFJqBkQVhq6jTwVnaud8vbZoAGbXm3alqOJ+G9WiucVfjZ7VvbM1
         OfUugUUTYXsAuFb31vuYZJwryxDxur16n02l7xk3jLfJJLWqS58cT0s3XRyzpleU3zok
         UJ05L13XiE/Gku+lJ1Wtvaq7bJoq/bu3aGYVqn/s/PB4+nkzPOlbkInI0IoajPycibHA
         14JT8NSu+E1oTsNJJ+xmYDbakSVVUB2PB2chd4wFKL+7gh/sG8oKkGFAXaJ9ziz+1jMC
         5jQQ==
X-Gm-Message-State: AOJu0YzwZ3B3BciXP0T/+jMvGcBs66tyugvwGurUm1IfdyMdl9MbuZbl
        crDcTULGlvDRkmcqYZlCbg1k6g==
X-Google-Smtp-Source: AGHT+IG69HWQtnYs+CSy9vMa3/6SjDlDWFcvjF3pYlNyzKb5yEjKVA/zaTO6w5pTNdbSubYZGIi2mA==
X-Received: by 2002:a19:4f5e:0:b0:4fe:5860:7abe with SMTP id a30-20020a194f5e000000b004fe58607abemr1533689lfk.7.1692361760811;
        Fri, 18 Aug 2023 05:29:20 -0700 (PDT)
Received: from [192.168.1.101] (abxh52.neoplus.adsl.tpnet.pl. [83.9.1.52])
        by smtp.gmail.com with ESMTPSA id q4-20020ac25284000000b004fbf5242e8bsm326070lfm.231.2023.08.18.05.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 05:29:20 -0700 (PDT)
Message-ID: <4d14de78-16a9-4720-9422-b684f261df01@linaro.org>
Date:   Fri, 18 Aug 2023 14:29:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] media: qcom: camss: Use >= CAMSS_SDM845 for
 vfe_get/vfe_put
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
 <20230817143812.677554-8-bryan.odonoghue@linaro.org>
 <f1a8e7db-ce26-4bdc-beb6-00ae4f0baa78@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <f1a8e7db-ce26-4bdc-beb6-00ae4f0baa78@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.2023 14:28, Konrad Dybcio wrote:
> On 17.08.2023 16:38, Bryan O'Donoghue wrote:
>> From sdm845 onwards we need to ensure the VFE is powered on prior to
>> switching on the CSID.
>>
>> Alternatively we could model up the GDSCs and clocks the CSID needs
>> without the VFE but, there's a real question of the legitimacy of such a
>> use-case.
>>
>> For now drawing a line at sdm845 and switching on the associated VFEs is
>> a perfectly valid thing to do.
>>
>> Rather than continually extend out this clause for at least two new SoCs
>> with this same model - making the vfe_get/vfe_put path start to look
>> like spaghetti we can simply test for >= sdm845 here.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
> Using >= here is veeery arbitrary and depends on the next person
> adding a SoC in chronological, or used-tech-chronological order
> correctly.. Not a fan!

Perhaps some sort of a compatible-bound flag would be better suited

Konrad
