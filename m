Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A42A7C582F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjJKPh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjJKPhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:37:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DADB8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:37:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CB3C433C8;
        Wed, 11 Oct 2023 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697038672;
        bh=sZYMiIgfprtrSPa/YkV0LT+ZOWe7IlPCwKkD47oyPlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SqMOVbfyTIsQHi9u7DJ5iIe+Ff0gwSpewAuPmDzyYXvqcvJ4F+kiBPbNSqrlJQCRK
         tl46k7q4/GIsuM7g4CwYR5gzNQxaknnoWaSotPpEGO/v02gd346PPfYUXzJFP37CeZ
         1b8PmDksnZhMFZJciijKOd81d9mD1d5wdrPRzetPswD+VujzyqUgU7uwhKfuQJn5b6
         dZ32lmPgn2Gcwb4ezDISUOx2EMgAWCKMPcBIL/8aUDlgnc1ziq+hJv678yteFFpcHP
         kihDfRlFKpIHXiE0oRUkMx4q6TEM13lCXeM/lE5TR920UXFBWWVOpeJX98sphVmy3X
         80UQuo8FOYC2Q==
Date:   Wed, 11 Oct 2023 17:37:47 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>, Lin Ma <linma@zju.edu.cn>,
        Ilan Elias <ilane@ti.com>,
        "John W . Linville" <linville@tuxdriver.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 net] nfc: nci: assert requested protocol is valid
Message-ID: <ZSbBS74m2PmdSmP2@kernel.org>
References: <20230906233347.823171-1-jeremy@jcline.org>
 <20231009200054.82557-1-jeremy@jcline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009200054.82557-1-jeremy@jcline.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 04:00:54PM -0400, Jeremy Cline wrote:
> The protocol is used in a bit mask to determine if the protocol is
> supported. Assert the provided protocol is less than the maximum
> defined so it doesn't potentially perform a shift-out-of-bounds and
> provide a clearer error for undefined protocols vs unsupported ones.
> 
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Reported-and-tested-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>

As per my review of v1, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
