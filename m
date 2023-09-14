Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A337A0565
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbjINNTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbjINNTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:19:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE5C211D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:18:33 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B7A2E660734B;
        Thu, 14 Sep 2023 14:18:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694697511;
        bh=QLmIOvyMYsAHwE/swB9g81iNqJ/lVTegnNyDspfyz+g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VCs+qGRYLlMKOSjV+9fS140xdhCFeaqPjV3BKdWXlFqvXe7dC6joaklTBoTlSvIM6
         KCx+ce8lmOWb25unXHIJ6l0a8n5+/Ut426yH6aaY0x0w0SfuJW0BqXoCDV5v4Yuruw
         1h/HV5XOzXXwVE6n/nH5cGfYAZlt6/UH1ycjfQijScPSjLrl5Ug0+q759+XZMA7jty
         e+VJng58d/asb4lTza4+FCYDQxMinCXxvDiCPw428DFK9wA4gejvjyMy3uWBopzBT2
         cov8zHvsAdN9vciHLkpUu+DEfKCQQ4hdb2EnY76yhiuzeIRbZxJoZWuOMwPSQaINmy
         nqz9SaeF1FUqw==
Message-ID: <982d201a-bcf2-f856-00e7-8807ca5a006a@collabora.com>
Date:   Thu, 14 Sep 2023 15:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 13/15] drm/mediatek: Add missing plane settings when async
 update
Content-Language: en-US
To:     =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
 <20230823151332.28811-14-shawn.sung@mediatek.com>
 <d43e0d7b-1e93-f9ae-df3f-cbf8a3381a70@collabora.com>
 <e1f07420c9d7abf26cf9ce111c063224001ba561.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <e1f07420c9d7abf26cf9ce111c063224001ba561.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/09/23 15:45, Shawn Sung (宋孝謙) ha scritto:
> Hi Angelo,
> 
> On Thu, 2023-09-07 at 14:33 +0200, AngeloGioacchino Del Regno wrote:
>> Il 23/08/23 17:13, Hsiao Chien Sung ha scritto:
>>> Fix an issue that plane coordinate was not saved when
>>> calling async update.
>>>
>>> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
>>
>>   From what I understand, this is a fix for an issue that was present
>> before
>> your newly introduced code.
>>
>> This means that you want to add a Fixes tag, and that you should also
>> send
>> this commit separately from the IGT series. Please do that.
> 
> Got it, will add a fix tag in the next version. But since without this
> patch, IGT will fail at some test cases, could we still send them in
> the same series so IGT can pass out-of-the-box?
> 

Fixes are applied before new features, so if you send this patch outside
of the IGT series, this will most likely be applied *before* that series.

When the IGT series will be applied, this patch will already be present,
so, please send this one separately.

Regards,
Angelo

