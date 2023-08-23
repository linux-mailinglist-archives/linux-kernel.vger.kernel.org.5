Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8942078587F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjHWNJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjHWNI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:08:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDB7CEA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:08:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a40d8557eso2386025b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692796137; x=1693400937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qf4G25XaAsD/bFVHzR33gk1moFWId2eULxYKt6rsK5A=;
        b=X0oEopZ67vZ521E3wtTlBhVphVkOlbEjB96po7Mjw3+RPZNFohwK2JhQ4lwLUwls/n
         69IB7hknFGKnFZn9eEbcgPiZlTuB+iZhzBE10sBpCR4NB/VPxTp0vVsdOBEfKcV9S+SN
         dfqC1A3ry9C+h7K1jvjplvekVDI6DSadWGkYYYoX1LtO7GyJOFILc8pf3V4OPfMJ0r/X
         pRZLCoBhhI4wnKmIvuNqcbEIdR3nOysYYpdUei4Fq4tVhSSos/0dWu2mUwBuvDS/RBkd
         kUsyZMvdu92ENrEcJNCgeLLmgmTtxVzYRNLV7E5lJQXS/8z2eE6G5g2F2c8+rSwFyvX+
         QlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692796137; x=1693400937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf4G25XaAsD/bFVHzR33gk1moFWId2eULxYKt6rsK5A=;
        b=UhWr3yRtLmeAzQJH5B8u1+eA76pS/HVDEh8Zx4cXtaE6DSOuL9EuH3KHZKjTHyPYgF
         NWSzmUPGUW5yVxYavD3upHLHOCd0WVblBepl+xEWBPyy8cAqY2cGA+FKR/Ui13m+ReGE
         EE2OYOmUTlLWhnntQ7ZxyhBdwdYFa/egsXD6PZ5Xu9nXZjfrW2nV1RDlbPniH90YAUZK
         vStO+JjGNIfpg15cwnNzPYbfuCLk3MdQ6wwsZA9pcde2MX/2DqECwahVXu/XyTDeJZAV
         N3kPSl5kSgWVmyF/rfPN20gmDnxEkzl6jbJG5j7R3vngMFYpALwg52GOpOS5DWac00SJ
         FFXw==
X-Gm-Message-State: AOJu0Yxpd0BgpGG51ZFEXk7Go2EcBj18k176/VtTzcdBWBlha3AuBAE3
        0FmkJvzKf+y8kiA1tHZIyF8=
X-Google-Smtp-Source: AGHT+IEhZg97xgWmxGmje8X6eRI20mOdZfA/gtCn7BWIkRhmlu6tUPcPIcZWGe1nuUS6je1oDprjow==
X-Received: by 2002:a05:6a00:1a15:b0:68a:5937:eaa2 with SMTP id g21-20020a056a001a1500b0068a5937eaa2mr9500711pfv.12.1692796136883;
        Wed, 23 Aug 2023 06:08:56 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([122.162.51.13])
        by smtp.gmail.com with ESMTPSA id a24-20020a62e218000000b0068bdb0be6bdsm1226466pfi.191.2023.08.23.06.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:08:56 -0700 (PDT)
Date:   Wed, 23 Aug 2023 18:38:52 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: replace camel case by snake case
Message-ID: <ZOYE5DI+AjRlRUnd@ubuntu.myguest.virtualbox.org>
References: <ZOTUCRICU6lSYfdn@ubuntu.myguest.virtualbox.org>
 <e5eb5935-5219-4d43-892b-96a03f8eb755@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5eb5935-5219-4d43-892b-96a03f8eb755@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 07:31:21PM +0200, Philipp Hortmann wrote:
> On 8/22/23 17:28, Pavan Bobba wrote:
> > Replace formal arguments of few functions and local variables of camel case by snake case.
> > Issue found by checkpatch
> > 
> > Signed-off-by: Pavan Bobba<opensource206@gmail.com>
> 
> Hi,
> 
> please find a unique subject so that we see it is something new.
> 
> Thanks
> 
> Bye Philipp
Thank you Philipp.i have updated my patch description in next patch
