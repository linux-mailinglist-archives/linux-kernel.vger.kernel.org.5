Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885037BF4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442588AbjJJHvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442488AbjJJHvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:51:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11429E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:50:59 -0700 (PDT)
Received: from [192.168.1.23] (unknown [171.76.86.192])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 088966607038;
        Tue, 10 Oct 2023 08:50:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696924258;
        bh=uSu0g+zrD88+d7SsFCucNpmU9HR6IeduY5+Lnz9neKA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ALlmQ31A83wpiAqOmjFDvybjtoYsUzTqD2PG6Px+VQnHLoUjSTBcJ7aNNU6Wnhrwl
         QP2YAyoZJr0rVR4h+SOBa27eo+eewkZkxitfCcrc3a07LkgXrdvqIB17TVg6Qi5ZAV
         R75p+Qgqj0WifGmCENK4FkliTbjFovnKmoUcY9vKcifCVP5bXojrj2wOMujU5G0/js
         C4wqlyvHMfaO7xJf8HfMWsAr2uOxjKxP2HUlZ5sAbhUceGRgJO0YM142qTlBCGEmjq
         C64Z+ChN9FJ4YBChVZOj7rS9BUijobKC2iqix63tlKLK/KCweCC+zlayv6dQdzcMkx
         3nd1HfENSLy3g==
Message-ID: <a4393a64-a640-a935-7e7c-e1e287bfe528@collabora.com>
Date:   Tue, 10 Oct 2023 13:20:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/9] drm/ci: add helper script update-xfails.py
Content-Language: en-US
To:     Helen Koike <helen.koike@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     robdclark@chromium.org, dmitry.baryshkov@linaro.org,
        sergi.blanch.torne@collabora.com, guilherme.gallo@collabora.com,
        david.heidelberg@collabora.com, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20231009004953.203576-1-helen.koike@collabora.com>
 <20231009004953.203576-4-helen.koike@collabora.com>
From:   Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <20231009004953.203576-4-helen.koike@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helen,

On 09/10/23 06:19, Helen Koike wrote:
> Add helper script that given a gitlab pipeline url, analyse which are
> the failures and flakes and update the xfails folder accordingly.
> 
> Example:
> Trigger a pipeline in gitlab infrastructure, than re-try a few jobs more
> than once (so we can have data if failues are consistent across jobs
> with the same name or if they are flakes) and execute:
> 
> update-xfails.py https://gitlab.freedesktop.org/helen.fornazier/linux/-/pipelines/970661
> 
> git diff should show you that it updated files in xfails folder.
> 
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> 
> ---
> 
> Hello,
> 
> This script is being very handy for me, so I suppose it could be handy
> to others, since I'm publishing it in the xfails folder.
> 
> Let me know your thoughts.

Thanks for the script.

Tested-by: Vignesh Raman <vignesh.raman@collabora.com>

Regards,
Vignesh
