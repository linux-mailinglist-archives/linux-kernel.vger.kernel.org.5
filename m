Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38157FA776
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbjK0RFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjK0RFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:05:02 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4799038
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:00:08 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-35b0b36716fso3788005ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701104407; x=1701709207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKCN+Wf00+ELxyn14a5AA+VFdBSorCTvXlpC+FYzc7E=;
        b=YKgN8udRyuEbVyB7dPh6j4lJQzWBo/LQn2fSk5KVtr1nDP0LoGNjlcRnTicOUqUFBB
         tmN+Iw6WzeUSfBVANjjIv6eX+C6xIdEAoFIH1QUR2Sqqn+vdObpuA9lhfzkMNSHwkzr9
         l9BBLvr+K+z3iz/FdOwiZeoWvPj+YuP2yLM6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701104407; x=1701709207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKCN+Wf00+ELxyn14a5AA+VFdBSorCTvXlpC+FYzc7E=;
        b=G/+6KFB7+ZtVPZMKbjY+9aY2Lqzk4KYln8UykF3JnMgczYBp/4Gayhtb0oEnmjn4w/
         vLlPPGRYvelgPTb5PWmMRs1inqcgBOdGu5PEXOPqBr8lyzpD3BCvvlDB3JQ1yjyzPjik
         2beT16d1Li9YIAhqWMUHXH2ew9+UIhn2ZO6Ls1j3eX+3EKp1qENs4jWdAzNWjg09/7CX
         K0l9fhOOi4a/YeLP+/hgjqfsyZF6DlVLzxKmPu6/zUHLxru385HMkI4ptWkc63tIRouf
         oqaxaGPA15Yfh07xrEkNm7oS8xiMZ1jE5Zf9gbuebOSHclsQpBaJ5jRGOrtAuRUxIMnT
         ZenQ==
X-Gm-Message-State: AOJu0YwzflVLNPS1+T6Nms/q6p/5jEmeup8TA00SU/j7I/0Mmhez0Jjy
        CdgjliO+682032+lErnGQuLiBbLH6PlC48tdRIo=
X-Google-Smtp-Source: AGHT+IEgVIvuW6fPNcvSD/7qD/x0se9Ajddb7fAiQdaYCd034lTW0DvylFz7ZRhdEG5jqFwqODpHsA==
X-Received: by 2002:a5e:9512:0:b0:7b0:75a7:6606 with SMTP id r18-20020a5e9512000000b007b075a76606mr11826362ioj.0.1701104407163;
        Mon, 27 Nov 2023 09:00:07 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id h2-20020a056602130200b007a67dd75d32sm2516233iov.4.2023.11.27.09.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 09:00:06 -0800 (PST)
Message-ID: <dd6739ca-72b1-4eb6-9fd6-e18dc974de50@linuxfoundation.org>
Date:   Mon, 27 Nov 2023 10:00:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/55] media: test-drivers: Stop abusing of
 min_buffers_needed field
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
 <20231127165454.166373-3-benjamin.gaignard@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231127165454.166373-3-benjamin.gaignard@collabora.com>
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

On 11/27/23 09:54, Benjamin Gaignard wrote:
> 'min_buffers_needed' is suppose to be used to indicate the number
> of buffers needed by DMA engine to start streaming.
> Obvious test-drivers don't use DMA engine and just want to specify
> the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
> That 'min_reqbufs_allocation' field purpose so use it.
> While at it rename function parameter.
> 

So how ate the test-drivers currently abusing this field
and how does this change benefit?

I don't have objections to this change, I want to understand
it a bit more. I would like to see more details on why this
change is needed.

thanks,
-- Shuah
