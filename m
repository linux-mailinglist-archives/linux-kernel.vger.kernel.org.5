Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC207D63DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjJYHqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjJYHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:46:06 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A01E5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:43:53 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EA62140E0196;
        Wed, 25 Oct 2023 07:43:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aQzNtrDhGknM; Wed, 25 Oct 2023 07:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698219830; bh=RfFNnc4/kKQ/hNuLaagWJNcxPlgYLwSc9zo7ZjJaAJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbjNN90CK6A5qKtE4XD6WGT0TLR8YM9s3M8cVWlp0S+00Qfc6cZ94Ngn/1Xr7WXTF
         fDrjj0xBuO/f/EfERRQpVN0eMWOP1L3X7gUarK5JC+Yrv1PG/NvknC5qB2dJrHxpaQ
         FnxsnHKJo+f+JmMyMrxW1MQaDmZ65o/eKKEh4oYaQfYbjYgpmzNq3TQLGwzfVgy5qv
         ZOySx5EK+fyp6WwBU3Ij/zpgHpFj98ZoBl4dPWeA/RR+a2ejtr3S2oOJaHToDy5lmw
         crGHeg75UVqaR2OS1sxKXkYsDckizCSc+NtOiReKT68EKh1houkQA+CxKv17fhqDXo
         r4vt/rzXbTnhBQBQQmB80mufOypr5sY+0hwZeqAniE+LnSG7wtJ1uURZ/HaTa9GYdh
         GIAiKlLf51Mbtx+JyYXkKpiUNe2fRSpPdDgt9477HbFBCs2dzfT6BLdXRCv1/9j0eL
         3iSeFjsIntE5QCUmQZrN/FMHOwi7TuKYRcVEHPshGfs0XZmCCorpcphUItrCFVpG7P
         hh4npGQ1LN8fsCbawtm3BBaFyq0CNWFX+HEuvQM+7yJviOyZScHW4WqKwyJs0ISEOx
         5CYq23T9FeLqAQk2zcH9cj2BCQVW3wremMVVbNBvCpiM971F5EINUtPF36T0utWt+M
         OXC7myiDR7yzEFebkhj6BRuM=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1693E40E0177;
        Wed, 25 Oct 2023 07:43:47 +0000 (UTC)
Date:   Wed, 25 Oct 2023 09:43:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/common: Fix typo in comments
Message-ID: <20231025074339.GAZTjHK2LO2nNlNtvv@fat_crate.local>
References: <20231025055927.1861-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025055927.1861-1-wangdeming@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 01:59:27AM -0400, Deming Wang wrote:
> The word "advertize" should be replaced by "advertise".

Why?

Did you search the net for the spelling with the 'z'? Maybe you'll find
an explanation...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
