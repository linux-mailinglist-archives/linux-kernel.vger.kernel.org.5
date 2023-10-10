Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C9E7BF1CA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 06:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442087AbjJJEEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 00:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJJEEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 00:04:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED09392;
        Mon,  9 Oct 2023 21:04:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B64C433C7;
        Tue, 10 Oct 2023 04:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696910661;
        bh=hPyKO5DO0BNd28hZ+zGZsyKJb/we6a5TifBIR3rPkdw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YIcBm8kOckd9fqORrM0pAPjiu66dweqjE71t6fhyWEr+WsU7voucx5uOoKLTTl3Bu
         1gWnodbcq7HxkN6DIbc7YsCR9Jy4PJbROgn9KQAFKN5qLsApwQf8wc/G50pEJX9oPI
         pBJ8uihsoXPflUnuXb88V6aJtK25Up9AsBG0WV3UdaMcaWNc2BvQHETOU577addU6f
         Nkwg3zDBARzIzZdqTBC1IDcjEwv5vxDVxmMhvdzknA2yAUCJh7HBXpoOy3ZGIsnkmF
         Y1KWkV0ui6rrO3axF33HAt8ckXdyeI8RvN1pyo6qzbImCA3Pi8OD30u9nO4DH8bc1e
         EKjmp1x2KQUpw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: wireless: ath11k: Use
 device_get_match_data()
References: <20231009172923.2457844-11-robh@kernel.org>
Date:   Tue, 10 Oct 2023 07:06:47 +0300
In-Reply-To: <20231009172923.2457844-11-robh@kernel.org> (Rob Herring's
        message of "Mon, 9 Oct 2023 12:29:06 -0500")
Message-ID: <874jizglyg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

ath11k patches go to ath.git tree, not next. Also the title should start
with "wifi:". No need to resend, I'll fix those during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
