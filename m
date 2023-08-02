Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DD676D5EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjHBRsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbjHBRsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:48:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1AA1FD6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 694A561A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D2CC433C8;
        Wed,  2 Aug 2023 17:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690998463;
        bh=kV9NfAwEiyRC6suvZbE0jpxaoqklhAtkhU0iiN3U7S8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CEMIiX+wwTlL3uCSxU1l8G9VXsCpuXq8hyDVlZnhhkIKz2JpIuLqaD+0nV4bvVADc
         oyqtT5QFdccdh4r2tYLzDXQ6BIhdgN3WXFdgIpknr6ZI1WaEhtml/Gynui9cOMJpYt
         a3rbdk+xoiCYZIjshBxYaNUiS94JxcL9q/RBRBTvnbA5h8iEbTA/qyaAkBZdR6gQzi
         J6UFH9WyBs3GhIuxBXFZ0JRpMO3Hsbv/qyMvPMgRMl2ifks8RxPOpl2Mko5cSLYN8S
         G6EtfS9M0PHlLKRisHamCUTkIT+oZJ/BpHZpDzidJLwZCvI1ZVDHFgF1YOJv/vviDz
         fdW9PpIf/0XSg==
Date:   Wed, 2 Aug 2023 10:47:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        shenwei.wang@nxp.com, xiaoning.wang@nxp.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, larysa.zaremba@intel.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH V4 net-next] net: fec: add XDP_TX feature support
Message-ID: <20230802104742.2f129238@kernel.org>
In-Reply-To: <20230802024857.3153756-1-wei.fang@nxp.com>
References: <20230802024857.3153756-1-wei.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Aug 2023 10:48:57 +0800 Wei Fang wrote:
> The XDP_TX feature is not supported before, and all the frames
> which are deemed to do XDP_TX action actually do the XDP_DROP
> action. So this patch adds the XDP_TX support to FEC driver.
> 
> I tested the performance of XDP_TX feature in XDP_DRV and XDP_SKB
> modes on i.MX8MM-EVK and i.MX8MP-EVK platforms respectively, and
> the test steps and results are as follows.

There were changes requested on v3, so marking it as
pw-bot: changes-requested
