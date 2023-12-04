Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D41D803B12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjLDRDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjLDRDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:03:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A6DCA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:03:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D4FC433C8;
        Mon,  4 Dec 2023 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701709392;
        bh=Pv3VYEkqIQLnSP8xafFSEbNXHalrpqZF41HTmyx/BUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FsT0xkdPXwslVEvkh776LXBEI7/HNwK2VGemBa3xaaWGrtQ0DPd0mVA3SvldUA+6a
         YMamvcIbquAMtlhfBAO9og1jAFc9xvcEZ0FyZdZdT/8W3UDpKUk3Wnjn23xCX0wOCt
         aC1wDIzv2U+Ihk46lP7NgYV9DDRjJApAnT67Qn+4k2Sj9IGuFH9S9TGm1bcGuqzYIA
         mi9Z/BEquIOSi5hhk9ndwBgTwe/+YvNi8phIR86WQhGwXdjmPJ259aAcbbJLPBMjJA
         oilm5DADTpOWrVW3BBxffs8jH6Bac/5014NKSkuU7ns0uIKprirmaoJHcIgr0a27D1
         1g+Whq4qKAAnA==
From:   SeongJae Park <sj@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Date:   Mon,  4 Dec 2023 17:03:10 +0000
Message-Id: <20231204170310.61209-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204155442.1243c74e@canb.auug.org.au>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 2023-12-04T15:54:42+11:00 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the mm tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> include/linux/damon.h:201: warning: Function parameter or member 'get_score=
> _arg' not described in 'damos_quota'
> 
> Introduced by commit
> 
>   99b36eab9c05 ("mm/damon/core: implement goal-oriented feedback-driven quo=
> ta auto-tuning")

Thank you for letting me know this.  I just sent a patch for this:
https://lore.kernel.org/damon/20231204170106.60992-1-sj@kernel.org


Thanks,
SJ

[...]
