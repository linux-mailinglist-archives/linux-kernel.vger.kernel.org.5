Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B87B8E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjJDUlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjJDUlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:41:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787139B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:41:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650C3C433C8;
        Wed,  4 Oct 2023 20:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696452068;
        bh=72lPpExPa7/l8tL0qUn7j7l+TWc7n+AL+YkQK0hH4Rs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=atmaCxJFjkuoGabbdB9Yr5oZJNjn/Bdzqi3HITjYF6aqnSMDpHMH5bfp99hp4hu9S
         ZLej3ZVqDIlgcOCVWEh/z1TfL0JlJy7ejY/tVkUEWh1lkzML859fY26D21NbzrJ6oS
         mZcJ+vs7HWLQWYMCkiilFAeuUE/i91yUMQRGVUSmATPRArfZ/68UMXOIcLCjXFgITR
         wVUTJ633op4v50sGt+9IYH/R3RFQhOsfrKs39O9GDD2IyBBuYeIH5PxlHeeAI3bdao
         DlShNOOgHT0wJGGHJbTENeMzo8Da3kPKTYi2A+7IvcTnZxvavLahGW7enZIs7mVro3
         9tzhl8wqhc7fQ==
Date:   Wed, 4 Oct 2023 13:41:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <linux@armlinux.org.uk>, <f.fainelli@gmail.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        "Sarath Babu Naidu Gaddam" <sarath.babu.naidu.gaddam@amd.com>
Subject: Re: [PATCH net-next v7 2/3] net: axienet: Preparatory changes for
 dmaengine support
Message-ID: <20231004134106.7779c29c@kernel.org>
In-Reply-To: <1695843151-1919509-3-git-send-email-radhey.shyam.pandey@amd.com>
References: <1695843151-1919509-1-git-send-email-radhey.shyam.pandey@amd.com>
        <1695843151-1919509-3-git-send-email-radhey.shyam.pandey@amd.com>
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

On Thu, 28 Sep 2023 01:02:30 +0530 Radhey Shyam Pandey wrote:
>   */
> -static int axienet_open(struct net_device *ndev)
> +

nit: spurious new line

> +static inline int axienet_init_legacy_dma(struct net_device *ndev)

nit: no need for the inline, it has one caller and isn't on the fast
path

