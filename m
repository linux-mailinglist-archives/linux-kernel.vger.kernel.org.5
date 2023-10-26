Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE85C7D7B53
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 05:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjJZDmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 23:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZDmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 23:42:52 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1346D189
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 20:42:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6be840283ceso406533b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 20:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698291769; x=1698896569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hgyXtgeuM91v2O73kk15NKizTKA7Lbg0Ot69X2U/sA=;
        b=QAr27xWLYtSIMnKJ12KbyJdX5fP6B2IKyrUbNveD5BmBrgupam947Ou+v50Cxu/zhl
         7iZnN2nTAnHZPp/VIvmz85U2Gn34o9szw1SRapzriAzd2mnWB4hEK7P77+bV/Hj2q1Cw
         Qf0VxRYBOvLp9cvc+595dGxYx4iLLTO5+heevjOQ2wG5fM3H0vEzfj/2xb4wVPq1klGK
         ZEDnmhWbGQVRH5Eh4ijSog1avfdyto+sf6XKTiS87yhDcX8VRuj+Cdhl/fQmyQAdneLY
         7RZhhhUS49mqaKYjf7r561ZY+XrbPLtyyQ717iDUAo6Mqq/3uAM0iUa4CkHD8mhlpRP2
         /+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698291769; x=1698896569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hgyXtgeuM91v2O73kk15NKizTKA7Lbg0Ot69X2U/sA=;
        b=KU9pm2DW40vKkKF6tJzPES/1Vs0bJhzmmWX91AnIpxP8mgxlQCdfjUZqc5LlJmbCti
         1exzfbMpHqjP8q2LTUzL12IvxNWUEQ3ZsWTv+j/NNp0jbfyjk1dwHC02FC1KqbtdeA7e
         AQ0jN/7boeAoKx5lXqNGQfvAae80wWdyDcJs84qvN2RzF9dJZS7znBhFXBQ8eE83aJB2
         d9lTKNORLYGOuVy/+OX3+/ddWp/7CZuiJpD3zmBSlbHjC5pzn0oNSG3MqAkTUnnJlf1B
         g+LwgDN7eZMj59yPqOxyHNHSmEQMR9gViLnr6VTST4QVOu9yqrybcrIfQctTsFUsOlQn
         Kp7A==
X-Gm-Message-State: AOJu0Yxf47aiCIh0ri9gz3Z9gKNII/Q13LgRrb4pRXQ3QPwLBAfEeABN
        ImX7PONng6t8Vp+y/LVcdtQGHUUWAm0=
X-Google-Smtp-Source: AGHT+IHb1rT1mMR/a4wm/RAs/zjlnUHIOtmM+SDlLHDdDV0xv7S/22W13cSN2JKBOzR82eQ/upo57A==
X-Received: by 2002:a05:6a00:1ad4:b0:68f:cc47:fcc8 with SMTP id f20-20020a056a001ad400b0068fcc47fcc8mr15418709pfv.14.1698291769506;
        Wed, 25 Oct 2023 20:42:49 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id h26-20020aa796da000000b0069343e474bcsm10128924pfq.104.2023.10.25.20.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 20:42:49 -0700 (PDT)
Date:   Thu, 26 Oct 2023 11:42:45 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Ferry Meng <mengferry@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] erofs: tidy up redundant includes
Message-ID: <20231026114245.00005aa4.zbestahu@gmail.com>
In-Reply-To: <20231026021627.23284-2-mengferry@linux.alibaba.com>
References: <20231026021627.23284-1-mengferry@linux.alibaba.com>
        <20231026021627.23284-2-mengferry@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 10:16:27 +0800
Ferry Meng <mengferry@linux.alibaba.com> wrote:

> - Remove unused includes like <linux/parser.h> and <linux/prefetch.h>;
> 
> - Move common includes into "internal.h".
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
