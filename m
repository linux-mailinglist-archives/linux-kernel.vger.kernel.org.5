Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5CD7EEF6A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjKQJ4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345792AbjKQJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:56:40 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4029A7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:56:13 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so1895812e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700214972; x=1700819772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mAvn4TYGu0MnjACYvrOksw5KpK5y/I6gyUCVs13r44Y=;
        b=NQSPCJkiK97seTEIrtDOyyOB7yjagEHnO0r6K4ea5eb6MFtRjz9wLvKxpUqZYqAeGT
         g//8wpPXvshDcGQfA7SN8+aFbqhW+6HNFJGxG+7QnKN4qEQYYwSmMuJD5+vglI39dOPm
         ZJWW//fabjQ8uTt8aZ6qo6qxYKFJgDJqHHMxgTg+MmjB3MHb3XN5AJqIgGg27N75ioPA
         JT9dYurwiD+snpwJrocf7iDtNeMpu/5j/OA5Q+ijl3K3GsV25lGMBMagFB8f72iU8ach
         fPGJmhLYEaEV81kIbIb1lnQ7VVch5TyQleyUmD8eQYXHSTDoWZJS0kfsU/YUZOD10pvu
         3SJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700214972; x=1700819772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAvn4TYGu0MnjACYvrOksw5KpK5y/I6gyUCVs13r44Y=;
        b=LSEV+k5IOBwA1u5aXb1xuUhzEZWGaaX2N5OGCpvHM0sdVTQ6vH3qJuobArFATkHMLq
         rlC8AjkqILeI5+/tDNiAFb+K+sSrGiNvcZECSuaC4lp1vu2JYD0iEy0tu54g5TFccCgq
         seiJrhAFLIiH1iiy5bSpVNz8DnqIHBiy6oUUpdPSUymvtqijkOk6q1v4L4rZRKfOtKtz
         GJNy+TJOWUs9RhR8dSn2AsuaeS44y4EnAaAmS5sfGjcYh3SdXVZn+jDKyj1cL+J1C5QC
         Vo9UwMFYYHsuiM4hY/UsxxPYNtsT3LiakHpENRvGAaj741pGWB4SnEHlxXx+GFKzXMrd
         N0/g==
X-Gm-Message-State: AOJu0YzaO5qmfOyuwoMSJXZPifrQaP3oZm3y2buwAQHKGL7BrXognKZH
        87G2KoBjM9j6HzPRLStwMJBxuyrZtOPlBWuPfUU96A==
X-Google-Smtp-Source: AGHT+IFQ33UA3tDkivKY/MbQUTpvO//HGjhdrR+dNQs+AkzXrlfm9w9hulG6vAzWc+6GV0F+aONHgMimEceIG0dWEvk=
X-Received: by 2002:a05:6512:ea5:b0:4fe:8ba8:1a8b with SMTP id
 bi37-20020a0565120ea500b004fe8ba81a8bmr2028501lfb.7.1700214971975; Fri, 17
 Nov 2023 01:56:11 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com> <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
In-Reply-To: <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
Date:   Fri, 17 Nov 2023 17:56:00 +0800
Message-ID: <CACSyD1NJ4ycr74pXHNus3ZjA=LvZP+aMNyz=iWyHuDODpx7aww@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     Chris Li <chriscli@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> That will cancel the batching effect on the swap slot free, making the
> common case for  swapping  faults take longer to complete, righ?
> If I recall correctly, the uncharge is the expensive part of the swap
> slot free operation.
> I just want to figure out what we are trading off against. This is not
> one side wins all situations.
>

Hi Chris, thanks for your feedback.  I have the same concerns,
maybe we should just move the zswap_invalidate() out of batches,
as Yosry mentioned above.
