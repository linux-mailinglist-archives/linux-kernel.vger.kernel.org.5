Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913057EE2EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343571AbjKPOeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjKPOeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:34:44 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F30C4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:34:41 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-672096e0e89so4391656d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700145280; x=1700750080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7W6//ULW37oFtDnEFJrKFg8viGAmQjXi9ezwNEfzsY=;
        b=Lz4WWvvgqaduREFnUIStrSMWehA4vgd9pivBLyF1wIiAxMPXO0WP6Kt96d5QQbkEit
         Z9bVKX36QFgUOFrwL8erIslxc0jvJQim39MHch3fAeeSAiUFH2BCSD80xMxjoXPwcqOK
         SmJbWlJUukowd+nAdQMclaBq2BLPGqXkCUdwnEZczV3/MfkZHHyNRCaiRUmAtXT2dM/t
         zC7CO5MVuAUMs7wUgv0lq3900s5Dl3aW+T7MfxEOlpiK0cwQdcSFuTKgbYKkL+wQsPwx
         0phQcZh/OpsQTW51o0TtoHhoRatDO1w8EtD+Dh1qR+zTNEyGhqiQWU/nRUm/RWdXNkKz
         1tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700145280; x=1700750080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7W6//ULW37oFtDnEFJrKFg8viGAmQjXi9ezwNEfzsY=;
        b=PtWkWt0zkGmOkp5DDxx4Rqj0glQm9Kiwgv8SA+RTW9gdw91cvjTBXxfEB8NZzkGjWh
         wZ+R0jFyJcdLa7Kcwd13ZF5tU/c9ZowN2DB04K2FjmHXcxU2WtsshPeTT/i2yD5Ae2Zf
         a6elJLDY10EkrsxqqDRx1J8DB7is4pxyqQGUOf/pJ3ERaYpDFkHTqH8A5Brj9iqacn+0
         65Yf92KNn39fnrgZ1kyOs/GzzBnVMJ3qKG6DjZ93bB9ftVOjEWSehkpqx5UdnR2az1n6
         J1QcAzDT5heGghdFO/xVL73CTwbaZ0uyfBD8Nfmn2SXJ8k5hTSQlm4CBLusAJ0jpZGlb
         T/aw==
X-Gm-Message-State: AOJu0YzKw1g4ydM5o+jMUgi3aUZ6EP/UrAmdETTKdCXSJon3qfTDaSq1
        SB+3TZqUAcCTlf1pPGshFx0=
X-Google-Smtp-Source: AGHT+IE11JwGbjdgvwr1u/V3BLUxRqcTo4KabZQ0moIm7tM5e1eXDmoQqe0n+DLGkXp6dGCAM8HnTQ==
X-Received: by 2002:a0c:ff4b:0:b0:677:d8ad:170a with SMTP id y11-20020a0cff4b000000b00677d8ad170amr5741514qvt.39.1700145280362;
        Thu, 16 Nov 2023 06:34:40 -0800 (PST)
Received: from errol.ini.cmu.edu ([72.95.245.133])
        by smtp.gmail.com with ESMTPSA id i6-20020a0cd846000000b00677ee93c52csm125912qvj.114.2023.11.16.06.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:34:39 -0800 (PST)
Date:   Thu, 16 Nov 2023 09:34:38 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] drivers/soc/litex: drop obsolete dependency on
 COMPILE_TEST
Message-ID: <ZVYofpygbLMCN7lI@errol.ini.cmu.edu>
References: <20221124161618.34ca07b3@endymion.delvare>
 <Y4DKYqgecIlGTxQK@errol.ini.cmu.edu>
 <20231116150357.6a2fa8f9@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116150357.6a2fa8f9@endymion.delvare>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 03:03:57PM +0100, Jean Delvare wrote:
> Hi Gabriel,
> 
> On Fri, 25 Nov 2022 09:00:02 -0500, Gabriel L. Somlo wrote:
> > On Thu, Nov 24, 2022 at 04:16:18PM +0100, Jean Delvare wrote:
> > > Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> > > is possible to test-build any driver which depends on OF on any
> > > architecture by explicitly selecting OF. Therefore depending on
> > > COMPILE_TEST as an alternative is no longer needed.
> > > 
> > > It is actually better to always build such drivers with OF enabled,
> > > so that the test builds are closer to how each driver will actually be
> > > built on its intended target. Building them without OF may not test
> > > much as the compiler will optimize out potentially large parts of the
> > > code. In the worst case, this could even pop false positive warnings.
> > > Dropping COMPILE_TEST here improves the quality of our testing and
> > > avoids wasting time on non-existent issues.
> > > 
> > > As a minor optimization, this also lets us drop of_match_ptr() and
> > > ifdef-guarding, as we now know what they will resolve to, we might as
> > > well save cpp some work.  
> > 
> > Acked-by: Gabriel Somlo <gsomlo@gmail.com>
> 
> Despite your ack, this patch was never committed. Was it forgotten
> somehow? Should I resubmit?

AFAIK, LiteX is too small to have its own direct path into Linus's
upstream tree, and so far any changes to LiteX specific kernel code
were filtered upstream through the respective dedicated subsystems
affected (e.g., mmc, networking, block, etc.).

IIRC Joel (cc-ed) might have been involved in the upstreaming of the
original LiteX soc driver -- is that correct? If so, which way did it
end up going upstream, and can we replicate that for Jean's patch?

Thanks much,
--Gabriel
 
> Thanks,
> -- 
> Jean Delvare
> SUSE L3 Support
