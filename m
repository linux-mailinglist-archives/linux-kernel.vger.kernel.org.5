Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68217CB5B7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjJPVw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjJPVwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:52:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13B2A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:52:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2C4C433C7;
        Mon, 16 Oct 2023 21:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697493172;
        bh=XoagB7RssmrdXCC7ca9EuXuf2feY9l34Rct0YBrHnIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EUdMzvBy0CVPhC8fRRYEKHIaC3aEURLSY48+sgoFBvUYurCdlDuZSFv7mYi8xBO/Z
         1KmuBG7KTNDyUmCWksYynhzY60BFUVYkhIdRqId4m1ffXBru+1tvlFG6AjZ+h08iMi
         Y+hSklqhJXM6JZgTDHdmlxpQCYBHu5aZD7G+TsB6Sz2z2OcaP7DCuYs46lSZ1iI1Tr
         NqE5+uBdmP1Gjljoh1bxASoQWyizNoeKmBkhXUIEiyx+IoI2AIGO83+rWCreCmb9l8
         dl0JbYtfci3Ih5exVyVumt1fjHd8vgGdauXBCoG8/vEtGRu+A3NRO2XGzppfaYl+Fn
         Lr8mYSxz0h6Jg==
Date:   Mon, 16 Oct 2023 14:52:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        Haseeb Gani <hgani@marvell.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Sathesh B Edara <sedara@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>
Subject: Re: [EXT] Re: [net PATCH v2] octeon_ep: update BQL sent bytes
 before ringing doorbell
Message-ID: <20231016145250.68fc1616@kernel.org>
In-Reply-To: <PH0PR18MB473487DDE40F83927FEBDC8CC7D2A@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <PH0PR18MB47342FEB8D57162EE5765E3CC7D3A@PH0PR18MB4734.namprd18.prod.outlook.com>
        <20231012101706.2291551-1-srasheed@marvell.com>
        <20231012170147.5c0e8148@kernel.org>
        <PH0PR18MB473487DDE40F83927FEBDC8CC7D2A@PH0PR18MB4734.namprd18.prod.outlook.com>
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

On Fri, 13 Oct 2023 09:04:07 +0000 Shinas Rasheed wrote:
> Apologizing for the format errors on my part. Should I send the v2
> patch again separately in a new thread, or will this be enough for
> now to avoid the clutter?

Sorry, I meant to get to this on Friday but run out of hours.

No need to repost, my comments were just for future reference
since you have sent multiple patches already and will likely
send more :)
