Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE779138E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352578AbjIDIex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjIDIew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:34:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405D3127
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:34:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7405D660727F;
        Mon,  4 Sep 2023 09:34:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693816488;
        bh=95fRj8cpZa7uWjfFUAP1aAqIMJzKCDnQz0gfY4gwKkc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=khqvwN1Lr+jaHM9QrdEdIdn77+1NkegUGk6y97QZgGhkC3Kk8Nte2+Xlmy8z0OMT5
         /Dc/CAryTtk8bwJAdnR3eaK2MEywHJuR9ZsX5iGuhk5HxL0WyWzzNGGiBnIgDnflIN
         gwJPl98nqnkNNVCgSUEUYeGrV22sAzf11+yzJWaQjfNKu40+Re8/Q9IfkXkE5WAt1Q
         e6sslU1hpMxJD+1O1GUd66flJNWoqGIRzuzDGMZNMSzTsvjqW07RBj/3abKAXWAzmt
         Kf4gW4azpEkLjfU6D/03qhX5aGx855JD9wWMVfAGRg2lza6vk75KejsIqUS+ymgUx6
         2KsKZ+ptsgbeA==
Message-ID: <40013c91-4941-1d03-1aa2-083bd6b44afa@collabora.com>
Date:   Mon, 4 Sep 2023 10:34:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND,v3 2/3] ASoC: mediatek: common: revise SOF common code
To:     Mark Brown <broonie@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230825024935.10878-1-trevor.wu@mediatek.com>
 <20230825024935.10878-3-trevor.wu@mediatek.com>
 <ZOiCVCJMaNX9Xhgy@finisterre.sirena.org.uk>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ZOiCVCJMaNX9Xhgy@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/08/23 12:28, Mark Brown ha scritto:
> On Fri, Aug 25, 2023 at 10:49:34AM +0800, Trevor Wu wrote:
>> Originally, normal dai link fixup callback is overwritten by sof fixup
>> callback on mtk_sof_card_late_probe and it relies on the mapping defined
>> on struct sof_conn_stream.
> 
> Angelo?

Sorry Mark, Trevor, I was on vacation, far away from my workstation :-)
Thanks for the ping on this one btw!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers!
