Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181C179917D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245412AbjIHV11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjIHV10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:27:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D15DC;
        Fri,  8 Sep 2023 14:27:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3E8C433C7;
        Fri,  8 Sep 2023 21:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694208442;
        bh=DmwIh27VDJqYmJb/+d1zU+KcpsagMmGvhv7EnakglH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iZEv0QUo17xhBx8KfSKasISAvcZO4zmj2nkOeV/sIbcwycOYPKZXD6Sb2w9usmCdP
         mIbSvpVWzgML7PryBR44cUpATJWEpE+L4dWx2Tnp+qxIQ59HnHLUbU7yIyLPUjkTE7
         qVmjKmRSWwJtettgCY7snXw1QHQjipgoal6yFEu8HKKUOsvJlWKs9qMMIuNXU2xMxE
         ixPH6EA8zvmSp1ry/9dYrkZcbKPuTYGMdR3964aJb/lR+ceFj62rKX4dOUPfwBYYBK
         0HLxTt+PyZQZAIldnv2kvDaGKqm+7cSqHNn+9Ibc5gB1zG7JohfnRQgYaWNMtbowqr
         woFiY0i4VQSPg==
Date:   Fri, 8 Sep 2023 14:27:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>, jiri@resnulli.us,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.5 02/45] devlink: remove reload failed checks
 in params get/set callbacks
Message-ID: <20230908142720.1b66b853@kernel.org>
In-Reply-To: <20230908181327.3459042-2-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
        <20230908181327.3459042-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Sep 2023 14:12:43 -0400 Sasha Levin wrote:
> Therefore, the checks are no longer relevant. Each driver should make
> sure to have the params registered only when the memory the ops
> are working with is allocated and initialized.

Not a fix.
