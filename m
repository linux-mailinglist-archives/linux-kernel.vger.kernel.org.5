Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15672779A5F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjHKWE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHKWEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:04:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCFF100
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C684E641CA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 22:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DE1C433C9;
        Fri, 11 Aug 2023 22:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691791490;
        bh=R79FmNVLkjyVIXv6tcSmcPvmWYKleg4cZwFL8d//vZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QIeCOjJ3kgBHaAngByoR+7WKXG5S3MUZzf8VNz4lm5p93cp034lXuqIByZvWT3QWE
         B3GG5Uz7waECrMAkotSKH3qKsLzzW8jxT0I5FGlWJBg6qvSh5osqDiDZLOwj5Tx43t
         s7gfbB+ZiflZvnrVAChWKhUqOWqqDnQ255PPJZNFblCZCIICRiOFeSBDCMNZMEftNx
         Cb5wpLLLHabXpfMq87yxFAnux0CV4c1uwqoaKHVId1f7aFp1cu8z7fmWZ0Y03SSNJ+
         LYAYffE0I2Uup57miARef5Pb+nxLSizI/bAxkvLV6Dvw1/AXJsvENaOLz6YWlsKuek
         KFSynfrpfgHXQ==
Date:   Fri, 11 Aug 2023 15:04:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sai Krishna Gajula <saikrishnag@marvell.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH v2] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Message-ID: <20230811150449.64ce3512@kernel.org>
In-Reply-To: <BY3PR18MB470745294C1B03C0DA5364E6A010A@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20230807140535.3070350-1-saikrishnag@marvell.com>
        <20230809155022.132a69a7@kernel.org>
        <BY3PR18MB470745294C1B03C0DA5364E6A010A@BY3PR18MB4707.namprd18.prod.outlook.com>
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

On Fri, 11 Aug 2023 05:48:38 +0000 Sai Krishna Gajula wrote:
> > If you reorder the includes - maybe put them in alphabetical order?  
> 
> There are some structure definitions in rvu.h which are required in
> ptp.h. So, re-ordering in alphabetical order will give compilation
> issue. 

Headers should be self-contained. Such dependencies are hard to figure
out for people doing refactoring so it'd be best to clean that up.
