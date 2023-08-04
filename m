Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E361C77032A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjHDOdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjHDOdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:33:36 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B5246B3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:33:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so35905671fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691159614; x=1691764414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJceY5070lCje9P8hIH/TGu5+TQ0hwpi7Lw9dbd0KDo=;
        b=Gtkh0KewHJRP0GX1gq08SEcRN1NtPosJofSJGhpkQlryJLREADTu1c2tTZSEBAriFb
         pm4yDPClhkOImF2dNEfaSRwj2mlv/ZDSnVWGthRMl79mIlnY675rZGw3L4ReUd8LH0A7
         Kgt2KV69Hev2faxLPNH7Wp0pp3HG8XGh5Z6IYdk6bo1JyrEMXy1acfIqOvLUdqzuSYiD
         NnmSacrXDT/hZUKvlmmWEzzMWmyT3d+4LBtxp85YhLjXUPkFPB46m3AlAQqE613TtlJy
         lwjv9O11uk+56jWNjVEeqHnCJmu0aQNl1DUrosaTJeAkyUTBv0Wt+eFVdAnZBYK/fFM0
         cLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691159614; x=1691764414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJceY5070lCje9P8hIH/TGu5+TQ0hwpi7Lw9dbd0KDo=;
        b=Xmsp7p3znDEdzX/uFR1IPUaUnOc3wz1XhbuSV1g/EKA0r8LhjzH4bTCddrbiy3la/6
         6WEsNd3rZw3j8jGQl6Qs0RX56qGkIwejaRENmdgxbdBEBgw7TRe2PfS6za1x8k3+asEu
         NYgewnXWNgImhyDT+IIrTrAvg3Qii+Arx4VmKJQTiTKegMO2ngdNbN315tuIxsSk10rg
         fF0BM+vIAkporTK5wzRFm7nXXlnQiPHBh+LR+oxSDtKK4n0AtdetiTo62BzoeZyCbFYk
         AJ2rEvNtKQW1SrFZSwJjRqEYqTAEcqvZXD0h6JXa6ZmvBEg3LuL+etSvCsdJaszCK+Yg
         VmUg==
X-Gm-Message-State: AOJu0Yz5jr0rOnTyy7ab1SaMB7KGGpbGXu+k7WUzj3xTlQZGT8foAxFn
        hwPKnM7M5jCpwY1UcGGqdeHaCg==
X-Google-Smtp-Source: AGHT+IFiFzjIO+ZLID319RKbJYXRmZHCV0URpVEiP/kd1jfJrpk0xC3qN5zBQkf0ICpI5ZOMCaxJWg==
X-Received: by 2002:a2e:7c03:0:b0:2b9:e8d6:c486 with SMTP id x3-20020a2e7c03000000b002b9e8d6c486mr1560433ljc.27.1691159613879;
        Fri, 04 Aug 2023 07:33:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u25-20020a7bcb19000000b003fe1cac37d8sm6985302wmj.11.2023.08.04.07.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:33:33 -0700 (PDT)
Date:   Fri, 4 Aug 2023 17:33:19 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] staging: vme_user: fix check alignment should match
 open parenthesis
Message-ID: <5539044a-0d67-43d5-9d75-42c65d616239@kadam.mountain>
References: <ZM0Lmt5Dp/k6iO21@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM0Lmt5Dp/k6iO21@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 11:30:50AM -0300, Alexon Oliveira wrote:
> Fixed the following as reported by checkpatch to adhere to the
> Linux kernel coding-style guidelines.
> 
> Changes in v3:
> - Fixed changelog
> 

Nope.  :P

> Changes in v2:
> - Fixed CHECK: line length exceeds 100 columns, noted by Greg KH and Dan Carpenter
> - Fixed CHECK: Alignment should match open parenthesis
> - Fixed CHECK: Lines should not end with a '('
> 
> Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> ---
  ^^^

Changes go to under this cut off line here.

regards,
dan carpenter


