Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BABC753BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjGNNcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjGNNct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:32:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8121991
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:32:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8c81e36c0so11709515ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689341568; x=1691933568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tF5GXQiHRC6b3b7lPddIM3w11DVDm7zYmiPWktt8cw4=;
        b=WNQ8an3/5ACMk30UpOfz+DLRRoWsYu/mhYbX5nDyudMdUpusayVFtd1nO5+RMdGrOx
         mkDort546NBeapqtagKfagS1IUPkIboKKGsmSt+CB3/VFxV7a+EVo97mJxT5gb7QXDqs
         fJEKszWPoecRmwRhv+a3isGWw61bQYEOZ12uG7Axnv3sEmd2yQZSyDXmc2fT2zM1Y6Jx
         8z6txtdSlStQZV8I6hRoalfw4xlaR88CcYu96zVrUE4dOMpsZU+Gd7fx5qwkWNUggjks
         FMwoPJ7jsT6FWlclxUaqaWrVwbTynOpyheesIZBlB3KIvgheKjV5PXEfm/4My+G3neoT
         T3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689341568; x=1691933568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tF5GXQiHRC6b3b7lPddIM3w11DVDm7zYmiPWktt8cw4=;
        b=R9ro0AEgI9Sh1x07PLJalPcwXssgAt0jCJo5eKtcebWnSXPcY0HTIvxcqDXNzF7yuW
         vBqV8Wovceap+TFlwgXZ6zBlNn4BhSIAw6pczbKT6Qvkbv2ng4BV62fYvOj1l938E3Qk
         dScFNFz+qUG8Isw/dsZ2o3PjwN1ge1jaBphYjOgUTx6RrJhZzUCh5wyd/Z9Cc0hOS/QT
         +CCeH/eXFUarJ6Ia9neudCvK4XPbU4mnzUY4qiTgZ35SHjY7MTSQdqnlOOsWxVCUFo32
         lc6DIpLMQU2zwaAO0p4Bq4gtLnsVtOZAMfxR5+tatjQ8oSKUxTNGeJNWKmeuY7e87slD
         B6Jw==
X-Gm-Message-State: ABy/qLYYGKOCVbjtU/7DWDFyXTHVwMEmsO1f0bgiiAJe5WTXPLbt3x24
        /uF2NLKKpNH+0x+Do3Yh0Vr88Q==
X-Google-Smtp-Source: APBJJlHpmho+3MGOk7Eg5Lo5QelZzUatsHeDz6eKOisaCK5K9bKTN3rglzpFTPUYVNPe8tT4RB80KA==
X-Received: by 2002:a17:902:d504:b0:1b3:f8db:6f0e with SMTP id b4-20020a170902d50400b001b3f8db6f0emr4353751plg.43.1689341568627;
        Fri, 14 Jul 2023 06:32:48 -0700 (PDT)
Received: from [10.254.16.139] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902bd9500b001b6a27dff99sm7785844pls.159.2023.07.14.06.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 06:32:48 -0700 (PDT)
Message-ID: <76cd3354-c808-0561-5b07-179161c06aec@bytedance.com>
Date:   Fri, 14 Jul 2023 21:32:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Maple Tree Work
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20230707163815.ns4kdz7iut5octjv@revolver>
 <0152143a-b105-a413-ddf2-47f688633d97@bytedance.com>
 <ZLFGMGtk2WMbGhuf@casper.infradead.org>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <ZLFGMGtk2WMbGhuf@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/14 20:57, Matthew Wilcox 写道:
> On Thu, Jul 13, 2023 at 05:58:13PM +0800, Peng Zhang wrote:
>> I have a question I want to discuss here. I noticed that the interface
>> of maple tree has three different prefixes, namely mtree_*, mt_*, mas_*.
>> I am curious why the interfaces prefixed with mtree_* and mt_* cannot be
>> unified? I think they can be changed to mtree_* to avoid two different
>> prefixes.
> 
> I haven't worried about this too much.  The long-term goal is to use
> the maple tree data structure to replace the radix tree data structure
> underlying the xarray and use the xarray API to access the maple tree.
> The xarray API will need some enhancements to make this work, but churning
> the maple tree API doesn't seem like a good use of effort.
> 
If there are two prefixes, mt_ and mtree_, I will be confused which
prefix to use when adding a new API. Users will also be confused when
they see the two prefixes mt_ and mtree_. However, renaming the API
is not a good thing either.
