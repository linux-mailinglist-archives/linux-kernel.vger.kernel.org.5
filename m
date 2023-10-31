Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E79A7DCB02
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343974AbjJaKhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343692AbjJaKhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:37:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA60A9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:37:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA578C433C7;
        Tue, 31 Oct 2023 10:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698748672;
        bh=RDrKBTKkDEoBkZM48hf5KpJenW69RiQQEbo97Ed53sM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+H9HO1625DKNGF7DTHy1PcSsc2B5L4yQO1GFFaOD4v9+3sGm9tgXmJQxyXyDK+ek
         UEXUfpWES3sL0nmibAiI33a2B3aSn3s7XKlyqlzO7VDp+eZ0QMtjCdE8LhM56c7nUq
         GHX7/7yABYfIdmYSH4OXrQXU/mBXLzMtLP2FORBJK6NynDPmt4BUDso3L+q7lslT69
         xmF5Wu/mYxgOq0N7EInz0mIitHJyoVa8qiSWEbuX1DUxhL84pu4xpppnHY2cxiahfi
         GR09r6/rX6x3CcDWE3AbslnMn8af+OVYZyepdQa+6GngzHOuP0+DzNa1JdanxQslk/
         LqLOm4OTsUB6A==
Date:   Tue, 31 Oct 2023 11:37:47 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce for_other_threads(p, t)
Message-ID: <20231031-funkanstalt-wohlstand-06346bf72934@brauner>
References: <20231030155710.GA9095@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030155710.GA9095@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 04:57:10PM +0100, Oleg Nesterov wrote:
> Cosmetic, but imho it makes the usage look more clear and simple, the
> new helper doesn't require to initialize "t".
> 
> After this change while_each_thread() has only 3 users, and it is only
> used in the do/while loops.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
