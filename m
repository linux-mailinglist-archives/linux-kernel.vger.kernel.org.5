Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BFB7FC195
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346505AbjK1Rx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346305AbjK1Rx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:53:26 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FBF93
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:53:33 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cbe6d514cdso4759552b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701194012; x=1701798812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6ztr6+2rLgZIaWqzKBS77D4ZPNoW2bglaBsW3eNwKE=;
        b=dhNSi8jLxZhYeeO3E39RzYoLkHDWZENP56FGJc5R0rVu3OC/SEYI5WQt5ZkwVDEjA0
         whSsKHezlvfd12iZZ56BXvoy08FA/eTG5uvCLg/TD45mKtiA1V0sA/pbOhvmzgqKFCzg
         9Mnfkp6eR6NaGy7PKD2Pv0n4ifNXQKTRimDcz7zly093xCrDStYPzXtvLLRfpyvnrw0T
         wFCagjDxjrn1JA7k9GsMypWqRmX0LaQ1u49E+nBCzkji4rrP/i0K0kQ5NGlJ4aH2OgUd
         qEHUwwJZnAbgTg7ELAP7MEmqEh8uOhaINXr25yXlMXNygm8Y4lFivI7T1tfpkWo/WrUv
         20dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701194012; x=1701798812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6ztr6+2rLgZIaWqzKBS77D4ZPNoW2bglaBsW3eNwKE=;
        b=TayaShsRRwINhARud48Og4gnoffrSWEECovSqpvOotVAKLKnmgqRPe0wPtLPSK9LMB
         p3Xg+sTXtxbnBjUci00R9Wxylj3eW4J5rcslW15L+RK3cYI/A4VdD20G4bg5CXX/ZyxG
         Zy78N6+bmTjW9cGs3C6XxWO8H6hc+knqoXtxGrM+g5QEzUiR1vF/KyGLniD5eqYcHlQi
         NRXOQkPT/M44je0upYdAphX5Qy1Yr5eY1zvrOlCBHcgZtx8pmxI/SrnP6VS7xZ5HbcXk
         hjFtGiFahZldNOZE+FYWyUAFyMrMTku5oRdovh5LGazm33G9e4EFtOiHfJ97hpeGfgds
         14Xg==
X-Gm-Message-State: AOJu0Yzjmwxomxn6ukmenlVETcw1f7eUtkSDFqauYf4TZE4330BD1MT9
        tJ5p+I+KlUyUJkptWbdFZZQ=
X-Google-Smtp-Source: AGHT+IGMWpfJM8b5bOqaD6mdsNWpxg2Ll2Z84Hx9IS3VW/fLw/mZP/xI2WsRcb9EfP/iRp0DADUPbQ==
X-Received: by 2002:a17:902:da81:b0:1cf:b1e7:14b6 with SMTP id j1-20020a170902da8100b001cfb1e714b6mr13238949plx.31.1701194012349;
        Tue, 28 Nov 2023 09:53:32 -0800 (PST)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902e84f00b001cfd2b088fasm3901217plg.134.2023.11.28.09.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:53:32 -0800 (PST)
Date:   Tue, 28 Nov 2023 09:51:16 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     'Guanjun' <guanjun@linux.alibaba.com>
Cc:     andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] lib/find_bit: Fix the code comments about
 find_next_bit_wrap
Message-ID: <ZWYolIpvGJGLs+U9@yury-ThinkPad>
References: <20231127083127.2420632-1-guanjun@linux.alibaba.com>
 <ZWYmNRxKE6CB4Lli@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWYmNRxKE6CB4Lli@yury-ThinkPad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+LKML

Just realized you didn't include the LKML list. I'll keep
your patch in the bitmap tree because it's a trivial change,
but for the future please make sure that LKML is in a loop.

Thanks,
Yury

On Tue, Nov 28, 2023 at 09:41:11AM -0800, Yury Norov wrote:
> On Mon, Nov 27, 2023 at 04:31:27PM +0800, 'Guanjun' wrote:
> > From: Guanjun <guanjun@linux.alibaba.com>
> > 
> > The function find_next_bit_wrap only has one memory region
> > to search on. Adjust the comments.
> > 
> > Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
> 
> Applied in bitmap-for-next. Thanks!
