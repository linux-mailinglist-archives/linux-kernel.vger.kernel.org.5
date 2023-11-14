Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FDF7EAC40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjKNI5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjKNI5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:57:47 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBAD196
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:57:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A48DC0012;
        Tue, 14 Nov 2023 08:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699952262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y71DTRYYjD5Pmt7mctLPg7jTQX9GlbAgtEg/Aq82o78=;
        b=PPXqcFWc7sokc1zQQ/M/kGX7QfiWYc+R9bfOUgm/uoUr8MyK8IlBaL7CTYfpzHWLy+gcei
        INEBh8LdFr6Zz7LKSlu5ZyDbdiOcGXusTWz/JEGUEdmFDMV12Ci99sPcr1SL0NdShbwinJ
        Jm3rygUvemq8+M1eSXrdOWiHiLPg+WNSPiWGTj1uXRanfzx2CB74ytN10hbpg1KhIEfuu0
        ls4Muy5Q1qXvZjO6IRbtsuGK1jjP0UUcbTHShrRYjQ3AoUwn1C662S7bTpG0ZcwW4FuL/K
        /lm2Zjy5+0UsKl85foPSblGx5pI8OH5E5NZ79frx/PRYIgdzsdZkLM5TLi4AGg==
Date:   Tue, 14 Nov 2023 09:57:37 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Joshua Yeong <joshua.yeong@starfivetech.com>
Cc:     <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] i3c: Add fallback method for GETMXDS CCC
Message-ID: <20231114095737.158781d1@xps-13>
In-Reply-To: <20231114085525.6271-2-joshua.yeong@starfivetech.com>
References: <20231114085525.6271-1-joshua.yeong@starfivetech.com>
        <20231114085525.6271-2-joshua.yeong@starfivetech.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joshua,

joshua.yeong@starfivetech.com wrote on Tue, 14 Nov 2023 16:55:25 +0800:

> Some I3C hardware will report error when an incorrect length is received =
from
> device. GETMXDS CCC are available in 2 formats: without turnaround time (=
format
> 1) and with turnaround time (format 2). There is no mechanics to determin=
e which
> format is supported by device. So in case sending GETMXDS CCC format 2 re=
sulted
> in a failure, try sending GETMXDS CCC format 1 instead.
>=20

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> ---

Thanks,
Miqu=C3=A8l
