Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638A67E96A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 07:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjKMGQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 01:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKMGQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 01:16:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2DD1719;
        Sun, 12 Nov 2023 22:16:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2041C433C9;
        Mon, 13 Nov 2023 06:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699856187;
        bh=f7P/2FEufZ6MYuuGYCr4NLzyjnoJSoG0mGhvbSldVZ8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gupgIl0Oorx/EUYnLi9gflXFNcVlYijoJbZ8mg4wh3+MALWVo8ExGSYwey4gPnbiB
         Ag6XYbgKkTznV/iaM12asMO25A41+c0Hzz15n8MlbjS6HYu4ZINNAEqkfX1GWLF13L
         ZwB+BoTnyPQSuAZxwSHWihgA1L20bjbdxJOLCmGzh57PvLFvfRFhbrYvmJT4weKve/
         lqSdUd91Bzl7pbYWik7UFcYj/2yfdniQkiAD6mhsDVDGRW3AZTygdWByFON/2RzWat
         EDN+W77+cuGVt3WSyTQQ5sEDplLDW+JBGDEQLWlSMZ/S3Mr7eHgKYtfSFJLahITp6l
         +6GUw5ZcM/6NQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH wireless-next] wlcore: debugfs: add an error code check
 in beacon_filtering_write
References: <20231113044113.74732-1-suhui@nfschina.com>
Date:   Mon, 13 Nov 2023 08:16:24 +0200
In-Reply-To: <20231113044113.74732-1-suhui@nfschina.com> (Su Hui's message of
        "Mon, 13 Nov 2023 12:41:14 +0800")
Message-ID: <87h6lquqiv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Su Hui <suhui@nfschina.com> writes:

> wl1271_acx_beacon_filter_opt() return error code if failed, add a check
> for this is better and safer.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>

How did you test this?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
