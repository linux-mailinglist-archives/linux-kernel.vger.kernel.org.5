Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25153785CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbjHWQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjHWQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:04:29 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2C5184
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:04:28 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-410915344aeso24231521cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692806667; x=1693411467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgwQQssNisFcDlSAbmB9tgKtABE8UDfzKEg3w2u2WUY=;
        b=PSHh0C0tup1HpJUcqAvhjxPp6TSWZfWCVDX4C6McSPiPkRG6fA1s4JVpwur/iUjjE5
         shFyXvjiCTQXOL8n1DADayXGQ/D+OUlX/1PGjxNYeVrDxt0IG6t4xvAicxy7c6UwhROr
         sGy5dHpBjLaCzkEY0vRuEPoE4brJUXa6CvcpxDm973Gsc1zuhjfGLjaYpM7M6qDV7Nmg
         v02UyYYx220ZOUdjSCVuD2DXmXrSTLFSZuBEmG6GfKt5Rm26KTqoD0iAXMPjU5Fasjvo
         2pKNlWBGMa4E6ozr31/ekMKNzYGzxoeTF1UHC6/QKLdO1kVGWM4J17MHVyrg86ON+TsV
         GGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692806667; x=1693411467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgwQQssNisFcDlSAbmB9tgKtABE8UDfzKEg3w2u2WUY=;
        b=B1CZXSTCRjCAvfDLZVmNV3YB4EfHtFwIj3SLEqMPfiG5BvGTNevVhI6mKcok3S4doD
         1+IKrUeL/MS0M9LBbAQSVrgNmReGNWEwDdHUcITs76saxEXEST1K8MBD63qLVvLiC9AN
         joYs/D9JRa46wd33lNMARm8K9kUEro2xjPhmzIqWbk7Y/cLCIw9HUpr/6zPciAtgJ5jx
         SYr0Q4IkEkBI4cKqExmUsYuRnuWqYQ4SO9sH9q+xNYlkm7DXl7DmVpbh8CvYVig1nG+f
         aGp8UVFdN8ac6yFO9phlmtMHcih/TKCjluTBRiCDxB3uZdoy6gqMtxpT6w2hq8/9l+z/
         V4wA==
X-Gm-Message-State: AOJu0Yxg6/pPA3qhZ5nHA084QFmPjpxGxgw+r/3rbRuHu4TlyCXLp3sQ
        kzWWN29B3NClCJbQjNSXWLx20rL21A0=
X-Google-Smtp-Source: AGHT+IHivHnj0yHlLVwLmnIv66NnFWZ14jcAHFP7qjk81m/CRqyiuMtdCNcSvg0MFWW1vMa5IEIAdQ==
X-Received: by 2002:a0c:e149:0:b0:64f:5ad7:f56a with SMTP id c9-20020a0ce149000000b0064f5ad7f56amr2555864qvl.9.1692806667162;
        Wed, 23 Aug 2023 09:04:27 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id c16-20020a0cca10000000b0064b502fdeecsm4133909qvk.68.2023.08.23.09.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 09:04:26 -0700 (PDT)
Date:   Wed, 23 Aug 2023 13:04:22 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check unbalaced braces and
 misspellings
Message-ID: <ZOYuBvMS3pcpA37b@alolivei-thinkpadt480s.gru.csb>
References: <ZOVjfKUWsSAkbpZG@alolivei-thinkpadt480s.gru.csb>
 <2023082303-balmy-bucktooth-f85b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082303-balmy-bucktooth-f85b@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 08:49:25AM +0200, Greg KH wrote:
> On Tue, Aug 22, 2023 at 10:40:12PM -0300, Alexon Oliveira wrote:
> > Fixed all CHECK: Unbalanced braces around else statement,
> > CHECK: braces {} should be used on all arms of this statement,
> > and CHECK: 'specificed' may be misspelled - perhaps 'specified'?
> > as reported by checkpatch to adhere to the Linux kernel
> > coding-style guidelines.
> 
> That's two different things, so that means it should be two different
> patches.  Please send a patch series for this.
> 

ACK. I'm splitting them and resubmitting right now.

> thanks,
> 
> greg k-h

Thank you.

Alexon Oliveira
