Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16113756CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGQTMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGQTMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:12:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17F697
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:12:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7355261217
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 19:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F82DC433C7;
        Mon, 17 Jul 2023 19:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689621125;
        bh=q1vjV+05Nobu+JpLPIvwaIeB762dezHqnRTiLlcmLCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Afsjf+VM9coDlrupkQv82KwZkzsnSQMABlMiP4DBvH0g3j2utCdj0/XkhiKDnj1w2
         pq8VGIkhLua7XxjmwrfvEkuQzmjf/Ehwk0zut6ZsrNkDBoju3KhD3NmyEdWGdTqPkN
         YGkIGDRwsoGvPf/1NWtEmVoIsdMyPEA4Ynk89ffOMXaBXe1FAM5UF9bbOvS2zeUs+u
         JgrMUfo/xDZ5T+Y1IthQ2cjmPlv2lv81JMBAeAGrjSaHfWFrsRiZmAglQZFBVMAWZU
         r6A2Glrgiym8X1Gq/gj7Ds01uC0bDREc+1rWk9KhL5l1oyXJlJCPn0oiTDTTCZ9vJb
         yryDC6aA9T7+w==
From:   SeongJae Park <sj@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/dbgfs: reduce stack usage in str_to_schemes()
Date:   Mon, 17 Jul 2023 19:12:04 +0000
Message-Id: <20230717191204.29065-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c7a050b2-4ceb-9888-5e69-36aeec0989cc@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Mon, 17 Jul 2023 11:41:01 +0800 Chao Yu <chao@kernel.org> wrote:

> Hi all,
> 
> It warned because my config is wrong, sorry for the mistake, please
> ignore the patchset. :-P

No problem at all, appreciate for taking a look into DAMON :)


Thanks,
SJ

[...]
