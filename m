Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC82811A04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378177AbjLMQsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMQsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:48:53 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9488E;
        Wed, 13 Dec 2023 08:49:00 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5C78A40E0030;
        Wed, 13 Dec 2023 16:48:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UBofbvajwNLn; Wed, 13 Dec 2023 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702486136; bh=5RmfJgzhCJhL1FocTS8kiTdsbL/Jz464PcnULFHHGVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RE1D1MJWUO5nGqj+MuKKKRI0zK4hzQi0DQWxRDxgPKk6zc4WuDyE5zk6pzVQvhHvO
         F2Ivln80YM97/PQes7MWh4j8TsI2n8ukuJ7mZXe+rF2gShLQzcRn7kiwT7nxM9F62A
         5Vcos6FlN677+IdJobG+NolWiFlNtvowduEENRbl8bfoN7rLnPf4lp1xN+5AjvqJb+
         WYFKfKJ8ey0MWwFiWRkMan2PvaB5uHWDwp0bzGJEN7tybyqaZUuG8o/z+Fw2C//+HX
         C+dPPU5nR9XbohTECvxZxtTpf+4SAfaSY5z3QDATk2gBFJlktLDZBpGYuruBMdGdVy
         lif0f1vN81T9hscOyuwMUOfxk1tgnG3ZScQ2uzY6/aQfRnBcUmTScKt+uCXlRzbYKj
         IdtlMmIiLdS2WQAVJfpA9u9jLKgPqHyBsCn/ggBam37o16gfrd+9tz5+N35StdhEz3
         Imke9bpj9BieFXfzqKVlWxMXFsYsCckW94+Z7NCpuYIbsEs4TJ+LhXM0WDcAmGdmdB
         BWp+CFYL1yv+D7S0pc/g4as21z57JU1a/POcpcJYcRuAaNqaAeJDeo3ZuZnHse+ZI7
         zyjZYNPSX3QQVbNakVk6qyh7SZn0A+/B9takbEY18JC+o3Q+mCXWnZIgdy0MJTliYD
         fWXoO1cRxVEVQO9onoBwbRrs=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 268A040E0140;
        Wed, 13 Dec 2023 16:48:47 +0000 (UTC)
Date:   Wed, 13 Dec 2023 17:48:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
        john.allen@amd.com, william.roche@oracle.com,
        muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231213164837.GHZXngZW3TYvBN41Ma@fat_crate.local>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
 <20231211195739.GIZXdps9DNvOgCR5Xs@fat_crate.local>
 <295f3cc9-6140-4813-b107-8c8b60f8aaa1@amd.com>
 <20231212153449.GEZXh9mSJ5epD13Dp7@fat_crate.local>
 <b9beb435-30e4-44a3-b27d-0567a8e873bd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9beb435-30e4-44a3-b27d-0567a8e873bd@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:35:55AM -0500, Yazen Ghannam wrote:
> I agree in principle. But I don't think it hurts to include an additional
> line to avoid the confusion when the module doesn't load.

It does hurt because this turns into constant family updating the moment
a new family appears. This is one of the major reasons why we do CPUID
bits.

> Also, the SMCA feature is used here as a short-cut to match on systems with
> a Data Fabric. We could use the Zen feature in the same way.

We could.

What is the main description of the environment an ATL library belongs
into: a SMCA system or a Zen-based system?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
