Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5743789D41
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjH0LVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjH0LVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:21:45 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB9E109;
        Sun, 27 Aug 2023 04:21:43 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1cca0a1b3c7so1651951fac.2;
        Sun, 27 Aug 2023 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693135302; x=1693740102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KH1XfVhLQ+YXClBpeGjKkGNc6ymX8DTVe/Xp1CqkEPI=;
        b=otdRgVw+sceV6uhU7bXKON6Wpv1U1Mo1VhUD9ZiH4LjQ6cPELQmuNpdI+J8t1A1lbG
         zpEXeN3naRKKo2ZA4WzLJ6KdZJTldgWLulD5aweMDNFIe2aw8YOI3Myi3dm+TCpN5whk
         1X5AunaksUTRBeyMmZv9pSHD320aIDdEeI15sCBagnCj15AX8x5JaeEX6TfUwaG6FS0Y
         vvm+qvLYKNUseolE70/WH1dserrHBh3ztDHk68l3C3WtK3etepl7mf5h4w1/S8l3vr3d
         2pfBk8QfDTWZktxn/pXg7GxSsY7f4/Wny2S3cW9EircWQC0f4nn9fLEGjB4wJhKrF+Ri
         Cv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693135302; x=1693740102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KH1XfVhLQ+YXClBpeGjKkGNc6ymX8DTVe/Xp1CqkEPI=;
        b=e/9jzni8I1mQYjIlfkWPe9r1J1X+LQErMK41zCijjWc6keJaViyDZ9ybksJhMurxWL
         CEI4LLZ87zLeL+Rvkx02Fk3TIDdUi8xgKnDCwrdamLdExTc3e5oSC/tsNTEDsTVjizqK
         s675uknXZE3Wal0dO4biEdA9ipvksono3BcgqYP6hZsh3PxgQcj/dkjWsvv9DaWohI30
         XpFOymDZ7xX4oH8h+kxiN7WR46Z2ghTLdwWpWmY9IauaVz1hX+6SbbMq2YI41feOczwx
         IulG3hiWiqeBOtROuXzZ51A9NHAEA6CZ6sflt+/zIJLmO0dBx3sJ+oiqfk9HMb7eh5pu
         1GBQ==
X-Gm-Message-State: AOJu0YyXWmIQSRbgd9yMizclJaVlJkaQuDQFQpPcZ26ou4vttwSrWh0q
        iEb9XEKTUXp50DOP++oE67Q=
X-Google-Smtp-Source: AGHT+IG/WbYrtVz2hOVgtBviLanFYvLODYr4gH8DRIO2f+CZMbSdHJ2rQgvp7FF51SXEA/UWxwqqjg==
X-Received: by 2002:a05:6870:5620:b0:1bb:9907:451e with SMTP id m32-20020a056870562000b001bb9907451emr8880558oao.52.1693135302068;
        Sun, 27 Aug 2023 04:21:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ci24-20020a17090afc9800b00265a7145fe5sm6721940pjb.41.2023.08.27.04.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:21:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 27 Aug 2023 04:21:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
Message-ID: <7e5c80f0-45a3-407c-8c2e-e85bf97f5483@roeck-us.net>
References: <20230813211718.757428827@linuxfoundation.org>
 <b392e1a8-b987-4993-bd45-035db9415a6e@roeck-us.net>
 <2023081631-uproar-tapered-2221@gregkh>
 <2023082627-tabasco-concave-1366@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082627-tabasco-concave-1366@gregkh>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 05:48:59PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 16, 2023 at 06:26:47PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Aug 14, 2023 at 07:04:57AM -0700, Guenter Roeck wrote:
> > > On Sun, Aug 13, 2023 at 11:17:25PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.1.46 release.
> > > > There are 149 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> > > > Anything received after that time might be too late.
> > > 
> > > Booting with f2fs root file systems still crashes in this release
> > > candidate. Would it make sense to mark f2fs as broken in v6.1.y ?
> > 
> > Ick, yeah, let me dig into this next week and figure out what went
> > wrong...
> 
> I've now pushed out 6.1.49-rc1 with the last 3 f2fs patches reverted,
> and a single objtool fix.  Hopefully that should resolve this issue, if
> not, please let me know.
> 

That does fix the problem.

Thanks,
Guenter
