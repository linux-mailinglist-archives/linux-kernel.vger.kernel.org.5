Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75100780421
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357413AbjHRDDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357376AbjHRDCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:02:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1AE1BB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:02:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc83a96067so3698475ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692327769; x=1692932569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miWNEdxtYXAMssImnpzpcTIiOJ1ID64VjwvMaMslPAU=;
        b=NnPKA/hykxy5RC3XYxGMOISOemOV6D3Bkhn4KuibYaou7bhVkPimm8ZrEVwaSvnPBm
         D1Zz2hiCr5GWso6gDqp6gJLtlTjyWbS2jjIWR+++HMuxasCaUWo0K2CjWK3kHErwfJ9d
         Wa5fTRGVKkNrPduKbAPLt5Iu2RPmlirwhiYJdo4HOHDbPevJ53QDdrXKOzCltWXnFkvq
         z2YBZq8kXgO/pzVwuFtgfaVZRdJ+GBoDtIEz9B0NArjfgkC9mSwptlr6ZJ9SEndFHY/g
         /yP7sdQqx22qStnXPEOvWdn0R2F14HO0tGK0zigiReyq/BO4cT15v5qXaHve6tnGPwBY
         NEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692327769; x=1692932569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miWNEdxtYXAMssImnpzpcTIiOJ1ID64VjwvMaMslPAU=;
        b=ijTWAQ56dqLo0HY04ihqNZdhnP0HKtmEoLg0GTB6KTsz+WgTdHjDQ3bDuWXAO9jJ5m
         L0f8id51S438LKL6AHYnPIR4wNhSY7rZyS2gIMG5BQq0Yi8/smgh+4rwNwBUMOzmL7/G
         HZqbRSgn0DM0Tf65kepgBPIEsERFxrq2FjYI4b6zZ1Ocqk1t4BJ8zUbCE2hlb7HFMlh+
         eyTYcYC2KMsnnEPZFenqHYM+yaCmuJ5ZS/CC8Pg1nxRGYkyPhWFmpcqifRGXM3pCX7cH
         mZVByxfl4kLKUNIQmXsRM/H1XVGux46ZL/tHd5frbPmaQdtvDPesGvRA7tEGCySLkgYb
         nNoA==
X-Gm-Message-State: AOJu0YwQh/FHSzb8p0BF0Xj24VTSSRX95Gbdc05qw3VksQfvG4afCVoO
        blHWARnvKmEVKBHGGThskdN4KlxZ/dU=
X-Google-Smtp-Source: AGHT+IGRoOhYReSfwhcJDpFVLu9kstsEPejNu6LIvWatAl7zO7V5WzDTO/SzR4pnuimVfKsvAcn5Gg==
X-Received: by 2002:a17:902:d2c4:b0:1b3:cf98:a20b with SMTP id n4-20020a170902d2c400b001b3cf98a20bmr1364493plc.54.1692327768752;
        Thu, 17 Aug 2023 20:02:48 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b001bbf7fd354csm481992plr.213.2023.08.17.20.02.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2023 20:02:48 -0700 (PDT)
Date:   Fri, 18 Aug 2023 11:12:31 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
Subject: Re: [PATCH 4/8] erofs: tidy up z_erofs_do_read_page()
Message-ID: <20230818111231.00005ddc.zbestahu@gmail.com>
In-Reply-To: <20230817082813.81180-4-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
        <20230817082813.81180-4-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 16:28:09 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

>  - Fix a typo: spiltted => split;
> 
>  - Move !EROFS_MAP_MAPPED and EROFS_MAP_FRAGMENT upwards;
> 
>  - Increase `split` in advance to avoid unnecessary repeat.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
