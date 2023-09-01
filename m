Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05E778FD10
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349387AbjIAMUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbjIAMUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:20:45 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E01E7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:20:42 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcc331f942so22353311fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693570840; x=1694175640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wRixf5Wln0+aq96AqT15WNRlI0DI7acs2jHkGoyqUC4=;
        b=WJ2qRpi9cgKouMXABSj9ZSCukBo2/90W1bGsAjIYK6M6inoaHNxUDlTWuqGGnCkwlx
         PRNDmkmsNTmQKc0O3h8y1ag94/2GQ8EldP3jt6oWM8ymoJFYf5tEMfovYC/zJ6V+/EXf
         J5Zz1d9ZDsFnXSlABTE3FDvvXV5+UnZnAwvueAxMBFRH82SwL889itCbRXH8yoLac78r
         0pm96l2q+i5hiMsL0D2enTjKJJQvGaYQS5BfS107t7Dktbu6gk9PPhpt+sve7edoK7LA
         KuCx8no1pS4/bhBvZ4CLejyotf++fGRydED7XZULOOF/f3SSaj/RtIQqfga9qK4k1cV/
         ATwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693570840; x=1694175640;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRixf5Wln0+aq96AqT15WNRlI0DI7acs2jHkGoyqUC4=;
        b=AFXrPVhESMpzbCmGffVDiBCmZWASmKHoNkdt6zIwcUdpDvdsnClq4g6YT+E8zPBV5a
         MD4TKFr8FCWgsNZH12tbH5ifw5O6nBeYINQgeqWLAwHGO7qzbwW20lBW4RIb6C7QCyXM
         mDI9VT9TmF4k+oJKbtAUvh1H2y8l9rAaYKU/BCvU/b80klwD/ElhuKj+uJorSIJ5M5t2
         gSuoK5e2bwQ3B/dfzntdQyMNuDGtNzADDzllAFHeUhqICynyF0YMVcqld0Jd8vurjsD6
         7sY4cTUXoSbAWBthFY0zGqCgFuPpCmDXggntG8IqNK2UQk79mmGCQFIaJNp2aGKeuSeU
         UuIA==
X-Gm-Message-State: AOJu0YwdMzr2cjRx51zK8eDCzrm0Fk4KdO/eFAimeUUlRpeaMg1Xv46H
        VVo6WvqWUSOKl0IgG41LT8KWig==
X-Google-Smtp-Source: AGHT+IE4Z/ktQ6qMzlFSopP5r6fYP4i40xwCpIZt9FemIrY+cUooZOn6b31azRQy3vMZowlZJS3F8g==
X-Received: by 2002:a05:651c:339:b0:2bc:fbc9:c0a2 with SMTP id b25-20020a05651c033900b002bcfbc9c0a2mr1879201ljp.16.1693570840584;
        Fri, 01 Sep 2023 05:20:40 -0700 (PDT)
Received: from [192.168.1.101] (abxh154.neoplus.adsl.tpnet.pl. [83.9.1.154])
        by smtp.gmail.com with ESMTPSA id d25-20020a2eb059000000b002bcc4d64758sm733680ljl.103.2023.09.01.05.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 05:20:40 -0700 (PDT)
Message-ID: <88964c63-950f-4d68-826b-f3b7243a2c5f@linaro.org>
Date:   Fri, 1 Sep 2023 14:20:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 0/6] scsi: ufs: qcom: Align programming sequence as per
 HW spec
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, mani@kernel.org,
        agross@kernel.org, andersson@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.09.2023 13:43, Nitin Rawat wrote:
> This patch aligns programming sequence as per Qualcomm UFS
> hardware specification.
> 
> changes from v5:
> - Addressed Mani comment to FIELD_PREP and FIELD_FIT.
> - Optimised ufs_qcom_set_core_clk_ctrl API.
> - Updated commit text for few patches to capture more details.
> 
Any reason I received this twice?

Konrad
