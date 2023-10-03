Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43057B6669
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjJCK3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjJCK3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:29:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4343A3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:29:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E11BC433C8;
        Tue,  3 Oct 2023 10:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696328967;
        bh=jXuGOUwI1yvSy2BEPDdzmf9cHXPyEcMQXrsWAPM3Lpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kqcITCWlLywDa065bvePch/EM+Fhc9kRn1Pf1zpPvsI7zEZCyqPb/tzWRbuJF52/S
         GpnKjE+wRVeGLEE3+29+yE10Hp0MGoCH3PQjW+l4ZWJUJyxeKHCzfitf4LXHOLRkVb
         GAmvZunFsFc/Z6UoAyJJOiyKX7DfZOk2/q1k5bzhXUPw3j2l4WHusRyEH1VgM9lRXp
         zvDdzD1Cy+4UBtGbrNvXC8SupHfACPgAOlhjljMEnQXHWTCVLVmHc0E7y304VTCgMl
         leZc6zYGsJhmVUJUErh5QAziKVNzws+LryHGeTbuSoaUNhocFYW9X2vGZbfah6Fsqs
         YZRRngcUmIkTQ==
Date:   Tue, 3 Oct 2023 12:29:22 +0200
From:   Simon Horman <horms@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] hyperv: rndis_filter needs to select NLS
Message-ID: <ZRvtAq7Vxb2G89J+@kernel.org>
References: <20230930023234.1903-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930023234.1903-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 07:32:34PM -0700, Randy Dunlap wrote:
> rndis_filter uses utf8s_to_utf16s() which is provided by setting
> NLS, so select NLS to fix the build error:
> 
> ERROR: modpost: "utf8s_to_utf16s" [drivers/net/hyperv/hv_netvsc.ko] undefined!
> 
> Fixes: 1ce09e899d28 ("hyperv: Add support for setting MAC from within guests")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

