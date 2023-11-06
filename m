Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FBD7E1912
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjKFDIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 22:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFDIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:08:10 -0500
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ED3BB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 19:08:07 -0800 (PST)
Date:   Sun, 5 Nov 2023 22:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699240085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPB+gQULftzdxrXbYK+nTuNYwE28bOhzjLLNlNRU7tc=;
        b=e7OoKvB4mHNMqZpzcNRZjvkdmVp+mpZ6DiAuSYmfMfDC7YyD1jYiG68AAvEM9okKQoRzwG
        DQ4aTwmbRmDQ9BS7qSsVfyW4edLr/OKQE6S7NxklgFoxJEWSwdnn2TRUxX2vaWTfHZ/Omh
        L7p5KwYdeV5fY72ZrGkhYo/lARVDdWg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] bcachefs: make bch2_target_to_text_sb static
Message-ID: <elba3jjtl7ftiq5ey37u2t27xokab7n2ulbynl4gev2dpzyfr5@gjkv3hrkgt26>
References: <20231106023401.28196-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106023401.28196-1-jiapeng.chong@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 10:34:01AM +0800, Jiapeng Chong wrote:
> The bch2_target_to_text_sb are not used outside the file disk_groups.c,
> so the modification is defined as static.
> 
> fs/bcachefs/disk_groups.c:583:6: warning: no previous prototype for ‘bch2_target_to_text_sb’.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7144
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks, applied
