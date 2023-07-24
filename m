Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12B075EB68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGXGVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGXGVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:21:47 -0400
Received: from dogben.com (dogben.com [IPv6:2400:8902:e001:2f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B31BE
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dogben.com;
        s=main; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
        In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=L9/Ov3ckf7Fe+amDurJrRPVEjT1XCcSCKaDWGlGVVbs=; b=D59vK4VFSovfOi0aXuz7EAF04G
        YK/V8lmBOkLPctS3lF1msL1AU7v7Z08ctHbHlRH3Bhzl4QUsdOAGXMkITil48C9tbEJoHtqlF3LDo
        V1kOoguV0eY4PrZj04b6w3l8QinvqPG9aNR8eBdTADUjEMMb/h0OEggL94AuvnUE+7ubUQrJaBnaS
        VISGVCmdT9bbYNF/iqsl0+qH4zLxQ259nqMj81XWFe0DqbP19ZMKruBezoTt8/96e19iCzd5SyUv5
        wIkUCg2GMQxajpZYba5Mzey+2F4byOVvDU7F86/qofF9I2sDkgxyD+kzMHnz1TcnU/YD0RSIGQxvF
        zsvWugxA==;
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 14:21:42 +0800
From:   Wei Shuyu <wsy@dogben.com>
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     ilkka.prusi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: WARNING: at mm/gup.c:1101 __get_user_pages in 6.4.3
In-Reply-To: <8fbc7879-09b2-4b1c-86e0-f8835b675843@t-8ch.de>
References: <CAJuPgPMp_B-TcBq0NWJcaL-aF4YEcJvx0ain7qVOLb-trVqrsQ@mail.gmail.com>
 <7c6b632270d0c250c5791a6db5dc3e9e@dogben.com>
 <8fbc7879-09b2-4b1c-86e0-f8835b675843@t-8ch.de>
Message-ID: <882633660a17792b574bcedea1431a6c@dogben.com>
X-Sender: wsy@dogben.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-24 04:34, Thomas Weißschuh wrote:
> 
> This should be the same as
> https://lore.kernel.org/lkml/202307041023.bcdbbfc0-oliver.sang@intel.com/
> 
> Which was triaged to the chrome crashpad library.
> 
> The false positive is also fixed on master with
> commit 6cd06ab12d1a ("gup: make the stack expansion warning a bit more 
> targeted").
> 
>> [..]

Seems safe to ignore the warning. Thanks.
