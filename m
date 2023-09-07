Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668A07974E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjIGPlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245562AbjIGPgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:36:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957952697
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:36:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fef56f7248so11899055e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100977; x=1694705777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aE7vJQ21e8Yb5nhmBCR4D+bvKfnELhlwtCmehPemd6k=;
        b=kGLERvbDmI57niQBIs3dPYZlqTBBS3HxFMLdcjnDjk13wn0QPxsaayhb9SSHUNcZf8
         LN/TvlIKJrSvtRFNYUOmbW4iYV7piURkzlO3oAKNUD6y40iLjBo1zElbfDuxLgd2F9p4
         HZB15xFBrd7yyto3sLosYGYEOOBgQuWnKEll07J8vAmk+8xgRUUrlD5yP490ZFJkqUqu
         Nfr/2ddhW+WjBD7UbjI2RRyrv1y+WvzGtFj3yG7ct6bgCAEwZpd/n6/Z+cPmV8LAtJSf
         JZ9hUqF/j+kX3MnpVVmbLg2SeDqhqN8wbf+RPzICACZjMESzAcKMVUYQRHUcpkHYV0g2
         WGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100977; x=1694705777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aE7vJQ21e8Yb5nhmBCR4D+bvKfnELhlwtCmehPemd6k=;
        b=GMX+F8NnLOpNMwG4soLGE6AcOPtZ9rzjCCbL0jULvc7w6xWaQ19Dow+Lx8/hGW17em
         Nru4H1T3JF8nxtrS7tTIpT0QSQSWEN07lqYrhGFwOIeiNpJjeJaxy5yOko9re26r+vgz
         gcWncW+cTCEezKsIXk1g6l6ru53tMJRldseAWuzEo+GVHMiao/gHOn3lBZpjUyPZGas9
         Z3eGXnDZuRJRYUoLZIPuomvWVl9BsrxSB0taZwiISnFfJ3ydWP5ZlwqD8WVsdEvi0Ojp
         dCG7Lb6tqGNNJux/iIG5yWWK8Nxkzw1wQy4hQczcrWJ/W0i2Tqr4OTZO6MN9M8BGL+cW
         wckw==
X-Gm-Message-State: AOJu0Yzmyvn8aSSoNfCSSDksPBpIhLsuqVsIdvpPhe11/jEFgK6xJP0V
        YKjqLyE1a999NxJ4Gp/ISBUDdCTuZFZCgaNJz5s=
X-Google-Smtp-Source: AGHT+IGQPcYGYPVwLKav68vZ77AytVa8Y+KuNIGyLdm9jK0D3P5KS5nbDeYyCDqnJCAVNeCyjjOSdA==
X-Received: by 2002:a05:600c:3b9b:b0:400:57d1:491b with SMTP id n27-20020a05600c3b9b00b0040057d1491bmr4554264wms.2.1694084544881;
        Thu, 07 Sep 2023 04:02:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l4-20020adffe84000000b003176eab8868sm23062193wrr.82.2023.09.07.04.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 04:02:24 -0700 (PDT)
Date:   Thu, 7 Sep 2023 14:02:21 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Kalle Valo <kvalo@kernel.org>,
        Sujith Manoharan <c_manoha@qca.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        hust-os-kernel-patches@googlegroups.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath9k: fix null-ptr-deref in ath_chanctx_event
Message-ID: <7a766c54-ec81-4ee2-8904-66adebd31b84@kadam.mountain>
References: <20230901080701.1705649-1-dzm91@hust.edu.cn>
 <87y1hqtbtu.fsf@toke.dk>
 <317b9482-d750-9093-e891-21f73feeac0c@hust.edu.cn>
 <87il8uta8f.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il8uta8f.fsf@toke.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 01:16:00PM +0200, 'Toke Høiland-Jørgensen' via HUST OS Kernel Contribution wrote:
> > Before sending this patch, I searched in the code, there are many call 
> > sites of ath_chanctx_event with argument vif as NULL.
> >
> > Functions calling this function: ath_chanctx_event
> >
> >    File      Function                   Line
> > 0 beacon.c  ath9k_beacon_tasklet        459 ath_chanctx_event(sc, vif, 
> > ATH_CHANCTX_EVENT_BEACON_PREPARE);
> 
> But only this one has ATH_CHANCTX_EVENT_BEACON_PREPARE as an argument,
> which is required to hit the code path you are changing.
> 

Btw, if you have the cross function database enabled then Smatch will
parse this code correctly.  No false positive.

regards,
dan carpenter

