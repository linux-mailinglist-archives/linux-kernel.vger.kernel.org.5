Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3633E755CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGQHdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGQHdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:33:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891AA186
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:33:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso6422290e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689579220; x=1690184020;
        h=cc:to:subject:message-id:date:from:sender:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zKmKTLXmJl4IrI3KGjrhzWyQ0jqbt+qmfLrIaf0PAGU=;
        b=iobThYhNpDHxZnDA6QuqHF86pJZGLct0jCkDjzO3zcGgnbHdGXmakdE1LMTRTcYpVv
         QBD6jVfccuJTKW12RCRkdz08UXaTmJPyhPGbv5A7luiGJM0/46RC7EDTzRbNHw/XqktA
         zR0AM8fqk8ye3xFqFiRLqem0w98s1D0GUZg5xKxLa1LBsRQrQRz9EqjEwxuYOd9r6Aul
         TD9VruFawZ9NA0daPV4dkyX478Y/O1UbDflpWoGhmkg3Uea8dqfXvFP3fjTxnQr685Xa
         HG+RX5Ar5ttNM24bORCK9dCFGQOcaLCx3iKQsCyHq+ZVI0eqzWA/NejdYWHKUev4lct3
         RZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689579220; x=1690184020;
        h=cc:to:subject:message-id:date:from:sender:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKmKTLXmJl4IrI3KGjrhzWyQ0jqbt+qmfLrIaf0PAGU=;
        b=DlbOOTbDJNtTNYrOYlHrTFNHMjowgJm/OtZmmjhBkmZQ2cDgIdgzv2Xuwsjmmyvbx6
         Y8GNotLL+BNOR/bJ8dsw4P/JOgicVQJaMOajmm05fCnI9JI9RUB4SizUm+DD2WwSLAfj
         KSE4MRNDy9OypevXVHv9N3PB2OvH+3S1jNuMj1c0oI7G/Lz30wWIVZLFIqCjE08Or9oJ
         2VDzJESlK2o8eewZNrVDZIIly6y6apavnWz+vWlZ9V2sJUD23gXJlUVgMRZa2t1sTFf1
         7kcsKgo+EGvogPrZ1oFEEJ/mQQmCTTV4U9IinPAwBh9PXxape3XeD7XMGr1g8iM0zYrp
         jZUA==
X-Gm-Message-State: ABy/qLYfaCyius7iJF2lkgjNWgKg3apOaqFdT/PMHyIsFCSG1n1waHJn
        d14kPNmSUh5kSn4cmwupAog8zUKiNXJzPy33oIw=
X-Google-Smtp-Source: APBJJlHQEvGi3Ct7TFoNtazDB7rZ7iTGxDDTzR5N7f+0zVIYzKF94V7loyXlmdCDO7y+FlXdlkGR+kI69zjgGHXy6gY=
X-Received: by 2002:a05:6512:2384:b0:4fb:8603:f6aa with SMTP id
 c4-20020a056512238400b004fb8603f6aamr9287175lfv.11.1689579219583; Mon, 17 Jul
 2023 00:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_8D245D1A87D17619EA8475E8F005A151000A@qq.com>
 <65f4c60a-9534-56dc-099f-ee7a96e0ccaf@redhat.com> <CAKdjhyBRcCFDiA923x0FLNYzs5vafENm96iAqV2XiDD_eTWBUQ@mail.gmail.com>
 <ZLFFGLQ6H/9RCaVf@casper.infradead.org>
In-Reply-To: <ZLFFGLQ6H/9RCaVf@casper.infradead.org>
Sender: cl1ntlov3@gmail.com
X-Google-Sender-Delegation: cl1ntlov3@gmail.com
From:   linke li <lilinke99@gmail.com>
Date:   Mon, 17 Jul 2023 15:33:28 +0800
X-Google-Sender-Auth: QVA3zl0oXRAlFcNIMYheonfzC6s
Message-ID: <CAKdjhyDMZBq=u1yphU=gTqb_if02ji2Ubn2mytHQ1tcypPiNdg@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: Fix integer overflow check in hugetlbfs_file_mmap()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linke Li <lilinke99@foxmail.com>, linux-mm@kvack.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        trix@redhat.com, ndesaulniers@google.com, nathan@kernel.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply
