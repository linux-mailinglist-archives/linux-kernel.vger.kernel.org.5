Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7977FFF7D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377254AbjK3Xb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377275AbjK3XbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:31:24 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8175C170E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:31:30 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35c683417f1so1367915ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701387090; x=1701991890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llYyWfCb69pBxaG0WYSOBLQY/Xppf6lTA3DcehbW2Ek=;
        b=cp7vN+uxGjdaN9eEqeW4neVl5T93MuiYyWqOSZkYd7ECxcNyvPMxis6Aj8NfCElH5T
         VkgLVFMxuCNytV1Ns4a/zn4llQjNBE8AXK3TJz1NANBRDndl5+ZWRIai082N07PX8KZM
         E9XtepPpwgJk/2FsC2SbI/dSoPj3dTaYPw1TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387090; x=1701991890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llYyWfCb69pBxaG0WYSOBLQY/Xppf6lTA3DcehbW2Ek=;
        b=dsiAtI47BRjSd0LeZlR7Hc9Br+hrTuLSayL0h5kQmbOo7aidKzPfTUgvc68oatwSiW
         sC5LYuc02t4FxbiJoGq57Ylr3TNRP8J+bcLsCS8ytGHepp8U84vJJVztbWjYE2+iQ/83
         rFgofvrnhTdpBSUXQ7c7zcwnL7xlZ4wwlgocQPeYfYq24Xuifq4DyaqQP0eMDO+uR5fL
         ABfmTJGyz0bePkYc76mO5VTl0TW6Gvf8T1wu/OTqzf5+DiIFXrpVdoZBB3o9D77I7wEG
         mBVd9u73OaPBB2oGurk8B8Tw7ysO961pQWFDNu0KmkesV+avgTm/kVSN5CujUa3l8dbD
         ddXQ==
X-Gm-Message-State: AOJu0Yz8zl/3ENmuePdXkE0SBCJnA8RaoMEOCiMNsWKPvALEhJvG7mnq
        xCqm5c8P4WQOTeHtXWFgszbKr2p2sgLxpjaKS5c=
X-Google-Smtp-Source: AGHT+IGh97ToGT1ForYO7+r88gaJE7pfGJ29v4Y23IUCdSGN+XdLo3r8+IlSeCQXDwW4Twd8aNF6Gg==
X-Received: by 2002:a6b:660f:0:b0:7b3:58c4:b894 with SMTP id a15-20020a6b660f000000b007b358c4b894mr20766432ioc.1.1701387089857;
        Thu, 30 Nov 2023 15:31:29 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id h13-20020a02cd2d000000b0046856360a07sm563841jaq.13.2023.11.30.15.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 15:31:29 -0800 (PST)
Message-ID: <d77d88cb-2a7e-45ce-8289-55d7b1c2826c@linuxfoundation.org>
Date:   Thu, 30 Nov 2023 16:31:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: prctl: Add prctl test for PR_GET_NAME
Content-Language: en-US
To:     Osama Muhammad <osmtendev@gmail.com>, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230820141354.29687-1-osmtendev@gmail.com>
 <CAK6rUAO2hyt0tcXif=kbZj=vd4+O9h3o1quWSF2R6FMm70u_hA@mail.gmail.com>
 <CAK6rUANdzA9JNP-Aah+1LbPAdJwBn9Z2_ogDi5i1jE6q6vmWSg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAK6rUANdzA9JNP-Aah+1LbPAdJwBn9Z2_ogDi5i1jE6q6vmWSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/23 12:23, Osama Muhammad wrote:

>>>
>>> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
>>> ---
>>>   .../selftests/prctl/set-process-name.c        | 32 +++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>

Applied to linux-kselftest next for Linux 6.8-rc1.

thanks,
-- Shuah

