Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA35F791D84
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbjIDTL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240889AbjIDTL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:11:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0EACDB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:11:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-317c3ac7339so1542928f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693854708; x=1694459508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8pEgA4HrkB9TGKJAWAP66UjBiQGMt4beUYVFuVhy4jg=;
        b=QJRE+B+/RlcvdOa4osdwyHIWZuLvVIoa23mvYTIjN+1pInHzLJmRJ9GnKoIr6StHT+
         2Z94cO0f2Z92LyplvrNR/4hMmeTW4ZFTTgqfpfQQBbM1/gy0+dZgvPNhyqviHjdoy92h
         BFMzmI+Iw01MTn5GCVCdN5Ytr/XLl5K0nfPSSL3UuxRnHpKKemQAmtvErWC7t/YqY4B0
         DrGWwyOsDnhplNBqnm37UsC/dhzBFTet32Eq+l/JAFkafCTNugxtID3KlaSnHWTfuJsE
         2RZLYPJRrpqTpXjo1sEoUuLKHK+ha7iamTr/+UzVRak4s7WrUGQWS69S/jRRoTyIM3fn
         x2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693854708; x=1694459508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pEgA4HrkB9TGKJAWAP66UjBiQGMt4beUYVFuVhy4jg=;
        b=D6dRlVXtPnhZNF8OWtD414QEUwA/pQIYrmDoDInmquQ/afgTvVxgHBFMxxXv3PA/p3
         qBObi0p4/GvLJcAe9T9Vn88wYBYDcYsFEttqV3bNNlJS30q6isyQof+Ebo6fL19oh1kg
         mMZKee3nLYsm0OL5XjqAtMQR/ZGahdUetfrPnKmYk1ML3KQImbCVK1P/AFqXh7x4m08V
         HgoSyFHBB0XeDQpLU9yUxd6pGoKHUVbtGr1CNnA5jY5toDMj4qhwSVxGferBZCbgrd1r
         G46WwPTXeecxoIEXq4XKfC5tIMjkhaLt+5/6T0T+iImIvLiglpVOdF2TuiyCHw2s3Bem
         YdVg==
X-Gm-Message-State: AOJu0YwZdGkessjilReD/T5/WXg1LW8iaGY5B+NFZCsqte76/LaAYq41
        OsA/8YdkoFxyTX1SuIG7WehldQ==
X-Google-Smtp-Source: AGHT+IHrmHb5QcFVu/TCsq1UWFkimGdZCJ405IMLyXpUMzoL97twMhbB9End6fI+HCUXW7G+Vm1LIA==
X-Received: by 2002:adf:f0c5:0:b0:319:743f:c695 with SMTP id x5-20020adff0c5000000b00319743fc695mr8060063wro.12.1693854708310;
        Mon, 04 Sep 2023 12:11:48 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c17-20020adfe711000000b0031773a8e5c4sm15173256wrm.37.2023.09.04.12.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 12:11:47 -0700 (PDT)
Message-ID: <3b3682be-5dbd-5e2d-a6c1-7bdf6d3ff8cd@linaro.org>
Date:   Mon, 4 Sep 2023 20:11:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 12/15] media: qcom: camss: Fix support for setting
 CSIPHY clock name csiphyX
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-13-bryan.odonoghue@linaro.org>
 <6f381a9e-9aac-4a3a-814e-26a230026d66@linaro.org>
 <5714055d-84b9-f60b-ed58-77d86722d71e@linaro.org>
 <e51e0d29-f455-463f-9324-6ee0459df067@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <e51e0d29-f455-463f-9324-6ee0459df067@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2023 13:12, Konrad Dybcio wrote:
>> I really don't understand your point. Could you please restate it ?
> If we categorized the clocks at probe time (these ones go to csiphy, these
> ones go to vfe or whatever), name matching like this could be avoided
> 
> Konrad

Yes, I like this idea.

I'd like to make that into a separate series. So I'd like to address 
your concern on the size of the string in the lookup and then punt the 
clock story over to another series since it will involved churning 
though a fair chunk of code, yaml and dtsi.

---
bod
