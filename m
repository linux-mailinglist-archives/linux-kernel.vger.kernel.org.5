Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC267514AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjGLXpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjGLXo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:44:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557CB2681
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:44:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso103092b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689205485; x=1691797485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2x+ltqpxVqFqamIdgfkuygPfrt3KBuJFxkfy8ylBDE=;
        b=eWnFNe7SQNBtWjNYtEgRxZP1V7Dwz6vm7srAxhyEqqJg5ytAHwWaCWq8C9dsq0CR9B
         kZ40nSCLfac/qsKtXdaSt7YsfLPJ9Zyz66vVoyukagRMJwAfXiq0Fzz6FnPHjsyPItuE
         B1/N2dHSOwEw7xphHwoLAwAixm9PlGQm789PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205485; x=1691797485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2x+ltqpxVqFqamIdgfkuygPfrt3KBuJFxkfy8ylBDE=;
        b=ByVvlDahCINWdYmf4Y6b3su69lc1FKlHyXGoKTi1ybiY8LHe7sljAmSFHHmmOnodTC
         wBxfHrfsnjTyQ+2w55v630371kkjMA75SVy6xzmtpBREmS6l+KHk8I+u9r/BpzeOKuw7
         fJPgHs5MKAEM7HDfzIJVJGR3S49Bnsceq/rvUIVyPZx0ZuV/9PqOALSGzNMB9IU/etXV
         UU0SIOpE+kdVkSEHZgFWA1+oEI300w186WyKvInAYIljXl6+tTcchSXN1XVI67Szw/Pt
         3DrdT1JyxVK/xLPeS2VvHXL9YPDtilF1pUlvfav4ORMLd/nEA/BFHt5r70nSx0QCzLTU
         aIZQ==
X-Gm-Message-State: ABy/qLZ6GI+B+enGX+yWg2v9QdTpcmfwFr8h1cOgruFhjo909TrTYRvR
        7Dv/of0sindOmRZhp6L6CrPNnQ==
X-Google-Smtp-Source: APBJJlHKXFXT+3vQO6u1MtO+fd+vDgoN5oWHpeMsy44Y47+W6SCldG9VCty9uD8GsegZWrC3T4Gi8w==
X-Received: by 2002:a05:6a21:6d9b:b0:12e:f6e6:882a with SMTP id wl27-20020a056a216d9b00b0012ef6e6882amr20160956pzb.32.1689205485375;
        Wed, 12 Jul 2023 16:44:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902e55000b001b89891bfc4sm4461515plf.199.2023.07.12.16.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:44:44 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:44:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] kyber, blk-wbt: Replace strlcpy with strscpy
Message-ID: <202307121644.75BD707@keescook>
References: <20230703172159.3668349-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703172159.3668349-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 05:21:57PM +0000, Azeem Shaikh wrote:
> This patch series replaces strlcpy in the kyber and blk-wbt tracing subsystems wherever trivial
> replacement is possible, i.e return value from strlcpy is unused. The patches
> themselves are independent of each other and are applied to different subsystems. They are
> included as a series for ease of review.
> 
> Note to reviewers: MAINTAINERS file does not specify clear ownership of
> these files so I have addressed these to the latest committer for these
> files: Jens Axboe <axboe@kernel.dk>.
> 
> Azeem Shaikh (2):
>   kyber: Replace strlcpy with strscpy
>   blk-wbt: Replace strlcpy with strscpy
> 
>  include/trace/events/kyber.h | 8 ++++----
>  include/trace/events/wbt.h   | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

These looks correct to me. I can take them if no one else wants them.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
