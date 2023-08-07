Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CA27728D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjHGPNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjHGPNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:13:47 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D01810FC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:13:46 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76af2cb7404so331062385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691421226; x=1692026026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uur4kbHWMbvbwOkDXCymcrT3HOQZL6Apml/tJhcRoXI=;
        b=KCndBI6wgPbEZIS4Q5OE6/jTs7/9XSLveGSEG9MJEm8Or3aRhjTyLdRhirnLYB+hrQ
         GiD/IFY6BdrQIkIu+6vyCwF5dDW033hjzqY9T/vfA9GxWwracFnrU1u+h/XbGuqGJZa3
         BL9N7D8o9hU105TCsdbxVoQVyDhx3Gb3uPF3diMWYOKi7hUktGtq/an8rNImHV+k4YkD
         EVbhx5Agi4PJrYoMVCqVBSWTRMkt9i/1/mkBJaFJc5fYEPIGiT6Hbxe6HYu+XrHftLjW
         RrhddGms1rRy3FAQNCmTwXpYWji1wzutDlhYF6tjp7iSs6WKRbpyadfXqOnS4zt+6B54
         KzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691421226; x=1692026026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uur4kbHWMbvbwOkDXCymcrT3HOQZL6Apml/tJhcRoXI=;
        b=bM3K2lkANIdfXc8+hUsI0yEku1Y/EeMldjSD4p4Zz7n1k0alj+D0xZtUxe8EW/AWWy
         S+UyD1gTf5G16S5cg0ecRfeJvnDSKL2jAGKYGSD9d40NhNkEWME2c484wMn2+9JRaMmF
         sBL4/IshNiRpRet5yD0LZIP9sj4S3qPJ2VbUc1R79iTpvpEJoO354MN00gNvZbeO86si
         QREeiOvgyINvLp8INAXu4GjIqkuScN95We8/ug3tOCtxJwtvx5M6QZizysfPB5/8DWXQ
         yru0fWksC6voMv6TPyTQe11Iy+iioLV0R39W/hMYe6xpR98Jckfav6CVF41odCTj9bL4
         Venw==
X-Gm-Message-State: AOJu0Yx9BGe3UTtFvsIiR8503nEryUI1JxNF+dfV0I1Se9LDu+dj8176
        Az7FwX6xQICMO/XIBedJGmw=
X-Google-Smtp-Source: AGHT+IGzWGavyM5RHvSarI9BxLEm18ljH6FzqkXabSCDqDt2ehE8J3z7jezUd7h4TwClDHjg69abgA==
X-Received: by 2002:a05:620a:b5a:b0:768:535:5950 with SMTP id x26-20020a05620a0b5a00b0076805355950mr10720544qkg.68.1691421225593;
        Mon, 07 Aug 2023 08:13:45 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id pa35-20020a05620a832300b00767b0c35c15sm2618353qkn.91.2023.08.07.08.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 08:13:45 -0700 (PDT)
Date:   Mon, 7 Aug 2023 12:13:40 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <ZNEKJH3mEoOwV6eF@alolivei-thinkpadt480s.gru.csb>
References: <ZM1rsu0M22HHtjfl@alolivei-thinkpadt480s.gru.csb>
 <2023080510-vacation-support-7afe@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080510-vacation-support-7afe@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 08:14:33AM +0200, Greg KH wrote:
> On Fri, Aug 04, 2023 at 06:20:50PM -0300, Alexon Oliveira wrote:
> > Fixed all CHECK: Alignment should match open parenthesis
> > as reported by checkpatch to adhere to the Linux kernel
> > coding-style guidelines.
> 
> This does not describe the changes you actually made in this patch :(
> 
Hi Greg,

Thank you for your feedback. Don't get me wrong, please, I'm just trying
to understand it now, but honestly I don't know what is wrong with
it this time. I described exactly what I did in the code: ran the
checkpatch, which identified a lot of "CHECK: Alignment should match
open parenthesis" messages, fixed them all according to the coding-style
guidelines and comitted it.

This is the same thing I did previously for the file
drivers/staging/vme_user/vme_bridge.h in the commit
7d5ce25fb4c3cc91d16e27163dc141de0eba213b, but now is the file
drivers/staging/vme_user/vme.c and commit
a1f0b0a8ba9a496504c2e3d4b37cee388e78f0ea. Different files,
different commits, similar fixes for the same warnings,
and same description.

The only thing I found strange is because instead of starting a new
email thread it ended up in the same email thread as the previous
patch. Would that be the problem?

If not, would you mind, please, to explain to me what would be the most
appropriate way you'd like me to write this changelog?

I really appreciate your patience and help.

Thank you.

Regards.
