Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C2579784A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjIGQps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjIGQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:45:46 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC09D1705
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:45:13 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-500b66f8b27so1981080e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694104737; x=1694709537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JnMGoGgKemb+DDrSQzPTABi+a718THu1rk85qOkvFQg=;
        b=xZ9I0Ip5+LJE765k6SPC8D8dVcss3y7fH3SN2y8AG0T/csRR09KLTQlwslXNOk0qGu
         dmrJAGJ8d08hsc9LaR6s1tEJO2y0plOx7xCYds33f/k4A4CF3e/vpDvY3hK2jiP+dQQP
         jcWmHareq5LDlu7Tj6lXci//851RWnP6UO/4bC5RTBYTt8pel7UktEj5N9CEbGKLv34E
         hDjgWFnmk1PXf5+pMTzEHqhRjusmoFjR78nj1TN42o017A8nExARWJ6BiE+aiAYgfJzN
         xpp+K3+3jRQdUm9ZR1emUSTLAAfiPQT2D2cMx1625TF2W1tSl73kMBoIXnpn7pnGHL8A
         VC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104737; x=1694709537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnMGoGgKemb+DDrSQzPTABi+a718THu1rk85qOkvFQg=;
        b=eSS9A1vIpgVhpPXsWQchWP9MRWtCBQYCSOBvmqwkce2T7JZCwceQrSbEzzE62zv67g
         BaZX+tC1r3lgwtPlL1F3QYzBxT6lf48EXLJmjT1HgqtkxGexvid/8OhaoU6AVmUnaKXG
         9+swkO5fEvbYh/J8Eo491V3c+Zvm9zoB0b/Od7T9Hbm93BIMSEwMDixwXC/9I9KUx3HT
         j9ksV0FeGokMoA0VQ/SCrZtaOhNO1xxwQRDRqtgrMxBfTTb/IaYg8bAA7igDw6DVctHm
         N4qJ0kl652DKXB8+LPDajPToBik/6CxgHglTcaLTQPHCCccvQwHoKiorvqoRcqeQk6GO
         R9TQ==
X-Gm-Message-State: AOJu0YxabkSeLdDuJnY4D3GKf7Htam8oYgtsXymd+W/PDk4F6+9Dnnx6
        Jx4WCY+IcsFxiT1oLHiceQ4lDygUhF/wyHdWKT8=
X-Google-Smtp-Source: AGHT+IGyPStu/4bGX3A398E8xixDQaUmGkOmIW0jf0T9gkQFvDYPcLVleJrm+vURQhH+rA2UwXThOQ==
X-Received: by 2002:a05:600c:2246:b0:401:c297:affb with SMTP id a6-20020a05600c224600b00401c297affbmr4284944wmm.37.1694085336903;
        Thu, 07 Sep 2023 04:15:36 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c364a00b00401b242e2e6sm2208451wmq.47.2023.09.07.04.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 04:15:36 -0700 (PDT)
Date:   Thu, 7 Sep 2023 14:15:33 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Longfang Liu <liulongfang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Zaibo Xu <xuzaibo@huawei.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon/hpre - Fix a erroneous check after
 snprintf()
Message-ID: <71bf9b84-462f-405e-91aa-fb21fc6ffbd5@moroto.mountain>
References: <73534cb1713f58228d54ea53a8a137f4ef939bad.1693858632.git.christophe.jaillet@wanadoo.fr>
 <ZPaSCOX1F9b36rxV@gondor.apana.org.au>
 <00bdcfec-6cc1-e521-ceaa-d16d6341ca16@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00bdcfec-6cc1-e521-ceaa-d16d6341ca16@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 07:27:47AM +0200, Marion & Christophe JAILLET wrote:
> > 
> > The other snprintf in the same file also looks suspect.
> 
> It looks correct to me.
> 
> And HPRE_DBGFS_VAL_MAX_LEN being 20, it doesn't really matter. The string
> can't be truncated with just a "%u\n".
> 

drivers/crypto/hisilicon/hpre/hpre_main.c
   884          ret = snprintf(tbuf, HPRE_DBGFS_VAL_MAX_LEN, "%u\n", val);
   885          return simple_read_from_buffer(buf, count, pos, tbuf, ret);

You can't pass the return value from snprintf() to simple_read_from_buffer().
Otherwise the snprintf() checking turned a sprintf() write overflow into
a read overflow, which is less bad but not ideal.  It needs to be
scnprintf().

regards,
dan carpenter

