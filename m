Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0AB7A9F91
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjIUUYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjIUUX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:23:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08EF8A6A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:11:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so602007a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316258; x=1695921058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7gFQeovCOqyG+Vt42B/k9KqcPKnAtH77aTFoPbh9E0=;
        b=yS0nIQqmyBoPffpV7C/mZlvStooBS9QmQqfE71OyfIDbJK2g4mknm/ZvSURtGo45kR
         jjqXLWJrMeGMzbd+3eVxHMIzNJeblsTCGMryPFZrZ9krFQn4c0xHGFi/QemUI6GvdstF
         6O7nPxlJfDOdCwGohvoURnM8ZodFIPNIMB7RAO4EyAycvITfyHhFN2DMRbY5q1pfbE1E
         0SAxa/8WJMjsRXmQfxEfsM7I48JzlzdY/ltjH2pkbdWwhyqSfJ85WzS312ewLfCl19G+
         1L+u0S4Z5J+l0OLCUvVAhxx5wJQsxchR0EeV4WHPqgOcGUdc1FLeWPOzsvJ3VCxxLfQY
         MjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316258; x=1695921058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7gFQeovCOqyG+Vt42B/k9KqcPKnAtH77aTFoPbh9E0=;
        b=PZJbOPWOHVhDTPMWjWubchE+b8RwWI0QkQ3qCDXaD8gumReTwyDKLE7lw0LMrHfsoF
         n2rOcZOlzf4+WIi6QBkYPBZvQQu9HTjT/ERNFCUnoNBlIz06dsvwCMgrdGEAzYtLc7vE
         4SsQe3CAGRsanLHkMuLjxg6lVS+nLLnOIf8DOVzmCBCS4BatjSdCDNtcVIJYDHCd2ETU
         FNzGjGNrXQwRktHs/mBfjQh1MPCaP9SnWAXrkkyMEqmJUzMsx9OUcLn9njzyB7ctMN34
         nodDNurXDugvvhlk9tcMd+FTed0K+M5lqdkXpXC1IeMbKbV2trMiktmlZzh/PbTESV4k
         aFng==
X-Gm-Message-State: AOJu0YxxhF8+5FDcQFIuDZ6GnU0QNDkhcf/WZ1tVgU6WpAY4wChOTCfY
        xAiq7JCcGQBLM233jTVM1EUT4N+dh85reJ+0391Sxg==
X-Google-Smtp-Source: AGHT+IHjIQkVJQybbyYx/PL2aE6OMJIhMwgKGQdYG4h1ptw97QpAlXlx1ORnozqq/yIgm5Zhfz1miQ==
X-Received: by 2002:a17:906:704d:b0:9a1:c42e:5e5e with SMTP id r13-20020a170906704d00b009a1c42e5e5emr3859123ejj.42.1695281319261;
        Thu, 21 Sep 2023 00:28:39 -0700 (PDT)
Received: from [172.20.15.189] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id a24-20020a170906245800b0098963eb0c3dsm616369ejb.26.2023.09.21.00.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:28:38 -0700 (PDT)
Message-ID: <2ec21b71-bfdc-885f-827a-eca7b70f2728@linaro.org>
Date:   Thu, 21 Sep 2023 09:28:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/3] soc: qcom: rmtfs: Support discarding guard pages
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230920-rmtfs-mem-guard-pages-v3-0-305b37219b78@quicinc.com>
 <20230920-rmtfs-mem-guard-pages-v3-2-305b37219b78@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230920-rmtfs-mem-guard-pages-v3-2-305b37219b78@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/23 04:37, Bjorn Andersson wrote:
> In some configurations, the exact placement of the rmtfs shared memory
> region isn't so strict. The DeviceTree author can then choose to use the
> "size" property and rely on the OS for placement (in combination with
> "alloc-ranges", if desired).
> 
> But on some platforms the rmtfs memory region may not be allocated
> adjacent to regions allocated by other clients. Add support for
> discarding the first and last 4k block in the region, if
> qcom,use-guard-pages is specified in DeviceTree.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
I don't want to block this anymore, but I guess I should ask
the question whether it would be valuable to add a common
reserved-memory property for e.g. low-padding and high-padding

Have we seen cases of that outside rmtfs?

Konrad
