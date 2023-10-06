Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656BB7BB1BD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjJFGtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjJFGtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:49:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A0DFA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 23:49:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-323168869daso1723021f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 23:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696574957; x=1697179757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKyYQbXkv0DN4EBuZMI04wTrChTBXwJCOcKCksVCFqk=;
        b=p57BjTEBzhJ9I+OcTZ9dAsLW0ToPT8QKKyb4qupfxIctDC5MaezZIVTCeaKfRyD28k
         V/mCYDrtqEuzDfS6P2xsOez1D2u6ASLBREWF42z9t1ukEey5hEHcuJtXjQMH/k0MZtrr
         WhS6bx7sKgeSwvWg6hgp5QRNQOrKw1hakLm107LR96E6pftrS6LnHArlWt3yPyd5K5C+
         crOtvuzABGZIDGjh+988+RmFS9jk6ozGAUyRRLuZ/Zh0qu2or3H/XPymQjqhlmsrgNGM
         eHqKUw/yW31ymBPgb7an6MY6n3PSGRMnEcpYHogashClIboJ4GSykVGHRftvcsC7t6nY
         Lj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696574957; x=1697179757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKyYQbXkv0DN4EBuZMI04wTrChTBXwJCOcKCksVCFqk=;
        b=lapxTwHw4ydXZJH9dYziD1BT0QG6evY3Z2Fn1GAYxV+BLPqk0NCDo69IXwyGsBZ/mu
         DnWsURPlu1MlyqHPwpGTzgJ08F9Ga9S7AjK50i+XkG99f6g/iL657o6/VhpF/xt2cVzL
         4FWEbnsy46MUYh6IGEXz6sszBmMgrCuLX3QY7lebTsf8+rz8YEzBVKQraQ6aYrOFZfo0
         IeTBgi66a3d8sR5NGVYkVqpRhI/5pWF7YRmNWxg45CpTqYS/VKQyJF+IPmXE2b4OOY2x
         f4c79GBSVay7WoC4dmwyDOxHP0LIg8bATMeygvG4hf/s+wlnGLoBeBqn2wkutvXkjIth
         Iqmg==
X-Gm-Message-State: AOJu0YwHaF+GNM2/5Zhsd+uPtVuSewBO93HzAtfvPvTlEV6Xq0fvbFh/
        E2s77olP947DCFiVPN4gBAjy+w==
X-Google-Smtp-Source: AGHT+IF2+kDKPp/gG06BUTDJC2DNcBwdzig6GHZZVXuDvKfDdbwG8DLu26BMKaY1cWPMGKa08l4QMQ==
X-Received: by 2002:adf:fcc8:0:b0:31f:e19e:a2c with SMTP id f8-20020adffcc8000000b0031fe19e0a2cmr6558632wrs.32.1696574956859;
        Thu, 05 Oct 2023 23:49:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q8-20020adff508000000b003200c918c81sm886963wro.112.2023.10.05.23.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 23:49:16 -0700 (PDT)
Date:   Fri, 6 Oct 2023 09:49:14 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ricardo Lopes <ricardoapl.dev@gmail.com>
Cc:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        coiby.xu@gmail.com, gregkh@linuxfoundation.org,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Replace strncpy with strscpy
Message-ID: <869f4059-1fce-49e3-9edf-8bfa42aba4a6@kadam.mountain>
References: <20231005191459.10698-1-ricardoapl.dev@gmail.com>
 <0b78b29f-2a84-487c-a43b-f8d3fa20d935@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b78b29f-2a84-487c-a43b-f8d3fa20d935@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 09:42:41AM +0300, Dan Carpenter wrote:
> On Thu, Oct 05, 2023 at 08:14:55PM +0100, Ricardo Lopes wrote:
> > Avoid read overflows and other misbehavior due to missing termination.
> > 
> 
> There aren't any read overflows in the current code.
> 

So when you're reviewing these to look for read overflows, a string
literal isn't going to overflow.  So that makes the last two obvious.
But for the first one you have to review the caller qlge_gen_reg_dump()
and the last parameter passed to qlge_build_coredump_seg_header() is
always a string literal so that's obvious too.

It's not really that much work to check for this.

regards,
dan carpenter

