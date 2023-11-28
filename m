Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988117FB229
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343675AbjK1GxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1GxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:53:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225ED113
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:53:02 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfabcbda7bso24083315ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701154381; x=1701759181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1AV/WeEvVkVZyxPY0LuVBzXLEkyrsg/KgP7ZanWOto=;
        b=QyTGN2Nvydgbd0vCV4Ghwl7+EfbTHkWfsCZsWjcYXBnu/dFZ7IdQraY4svb1Z2tU0Q
         EdE7U8C60KWQPb/93psOQ6rHhJXQd6UWdHxAtme6FgSziNpoA1cBfl3ubIcDaVbar4Hk
         orjphwQ+r+tZDq7j3FNnDapkO3Jxg/SHIKeZm3C++SqPnyRU+QnC4xuU4TXbntXZjzrO
         Orv2KQhC6d7McNkMrtD/x8ZC7r8kh1cK/T1U3jic228vUpY+Stgi36aIos2SAOL8GS0b
         natsSsOQ4+zUtq7sE2yXZtj+o1et2O5aPWsYk/R04NQX8ZW2ARXQMWe4oj7MsjX0IzZZ
         I7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701154381; x=1701759181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1AV/WeEvVkVZyxPY0LuVBzXLEkyrsg/KgP7ZanWOto=;
        b=DESa7pkyUWpyQuMvOjLPkQNB2LfBMn6U0BxXqekBhZ1bDAJn1uBP0IsxnGitHnBzVP
         ZcRvaUOfEDDKvViS77A69DGgz5dzJko1x2wZJSPgjSWwTZxp44SnJl8QgnBGwPQW4LKP
         xt6cSoqhKTrxOlvtfxhs4WJnz+BxQpsll2Sl75CmxBG6v1KfRi7rp5g1AQclGelt+IUj
         Vv/A0rlhx3WUEbOnOHKVOnv9F/nnZd44umDz4WETZg5kznyY5Sv2CAW91sItpJKUUAMx
         hTEbms7HZJmWgZ/8e8aMZ0Oni5Izi/6SgAASfcelMnbs8+msHLqo6GVozXfxEudddd7H
         29hQ==
X-Gm-Message-State: AOJu0YyJMYsamVH3fv8wZRZYwcJ+iiccizv+pc5tKLyGmPgTjl37yeNS
        x9Uphsx9ZtqCWn/FHLWSLv1u9Q==
X-Google-Smtp-Source: AGHT+IHOa5baZRFQaSnaz+ioo9XSwG/sUhHgXviZemTNH2BSoFuftQMb2eHft86SovgM+B880jxBxg==
X-Received: by 2002:a17:902:e812:b0:1cc:5671:8d9 with SMTP id u18-20020a170902e81200b001cc567108d9mr24210525plg.27.1701154381627;
        Mon, 27 Nov 2023 22:53:01 -0800 (PST)
Received: from [10.4.104.221] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090ad24b00b002774d7e2fefsm8422297pjw.36.2023.11.27.22.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 22:53:01 -0800 (PST)
Message-ID: <13ad8d92-dc69-4088-b3db-16fade43bde3@bytedance.com>
Date:   Tue, 28 Nov 2023 14:52:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] hugetlb: parallelize hugetlb page allocation
 on boot
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>
Cc:     Gang Li <gang.li@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231123133036.68540-1-gang.li@linux.dev>
 <5c0e27f2-5826-4537-a1ab-1debfab65b9a@redhat.com>
 <28e28c2a-e72d-a181-e87a-39cecc8c3c76@google.com>
 <9d5de524-28ee-4d71-9493-f77967ea213c@redhat.com>
 <783f8bac-55b8-5b95-eb6a-11a583675000@google.com>
 <db1b593a-41d9-444a-b3f4-f6bffe98634b@bytedance.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <db1b593a-41d9-444a-b3f4-f6bffe98634b@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David Hildenbrand :),

On 2023/11/23 22:10, David Hildenbrand wrote:
> Sorry to say, but why is that a scenario worth adding complexity for /
> optimizing for? You don't cover that, so there is a clear lack in the
> motivation.

Regarding your concern about complexity, this is indeed something to
consider. There is a precedent of parallelization in pgdata[1] which
might be reused (or other methods) to reduce the complexity of this
series.

[1] 
https://lore.kernel.org/all/20200527173608.2885243-1-daniel.m.jordan@oracle.com/

