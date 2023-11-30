Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9DA7FF0B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345682AbjK3Nu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345581AbjK3Nuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:50:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8821B9;
        Thu, 30 Nov 2023 05:51:00 -0800 (PST)
Received: from [100.124.219.30] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 037796607345;
        Thu, 30 Nov 2023 13:50:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701352258;
        bh=HGnD8bUQWOaK+6RFgKTsVFZmO6HTrfFGIJlJrDox4v8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H58wh8CHNeyKhFKLgOKBi4cHe/A5GWRrfro7BiyeAt4Jr5iSpHtao56/5Xpa0WFNt
         iL9p94K8uIyTXndAwxXyrdNoIHY9sXoa5oBmnefTqKNP3R0jrZm8Swjg7huYA2KQi2
         qA2dhqdwQ0MRA5G3Od4dScyaTjrYKG0aYkBzU0D3kIBfKadg5E9uG5RT6kHtSoFYVf
         4V0V4odklj4B0h1o/kAGP/l1KaQWj1PwW92dO9KW8DxzbwFbO/+nUqH7C+XFTFeJ/d
         058/Sgc7SGQkJBFyU3cqme3tnGtkMBUFdWLM7lBBh92rCW62iY4m/GSvtgeOyxYAOI
         yAE7gIc4P+R8w==
Message-ID: <893192db-0431-4d1f-7281-952da9979345@collabora.com>
Date:   Thu, 30 Nov 2023 19:20:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 06/10] drm: ci: mediatek: Set IGT_FORCE_DRIVER for
 mt8173
Content-Language: en-US
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
        daniels@collabora.com, emma@anholt.net,
        gustavo.padovan@collabora.com, linux-arm-msm@vger.kernel.org,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        david.heidelberg@collabora.com, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20231129121841.253223-1-vignesh.raman@collabora.com>
 <20231129121841.253223-7-vignesh.raman@collabora.com>
 <CAPj87rPKywWa8KxTCeJQz4vvgTwhPzL+y4aCX9zxZDkkfrvsoQ@mail.gmail.com>
From:   Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <CAPj87rPKywWa8KxTCeJQz4vvgTwhPzL+y4aCX9zxZDkkfrvsoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 29/11/23 18:52, Daniel Stone wrote:
> Hi Vignesh,
> 
> On Wed, 29 Nov 2023 at 12:19, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>> Expected driver for mt8173 is "mediatek" and for mt8183
>> it is "panfrost". Set IGT_FORCE_DRIVER to 'mediatek' as
>> the expected driver for mt8173.
> 
> Actually, for mt8183 it's both. And for mt8173 it will probably be
> mediatek+pvr pretty soon. Each of these SoCs (like most Arm devices)
> have a separate display controller and GPU, with different drivers for
> each. They'll run different tests with different xfails. So we should
> figure out a way to support igt running for both devices on the one
> system.

Agree. Will work on separate patch to test both the drivers for these 
devices.

Regards,
Vignesh
