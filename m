Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD37C7FD2D8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjK2Jfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK2Jff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:35:35 -0500
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A21707;
        Wed, 29 Nov 2023 01:35:41 -0800 (PST)
Received: from hillosipuli.retiisi.eu (185-9-10-242.cust.suomicom.net [185.9.10.242])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4SgDhM3nDpzyQm;
        Wed, 29 Nov 2023 11:35:28 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1701250535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBMtK94Go2Qx3A8vq16Az09u3ZHaqoIiuqWziee6a/8=;
        b=U2OgepDEX3JXK/Uy0lZIuhn7HqvTKwStbn/1/hieTCH3Wp+MTYc9YO3zpdDc+dDGVBz1EE
        bPGNJWMN6ymD/iIfTrEwP0NpHRY5Rqqfia12ezhGhtBlF7VcHJP8y5QIKcM8jlo7cwyaik
        mnLQ/n5MT0m0J/xyQZr7LlAXEt1I4m0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1701250535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBMtK94Go2Qx3A8vq16Az09u3ZHaqoIiuqWziee6a/8=;
        b=onqBuo4pUwtq+exTLJRnadXdbZMH710QEai0aU6KTp3sO2iqbCAtSuepiXo8Bb4VKqaJpv
        Pta2EElIE4U9nCj8Mq+TwaSRyiqH9LQ+83whUDRs2d5XuaPrtNXHTDF+tvlkWIniXNVEr3
        W0/Z1hpVHVyo9KwD6L96Q1pzzJX5C5s=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1701250535; a=rsa-sha256; cv=none;
        b=VDNXvY+hJj7kCbvBOKDaQ30Y5Ccx8KYgrGBB48Tu1ViiDqHql50oElByTXp3QQTC4GQFXi
        vkbL8tofbxj1eo394ot+wSE+BQ2eKiPhygRRltJhzhh3g+w02yvcR+M5wFoxt7xqG1Kt5s
        5bJ5oh3YZ7n3SS4OcnlJx7q68yNSBO0=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 110BD634C93;
        Wed, 29 Nov 2023 11:35:28 +0200 (EET)
Date:   Wed, 29 Nov 2023 09:35:27 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: stm32-dcmipp: correct kerneldoc issues in
 dcmipp-common
Message-ID: <ZWcF38Pd97bAbHvf@valkosipuli.retiisi.eu>
References: <20231128201404.237856-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128201404.237856-1-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 09:14:03PM +0100, Alain Volmat wrote:
> Correct kerneldoc issues regarding:
>   - dcmipp_ent_sd_register
>   - dcmipp_pads_init
>   - dcmipp_colorimetry_clamp
> 
> Rename as well dcmipp_pads_init parameter from pads_flag to pads_flags.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

Thanks, Alain. I've squashed this to the driver patch.

-- 
Sakari Ailus
