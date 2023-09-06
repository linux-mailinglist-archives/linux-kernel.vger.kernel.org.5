Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D696D79372B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbjIFIap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjIFIan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:30:43 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFC4E6C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:30:31 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-44e86f3e4b6so984369137.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693989030; x=1694593830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y3qaHUpB3fswo9j8iqoOUfj4VcoKPrcYGCjIGR+vFLY=;
        b=DZPwYK/nMX3Qp7QV0W4tEEytiWvs6zwLPJeojxn8MzaHtaBnzP/drtTrczVjt4dfby
         Gb5Kfhn7AJGv81afM66MATJGgqsyr0SDGL98slxyCahMZtZ+4VH1TwUI12ZabXQpU/8F
         cTSmvs7cd56GGhMMv8I5KJJEVkJ8jm2EMCQ63dCTDROrGyu/J33W1MZ6zku4tURhvkiV
         qjTGZETcOIUZZKmTWR3O8z6dyDApAROWNvBG6PIQHxyQhdVY162nD+XI7KkJebCvdD0I
         hlq/4C9MIJ8iiH2U4PqSZyveggisBpDBrzSOdShTY84epXdIUmC247tGbCzrUOmkjhD4
         f2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693989030; x=1694593830;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3qaHUpB3fswo9j8iqoOUfj4VcoKPrcYGCjIGR+vFLY=;
        b=RMFGfMhA6C9w1ifwbnTCc7ZIqCSVOAKr0Sma/dX1D044wJNO/yBOkfbSPGY1k7ySfx
         0wEkvWg7XiMCedeypeTi5RuUXb0giG5kRwhPgA+fd/wEV0qnZLlyNoDLmo5vO6BgZF3g
         iOvspZpmdY1McnbjpHSENJnUXtXMF7lz4d/5os99Dzy4YpLnI6bpecfHrKobVGyshvCb
         RO5I5EtvHkN01pJb5f2A/RgKzPwnYEFxvDIYgIEo9x7mrGiJnG4VhNRqePLJaLUhHvIS
         YC27P7rRDL/GtSkpT+zUBzaHDQ73xLXl86KHxPp5tO3iIq/ydo4wJQDpyxo2fzgz5Jlz
         mntA==
X-Gm-Message-State: AOJu0YyADSc/hSRDJgnHOQL0zqWjhCDxiblHNXwKj/vUCFhcORzOEA9b
        GOtxilu/okVJ8P53aL/b+McXg9tl6xe/9P+gMZSyaYaUpuw7Lg==
X-Google-Smtp-Source: AGHT+IHW7CkDpGhb8VSPuS3Md9CoY4UNIenUGugQxg2PUOc0g6reQYOnJKxMbU52nY+a995WkBfvVYEdbPoCGH3A4uI=
X-Received: by 2002:a05:6102:1356:b0:44d:62a2:a397 with SMTP id
 j22-20020a056102135600b0044d62a2a397mr1767975vsl.28.1693989030451; Wed, 06
 Sep 2023 01:30:30 -0700 (PDT)
MIME-Version: 1.0
From:   Ed Spiridonov <edo.rus@gmail.com>
Date:   Wed, 6 Sep 2023 11:30:19 +0300
Message-ID: <CACm0Nn0a-Dd7SX5r3cPmph_a_pnWBXCat81OEFGk5XogsuAzTA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/microcode for v6.6-rc1
To:     bp@alien8.de
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the commit message:
> This part makes the loader core code as it is practically enabled on pretty much every baremetal machine

Hmm... I guess there are a lot more virtualized Linux instances than
baremetal ones, why should the microcode boot code be mandatory?
