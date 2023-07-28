Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67118766F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbjG1Oee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbjG1Oec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:34:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA623A99
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:34:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so2333025e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690554869; x=1691159669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQHJGwayOc+O4cksaa/ROvfn4y8YSDZc3qnYsF4uZqw=;
        b=EcDu3WAIxaRhO63H6hHNuwo0THjAYjbMikEkGUQleSFNeDnX2Xs8wV8hGhlfUFpIzC
         1fB6D0X3Ixg0+E/n0cVN/p4U1JhENLqx88d50pw4If+aZ5LzlzVGoK+cLSYwsAjkLhIt
         yIQIh4qQuSnWqwoI+Cus5tVTn/KZauSQsSh4pruFKtZ1Q6L8Nd2JFVLulSe4xmzExqKQ
         LzUdpE0t9s/RGbV2tA/8bQOlJweepTEDuAaCmhZUpnFeYDhC4KPSlM105luoEPvRgPoW
         QZ/ni93CT1E/ipM5l51bH84R3mIT2Y/HtWfc+04p6ND9z+6k6G00UekHetqjN+wxLnnx
         Cavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690554869; x=1691159669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQHJGwayOc+O4cksaa/ROvfn4y8YSDZc3qnYsF4uZqw=;
        b=crLgPo+G+xt2yvldetdNqwGbXVxHC2fdEokXGLqw1KXMayrC+n2OhOJJQBsFJtpudZ
         /kf/LKxmlipsw6Fxt+mI2CKLGRFUdkukD66rX7s0BFOiA78mOX1qnY/cCucD0NVHWhGW
         BYlhX+6oGBE5/0WMUdXBa6dXU+Yp5KZDJv6sEYKY/ShLTmzg5u3d3PT+Fizkk5+xJRfU
         0LTidoEHhaKsbJZTbaB95fmkE3ZDYMRGTf/qpV/NCHb/MrZpttajPyvw0rsaw58PtyBX
         u05+2weOKMqiW2b76WZNXLPTacq8eybogyZuQtigoxcOgyCByJg1PMEABaCR/Mss8QfH
         yYxA==
X-Gm-Message-State: ABy/qLZeAYKhlppLHmgnLRVn7DDwF/OVSCAQ/+3zLlfGyoctmC7UUmfD
        7fjljqLlXBu+vYaloO1QhimjBQ==
X-Google-Smtp-Source: APBJJlHqVdMI1zH3ei216nTKTJ3P7/3y7iqzi2E5C3bdueCeKqiWOkVS6ktlrc6U9SJzoyMWV+O1+Q==
X-Received: by 2002:a1c:7216:0:b0:3fc:627:ea31 with SMTP id n22-20020a1c7216000000b003fc0627ea31mr1875553wmc.38.1690554869645;
        Fri, 28 Jul 2023 07:34:29 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fbaa2903f4sm4378117wmb.19.2023.07.28.07.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 07:34:29 -0700 (PDT)
Message-ID: <f5ffae25-fcd6-b4a5-5114-3b66db5d7c31@linaro.org>
Date:   Fri, 28 Jul 2023 15:34:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/33] Qualcomm video decoder/encoder driver
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 14:23, Vikash Garodia wrote:
> This patch series introduces support for Qualcomm new video acceleration
> hardware architecture, used for video stream decoding/encoding. This driver
> is based on new communication protocol between video hardware and application
> processor.

I think my main comment and question for this driver is; what 
specifically about the sm8550 requires an entirely new driver for the 
venus block ?

We have a re-implementation of the HFI as an example.

What are the specifics of the technical barriers, if any, that preclude 
adding or extending the existing venus codebase to enable the new silicon ?

---
bod
