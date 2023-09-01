Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA6C78FB8E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239403AbjIAKA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjIAKA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:00:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC200E8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 03:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8C37DCE226A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F05C433C7;
        Fri,  1 Sep 2023 10:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693562448;
        bh=BTGDfJTyzKP6h40J0iVNdbrEIIzNDkliCuw7WPVkb5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GjYcGy6rAAbtGbUDR7I52WYpGsvlouX3287Du4qRwGUtujJgItXyVUo03LxnQi5Fy
         Hd2Y+78vjEwmV1kfQo4tbP/DEj+oFrfkM9Js/D/TKV/ezUgJt9x1ohGcEapPhhZVp5
         ODKBGcYciLlfghU7NbDW7CAHkYWxuCf3pZNrp/aeuwQoUmcjtjLh8UY6SOhiEl7+ov
         6dNuWjUyIhd2Mcu2Jl7e5We96gXmWiuO0lUKnuO3zoj240I7dAN/Z9WfbRGwrwFIbn
         xgXP4Ga0NTOQtJngynxVK/rne/2C5StagKXXmHDvLURH0oC8VpzLZFi7t1rIfIKOj+
         5/v5jlnl69P5A==
MIME-Version: 1.0
Date:   Fri, 01 Sep 2023 12:00:43 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, angelogioacchino.delregno@collabora.com,
        airlied@gmail.com, amergnat@baylibre.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, ehristev@collabora.com,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Subject: Re: [PATCH v7 09/11] drm/mediatek: dp: Add support for embedded
 DisplayPort aux-bus
In-Reply-To: <CAGXv+5E4nWSuZdHmRhgYDUG4WhYs5o+-ZQBh3pnd2T_fdf9Edg@mail.gmail.com>
References: <20230725073234.55892-10-angelogioacchino.delregno@collabora.com>
 <20230825120109.3132209-1-mwalle@kernel.org>
 <5b438dba-9b85-4448-bc89-08a11ddb822a@notapiano>
 <fc6c054941420ac2d016496ccbeecad4@kernel.org>
 <00f65d49-497c-4ade-a2f3-7a5b7ad803b6@notapiano>
 <18bfffdd7ce3bd7693c8362b28651b49@kernel.org>
 <cce6f9c2-e0b6-47e4-ae1c-9a3d8a4e4b02@notapiano>
 <7a3257dddac78c46408341253a3286f4@kernel.org>
 <CAGXv+5E4nWSuZdHmRhgYDUG4WhYs5o+-ZQBh3pnd2T_fdf9Edg@mail.gmail.com>
Message-ID: <d6031e00cda9ea1e30bb75b2ca97300f@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> I was just curious if you know of any development for that (or 
>> similar)
>> in the kernel.
> 
> This is probably because support for this SoC began with Chromebooks,
> which have fixed and defined uses for the pipelines. I suspect that
> what you are working on is much more flexible.

Yes. that is correct.

> The driver should be made to allow dynamic selection of outputs, as
> is commonly seen with other drivers, but I don't know if that's on
> anyone's TODO list.

Do you have any pointers where to look at?

-michael
