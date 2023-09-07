Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D81796F76
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 06:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbjIGECi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 00:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIGECg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 00:02:36 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E22199A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 21:02:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-26f7f71b9a7so433079a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 21:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694059330; x=1694664130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzFWzXBGnRsqCwKpysfeip0HHkXxYeCESv6nHyFM/J4=;
        b=Je8rI4ZArDTmLyXuUJQwTNGoeEz0f8DnhrIr5GYX6kwBMsIPAm2t2Idyshqc3KwfPB
         /Qms1HfmYl1pdEzSwS3Q2qbnFv93eZ8N5EY+cUy3FBVAYtGdhXAEP+SjX356jGoUVqdv
         clCUFJci8aQrhe8i+GoynicTLT1fvtwjeVqkDCdqxroiP6C/LW7TOgrh98bJdhM3XGgP
         wnhimVQeFKvJwC2Vq8JRRRptB2bGetVcHwdh4NSUxTQMnsZXgQ/3Pvp1nJqJRHGnKl0Y
         NF9TVw0fc7jHXsXdc92vG4ewJbVNSGKj8aEd19oR2HOgonB04wM2tIC8Fkp46sJnnC5+
         se9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694059330; x=1694664130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vzFWzXBGnRsqCwKpysfeip0HHkXxYeCESv6nHyFM/J4=;
        b=GUbkst+vepGTeSFu+obBO5iQ5rCmFiOKZug7u7neLm+trhxJF2LH3nmd+W1I1q878j
         cCpqC+VpKMVEeT5OaVNkwtX+XqGj/KfgCD5BYv1B6tp+D4Um9IDYdqHftkf0L8bGW3BG
         FFLSJwLoyX0hGGDj4p4Pw6qe6CnnsTGa0WTWcb5bqFv4eFzicX+9HfQVp9P3BxS9Pu0D
         BSsKrPSFi2ZJGS/P+tbkWb5Qoe4HJgVAj8X1Q25iivUBax0nz5mZdJ1u3iHg1j+ju8n6
         lFek3scoczohvcACvTy4VU9fe4F/6hVpUmT9JLmQnCkMqZA11tIiHfAzNCkqomHxp2Ez
         EAqg==
X-Gm-Message-State: AOJu0YzL8jSimXnNQ0flId51FxtNqjlbod8DnVp7fzen352A8fXoTIvo
        fwtIq6TF2OqSeNkTjbsRiDus8rwIQGUZr2dnc70=
X-Google-Smtp-Source: AGHT+IFOlS/qO02By0FEw5WBsVOJHDcayiHSdTZSugKq+WRiptU3rjt9Ug9e15oU0Ue9crbFsMQceA==
X-Received: by 2002:a17:90b:1e4a:b0:26d:5049:cf48 with SMTP id pi10-20020a17090b1e4a00b0026d5049cf48mr16282352pjb.40.1694059329986;
        Wed, 06 Sep 2023 21:02:09 -0700 (PDT)
Received: from [10.254.232.87] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090a2e8a00b00262d079720bsm511582pjd.29.2023.09.06.21.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 21:02:09 -0700 (PDT)
Message-ID: <06a8624e-00bb-a332-4271-860847faf4a3@bytedance.com>
Date:   Thu, 7 Sep 2023 12:02:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] maple_tree: use GFP_KERNEL on mas_node_count
To:     =?UTF-8?B?7Ius7J6s7ISg?= <jason.sim@samsung.com>
Cc:     "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Matthew Wilcox <willy@infradead.org>
References: <CGME20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p6>
 <20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p6>
 <ZPlIShWJWt+Kxt8x@casper.infradead.org>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <ZPlIShWJWt+Kxt8x@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/7 11:49, Matthew Wilcox 写道:
> On Thu, Sep 07, 2023 at 12:39:14PM +0900, 심재선 wrote:
>> Use GFP_KERNEL on mas_node_count instead of GFP_NOWAIT | __GFP_NOWARN
>> in order to allow memory reclaim.
There are many paths that call maple tree's mas_node_count(). Some paths
cannot reclaim memory.
> 
> What testing did you do of this patch?  In particular, did you try it
> with lockdep enabled?
> 
