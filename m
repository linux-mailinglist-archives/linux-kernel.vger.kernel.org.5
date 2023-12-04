Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250FF803A8E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344775AbjLDQjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjLDQjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:39:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E88F9B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:39:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5155FC433C7;
        Mon,  4 Dec 2023 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701707998;
        bh=MgFWaWNx9i/xDOOSQ9MpMUgMmqSc1reTXGh7sUetAUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADzcMsE2i2UTU0caND6AJ48een6qtYHlZ08l67jA0rbDO38592PF1AwSIHbq9u+mo
         ow8TN8FJDi+dzAyGAVDDxle3l6DQVZMho5WFM2iRWEIOvYnVAzOUGVSdHlm67vsIqn
         9k8TevJrjx6uyj7saxRakfzewKhWKDgTZwevmt7we8wc1lWSE1I/Szg63K/PtriTUX
         SnxzKimq/C1yaLP4nlPlEInd9YM06LTzARJYd0nqRtnGZb/fv9r3Zh7ePdlmwqrxMY
         T5yS1VYsVwRdizmdD+/Op/rSxAUrfmueViSQeNdbyZwQrBpbxzIYxKiuQmHaM0SJXy
         JEIQMRPSQ7SkA==
Date:   Mon, 4 Dec 2023 09:39:56 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Bitao Hu <yaoma@linux.alibaba.com>
Cc:     sagi@grimberg.me, axboe@kernel.dk, hch@lst.de,
        kanie@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: fix deadlock between reset and scan
Message-ID: <ZW4A27UR95CqtlLt@kbusch-mbp>
References: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
 <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied to nvme-6.7.
