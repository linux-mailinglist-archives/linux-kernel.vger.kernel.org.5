Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01467F6D13
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjKXHqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXHq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:46:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D480D40;
        Thu, 23 Nov 2023 23:46:36 -0800 (PST)
Received: from [100.124.219.30] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE18466022D8;
        Fri, 24 Nov 2023 07:46:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700811993;
        bh=8LvJc8DaAgHeIHvOQk6AYJxeRlrV3q4wIVakxhIdGb8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z9ihSIAdqUhMuQz9cCS/bwAmg2YL6c12FYaZKZOE5E7g8/LQH3vK7Z5qQiqUpBp7C
         H/E0LW/5bWnBo0sXZAYEL6+5JpXKxm0emC+OR/R2hQTJBn/6lU7fl4ile4YO3aSwT2
         BuR3+9KMeMjwQL09nvKxfl/kjb1Kc9He7tUmzKnVqZxBWehMdO1nmbNcTBxWAMkU+D
         /5UN0N8+uUwJf1DC8gzc/BSCwMTmK01P379ZRX77WH8aFX3f4Qt4NQm9DFRPAIVrFg
         yF0tNZWvbSZ0b+JbadNjsRbBorMOmlwMqYiO7pqx99IHuoyyl7xhdPkJkUO0GOw4e1
         vVXd1rSFeLQxw==
Message-ID: <92467afc-cd50-41aa-a3a5-481c9da30a4c@collabora.com>
Date:   Fri, 24 Nov 2023 13:16:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 9/9] drm: ci: Update xfails
Content-Language: en-US
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
        daniels@collabora.com, emma@anholt.net,
        gustavo.padovan@collabora.com, linux-arm-msm@vger.kernel.org,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        david.heidelberg@collabora.com, linux-mediatek@lists.infradead.org
References: <20231019070650.61159-1-vignesh.raman@collabora.com>
 <20231019070650.61159-10-vignesh.raman@collabora.com>
 <CAPj87rP=22Fw0h42U-p9fHd=6OHOu9Lj9kbpVMQVqL9U6BRE1A@mail.gmail.com>
From:   Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <CAPj87rP=22Fw0h42U-p9fHd=6OHOu9Lj9kbpVMQVqL9U6BRE1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 19/10/23 13:55, Daniel Stone wrote:
> 
> By the time we get this error, it indicates that there was previously
> memory corruption, but it is only being noticed at a later point. The
> skip lists here are way too big - stuff like drm_read is common
> testing not affected by virtio at all - so we really need to isolate
> the test which is actually breaking things.
> 
> The way to do this would be to use valgrind to detect where the memory
> corruption is. VirtIO can be run locally so this is something you can
> do on your machine.

Thank you for the hints and suggestions. This is now fixed in 
igt-gpu-tools, and the patches are merged. I will uprev igt in drm-ci 
and rerun the tests.

Also will drop the tests from virtio_gpu-none-skips.txt and send an 
updated version.

Regards,
Vignesh

