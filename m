Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D267D8AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjJZVwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZVwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:52:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD3E129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 14:52:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC67C433C7;
        Thu, 26 Oct 2023 21:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698357138;
        bh=Ar47rK4VoU9HotPJMrv49W+xY9ALyh8WYdwKhKQgUjU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=toS75VrT71cikMeUq+SfNasbWtSG1FISHYIJFDSUO0ISgit075mYCrh1WTa96gqPk
         B4Ho5FKtAF9MAaCg9k9C4EFXLyF6ncBFhU9Mt2qYJNLwAF1ftJPxlHjLqQi4qpuYTm
         Qee57m3AjAjykTLJfW+C0S85VION5dk47IDxHcwPM8jsnAZ4EIdjPp0KMdcnHUr1jN
         H1Gjou0ILvGoQZANolOE1wDuky0MwqaK+OtnnlcijosFr061irIm8KNpwIFIimabRH
         DIxjo7PAf2Hb67ywTo4VIEPMnQCz3ZeXdZ1THQFQykeZKZ/F6arfAU99Iu0Amo3ocy
         6qOjLI9h9hZSw==
Date:   Thu, 26 Oct 2023 14:52:17 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wojciech Drewek <wojciech.drewek@intel.com>
Cc:     Ratheesh Kannoth <rkannoth@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [EXT] Re: [PATCH net] octeontx2-pf: Fix holes in error code
Message-ID: <20231026145217.4b840baa@kernel.org>
In-Reply-To: <0d1cb5d7-53e8-45bd-ad45-48fae64b8d9c@intel.com>
References: <20231026030154.1317011-1-rkannoth@marvell.com>
        <5819e6c8-d887-40ca-9791-07c733126e64@intel.com>
        <MWHPR1801MB1918043F69F45C9D69656449D3DDA@MWHPR1801MB1918.namprd18.prod.outlook.com>
        <0d1cb5d7-53e8-45bd-ad45-48fae64b8d9c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 12:56:26 +0200 Wojciech Drewek wrote:
> I'd add to the commit msg that some error values were wrong and it it
> was fixed, but it's a nit.

Agreed, it should be explained in the commit message.
Borderline it deserves to be a separate fix.
-- 
pw-bot: cr
