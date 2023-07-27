Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39167649FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjG0IFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjG0IDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:03:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCE430DC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:00:55 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D5F531EC0D3F;
        Thu, 27 Jul 2023 10:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690444853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=w9/qOv4uCdvUqQJ9QBnYGRPwhodQGH23G+oMTRYnlYI=;
        b=cOcTNIPvnTBwKFA8zP1vJhKHHZb1wPmQuARXnNc7kKa47knjicLnvlulrZu4jOAO7mJqWD
        3Y4ncPZUxMHh3J+a4CHkqelxIUDGDS+HSLX5abom8Ru+7qmOI+GHyUCYwgGBFLU8xB0Y8x
        cbzL/BwgLf57KmBZKVb//QVhRwYxPKQ=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yrM93N-xxMPf; Thu, 27 Jul 2023 08:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690444850; bh=w9/qOv4uCdvUqQJ9QBnYGRPwhodQGH23G+oMTRYnlYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMoBo14DUk7boDQeICVNKWmsQrUII7IlpAs20KE6wcX2KR0/j89g4mVxn6ixmtKLW
         KSebZgdrsxHa4prjLgI+1FWW4VlpsoKO1svjDGJwAHNfau0GAZkLtUEOyHOYySuzm+
         CTdaKNF2zMHxVm0GuQV7FlGLEhqKYpM80fYamBrJ2Cf2MRF8KFiPeM2dwCQkKinvu2
         u/HKBRMYbGhMNOnA+2xa8Nm7+DehnCG9PKJzxu2aO+lLm31+F1gYaPXR3NnCESAPJl
         V7UoykTgieW9psCcWbOX9GAkbeFKQOBaW6lkLuHGXFpUDVpLV/lZnce/pr59U++BpC
         I0BBbAtiAci+MSqll91tvAliWpDoq0jeIX5L8NDBJMK8+FSDN0yBdvyZsSGBX7dnug
         L+iaTRgJpmy3RHWNL0o/XL4S/zhcZo1AxXshd2y5sXtKGQs/JV/vlJCtoyjaamzcV1
         ikGCFyxHYQbBckFQcKysHKz2haOGv+rZ5h52kQE5esUbtINOofxSkwVKBkbq/YYU/W
         4+UqoSDszkWK0VX8KnpPdIHnH+ctaJSVk8dDefhxW0BJAGp4aKxXZ1/LpBP4F8BRrG
         hYu/eg5VAh6c1kPTk4aGFaCJQVoIQwCwEoUwOZbGD+2hfUZiGaSSI/uWA3QAFC9ICI
         jecVbYAMIspMh+kWDxt10Z2I=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C37B240E00F4;
        Thu, 27 Jul 2023 08:00:46 +0000 (UTC)
Date:   Thu, 27 Jul 2023 10:00:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     x86@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/amd: Report zenbleed in sysfs
Message-ID: <20230727080040.GAZMIkKENcNIGQc1FV@fat_crate.local>
References: <20230727075446.1749969-1-nik.borisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230727075446.1749969-1-nik.borisov@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:54:46AM +0300, Nikolay Borisov wrote:
> Initial submission of Zenbleed fix omitted reporting the bug in sysfs.
> There's no reason

Yeah, there is a reason - it is not a speculation vuln and people want
to disable the speculation mitigations if they deem their userspace
trustworthy. This one you don't want to disable ever.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
