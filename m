Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4338799FE5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 22:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjIJUnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 16:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjIJUnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 16:43:09 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A95418C;
        Sun, 10 Sep 2023 13:43:05 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76ef8b91a4bso242787585a.2;
        Sun, 10 Sep 2023 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694378584; x=1694983384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9msZ5DbtmGekV4G9H997JGWjDCJ9TtwZbavZxL9DMMc=;
        b=AUd2wC5+FTFzmaopEK6trMjhEpXTMGApG0BUbb1cRvQNb6fdAJt/jROhAdEtuKdCrI
         RBJ+5rujB3x+sWXMM0j2C3N21Z+zJbHuR+oxOO4IRvT7JaDCIxroH/RkAIyyM1GtBZcX
         oycnSsbbNxmRHrjmVaNH0sDnBMkh9+oDewR5bIHqFGczNP36UJh6TwEJZVBXNObUdj97
         fWW6cMBfZBZA0wVt8hlsEayUs2600vwF34rgSNi7IxhuhT0ds86Z3TfvJZClg/YCBpgl
         0SOXBFgqdIhsvf8KfNwrgNDEQxrKKf0CHGcshDz+nBMBuCj1Evsd74z+WD62VEAeIV97
         PlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694378584; x=1694983384;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9msZ5DbtmGekV4G9H997JGWjDCJ9TtwZbavZxL9DMMc=;
        b=hgXysp0mNlPxH1bNXeiUN36gfWOFTugaYDdCpYx2jZjRsrilL1fwY7NbLqxK0jhg3S
         rFgRkxfLkdyIkUQXIn+sLqxFz97ubCKCW4H7XlBxCb8UZSf7rZkKLl7vg78ZCqSSKJEL
         aUw3v3cQnQA2Y4Y6poW77tbfT/TfeP6HPsZd57+XS1QHhXUdaa6cJSAHohccS0ki/k6R
         XEPB7Mn07s7tri90XC1WcZz09sgbNYZgwyb0jY1GwkXqoAqNix5Oi+D2sN5b3VeRnkfQ
         czHk/hxi1C+oMrpPf+7q2vGN5SnbxjzkGrmqpVzzVEZGY72cbu6LlzLW8TveZ6/6gyA+
         GNjg==
X-Gm-Message-State: AOJu0YyykIuzaF54Vt+yRGLj3MSbDaztK0IeateepHLaafq3Fb6vKLXL
        ckA+lofVmoBWLzQQjqsvpw==
X-Google-Smtp-Source: AGHT+IGFD46wMQVTSgKn/nRK0+OF5Uj0+a2n5PrWm4+i0yeQVx8oqrj3HKfG4ybkZzKzbEaxQ/+V/g==
X-Received: by 2002:a05:620a:4316:b0:76c:a673:5271 with SMTP id u22-20020a05620a431600b0076ca6735271mr10659649qko.24.1694378584265;
        Sun, 10 Sep 2023 13:43:04 -0700 (PDT)
Received: from ?IPV6:2603:6010:7a04:7681:ad4:cff:fe30:e67? (2603-6010-7a04-7681-0ad4-0cff-fe30-0e67.res6.spectrum.com. [2603:6010:7a04:7681:ad4:cff:fe30:e67])
        by smtp.googlemail.com with ESMTPSA id qz8-20020a05620a8c0800b00770f2a690a8sm1208073qkn.53.2023.09.10.13.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 13:43:03 -0700 (PDT)
Message-ID: <d32d6919-47cf-4ddc-955a-0759088220ae@gmail.com>
Date:   Sun, 10 Sep 2023 15:43:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     gregkh@linuxfoundation.org
Cc:     Lang.Yu@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        olvaffe@gmail.com, sashal@kernel.org, stable@vger.kernel.org
References: <2023083119-phoney-ascend-d4ec@gregkh>
Subject: Re: [PATCH AUTOSEL 5.10 13/22] drm/amdgpu: install stub fence into
 potential unused fence pointers
Content-Language: en-US
From:   Bryan Jennings <bryjen423@gmail.com>
In-Reply-To: <2023083119-phoney-ascend-d4ec@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is also causing log spam on 5.15.  It was included in 5.15.128 as 
commit 4921792e04f2125b5eadef9dbe9417a8354c7eff.  I encountered this and 
found https://gitlab.freedesktop.org/drm/amd/-/issues/2820 while 
researching the problem.
