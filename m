Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5507527B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjGMPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjGMPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B791213F;
        Thu, 13 Jul 2023 08:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA18361087;
        Thu, 13 Jul 2023 15:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C2BC433C7;
        Thu, 13 Jul 2023 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689263409;
        bh=2NOFOv1mox0B34eGmT558oG4B3bVJOOiCICa6iNLwA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgx4M+is4LhV6C/gBegZLG5nj+tF4rmWD6hizr2Qupfamu2cOb0wCk9DVIc4yQMBn
         tah0nR3/cEkKDr0zOgHK8DMttoPbxTsV2aHkSKloS7bKzfQC7/1ugn1mXpgXiJ7IZh
         dae6KS3iZ8ALgTqRHJcE5OlREzStYbcfktwqTpyY=
Date:   Thu, 13 Jul 2023 17:50:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ye Bin <yebin10@huawei.com>,
        Seunghui Lee <sh043.lee@samsung.com>
Subject: Re: [PATCH] mmc: core: set card fwnode_handle
Message-ID: <2023071334-amnesty-daughter-f5cb@gregkh>
References: <ZK91G1qd8JwFEpIX@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK91G1qd8JwFEpIX@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:52:59AM +0100, Daniel Golle wrote:
> Also set card's device fwnode in case it isn't set yet and of_node is
> present.

How is this "also" when you are only doing 1 thing in the patch?


> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

What commit id does this fix?

Why is this needed?

Should it go to stable tree?

thanks,

greg k-h
