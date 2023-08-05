Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE8E770E6B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjHEHZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjHEHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53904EC7
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 00:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4818360B5C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 07:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE06C433C7;
        Sat,  5 Aug 2023 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691220311;
        bh=E0NfDEjMRsPv+gyd0sYbOv3jaYygSJdML+8/lrfvaZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TcJxFuZpzKlaJkrQvJZDi9gVUkT78wSfiROjYvecJdiZFksuMjhBPC8KMW/D36xmK
         ccBO/kan0pZuqjLYTSaIaaohR+o5ZAW7h2V/o0vJj6wKmRx0Z6ZoqBJADIS68o0YUt
         DVBDOyT7eioUtiH53UM0tmiDOUOr3rYR26d2RlS2sgUfkYCBiiHQuK5XhsPrLrAZkb
         S/GgklMtQu+vSG0VYa7B02wyvVS3txDCVuqAT1NyT9NkXEe56P5FLJJeEwQTp52Z1Y
         xJIngeKVuFmjyIYc0+NxyH9OKWaOeFvxtLK0ZnqoRYBNPHMNnymu96K8I+YS2BH9yV
         I9fGVFuK6Y71Q==
Date:   Sat, 5 Aug 2023 09:25:06 +0200
From:   Simon Horman <horms@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com, simon.horman@corigine.com,
        jesse.brandeburg@intel.com
Subject: Re: [net-next PATCH V5 0/2] octeontx2-af: TC flower offload changes
Message-ID: <ZM35UguoE2KrX7JF@vergenet.net>
References: <20230804045935.3010554-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804045935.3010554-1-sumang@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 10:29:33AM +0530, Suman Ghosh wrote:
> This patchset includes minor code restructuring related to TC
> flower offload for outer vlan and adding support for TC inner
> vlan offload.
> 
> Patch #1 Code restructure to handle TC flower outer vlan offload
> 
> Patch #2 Add TC flower offload support for inner vlan
> 
> Suman Ghosh (2):
>   octeontx2-af: Code restructure to handle TC outer VLAN offload
>   octeontx2-af: TC flower offload support for inner VLAN
> 
> v5 changes:
> 	Resolved conflicts with 'main' branch
> 
> v4 changes:
> 	Resolved conflicts with 'main' branch
> 
> v3 changes:
> 	1. Fixed warning in file
> 	drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> 	2. Updated commit description for patch #2
> 
> v2 changes:
> 	1. Fixed checkpatch errors in file
> 	drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> 	2. Updated cover letter subject

Hi Suman,

Thanks for your patience with the minor fixes and rebases.

Reviewed-by: Simon Horman <horms@kernel.org>

