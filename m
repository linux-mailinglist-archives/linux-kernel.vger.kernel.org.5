Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0F76CAE2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjHBKct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjHBKcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:32:23 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139042D78
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:28:01 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fbea147034so62086615e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690971951; x=1691576751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3xsXxqRa3tPBSRkvz1oPB/eL3+99UKxKxOJFNA9MY0=;
        b=m18MhcmMCSfWzAK9MNiH7Q4bVVQhKDDmtHnfSFcKMKQIzPIhhHtO6zLhGkYyHwiT6h
         K2g1bdYuCLFw+WBGg6I8sPMnwFJ9NnDdSMiIB4V/3ROu82pFGA1vuVgxKWZS/rmSVjAd
         lgB0DMsEZnbTMzhq3ySLutsNfQCD9jGyJSgaI75q9aDGGjXn/6NUP+xGutZn1UVZipP/
         dhZu/fN4s2DD6oM6is7t06khRwzq3xdOd0N7CtjtHB/Qoq3OeuaHotoIkOo+Vg3KdMVe
         +dnYBiuPbdhfwmgQvM1d8XAcFyCWRF8tH6dH5ESMgi1uzDhFjiRKNjy5DGr83ndj1boN
         s9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690971951; x=1691576751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3xsXxqRa3tPBSRkvz1oPB/eL3+99UKxKxOJFNA9MY0=;
        b=Nq03C11O4QKGNv5IzfOBs3rcaRt6YAESdQAuyM3ChtwHPcEet8W3XOSNdlOtXZOuTT
         H5kcDc2wsOzEtuWBDFVjgLXIdJPe3WU0ziI2YngGGAGtKnwobAhxQ+QruuJ7ZGElxSTz
         F1PVr7QrQ5zcxWFNmldYe6aYl2f5eBqnIFkWHQQxqAU5eC0QbgVkzFMrp+uRLA48woko
         Ebwh8ARvk6RPg89pJeHym10jn4eAYCTWcmz3u2kM03BIssATo7S8vO6BDUxFBkMZcI7B
         4/N90ZBUIsJwYAO7jUlb5BdBq7nBiJ4FwLjvvPx7Lc31ssqL5cquf/a4VAjeQ1LWP1q/
         kgUQ==
X-Gm-Message-State: ABy/qLb+LrXokuOTLr2k1DqtOhdK8Oe1rLNXQBe380iqxX4rc9Drfw3k
        e+2s6UK0xKvo2nCgSFPPpuZGkA==
X-Google-Smtp-Source: APBJJlEk4snBLq3TyctOwWDs/lvn3Y5F4HIa1dBj5Swh00i83Ft02caDhSARnn+7/wDqmMsxVfUnbQ==
X-Received: by 2002:a7b:cbd8:0:b0:3fe:228a:e782 with SMTP id n24-20020a7bcbd8000000b003fe228ae782mr4398543wmi.37.1690971951228;
        Wed, 02 Aug 2023 03:25:51 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bca4d000000b003fa96fe2bd9sm1325004wml.22.2023.08.02.03.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 03:25:50 -0700 (PDT)
Date:   Wed, 2 Aug 2023 13:25:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        bfields@fieldses.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs: lockd: avoid possible wrong NULL parameter
Message-ID: <531df8ee-ba09-49df-8201-4221df5853c6@kadam.mountain>
References: <20230802080544.3239967-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802080544.3239967-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 04:05:45PM +0800, Su Hui wrote:
> clang's static analysis warning: fs/lockd/mon.c: line 293, column 2:
> Null pointer passed as 2nd argument to memory copy function.
> 
> Assuming 'hostname' is NULL and calling 'nsm_create_handle()', this will
> pass NULL as 2nd argument to memory copy function 'memcpy()'. So return
> NULL if 'hostname' is invalid.
> 
> Fixes: 77a3ef33e2de ("NSM: More clean up of nsm_get_handle()")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/lockd/mon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/lockd/mon.c b/fs/lockd/mon.c
> index 1d9488cf0534..eebab013e063 100644
> --- a/fs/lockd/mon.c
> +++ b/fs/lockd/mon.c
> @@ -358,6 +358,9 @@ struct nsm_handle *nsm_get_handle(const struct net *net,
>  
>  	spin_unlock(&nsm_lock);
>  
> +	if (!hostname)
> +		return NULL;
> +
>  	new = nsm_create_handle(sap, salen, hostname, hostname_len);

It's weird that this bug is from 2008 and we haven't found it in
testing.  Presumably if hostname is NULL then hostname_len would be zero
and in that case, it's not actually a bug.  It's allowed in the kernel
to memcpy zero bytes from a NULL pointer.

	memcpy(dst, NULL, 0);

Outside the kernel it's not allowed though.

I noticed a related bug which Smatch doesn't find, because of how Smatch
handles the dprintk macro.

fs/lockd/host.c
truct nlm_host *nlmclnt_lookup_host(const struct sockaddr *sap,
   217                                       const size_t salen,
   218                                       const unsigned short protocol,
   219                                       const u32 version,
   220                                       const char *hostname,
   221                                       int noresvport,
   222                                       struct net *net,
   223                                       const struct cred *cred)
   224  {
   225          struct nlm_lookup_host_info ni = {
   226                  .server         = 0,
   227                  .sap            = sap,
   228                  .salen          = salen,
   229                  .protocol       = protocol,
   230                  .version        = version,
   231                  .hostname       = hostname,
   232                  .hostname_len   = strlen(hostname),
                                                 ^^^^^^^^
Dereferenced

   233                  .noresvport     = noresvport,
   234                  .net            = net,
   235                  .cred           = cred,
   236          };
   237          struct hlist_head *chain;
   238          struct nlm_host *host;
   239          struct nsm_handle *nsm = NULL;
   240          struct lockd_net *ln = net_generic(net, lockd_net_id);
   241  
   242          dprintk("lockd: %s(host='%s', vers=%u, proto=%s)\n", __func__,
   243                          (hostname ? hostname : "<none>"), version,
                                 ^^^^^^^^
Checked too late.

   244                          (protocol == IPPROTO_UDP ? "udp" : "tcp"));
   245  

regards,
dan carpenter
