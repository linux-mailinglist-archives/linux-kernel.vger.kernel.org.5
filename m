Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8B4770221
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjHDNqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjHDNqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:46:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B181ECC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:46:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso19434795e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691156763; x=1691761563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWuu2OnLKmbYmSWSzEw/OZwUtFt5TnMq9XjoBkxbtSU=;
        b=AdNRPW8NVlSEdiGvGG4AzCR4ZwB/6Sr/SWoQ4LVb1SvUJGjrLF86H5+k6QMcgb6wbO
         NuqqhukaO6/isA6KMbFL4XRc+UZtXIzS+EsMnzd4c7+2lcc9g627+PgBESdqwGvvcIaN
         DH+7FO4D5v7AAB7i8ivbYMF9boB5co9WeXmY1QOMsTS/w5MfI9ddIBpvqdZPJUxvRVxF
         2Uz4phSg4X6F5Sq7zcELLN82nLLwxZUD8OPwz6KWRSCrlpDnKuD9AtZBdvwGo9beIhXI
         OTA2sXn5nzq38njmBscc5SnKqjTEUsx18zXmMPK65glSkjgvTSng00YxyVVnnOI29bY1
         TvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691156763; x=1691761563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWuu2OnLKmbYmSWSzEw/OZwUtFt5TnMq9XjoBkxbtSU=;
        b=NKz/hAXMHN3GtV3IlRnnDtzGJZBhqw0IKB/xGGXf2tGFMQwau7L+ib7s8lMeY7oPlg
         9FNs/vODT8TcARpMkG3fnj6s2DGuSI0kmeAi8r9dMvkBGMQjSTOYj9Ju03YzrQd34KAJ
         +VtxgdLMOFEmYAGHwexSkutoeo9UG7oNIURs9wYAtnkvtQPspExp+LJNW3idsa5ERXgi
         YEogKkEN6mRUm/SPA5+wTqE3/D1h7zq1h8RxAzXgE1w+GBBdhZaTCK6P5Bz8OUGfjFEp
         tgBggr2tr+eCX+7b1OZIOSbeTg64rpbuh/24g/c1164ufXMIk6rYabe3/0+Heg71LVnR
         wf3Q==
X-Gm-Message-State: AOJu0YybGxav0xsKTRmIKdqePWjIg/puk/46pQpRRJqogvTx/X/K2T3S
        9SpbWH+f9Rb9tHtJDrCULhRh3A==
X-Google-Smtp-Source: AGHT+IEurdBJVw10nT5g8eJSHrfsPFgwk2PgPdluZkwQK2tvT4oKT1F6OL+j6HTggPdKhhBIcIfutA==
X-Received: by 2002:adf:de0f:0:b0:317:61d8:3c83 with SMTP id b15-20020adfde0f000000b0031761d83c83mr1324718wrm.3.1691156763151;
        Fri, 04 Aug 2023 06:46:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p8-20020adff208000000b003176a4394d7sm2587093wro.24.2023.08.04.06.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:46:02 -0700 (PDT)
Date:   Fri, 4 Aug 2023 16:46:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: vme_user: fix check alignment should match
 open parenthesis
Message-ID: <7159231c-9e87-4a3b-bc0d-a6ade6c04c65@kadam.mountain>
References: <ZMkwA8TnMBAgPRgR@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMkwA8TnMBAgPRgR@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 01:17:07PM -0300, Alexon Oliveira wrote:
> First patch was intended to fix all "CHECK: Alignment should match open parenthesis",
> but added new warnings in the process. This patch is intended to fixed them all,
> on lines 133, 142, 144, 145 and 173.
> 

Since you're going to be re-writing the commit message anyway, please
leave off the line numbers.  Line numbers are not really useful.  Just
say:

    Fix the checkpatch warnings which complain about "CHECK: Alignment
    should match open parenthesis".

regards,
dan carpenter

