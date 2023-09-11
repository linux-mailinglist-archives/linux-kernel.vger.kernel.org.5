Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD2279BF15
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349573AbjIKVd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjIKJRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:17:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508C0CD3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:17:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so71335021fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694423859; x=1695028659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JQH9ivnhVEuNYoZ7gWrE/2JTu+vTayND8NJxuSu5kuQ=;
        b=mgHYMS2RA1BDYgh+qsNoAhbltSkA4epdgjPimN9W8mrGjNRHrwKTKtAcjf3EC2c6qp
         zJK88O67LCLfVpr4zeoXXp+BWJhuOyvzEtwMfTC/ub/dhdZf+He/g/RfnAUi3fVKW2fp
         /Waz0OICsAGQQpflODoRjHwEDPj+4AS1iT8dReCpwilOFyKGkg11R8yCFpE4iISTT+B6
         LlEdrsaVxIFtw74OMHd5hC60HW5Po4Kb2CNSty9KyoOOQubZPpZDHOjkH8g2cIeeR7Jd
         OW+BBg08xnuSED3GyCASZkfp5567oQrU/EbzDhVwVAFdyNUIaYgsnQPyBoCmmlRFOXU+
         5z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694423859; x=1695028659;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQH9ivnhVEuNYoZ7gWrE/2JTu+vTayND8NJxuSu5kuQ=;
        b=vd6pJKVj3k78fgbbke+jsU/3ZZsFFnaZ/rQFyHyijjpwc9JVf4nE/Q06RWy2n0vlT1
         fo9J9FrQOtNlVAWFbhifVC1JQs7XKHfKQhZpTMl9TGuOQYbqxYcrAumkoWVwzQN5lHrn
         RFgmxkBlAjSUor6lQ6e+4hmlQ/4NUeO3gwKfiQ+ASfQiUCU8ZvevNMvwjTG9mdFv9JCS
         qqDzKKkBCeOhYLUucRVAIHuNGNkJf5isrX/sV3nkZapT7mOHsjrj8nfDgGN82pnBg5y6
         xEwX9HjMKQhsTj3QnKk3hnBqncKX39PNxVWRAPkkw29vixc2naRqIAjGciM28lLjO2cA
         b0kw==
X-Gm-Message-State: AOJu0YzIcmp7/MbUc1Sxtv0VUboZmNosarQROhwEeg2ebsXf4UdKMi7/
        7dSelIfJYTI/kGUIZ1yj6akvDg==
X-Google-Smtp-Source: AGHT+IEQbWgY9VKd4s2CeTD2F0I8xGKbPG1hks7s179vVqmQi67UpBcT0Z4xa+gu9MXya89Y9g3Z+w==
X-Received: by 2002:a2e:9783:0:b0:2bc:d582:e724 with SMTP id y3-20020a2e9783000000b002bcd582e724mr7008765lji.31.1694423859488;
        Mon, 11 Sep 2023 02:17:39 -0700 (PDT)
Received: from [192.168.37.41] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id lc1-20020a170906dfe100b00982a92a849asm5028765ejc.91.2023.09.11.02.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 02:17:39 -0700 (PDT)
Message-ID: <6055cd57-4de7-4b7e-a4f3-68a7de1aef28@linaro.org>
Date:   Mon, 11 Sep 2023 11:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
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
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1694411968-14413-3-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.2023 07:59, Can Guo wrote:
> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
> 
> Retrieve UFS device version from UFS host controller's spare register
> which is populated by bootloader, and use the UFS device version together
> with host controller's HW version to decide the proper power modes which
> should be used to configure the UFS PHY.
That sounds a bit fishy.. is there no bootloader-independent
solution to that? Can't we bring in the code that the bootloader
uses to determine these values?

Konrad
