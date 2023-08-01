Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D680276C0D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjHAXZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjHAXZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:25:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2D02130
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:25:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686f94328a4so235013b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 16:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690932303; x=1691537103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8DB7NbDsAn8EUrVtRgWQWKrnvDzR5ULizdCe1TRVecI=;
        b=eSuXH06fGHPWanB/YZ+J2QKDAVJRQkq2fZbLn8T9TVWSkFpCr0Q0uINw6ckgd0a1ec
         JOnnHLRHaXYOhw/f2OYfBG+9VCIXHlmnSyYbI86SGyBNx1i/L7f/LiIoK743mbr5qgv5
         0Tbh1FmonkuZeJpnc1Ks81So271DhDQXbfVAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932303; x=1691537103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DB7NbDsAn8EUrVtRgWQWKrnvDzR5ULizdCe1TRVecI=;
        b=UsmCD+23H2EiBN2G/S76f1xB40Za+/2OUniHnngDwdAtYPjOEwHL+SCvcfFrpvdoZ8
         cCOIx2FCP6sbGvw8hDX+B+ftOkcmAzCmfZcpqrR2Tnd/f1MPVgCUL3J4eggVwnBlhwk2
         0eUwmCYhC4NWlDZopg+KpveCDEfwGwjStv2YN2/RQArIxIUVmXbtn2vD6jajmNC6y8gm
         fETfsVVBbFRcN9vUKYRjcbjJGDQfr1Ck+90KJNeGl1vLAXrauFEVTTsggdtgawWQKLwL
         aKxxXsYNsRJWBrW51D80wdNpW4psmIrM1QGyBk7G1G+4JwiGhecGXbNohnA3wtEC0CRW
         HfMA==
X-Gm-Message-State: ABy/qLZWNbYolCiDcLL6kTN8y6CrGS4XhRV8eqa7Q2PV3KC+GXZc89T8
        bHroLNb41C8AcLql9IpcJUL/zZPBb+5aOOHxFL4=
X-Google-Smtp-Source: APBJJlHjQCrnLHz6V1HJoI3U0b00CuliXO6jJnknLdcBbfdeomZRMK4TWzo0biJIxq7OC2cGy15wSQ==
X-Received: by 2002:a05:6a00:4193:b0:678:11d6:2ad6 with SMTP id ca19-20020a056a00419300b0067811d62ad6mr14678959pfb.9.1690932303240;
        Tue, 01 Aug 2023 16:25:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v26-20020a62a51a000000b006873aa079a8sm4117645pfm.210.2023.08.01.16.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:25:02 -0700 (PDT)
Date:   Tue, 1 Aug 2023 16:25:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: ipw2x00: replace deprecated strncpy with strscpy
Message-ID: <202308011602.3CC1C0244C@keescook>
References: <20230801-drivers-net-wireless-intel-ipw2x00-v1-1-ffd185c91292@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-drivers-net-wireless-intel-ipw2x00-v1-1-ffd185c91292@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 09:53:36PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We can massively simplify the implementation by removing the ternary
> check for the smaller of `count` and `sizeof(buffer) - 1` as `strscpy`
> guarantees NUL-termination of its destination buffer [2]. This also
> means we do not need to explicity set the one past-the-last index to
> zero as `strscpy` handles this.
> 
> Furthermore, we can also utilize `strscpy`'s return value to populate
> `len` and simply pass in `sizeof(buffer)` to the `strscpy` invocation
> itself.
> 
> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> [2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/net/wireless/intel/ipw2x00/ipw2200.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> index dfe0f74369e6..8f2a834dbe04 100644
> --- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> +++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> @@ -1462,15 +1462,12 @@ static ssize_t scan_age_store(struct device *d, struct device_attribute *attr,
>  	struct ipw_priv *priv = dev_get_drvdata(d);
>  	struct net_device *dev = priv->net_dev;
>  	char buffer[] = "00000000";
> -	unsigned long len =
> -	    (sizeof(buffer) - 1) > count ? count : sizeof(buffer) - 1;
>  	unsigned long val;
>  	char *p = buffer;
>  
>  	IPW_DEBUG_INFO("enter\n");
>  
> -	strncpy(buffer, buf, len);
> -	buffer[len] = 0;
> +	ssize_t len = strscpy(buffer, buf, sizeof(buffer));

This means "len" could become -E2BIG, which changes the behavior of this
function. The earlier manipulation of "len" seems to be trying to
explicitly allow for truncation, though. (if buffer could hold more than
"count", copy "count", otherwise copy less)

So it looks like -E2BIG should be ignored here? But since this is a
sysfs node (static DEVICE_ATTR_RW(scan_age)), I actually think the
original code may be bugged: it should return how much was read from
the input... and technically this was true, but it seems the intent
is to consume the entire buffer and set a result. It's possible "len"
is entirely unneeded and this should just return "count"?

And, honestly, I think it's likely that most of this entire routine should
be thrown out in favor of just using kstrtoul() with base 0, as sysfs
input buffers are always NUL-terminated. (See kernfs_fop_write_iter().)


diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index dfe0f74369e6..780f5613e279 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -1461,25 +1461,11 @@ static ssize_t scan_age_store(struct device *d, struct device_attribute *attr,
 {
 	struct ipw_priv *priv = dev_get_drvdata(d);
 	struct net_device *dev = priv->net_dev;
-	char buffer[] = "00000000";
-	unsigned long len =
-	    (sizeof(buffer) - 1) > count ? count : sizeof(buffer) - 1;
 	unsigned long val;
-	char *p = buffer;
 
 	IPW_DEBUG_INFO("enter\n");
 
-	strncpy(buffer, buf, len);
-	buffer[len] = 0;
-
-	if (p[1] == 'x' || p[1] == 'X' || p[0] == 'x' || p[0] == 'X') {
-		p++;
-		if (p[0] == 'x' || p[0] == 'X')
-			p++;
-		val = simple_strtoul(p, &p, 16);
-	} else
-		val = simple_strtoul(p, &p, 10);
-	if (p == buffer) {
+	if (kstrtoul(buf, 0, &val)) {
 		IPW_DEBUG_INFO("%s: user supplied invalid value.\n", dev->name);
 	} else {
 		priv->ieee->scan_age = val;
@@ -1487,7 +1473,7 @@ static ssize_t scan_age_store(struct device *d, struct device_attribute *attr,
 	}
 
 	IPW_DEBUG_INFO("exit\n");
-	return len;
+	return count;
 }
 
 static DEVICE_ATTR_RW(scan_age);


-Kees

>  
>  	if (p[1] == 'x' || p[1] == 'X' || p[0] == 'x' || p[0] == 'X') {
>  		p++;
> 
> ---
> base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> change-id: 20230801-drivers-net-wireless-intel-ipw2x00-d7ee2dd17032
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
