Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB7875A52B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 06:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjGTEhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 00:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGTEhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 00:37:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEBA1BFC;
        Wed, 19 Jul 2023 21:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB88611A0;
        Thu, 20 Jul 2023 04:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD80CC433C8;
        Thu, 20 Jul 2023 04:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689827850;
        bh=wtXXdLVLfi99i9vNuFnHhlk19NvlcTjhBzB3ICdAvko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oR77DCAfnIF9ROq994H/Xxvg6BqQ/PtjhVzf+zqKANe+7KHHpQeBCXRhkn2gEIApa
         4AEtuJvpN/O2Pq0MQUp2W3fVWVr5ZpIt2dOpJA1v2CMAIj6rZbaOvwP7MJSOP5rHpl
         eN3abGN/HXKPbVB6+uP2nGODF333tccSEw3RJFHu+A8YgWydSjSHMBQc4b2EmqEBB8
         j9sNLkytr2JIA2K+dgRuw3tAL5v5VPEiY5vLjEaUbrB8Ry909OMyx1XSwlowZEeqwN
         NncHiCRCejDM5uu7qVfuMCeVjiOLbue/PQC9KOthxIiGJfyGXSOV/InTxkfImD/5xX
         lDqVrn8LUChMw==
Date:   Wed, 19 Jul 2023 21:37:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vivek Pernamitta <quic_vpernami@quicinc.com>
Cc:     mhi@lists.linux.dev, mrana@quicinc.com, quic_qianyu@quicinc.com,
        manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
        quic_krichai@quicinc.com, quic_skananth@quicinc.com,
        andersson@kernel.org, simon.horman@corigine.com, dnlplm@gmail.com,
        linux-arm-msm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH V3] net: mhi : Add support to enable ethernet interface
Message-ID: <20230719213728.65118446@kernel.org>
In-Reply-To: <1689762055-12570-1-git-send-email-quic_vpernami@quicinc.com>
References: <1689762055-12570-1-git-send-email-quic_vpernami@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 15:50:54 +0530 Vivek Pernamitta wrote:
> Add support to enable ethernet network device for MHI NET driver
> currenlty we have support only NET driver.

There discussion on v2 doesn't seem to have ended.
-- 
pw-bot: cr
