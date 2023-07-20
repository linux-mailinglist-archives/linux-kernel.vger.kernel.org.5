Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787B475B6EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjGTSgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGTSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:36:30 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6232712
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=HliQDCk+4Yn/B9aqgI/4DmJNGu6hnH6geQMJQqj1HGk=; b=ZSLrHpYQCqhJx5Hn+54ULNwbQH
        4T5Mssipxk7hifgTSQi2ZEgeaISUucwvkRPGm/WhnuxyEkEwzOpUY/vNLeKbg1k8HwF1qJiovf5cE
        vfVeXCFaPR0iv+d8aoehXEfOvDeim9gnldqPFeJkF8u9r+bpdIYmKH117fJ2RltUbVWBCYTg1+ODh
        CDLxli5VgywkEx+MfbT5j/A5J4ymouWqSl9BSUJVDzqj+6h2BLocc58X1VAnMUVI0DkEuWTjif2Nl
        aDt8cbZua3hoXxdqXM3a8EIgxEOYE6rit6K/cyds5nFtPyL/0UpDBj9kxlykwK3sytLhScLZ2iX8i
        oSo1Y9ZOQr7dO0PFjzCOOXyStER1ZOaVbTdULZAwHRCwE7Tii2cKBEdjyL1N2dmIT59Bsm259QiYn
        kAc7EUUC5pTje1MBqYSRxr0JFGgxUNEyT7SUx9EWAj3D9/iiSuxPYMm826aN706MnMhFYWG93GIwn
        b6dP15JIas7tf4vh1t6x1OL3LOljzOmJCL7nmklEoh6OmOMJegDbqgw7mgTlRPTop/rUsDzSVsYaW
        zsuG2NeXIqzSAdd/vGS/v/uTZLg++i9vrVuNLXe+mRfCFr1As3OTKE6ADxwEAtCYjV6byu0Yu93s+
        ZVyQQyCUkhdBMLFRfmT6/JJ/e7fOCdYt1JvE//AvM=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
        YueHaibing <yuehaibing@huawei.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] fs/9p: Remove unused extern declaration
Date:   Thu, 20 Jul 2023 20:36:11 +0200
Message-ID: <3136669.aDIXptDytX@silver>
In-Reply-To: <20230720143506.33860-1-yuehaibing@huawei.com>
References: <20230720143506.33860-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 20, 2023 4:35:06 PM CEST YueHaibing wrote:
> commit bd238fb431f3 ("9p: Reorganization of 9p file system code")
> left behind this.

Right, it renamed v9fs_error_init() -> p9_error_init().

What a giant patch that was BTW (3422+, 3130-).

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> ---
>  fs/9p/v9fs.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index c7f774fe398f..d525957594b6 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -545,8 +545,6 @@ void v9fs_session_begin_cancel(struct v9fs_session_info *v9ses)
>  	p9_client_begin_disconnect(v9ses->clnt);
>  }
>  
> -extern int v9fs_error_init(void);
> -
>  static struct kobject *v9fs_kobj;
>  
>  #ifdef CONFIG_9P_FSCACHE
> 


