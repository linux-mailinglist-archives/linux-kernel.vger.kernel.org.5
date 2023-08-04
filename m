Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B4176FBE0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjHDIXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjHDIXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:23:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3FB46A6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:23:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8ad356f03so12877015ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691137417; x=1691742217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqdXFomMcxJTHaDqy7dbmnB+epG491/CtwlKPqeBXDk=;
        b=OWLgSbAlpdbLlX97XZIdjRI8lxtlydrt+JjLXEl569rs+xBK8lrjUXKTKwBwtTCUs/
         qzMDhsatNvTHT9zrNH9C2aTQyVT1wjpajEpxe31Kr0rJ0EzNQbiSeohiFgXEWsbJth4M
         aphehO58kWydtezPbXacheEC/y3n/aaryw5II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137417; x=1691742217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqdXFomMcxJTHaDqy7dbmnB+epG491/CtwlKPqeBXDk=;
        b=jk5PAwlVV57yXKrnQg+/gyywhAa2u5A50gbs2nRExqvPeijBDrAjPq/wTIuuR0gMmy
         x7UJJe2BLH4iyQ1/aaJXrwkgXwHcYFGM23QQYJ+hX5+Ngvqjk3jMr5nLNK9+9gdnJ55T
         Ysl8DjCLkqp9fR5jvLqaFy9x9KAmqj/k08jWtlbMPMHeiznC/RWNW9pV3TZOMg+wMV8E
         0PBF4bNf5oxshpH7uKSBTEU3CUW9vQ7fffUtTXohU8qReEWC/m2en+GHJTlyA9nOncS8
         ZC1WqmMfYEnyHWLLdsnUgRNvVsvAqnUSCyn77gcM5Cb5pw6H2mRgkOOpAGRgYlwhwIe4
         5ywg==
X-Gm-Message-State: AOJu0Yz55Ef47vwiD5yDatiMruAQwqzZGcg5yzHvKL0lukQlLI9sa6BY
        Ipy4CAJMTQu/laPiH+AI6lcFRiXBwqIPICFK6lg=
X-Google-Smtp-Source: AGHT+IFsafD90E5qJcldKYIP+UlnOQXPznSagsYMzXhCxyqNbhsvX6sR7P4YJOGbyW60Y51msSweXA==
X-Received: by 2002:a17:903:32d0:b0:1bb:14e7:4fd0 with SMTP id i16-20020a17090332d000b001bb14e74fd0mr1023520plr.7.1691137417129;
        Fri, 04 Aug 2023 01:23:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jw24-20020a170903279800b001bbb25dd3a7sm1151837plb.187.2023.08.04.01.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:23:36 -0700 (PDT)
Date:   Fri, 4 Aug 2023 01:23:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, tech-board@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
Subject: Re: [Tech-board] [PATCH] docs: Add a section on surveys to the
 researcher guidelines
Message-ID: <202308040123.927319F@keescook>
References: <87il9v7u55.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il9v7u55.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 02:23:02PM -0600, Jonathan Corbet wrote:
> It is common for university researchers to want to poll the community with
> online surveys, but that approach distracts developers while yielding
> little in the way of useful data.  Encourage alternatives instead.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Yeah, I like it. Moar conference presentations! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
