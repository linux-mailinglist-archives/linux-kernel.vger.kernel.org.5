Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B86477BB55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjHNOQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjHNOP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:15:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB719B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:15:32 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso44445265e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692022530; x=1692627330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53j/5094r03iKS4uZK9mu72IHMP5gEBY2aqqyAGJwsg=;
        b=jQYADeKY/FfySjh679B5lqdzESsU3vaZWyIkn8/2CkdsmPygJKKPulBPVuvIK/rVJT
         ZYuXqhNJsmql/F6vi8zujMzC4xtzqhgWLQRfBoaxCl2JWsNrIua1zi4ySrgKq1+nL5V8
         taqIUgJmfSw7Mje+yOybUDxE97OjiEZsWm1/XfS5mDQWhw47SxQqItQ4CkqCKtGFuydy
         DqOoNwL6eenKYoGIaVKJOm5Nxnh2Zq+Mv7fzdgda1l8uCC6DH/pap+U9rN2CUbWShxxn
         W2vo2JfTP2EudCJJ0jUwI4kBCRKJE/xPvDS1b0zjobpxLuXKBQwUXNLTqcDmQmZcX9+k
         x3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692022530; x=1692627330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53j/5094r03iKS4uZK9mu72IHMP5gEBY2aqqyAGJwsg=;
        b=chof9L9lKnw87LRI12ETrWdRSM5jWOMG4iSq3/eWWK0wTZb9JiQd8pUSB751X1sgBA
         mrcn6uDBQPc7apK6Y7Bkgwom5R9sWQkzYZQLmABhX5oR+JShqxM3GprepSyYS7L73Qrq
         2AkSfPXZZsumzb8wR/pT7vSdHWEBphKO8Jou26xu8Nqyk8MTuUxF5gsHlKKnOCKDHUvA
         jWJud7D1mrrYaiQxDgFSriqUGI1sC1ZBtFtA0ASxhzUEIVsy0+OUezHZM1ZTodhcsY8H
         fM2qIoN4z0AhkDpD0TPpXxCvgnKkfsJW1zqRhmrJF0ZZdHX6JwvgZZGNMpxWTSaeqYxz
         7xMA==
X-Gm-Message-State: AOJu0Yy1KbG6pEZYW7LDxZoybqy+UEV1VDQ6SUhD1pK82MbXVkREuv+t
        B7ozh6aJuYGXRg+lDx9xlXKTcQ==
X-Google-Smtp-Source: AGHT+IGq98nhB7kEk3xjrvjG0zOByhEQOpwZY9relAnXA4NePzVIuBzhokeQ9etQcTU1AAyA7ZN+Mg==
X-Received: by 2002:a05:600c:230f:b0:3fa:964e:e85 with SMTP id 15-20020a05600c230f00b003fa964e0e85mr7764653wmo.5.1692022530328;
        Mon, 14 Aug 2023 07:15:30 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b003144b95e1ecsm14414401wrp.93.2023.08.14.07.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 07:15:29 -0700 (PDT)
Message-ID: <ea587bb1-8ff2-7a92-f948-fd932f6b2769@linaro.org>
Date:   Mon, 14 Aug 2023 15:15:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/4] venus: hfi_parser: Add check to keep the number of
 codecs within range
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, tfiga@chromium.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
 <1691634304-2158-5-git-send-email-quic_vgarodia@quicinc.com>
 <fec4a8c7-206f-7af8-4ea9-c919a677bf7e@linaro.org>
 <2214c31b-eca2-012e-a100-21252a724e7c@quicinc.com>
 <8b72ce47-c338-2061-f11a-c0a608686d8c@linaro.org>
 <e880da07-ccd4-e427-ed34-20b284dc7838@quicinc.com>
 <8f1a4ca0-dde8-fa5d-bca3-d317886609de@linaro.org>
 <060f4dbe-63d6-1c60-14ca-553bf1536e5a@quicinc.com>
 <c5f912a9-cc08-1645-ad04-c7a58c1e47ce@linaro.org>
 <cd9da205-ccdb-dc71-16a4-83b22ca7fcae@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <cd9da205-ccdb-dc71-16a4-83b22ca7fcae@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 07:34, Vikash Garodia wrote:
>> We have two loops that check for up to 32 indexes per loop. Why not have a
>> capabilities index that can accommodate all 64 bits ?
> Max codecs supported can be 32, which is also a very high number. At max the
> hardware supports 5-6 codecs, including both decoder and encoder. 64 indices is
> would not be needed.
> 

But the bug you are fixing here is an overflow where we have received a 
full range 32 bit for each decode and encode.

How is the right fix not to extend the storage to the maximum possible 2 
x 32 ? Or indeed why not constrain the input data to 32/2 for each 
encode/decode path ?

The bug here is that we can copy two arrays of size X into one array of 
size X.

Please consider expanding the size of the storage array to accommodate 
the full size the protocol supports 2 x 32.

---
bod
