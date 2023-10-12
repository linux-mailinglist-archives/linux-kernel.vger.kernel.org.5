Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338197C6DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378368AbjJLMNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343987AbjJLMM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:12:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C5CB8;
        Thu, 12 Oct 2023 05:12:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8540C433C8;
        Thu, 12 Oct 2023 12:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697112776;
        bh=b8BfMObBykm/amO/S9HTj8NCZ8lSEHJnylp7Iixrelg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HnXyh/1JtDFJPMutjG1drZN79OU8VOwrjRf3QnTje1l52GU4tuS4jltsO5jTr8Ze1
         WPibteX9NDTm6YDlIDxF5Z1FuXqPhB7mQPf60ikM4U1CWval213mjNN4czWwpfnqMu
         RA4+3kCNlPCWdP8Y5THHnzZaqABIC7A3qCxi1X8kQ9zeluCWrhvoSOtz/N8L6rtL0d
         Dt+n8ccH+UHZhvCYXcoSDm/Qq1xsuW4zE78vMz+mi3s4K/y4VaWzQ1y2doI22vtcnB
         jbegiWzKp6CIDq7Hmi4KgNcWbBQRafLL76BofmwShaCtDcDa1hB7ghRzUE+q8PzfI0
         CvNSgbpznSxQA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: p54: Annotate struct p54_cal_database with
 __counted_by
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231009161028.it.544-kees@kernel.org>
References: <20231009161028.it.544-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
        Jason Andryuk <jandryuk@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169711277180.2932680.4051421133229549634.kvalo@kernel.org>
Date:   Thu, 12 Oct 2023 12:12:53 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:

> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Add __counted_by for struct p54_cal_database.
> 
> Cc: Christian Lamparter <chunkeey@googlemail.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Jason Andryuk <jandryuk@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Jason Andryuk <jandryuk@gmail.com>

Patch applied to wireless-next.git, thanks.

d9756ce618f3 wifi: p54: Annotate struct p54_cal_database with __counted_by

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231009161028.it.544-kees@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

