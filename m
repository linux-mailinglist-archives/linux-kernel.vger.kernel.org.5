Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDBB7FA3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjK0PCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjK0PC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:02:27 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D7BB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:02:33 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00d5b0ec44so599562066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1701097352; x=1701702152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5joBsafDa+/LYb57y4VbtzIveE2Spcp3cT3kdc03ld4=;
        b=f+e+s7O26LrDfb84VOvmLrVermCXo/oYOHAWiTmm3Cbz/jdwlljU9iCTIeefJTKPtv
         GH7oQX5JybjRdvH4Hs/lPwaju31Uc2feZJmSkqfrk/znu6U0zAyn4Tf9My+KPN/lzI35
         MzhYd6rR8tp7tnXfKQLqxjbcaiwNv12VRCBNeXCleTRGuaTLVbNyG8ZDQaDh1XqeQ8OH
         HjE+BMz9jKTC9wcO1a+AN8ipQHZCZUs+zEFjjnb9dgTOlPJrhdd55b7cSnrI6/f5aux8
         CC6xauwqZPt2X3wYOClXaQRzrKIqnP9XS1vCCI1C6SmRbMsUDY8hYK5PpznqoLcNX2D/
         S/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701097352; x=1701702152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5joBsafDa+/LYb57y4VbtzIveE2Spcp3cT3kdc03ld4=;
        b=OZLYfooxLghmORa1SJyK7gH8sNl2sUOulLv1D+RllPrbTczcILAz33aEekn5DG7BVy
         lmGORKmaguT87yeHRQ/8yfUcoW8/bYGjXVhoOnoCv0SBO9+YsyA2gsCXa1Lblg5tWudx
         WLJgODXRts/Gc2Afq/Sr9TqY9VR9gpb/I7RmtOJPWHQQxyX0f1E7cqppW3UvD6RBPPih
         5SdfCN/mmWQwy+DB2aTkyJbeQ3Ar7oCnaUGEV5UbVZwH9VicEgd9bX5gEqSnTcmc8Ndp
         MRWKUrGQjbioCkkmExC2KpEW9fL0lt2scQPg3TLN7mk9hqYH3l5l2IGXMwPrk1Dym9uU
         I2+g==
X-Gm-Message-State: AOJu0YxuAX8h1vFC5EIdVX6PlOhv7khp/rH0oiDUgrigA9wJuJub5XRD
        7AyZAgAN46uYUJmVZ4nLVMaZxA==
X-Google-Smtp-Source: AGHT+IH14X2dO59FKnHrNLey+PEQu8nZw3uE/lmwblR6iVZk8VgVy4Bu0jaw/CKKZyDinSeTGZU9OA==
X-Received: by 2002:a17:906:fad6:b0:a10:d5ef:ff00 with SMTP id lu22-20020a170906fad600b00a10d5efff00mr1591294ejb.2.1701097351087;
        Mon, 27 Nov 2023 07:02:31 -0800 (PST)
Received: from ntb.petris.klfree.czf ([193.86.118.65])
        by smtp.gmail.com with ESMTPSA id bj15-20020a170906b04f00b00a01763d21f7sm5766272ejb.31.2023.11.27.07.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:02:30 -0800 (PST)
Date:   Mon, 27 Nov 2023 16:02:22 +0100
From:   Petr Malat <oss@malat.biz>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded config
Message-ID: <ZWSvfgFFu+ILKN4H@ntb.petris.klfree.czf>
References: <20231121231342.193646-1-oss@malat.biz>
 <20231121231342.193646-3-oss@malat.biz>
 <20231123194106.08f5832f558fe806b1fd8098@kernel.org>
 <ZWADKWURCDZXyJTQ@ntb.petris.klfree.czf>
 <20231127074630.993db80be06f03067d8a1aef@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127074630.993db80be06f03067d8a1aef@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,
On Mon, Nov 27, 2023 at 07:46:30AM +0900, Masami Hiramatsu wrote:

Shortened the mail as this seems to be the last open point

> > > And as I pointed, we can remove CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD so this case
> > > should be removed.
> > 
> > I have added BOOT_CONFIG_EMBED_APPEND_INITRD, because it's not backward
> > compatible change and I didn't want to risk breaking current use cases.
> > My change tries to get early options working without affecting how
> > other options are handled, but I think appending the config is more
> > reasonable behavior and if you do not see it as a problem to not be
> > backward compatible here, I will delete the "replace" behavior.
> 
> That's a good point. OK if disabling CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD,
> it must skip setting early_params to avoid "hidden setting" from the
> embedded bootconfig.
 
That's not a good idea because then disabling BOOT_CONFIG_EMBED_APPEND_INITRD
would disable early options handling even if the user doesn't use initrd at
all, which we do not want.

I suggest logging a KERN_NOTICE message if any early option was applied and
at the same time embedded bootconfig was replaced.
  Petr
