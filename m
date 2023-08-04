Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659D576F7BB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjHDCU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjHDCUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:20:21 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4BBA3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:20:20 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76c93abeb83so123946485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 19:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691115619; x=1691720419;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=anHjwPjiZzagsTV/ojI6gGr9I5a6pEf5vqZtND3Ybkg=;
        b=SAH2INs0H0RsUQ+WanHmSwBavc1TOKpNv1gxkeirK9w+1X/gVPjigC55V5uE88Bxq/
         i6WPzxjyOWv1MHDW6INGUghZV1A12eCrH7JYeiCSrpJeQNUjM3JS2Ztfq6DRVmMmH7+y
         7RrHGEZYeL/5bSVfKSFKzEPSz9nr4KvYZ7y3h7VUWiiJ8IHQCzifaNTa8/uSso01IxMs
         8m6K1StUuPtmjnkFcqn9h4OeSDtE7beVBN1elhxl4WJNExKZP1dtHb2TUfbO1IPGDvYF
         8L/oJAfvMCVsmNn4slaCfB6caij1pXZCLkdGlyhfj2h5Mk++PF6Tqodl7t0jCO9AKVBu
         sKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115619; x=1691720419;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anHjwPjiZzagsTV/ojI6gGr9I5a6pEf5vqZtND3Ybkg=;
        b=WD+Y2KXFBzRGxuYPUfwu7QMykhd3dRVitjGU1k2vXDLuMuohuT2lG/PUFOQQgZFy+E
         PsB/9xXgAcRkKbBTMJHfTmk5MCkGDQNcJOUN2WWDrZCJN2wcWN27teKqNsIQducRytWp
         8aRsk21z8sx0JU7n//VBJvoQMhHnD0Kx6/cr65rvzmFfkOLgH4coC5zDMoNcr7pnCwxw
         DwVpnl+IXX4opkD4dIuD3WIcy1ML/mOBILwX2fgisq8B7z5LsznMjjJ+wbl2vDEHmW0K
         aoIwQQ+dh48VLaXuIa0VozmKDm129a245VGoJS63kY0SWzpq1IqdN0MIIi0e0CSUEaYT
         V7QQ==
X-Gm-Message-State: AOJu0Yy/Uqjoac2oFbvvcBx/YPEgc9QKgtJrA3s8utA/t1UMccarT81a
        UZr7xKFwHLgM2osxlTkC1hu5
X-Google-Smtp-Source: AGHT+IFcxBAz22BTHcIswjcjcvcn8/xLuxpnDnVEoB4q/PVHkxBr+BVYhJF5ZURUA0DKVpu851CkIQ==
X-Received: by 2002:a05:620a:444f:b0:76c:9cb8:a243 with SMTP id w15-20020a05620a444f00b0076c9cb8a243mr595224qkp.42.1691115619212;
        Thu, 03 Aug 2023 19:20:19 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id o15-20020ae9f50f000000b00767e1c593acsm334331qkg.79.2023.08.03.19.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:20:18 -0700 (PDT)
Date:   Thu, 03 Aug 2023 22:20:18 -0400
Message-ID: <5f0390a4bd0649d7a621fbb3c614d5ad.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] selinux: use identical iterator type in  hashtab_duplicate()
References: <20230728155501.39632-2-cgzones@googlemail.com>
In-Reply-To: <20230728155501.39632-2-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the identical type u32 for the loop iterator.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/ss/hashtab.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Merged into selinux/next, thanks.

--
paul-moore.com
