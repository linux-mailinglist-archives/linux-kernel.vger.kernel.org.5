Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9BB7D49E0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjJXIV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJXIVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:21:54 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B102299
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:21:31 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5ac88d2cfaaso3293580a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698135691; x=1698740491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUo6nBDSjHnWxlBYRXP9wvzcVcvr9aSoPVi9khaxylQ=;
        b=Kb6BXI4QgZ7xPLow1JYc2OaFq4/PbC7AJbBpZbaepuRaJYkyIEqQrZTYFNnIlmvI7d
         aQYqOJBrj7FtZgsD1O2Lcq/XF45Kk0I47yleg6bKvERdXp0Vu440L/iiJS5IYL1vrth5
         qbQoJEpZiqC11v9DhWYRhar94KhULRBbG2zefgatzCCADkCYNA7kTcTW3IFwIXxVAe/Q
         rXceJy+7WY/4zSwtPZFQYoztLADv55XYQMz4ubLypldzIZyIE/0F1zWujm4uOtWTA8lx
         Mbo8SIkHlPxLY/UGIAdi0VjmsBEGodbojUAf1/BOJdTNteCkjbgqoe/cH8UarjMUZXMk
         Blmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698135691; x=1698740491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUo6nBDSjHnWxlBYRXP9wvzcVcvr9aSoPVi9khaxylQ=;
        b=KTJmKLSgwHAr/tZV3I+59K6Zgs7UkrJeLmXcGBZog3DyENcWQ3y7FMh5wFf/b7oWiD
         vrdD1STK15Ikj/XraVUzjhTP/zRJicbwiE+eMEJS/aSS0WSCRpTONvpRaGUgCVopu4E+
         J3AVtng0m7d/O7Zyk2Kop7VbI14ee4Tb9D1UjB4x0hWziMYivtGYLG0Ezbot+kMpY/JY
         YEHAn08rakfVTAe3WbxIQ/6FJMjdYov4BRvCigLzQF/tfhSbev4O7yzdqL92wjdJGZz1
         e67IFjbq8pcLWWWKNt/4mUC5J+XionLKAlwUGEvPnMoDz2edgfWfIeUuHmwsOhSlxBe1
         QC9Q==
X-Gm-Message-State: AOJu0YzhnqJIx3gao29oJdIcBjCcVZEilfZDaqJpTSpA5ATA0r7Fl7Mi
        pRpQpLlVGohCrLM4tv/lbQrCyA==
X-Google-Smtp-Source: AGHT+IHbILyu6kZBKayDDb4NnoqcCDA4V3hXD153HR0lhVyDjX8ZUOVIYiA3+aqhk3W6AOa8Rx4r+A==
X-Received: by 2002:a05:6a21:a109:b0:15d:e68d:a850 with SMTP id aq9-20020a056a21a10900b0015de68da850mr1519205pzc.29.1698135691165;
        Tue, 24 Oct 2023 01:21:31 -0700 (PDT)
Received: from [10.84.152.177] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id fb22-20020a056a002d9600b006be17e60708sm7200680pfb.204.2023.10.24.01.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 01:21:30 -0700 (PDT)
Message-ID: <b2bde6a6-a242-4eeb-9a65-4081e8ac5df7@bytedance.com>
Date:   Tue, 24 Oct 2023 16:21:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH net v3 3/3] sock: Ignore memcg pressure heuristics
 when raising allocated
To:     Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
 <20231019120026.42215-3-wuyun.abel@bytedance.com>
 <69c50d431e2927ce6a6589b4d7a1ed21f0a4586c.camel@redhat.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <69c50d431e2927ce6a6589b4d7a1ed21f0a4586c.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 3:08 PM, Paolo Abeni Wrote:
> On Thu, 2023-10-19 at 20:00 +0800, Abel Wu wrote:
>> Before sockets became aware of net-memcg's memory pressure since
>> commit e1aab161e013 ("socket: initial cgroup code."), the memory
>> usage would be granted to raise if below average even when under
>> protocol's pressure. This provides fairness among the sockets of
>> same protocol.
>>
>> That commit changes this because the heuristic will also be
>> effective when only memcg is under pressure which makes no sense.
>> So revert that behavior.
>>
>> After reverting, __sk_mem_raise_allocated() no longer considers
>> memcg's pressure. As memcgs are isolated from each other w.r.t.
>> memory accounting, consuming one's budget won't affect others.
>> So except the places where buffer sizes are needed to be tuned,
>> allow workloads to use the memory they are provisioned.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> Acked-by: Shakeel Butt <shakeelb@google.com>
>> Acked-by: Paolo Abeni <pabeni@redhat.com>
> 
> It's totally not clear to me why you changed the target tree from net-
> next to net ?!? This is net-next material, I asked to strip the fixes
> tag exactly for that reason.

Sorry I misunderstood your suggestion..

> 
> Since there is agreement on this series and we are late in the cycle, I
> would avoid a re-post (we can apply the series to net-next anyway) but
> any clarification on the target tree change will be appreciated,
> thanks!

Please apply to net-next.

Thanks!
	Abel
