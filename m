Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0578B4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjH1Pn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjH1PnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:43:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCF8E1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:43:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so2851654f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693237390; x=1693842190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSVBmNKujJMQyMHeBx+QDenvXtOk8bzLGjMqef3Lc3A=;
        b=uKtFQpqf66SmeVq5sIOJaWRGTq95bgboD8NuNJnDkrAZjvlXOPCPqr68JIsJNaMYta
         aA3nPK/5TZoDoLFz9u3tKE13J93psQY1HOBjk0d9nKT0aYRQ9R1Zx/sJ7LLAPExUHHT5
         PAHPIHJC15OdJ7/hp3NVYpM4DWysNQeBV6FcIg3zPu1/8AbILIdySZK3sMvGmfKTVC14
         C+mFGlGb7nVx8Lr6dIw+sxWiHIECEF2PUZiUuMrEBd6idB3CRqDhScbyPqhJDYSdyhh7
         owLgCvnxtMgc/fk2gt3fnGVUs2uZRjmym/iE3YygqsN0kS8ulectsRRDGYW1ofV3zImj
         92VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693237390; x=1693842190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSVBmNKujJMQyMHeBx+QDenvXtOk8bzLGjMqef3Lc3A=;
        b=U6kXIDN7Muw+JhgsmddRI2DavLOZ7b4R+UkkVShCLvPgTm4hCNhOMAZMMGgNWK+inG
         H8YpLp2HNdP0ei2keRB0wLhdiusPP6uKdbdzCznfiCGTTxmvJoMZCyyKRBTPvokZSmWG
         b1V0beHKTcWk/UihOlQcUT41y1L3T4eyOkAt26fqvtfE91iRip67u8vtTfyBP0ZAvqqP
         MzXODLCI2xbQILLgvUoeYwQlR1w71VgcVvpIADY0SxaSdskkbTI5vYQuYfhGu7xqHXdd
         ITTyVEKhiyFTffwJtZvBia5t0WUGWgKc2gZdKs9bQO4gISXO/NWzv5kPiQSYm9X0iIPz
         rvJw==
X-Gm-Message-State: AOJu0Yxrf2il0dT5QtSh8UMPl6ig0dIFUMYf4WgNbFdNhZfsUPFOqj7d
        JWmialZ4BuUsHhfDNL6SdVmkGA==
X-Google-Smtp-Source: AGHT+IGHWv17wOn1PsuOg4xzx66jRgR52+uidM3fz9INq+GahoiA1e9phDRKx5/MX/0nK8rTrov0mA==
X-Received: by 2002:adf:e68d:0:b0:31a:d48d:9b97 with SMTP id r13-20020adfe68d000000b0031ad48d9b97mr20851745wrm.5.1693237390048;
        Mon, 28 Aug 2023 08:43:10 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id x7-20020a1c7c07000000b003ffca80edb8sm11181146wmc.15.2023.08.28.08.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 08:43:09 -0700 (PDT)
Message-ID: <2d26595f-8a74-04a5-b62b-c4383ffa7dc8@linaro.org>
Date:   Mon, 28 Aug 2023 16:43:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 15/15] media: qcom: camss: Comment CSID dt_id field
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-16-bryan.odonoghue@linaro.org>
 <4929aa72-a134-4eeb-850e-46d9255c011b@linaro.org>
 <b4545982-af6c-5460-d662-36b0eb80bb4e@linaro.org>
 <8310417c-bba9-49ed-9049-bee5b23c2e3f@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <8310417c-bba9-49ed-9049-bee5b23c2e3f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 16:38, Konrad Dybcio wrote:
> On 28.08.2023 17:34, Bryan O'Donoghue wrote:
>> On 26/08/2023 11:18, Konrad Dybcio wrote:
>>>> +        /*
>>>> +         * A value caled 'CID' gets generated internal to CAMSS logic
>>>> +         * which is a concatenation of [vc:6 | dt_id:2] hence we reuse
>>>> +         * the least significant two bits of the VC to 'stuff' the CID value.
>>>> +         */
>>>>            u8 dt_id = vc;
>>> And where are you discarding the non-2-lsb?
>>
>> At the assignment of dt_id
>>
>> vc:6
>> dt_id:2
>>
>> =>
>>
>> cid:8 = [vc:6 | dt_id:2]
>> vc == 00110110
>> cid = [110110 | 10]
>>
>> I have no more information what CID is or how the bitfield is populated than I have already indicated in the comment/commit log.
>>
> OK so you're discarding the 2 lsb of the [vc:6|dt_id:2]
> 
> however
> 
> the way I read the comment would suggest that you're taking
> vc[6:2]
> 
> Konrad

Fair enough, obvs the comment needs work so.

---
bod
