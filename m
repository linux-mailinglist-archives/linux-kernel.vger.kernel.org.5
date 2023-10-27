Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F157DA219
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346501AbjJ0Uza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjJ0Uz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:55:29 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38591BD;
        Fri, 27 Oct 2023 13:55:25 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1cbf47fa563so21857335ad.2;
        Fri, 27 Oct 2023 13:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698440125; x=1699044925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YiqrRPa09XwcSO6dmunATjOVHB3FZKY8V49FUoXNpc=;
        b=wIlhq3RWFhfWgOduwrJNS1mC3ptMuJxZfyhP7FDZY2sZEGA6VjBlX23mkvPTeAdqUy
         lepjhAYXcbrI85+0fMJN7NZjh4qO6YV78CqSiIqkHx/NgLWIGIw6x+iVv1rDgnsGqJzP
         FBpBd38aXSMLBOjMk8UN1UhiI6u3F4UVxkfGe81D7E0SWKJa5JGgkK7Q6nw21pls95eN
         /ZLyB5zBliagmW8zbAEA0V2VDHGb7QsKUvuOPAvDutC64mkxtG/NZ42yFBF2F8tdRJWw
         VnTltxERWAb4dc9Fx03yDRVgb5jjPFVZ3h+siFcprEpeuiQwqTEoP0rBgRtW2vVdZBpA
         SBCw==
X-Gm-Message-State: AOJu0YyXhSMSQDxQ8cA1viniWuvv3Qzto0rO3EIMG+tZSkznyJMY3hu2
        DjqQAWHpd/Nvjqd/6DBrnzE=
X-Google-Smtp-Source: AGHT+IFNnAI4aHBm8o7jUz2CjwqbUusBVaJvM6IjEzdEXUT4v8V/PYR/KGKCPVaC1ihakvXkyE1mxg==
X-Received: by 2002:a17:90a:1954:b0:27d:98f3:21a5 with SMTP id 20-20020a17090a195400b0027d98f321a5mr3469818pjh.24.1698440124610;
        Fri, 27 Oct 2023 13:55:24 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a01de00b002794fe14cabsm4068946pjd.12.2023.10.27.13.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 13:55:23 -0700 (PDT)
Message-ID: <a16dc8ba-ca3b-4dd6-a8b5-dbb3ac7a49a5@acm.org>
Date:   Fri, 27 Oct 2023 13:55:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ufs: core: Add host quirk
 QUIRK_MCQ_EXPAND_QUEUE_SLOT
Content-Language: en-US
To:     =?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "Arthur.Simchaev@wdc.com" <Arthur.Simchaev@wdc.com>,
        "keosung.park@samsung.com" <keosung.park@samsung.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>
Cc:     =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?UTF-8?B?SmlhamllIEhhbyAo6YOd5Yqg6IqCKQ==?= 
        <jiajie.hao@mediatek.com>,
        =?UTF-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        =?UTF-8?B?VHVuLXl1IFl1ICjmuLjmlabogb8p?= <Tun-yu.Yu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        =?UTF-8?B?TGluIEd1aSAo5qGC5p6XKQ==?= <Lin.Gui@mediatek.com>,
        =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        =?UTF-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        =?UTF-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?UWlsaW4gVGFuICjosK3pupLpup8p?= <Qilin.Tan@mediatek.com>,
        "kernel-team@android.com" <kernel-team@android.com>
References: <20231025085656.10848-1-chun-hung.wu@mediatek.com>
 <20231025085656.10848-2-chun-hung.wu@mediatek.com>
 <3056c6d8-1e54-4954-9141-e0760a0d935a@acm.org>
 <53d7d12bc12237e5f86522faf09876ab08ef7592.camel@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <53d7d12bc12237e5f86522faf09876ab08ef7592.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 20:27, Chun-Hung Wu (巫駿宏) wrote:
> From UFSHCI 4.0 spec "When the head and tail doorbells are equal, the
> queue is empty. *Nothe that this definition means there will always be
> one empty queue entry"
> One of our platform does not keep one empty queue
> entry for CQ full
> case, that's  why we need this patch to fix this corner case.

The UFSHCI driver should make sure that there is always one empty queue
entry. Does "platform" in the above text refer to the SoC that includes
the UFSHCI controller?

What is totally unclear to me is why the following code depends on the
UFSHCI controller type:

+		if (ufshcd_is_mcq_expand_queue_slot(hba))
+			hwq->max_entries = hba->nutrs + 1;
+		else
+			hwq->max_entries = hba->nutrs;

Shouldn't hwq->max_entries = hba->nutrs + 1 be used for all UFSHCI 4.0
controllers?

Thanks,

Bart.

