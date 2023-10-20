Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9C7D1649
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjJTTa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:30:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2919D51
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:30:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9c603e2354fso252697666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697830254; x=1698435054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bT7h/fDIIyH1JhpOTfVJdPpMd82YvDVRuNaeiEbaAEQ=;
        b=ZxhHiLWgdbdksgj+jJVeEotdUNL3mW+Jkcf105SO4Fzbo0O2Dq4PJuStJjDC4FXMEb
         H7AoJd5Y4SCVK6JgBgM3jn3MhqUvPVYg3n+S8W4Uw0NncUmbWC+fzfTvimnUk97Wav51
         S3VQWvtm1lX4SzBsWWpRUYvfBHtdiib+7UNt8+/mqBV6sEo5uNBgoMR8H25ox77uEXHg
         XX8JA5LuXX/iklJ+Ldzbq2hDZc0KgNQk87Wp0a2fScUfG6/ObM5aPp9QF/zYNvvtRwt7
         RbhDCtA+YpLYK2hn2XZUJ3yN3mnKZ3i/U8LWFgswi8ccEOnL8LkNPuI5ux3T/P1hURKA
         rNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697830254; x=1698435054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bT7h/fDIIyH1JhpOTfVJdPpMd82YvDVRuNaeiEbaAEQ=;
        b=YuBrPFSS6BXYe6BXPQYyqxUuZRO7AeuOMjlJH0NKiaEw0YPUNlljmg+M/REtq/L6tk
         NfXoTgWF7dTdumxvOAPn+OtupatbAmURk2OVvw32cPbV0sAiHsN0p/0q8scWWdoQAKTJ
         1IIXqq4pkerQ14GtCm+ENJgZNaKkVbWp7UdNBP+bnaxEHajxLEn9iX01MfAn7I4zmFqn
         N/YL9ln03N6+QAvG5LsfT4QaiWR/j5aMD1tj087b5zbIkEHuJb/FvqdTghHBSuJh5Mzi
         K7yPDUHKWl3MFxsKBACC4I40gnP5bcx4FCs7A9VTBb4iuyQ7WuTolMWFKBCBrDgm+t2g
         KvOw==
X-Gm-Message-State: AOJu0YwU1DLBPKSCifvnzIfAuTuTiVsX4ljN8jXPMfAcoFvnaZzoiqpa
        USp+AomKza1+NDS9VC1WHXCZ7CAhk0YVPGMvxJ3CqvDG
X-Google-Smtp-Source: AGHT+IGvGHMt5chbuySDGSCy0Ohjx4D4fXJX6CKSkoqOkvOybxIBa55p2Fr4dCL7+TH9Z8jGVJ9/a0cJu0TZJdbYtEw=
X-Received: by 2002:a17:907:3e10:b0:98e:4f1:f987 with SMTP id
 hp16-20020a1709073e1000b0098e04f1f987mr5525234ejc.3.1697830253072; Fri, 20
 Oct 2023 12:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231018081941.475277-1-saeed@kernel.org> <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh> <20231018180128.GA719006@nvidia.com>
 <2023101808-quicksand-roman-0da7@gregkh> <20231018185629.GD3952@nvidia.com>
 <2023101913-owl-showman-5858@gregkh> <87r0lq8eop.fsf@meer.lwn.net>
In-Reply-To: <87r0lq8eop.fsf@meer.lwn.net>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 21 Oct 2023 05:30:41 +1000
Message-ID: <CAPM=9twY41Xd+=M+bkHapJpNh1bH-SHHarrED1=_x0Gd6SWpHA@mail.gmail.com>
Subject: Re: Dual licensing [was: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver]
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 at 07:51, Jonathan Corbet <corbet@lwn.net> wrote:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>
> > For your new files, please make them single license.  If you insist on
> > dual licensing them, I will insist on have a lawyer sign off on them so
> > that they understand the issues involved with dual licenses, and just
> > how much I hate them in the kernel tree as they are a pain over time.
>
> Out of curiosity, is there somewhere people can look for a description
> of these issues and the pain they cause?  I've seen this go by enough
> times to think that it would be good to set down in Documentation/
> somewhere for future reference.

I'm also very curious, I've never had any issues in 15+ years with the
dual licensed code in the DRM, and continue to prefer it.

Greg if you get new advice that you want to apply to the kernel as a
whole, you probably need to write it up for us to discuss, your
lawyers are not my lawyers etc.

Maybe something for Maintainers summit?

Dave.
