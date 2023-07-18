Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A679B7587F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGRWBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjGRWBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:17 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D191BC1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:15 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7679ea01e16so565235585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717674; x=1692309674;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q0cxD0bDSBI3iXwBbGCEOOB62CAlIgStj1niGo6wUfs=;
        b=BEjayJIVSjPLP6rBRHfpaDVYX4HBSO9IEJ7V8XaZQecA/tokegyGgh/hWaMya6lmgM
         f4MAHmrEhKWn1W12y01ExDcysvIfQZd9vwHJ6d6lsgjFcH/wBrOvLlogCe65uopXU7Bi
         wGLw7XlWSdo+Td4SmXwckU1U2KdjdXzJhNI8YgGm/rJMjZczcUT26s7K1h/TEsYcNLBC
         EySKNW/Se5SBqTp/CLDPrBLhi8PBkCuSn/B5sQJ5TF+Z1qMxzIAB2eG9Z9/D7rMDxJkb
         j+tgLC6JnqiKJ3M/VRR1gUhBz884H+a2G4bJGOzMOYq6vRQ2c0mzcte5AzudV5efuVG9
         5UmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717674; x=1692309674;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0cxD0bDSBI3iXwBbGCEOOB62CAlIgStj1niGo6wUfs=;
        b=A71Er80ksBtYVFg+0TaO4S19iJBwlJJQ5ToetK5EHPSRzga9Qo51P0qkslLpJqAqID
         V1FhLzIJj7CDEusfqQRU3hA+5346byUgGovjR+TcRASYCdYmgxubMRtUObxGprtwR4Vo
         rBnL7y3EIYqZBxzkDHZt6fo4pcqhw6MSk4bXIOei5Ks3GyW+hmkGWb827Z6vA+2ofxlc
         Q8ZDP9ZC2K7z0lVLc2fei0JCE28Q0v4zx7/uvll3Z0Cwu/xGH8pRL8OYBqZGxUxcHxFB
         nFW0ZBeiJjaL/3hem2Wv3bvGfdizAKku9JDtwEjp5bits7mD3+PAdmC1ED7atFqIUS39
         Oogw==
X-Gm-Message-State: ABy/qLbM746sTs87N2HfI3oW96/NqjptthjIAfeU43gasN7VcL/+ttBA
        ylIxzct7hz1vmZd9heN2/lwxLMkzDeKnRQiGHw==
X-Google-Smtp-Source: APBJJlEtgaOZvqlrgGbcYhiLUehU1+h01BWuQ7CUTaLh/SAIqW1VqePSRHvS4qtWm2e2Xyn8g8sqBA==
X-Received: by 2002:a05:620a:2d87:b0:768:14ee:234c with SMTP id tr7-20020a05620a2d8700b0076814ee234cmr9010116qkn.50.1689717674012;
        Tue, 18 Jul 2023 15:01:14 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d23-20020a05620a159700b00767c8308329sm893121qkk.25.2023.07.18.15.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:13 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:13 -0400
Message-ID: <50ff9fb2fb463d74065580e41c4cc194.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/20] selinux: avtab: avoid implicit conversions
References: <20230706132337.15924-2-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-2-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Return u32 from avtab_hash() instead of int, since the hashing is done
> on u32 and the result is used as an index on the hash array.
> 
> Use the type of the limit in for loops.
> 
> Avoid signed to unsigned conversion of multiplication result in
> avtab_hash_eval().
> 
> Use unsigned loop iterator for index operations, to avoid sign
> extension.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c | 38 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)

See my previous comment about loop iterators.

--
paul-moore.com
