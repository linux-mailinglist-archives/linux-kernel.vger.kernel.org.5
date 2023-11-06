Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB68E7E2212
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjKFMpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjKFMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:45:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1794EBD;
        Mon,  6 Nov 2023 04:44:56 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 342386607483;
        Mon,  6 Nov 2023 12:44:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699274694;
        bh=qeDXqRDUTsQ1DG9wmAsxJdQreIW7WiuA6YuIhOFErlQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WmEBGVWcKco0Rp60xT2b+yg/OK3gdcffLGBbRjuBbwtZO3OmGHLXVTjVbJSf4bm4h
         VYhfCLyVzM38nYa1YSvY7IqwSHd7fQmsk4gmZcFTCnWPY7J2EEkbd32KA2p+VDXDlX
         2wvxn516ohXnJf6abk9YRRKRzActIQbOmfuGVihLoD0i615BLCBWWMersf9VrLcMBG
         /8lsRpVdRjh6ZGEnPseDHajC2kOgVidHfMI8rcJVNx0IKreMx40s7Vk23kmFyVxYXP
         9xplnZL+zzbOVedRj+ubLryWe6TBpqpaaM+6st2xwHk3awVo4AmwdqgPMIIAIRGvkN
         1spQVgy1WRtig==
Message-ID: <7ebcbec8-1f6f-4963-a382-3ed0be0e4329@collabora.com>
Date:   Mon, 6 Nov 2023 13:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/12] media: platform: mtk-mdp3: avoid multiple driver
 registrations
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
 <20231030100626.12564-7-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231030100626.12564-7-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/10/23 11:06, Moudy Ho ha scritto:
> The amount of MDP3 driver probes is determined by the registered
> clocks of MMSYS.
> Since MT8195 MDP3 utilizes VPPSYS0 and VPPSYS1, it's necessary to
> prevent multiple driver registrations.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


