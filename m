Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7DC7FEC3B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjK3JxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3JxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:53:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD010E3;
        Thu, 30 Nov 2023 01:53:21 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0E525660734A;
        Thu, 30 Nov 2023 09:53:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701337999;
        bh=JsvgpBm+jN736PjJX3c1tvCgfoG0+lhKgsKFQCA5mw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ot1ulRvQCpjwK/uj8QKL57IJsxS0S+kocRXYM9NYNHPSMJs75/0FZDVnA8wMZDYmx
         AdkvZ2p1hEVYOfeyKgIbr8GF/22+5IhRiwsXJ2QSPkSc8hFS4SnfPfBM3YJuBNZwIn
         bgkephfNyTbI+kbl1iqrTRjHbZ4jyzN1xRZXb1mukHpymmA3uGUJ4Fvrq4+BqHe0XR
         RsBl4SMzgV/20wEO+OSrIZ6PZQDOrgZcYrDwa38T/FcKJ1WAx0orqijVkfEtwgajYf
         fs7/VHK8R/BRADuBtMeXmPxpp9ItmavZ8qReklR0eoLdkDeLQSltXKf+0uC4231C/L
         6L50Hd9jnS76A==
Date:   Thu, 30 Nov 2023 10:53:16 +0100
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     nas.chung@chipsnmedia.com, jackson.lee@chipsnmedia.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next 1/2] media: chips-media: wave5: Remove unneeded
 semicolon
Message-ID: <20231130095316.ckchdgnblkmsdmci@basti-XPS-13-9310>
References: <20231127005959.108764-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20231127005959.108764-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Yang,

On 27.11.2023 08:59, Yang Li wrote:
>./drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c:95:2-3: Unneeded semicolon

Just pasting this line here makes the commit look a bit confusing.
It would be enough to simply write:

A switch statement does not require a semicolon after the closing curly
bracket, remove it.

The same applies for the second patch.

Greetings,
Sebastian
>
>Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7633
>Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>---
> drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>index f29cfa3af94a..8bbf9d10b467 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>@@ -92,7 +92,7 @@ static int switch_state(struct vpu_instance *inst, enum vpu_instance_state state
> 		break;
> 	case VPU_INST_STATE_STOP:
> 		break;
>-	};
>+	}
>
> 	dev_dbg(inst->dev->dev, "Switch state from %s to %s.\n",
> 		state_to_str(inst->state), state_to_str(state));
>-- 
>2.20.1.7.g153144c
>
>
