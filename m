Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62E17A762C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjITImj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjITImb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:42:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E0693
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:42:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C08C433C8;
        Wed, 20 Sep 2023 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695199345;
        bh=hEUuxuFh0kGe5BdlQv+cI5SNpDgSIM6ER49DT371oOo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S311jB3Kt+8O6f5c17RXE3IYiB7Ag73NgmB4hz64Dqz4EwB376LIrd8JFmktzD4mp
         ap15DMpOvIGcloHuBk/lU4U1GYWEXT/03+c0wGwa5xd0j9c1b53beFg3peZ1wM6uDt
         PVwqLXNNQAGf6pNOJnhibS1ax2zNmRHuizngXgPCp1xgHPBNujrrIcNDZE8SpcY6WS
         s/Ftw/KfTfiuLu6REwTwPMmWu+vC77lIagD8+0Oo48cNY7z0V+qrwmco2be1bPJzoq
         2TSqntRl9WsTh2hbKVGFmCwhPKH0JKWo3TebB2GLlhPmnoFs9GelmAcqH5TQbpx9zZ
         W5J2Tcde7S1Tg==
Message-ID: <b86e4f39-efba-b396-d209-ba085c0f2415@kernel.org>
Date:   Wed, 20 Sep 2023 16:42:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: preload extent_cache for
 POSIX_FADV_WILLNEED
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Eric Biggers <ebiggers@kernel.org>
References: <20230920004645.1462354-1-jaegeuk@kernel.org>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230920004645.1462354-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/20 8:46, Jaegeuk Kim wrote:
> This patch tries to preload extent_cache given POSIX_FADV_WILLNEED, which is
> more useful for generic usecases.
> 
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
