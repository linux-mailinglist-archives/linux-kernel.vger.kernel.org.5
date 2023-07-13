Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0257A751E96
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjGMKOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGMKOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:14:34 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA08EE77
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:14:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so4412375e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689243270; x=1691835270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eylTNeGotPT4mFHd6mUGuPwign2b2eJWh9cYl75CktI=;
        b=sosSZTG63jbMiMaRY3hSW2RjHaOXG1Z9zgPoqAmXLkF0ZtSSRnNESPw7n71HK1CLmJ
         J1K1jLtUl1uvMqO8z3mlnL01YNAXolTJGpxAOON7tRLkUuqw4fhJx/BNK6vQogBRac1I
         tzaB0ttSOoaS2I7S/BmTGbedNrSAGTy7P898XCs1x6IYEcjnEGnXf4HcN3+RifTMpoT2
         qq7MBZC3scGMgyrAhjQDmE7Y2s/BmitlT0pIdhepROxLE7B3by6VRLy0qhvryF8H/1he
         s3MowmaHbviXWlXuw7Hzcx4VD/GFhAeEzZFoJH5jEPJnCDfMMwJ7F79B3Ljv8P3g/rfA
         RQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689243270; x=1691835270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eylTNeGotPT4mFHd6mUGuPwign2b2eJWh9cYl75CktI=;
        b=GMIkXN+d9vT6hiKWEINBCffATM1sLNBs0qXCF6BRK2pak83LoBW1Yv1b6nKhZGyQ7V
         JpI+gn8lVaWqZgAlVAjzRX6EVwzGx7j4N+AOjA7W2capa4L4JMZDmGyLP+8S66C2+VVn
         xfXg8HDMrAgrIcsI6X+iYWkg6uLoUBNbwQKrixvcdVEPaG1MiwvNcPPY22D/blqOKJ72
         A30WUiV1JEdrZNqGE/CddoHtnIfgjJR8z2PQ9mjqw8QDZ3R1hghZ/UTe8ltey1MIQzj2
         4g7h/Ne685WHQz6HVfIe/RRicohGquitT+8Qc05hfMuUANx1PclSVIEnnaw2bjkhziY7
         0dIQ==
X-Gm-Message-State: ABy/qLanVppP5G5+K+lZBMRmL84XNrcpkuj6iYMvYLDtVyLycSz2Bl2A
        f2vR7+re+rDsJvPJWrFTTt3fKQ==
X-Google-Smtp-Source: APBJJlESa2LU/i2J1kg4/CXlx9uNZfKYQiFGk01+9QiwxaXq6nsOX7KVcE9MNxIJvj0zp16YUysJGA==
X-Received: by 2002:a5d:500f:0:b0:314:37a:4d2 with SMTP id e15-20020a5d500f000000b00314037a04d2mr1061868wrt.60.1689243270137;
        Thu, 13 Jul 2023 03:14:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a25-20020a1cf019000000b003fbb346279dsm7467745wmb.38.2023.07.13.03.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 03:14:28 -0700 (PDT)
Date:   Thu, 13 Jul 2023 13:14:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v3]  ntb: Remove
 error checking for debugfs_create_dir()
Message-ID: <090a0dd4-cbe4-4a9d-8074-7148d69ea72b@kadam.mountain>
References: <20230713085621.3380-1-machel@vivo.com>
 <2676117e-cbaf-4c4b-9197-91c796682859@kadam.mountain>
 <SG2PR06MB3743648B9D54AF2D6CB4229ABD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR06MB3743648B9D54AF2D6CB4229ABD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 10:07:45AM +0000, 王明-软件底层技术部 wrote:
> Hi dan carpenter
> Sorry to bother you again, Is there anything wrong with my patch? Can this patch be applied?
> 

I'm not the NTB maintainer.  I don't see a reason why it can't be
applied but, please, wait for two weeks for maintainer feedback.

regards,
dan carpenter

