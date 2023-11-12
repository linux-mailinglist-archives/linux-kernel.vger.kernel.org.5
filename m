Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9387E9277
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 21:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjKLUS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 15:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKLUSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 15:18:25 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1022116
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 12:18:21 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc13149621so4523985ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 12:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699820301; x=1700425101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgzcqveWGXZ8cELOepLq5XS/QVDQlGc8b6jyqXPEG4w=;
        b=FSY8MB8jSQ3f/PGgJ7koMwY/xS/LKqiMCCkGzB+gvUYwQAd5xC0NvA/A46CGom8PFn
         Ln+yNqQfT3iI7nGRMgoMzeiwqjL/i886eLHUll3/nr6CAilIZSpGqCItTEvo9hsvBw1O
         SqaYn2I7TihzlaBmI+50dwTBcCW2rQhryNysij8XLhxrLkBRPAn8CwrLPxu+XNHBLwAX
         SmRBn0pHSHkHUev6Uul99K3/hBM/EiP4oLloUwOAZRuTfmo13YmRDfKUlRAm3Kd1hSZ2
         kn5YGVntDIlVdDXYlBOi2I8M65tj1mnqo7TGLBHdlWdZjLsoUAJ8U3Wvhv4b7WBi/eDM
         FoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699820301; x=1700425101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgzcqveWGXZ8cELOepLq5XS/QVDQlGc8b6jyqXPEG4w=;
        b=jl13+RkSQU3pDwxd92zUfx+oR7gygxJcFuJIsexLf1uYo+KLHCsjFSx3dpS/mK1oWe
         kYe9fDqd7L8GTOeiV1G3buzIO8tcbqI8Q1iGZiXOMlGf2jZZhxOidfTMZ0dk6iZfm7vQ
         UvZ/Aa5FFL7Didv920iAc3zm2Bg4UOfN0Fj/0zyDkBZMCbwyFgu6T1Yji9X+s4hK9Zbi
         q4x8DOBuAiKqnk2fFd/CXLIi6ilqVlV7DHcLVpT2YebUUJgnqmYBjn1b/E5kjmHlFjk9
         Zx4x1fIid+9wwBcBhRB+JOntjER8gWgfWlFvIRYL/9FNZDw1Pp+goT/CcDiDEx/d5t9i
         cTAg==
X-Gm-Message-State: AOJu0YzHmcgC7QjVFOqOFeHxej7xehFSrM2iiWD7J9n7xcxFkmM4MXrG
        9fQsiujZJJOThGdn86oLLsY=
X-Google-Smtp-Source: AGHT+IGmKldSSZMid9qXjWh8w9COFO8BtH5jlrKeAvaY2WulTkeqttqsFpQntEaFr7AQ2udmWlR7pQ==
X-Received: by 2002:a17:902:db0c:b0:1cc:277f:b4f6 with SMTP id m12-20020a170902db0c00b001cc277fb4f6mr6776508plx.6.1699820300880;
        Sun, 12 Nov 2023 12:18:20 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902708400b001c739768214sm2880695plk.92.2023.11.12.12.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 12:18:20 -0800 (PST)
Message-ID: <b6476b5d-5938-45e8-9c3b-14448a5d854f@gmail.com>
Date:   Mon, 13 Nov 2023 01:48:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Fixing directly deferencing a __rcu pointer warning
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <202311031320.c3ebc782-oliver.sang@intel.com>
 <20231112193055.2072382-1-singhabhinav9051571833@gmail.com>
 <20231112195839.GA9987@noisy.programming.kicks-ass.net>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231112195839.GA9987@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/23 01:28, Peter Zijlstra wrote:
> On Mon, Nov 13, 2023 at 01:00:55AM +0530, Abhinav Singh wrote:
>> This patch fixes the sparse warning with this message
>> "dereference of noderef expression" , in this context
>> it means about directly dereferencing a pointer tagged
>> with __rcu annotation.
> 
> Please, stop this madness. Just accept that sparse is a stupid tool and
> the code is actually fine.

Thank you for your tine maintainers. Okay I understood that this extra 
patch, is not required. Just one follow up question, in some driver code 
as well I see these warning, might be possible those are real issue.
Can you suggest me like how do I know if a rcu related warning is really 
a issue or just a false positive warning.

Thanks,
Abhinav.
