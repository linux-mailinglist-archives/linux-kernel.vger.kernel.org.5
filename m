Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07577FC124
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346312AbjK1One (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346309AbjK1Onc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:43:32 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C6A10E2;
        Tue, 28 Nov 2023 06:43:37 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6D0C640E01B1;
        Tue, 28 Nov 2023 14:43:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C0Msifj7-dWQ; Tue, 28 Nov 2023 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701182612; bh=faEAX4X+9jfjzHsHjHAHPU0gB3DelUTtbAK0YZozHzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JeJNoMdQfWEirHmQQ6rrQChJehksLE2AbrFjoZH8jqHNQq9lSyleP5wVc84WSd3M2
         T1+vsnuIuyqILKr+Ys8HYDqOir7DsUHGyZ6ry2KVhiyd3hf2rPeqwzNJBwcioLRY0K
         8G9Vxcq4IKqEEWBQkyB418qhWfLcDn4tHHwLeYuToH4OQtdT33lkMvd3wlTv92aTlU
         RZ2kwT5m/kQqOhvxmSB1ej3i/ZzPpBtaxGyiDvRpdD6AWxd/NWWqs2KrpvbEf99Yh6
         57ZYTlS4ZBaAgg4e5cOEDT1q9vAgYS4hSH8inpboGblCgx/ryDFfv6G8mbDf1e4Psu
         iB1CCWVYRv/15BvYsy6JIy6jXwF65raxyx6qKVnLhM5br1W9sYBAe82g38BbLjh4/f
         vkFJqDDD3bZlsHNCzoCKLtF+mQMVEdlHWZg+4akmYKFRc1dFdpl0OX5XEYeUqBlzLG
         FMHZibwuJ2QkoJcJVeHWDW8CX1CcIrNio0UIar6Yei7K6Iqsh2BUfr5VKzGYst5c+F
         aW9NzzPg4AleXPMTLlXeERDsx2EnvLv3Q3XMWTI7qeXVKro5hFAYOE6sk4idgvcuKe
         JhOP9wzCW6H9A+fd74l2qMlvNmKhlbRty98nKysTV6w0PSXOk9Le0m/LJLAR522TaD
         OyCA6c/ivvp65qNUaddcHkEQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AACFA40E01A5;
        Tue, 28 Nov 2023 14:43:24 +0000 (UTC)
Date:   Tue, 28 Nov 2023 15:43:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, qiuxu.zhuo@intel.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] driver : edac : Fix warning using plain integer as
 NULL
Message-ID: <20231128144320.GCZWX8iMRIIX6qDyVO@fat_crate.local>
References: <CY8PR11MB7134D203710F24755B7651E889BCA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20231128141703.614605-1-singhabhinav9051571833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231128141703.614605-1-singhabhinav9051571833@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 07:47:03PM +0530, Abhinav Singh wrote:
> Sparse static analysis tools generate a warning with this message
> "Using plain integer as NULL pointer". In this case this warning is
> being shown because we are trying to initialize  pointer to NULL using
> integer value 0.

Applied after massaging, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
