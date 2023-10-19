Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655317CF5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345270AbjJSLAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjJSLAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:00:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46350137;
        Thu, 19 Oct 2023 04:00:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDF9C433C7;
        Thu, 19 Oct 2023 11:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697713240;
        bh=oQXN+1e6ytcbcU5S2Em6a6f7FxQLS6ypfbh3127dMZo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XJjcdxrTY0rX8fsKwkO+xIVHPukzTmuGhyEEGex73HX1iWLZX+Hz1bcGfIcbVeK1Y
         3o+YVbllb3RYrrPHTqEQngjEcGWKaljBBe0HAQp/DDc9IyL6VXO61QcZvfOo53oZRr
         KoIqSHfkQ69AQxUF5+fi1DVYiKncHmdQiyGX+37fHNzu+YLdmckj/0tsiMV1lN5nUj
         6krdqFw/d+Mr0lx5xLZYUI5g8uJQFz/amxijFTaMwJM+tVeL4Le0CgszP5aakT6XoK
         DDLYV7ZbWs/F2+tNagoSmJjsutYs3etVwnsvXHRdyLMlDmIu9LZiyN9tMDiDrwubZV
         vZdUF/6mGBONA==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     linux-leds@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20231013022010.854367-1-chunyan.zhang@unisoc.com>
References: <20231013022010.854367-1-chunyan.zhang@unisoc.com>
Subject: Re: (subset) [PATCH V3] leds: sc27xx: Move mutex_init() down
Message-Id: <169771323911.2438345.5584954485789045031.b4-ty@kernel.org>
Date:   Thu, 19 Oct 2023 12:00:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 10:20:10 +0800, Chunyan Zhang wrote:
> Move the mutex_init() to avoid redundant mutex_destroy() calls after
> that for each time the probe fails.
> 
> 

Applied, thanks!

[1/1] leds: sc27xx: Move mutex_init() down
      commit: 8f3a620c7830d7b50d32614d48c4b7df7205309a

--
Lee Jones [李琼斯]

