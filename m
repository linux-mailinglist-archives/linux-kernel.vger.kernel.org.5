Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A43078E1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbjH3VzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243220AbjH3VzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:55:17 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D77CF7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:54:49 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34ca860051fso847645ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693432414; x=1694037214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fT/dG8PH+5kjdfp0lNfGSE00HAneCDlI+gc0vyBZvf4=;
        b=UgaCFFwVG2+/N6264AWN8WiR7L3SoRCHFVS/HtqaykEkPSmCzeFS5o9n6pQQWN3AHW
         RYpT977tp/2+v2ZsCVtFHdNc5uG0cN0AnrEd29YLNvS2KEF0OVe4d2UWFsPeWEqXClPl
         /8Uy/ituU1RB4ab+CYQ33T8DRECTfdEoRIfJN1l9pHtv2OqmgNR2grNJIQBV5w37Fi2r
         A9WkglWHmfFFb1cjIS21dXNKivWHbh0qv7GGQ5tCDWspxNbsgjLyxSqLFb2bFr41hWvV
         ulwsa03U1OtanCZk7gvdV+lFukmXhUZLRquazJdECa6fztzLwrygDJo4YvPiwa8aLXI2
         +Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693432414; x=1694037214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fT/dG8PH+5kjdfp0lNfGSE00HAneCDlI+gc0vyBZvf4=;
        b=a0A7wycR1xPdyTZdjGzEwR1OBx9qpA/ha830aaJBJui1Yu/RddzkE8U/o1VmgstDuv
         ohqGQVmNh8gZ3tLyVDWfxc8lTtd2zHtBhUTJd9hddzHNCLWvs9KXCxiXe3PpTQ5ggfYx
         nDLvw8Ou/hKR4UCiGXZDK0d2r7PVF/2SFzU+FKTXvHRRRWG4ipwFzuXMRr851cR1ZMOo
         EQrsh/UrbCEFdiXMugMPqmfSLmAgkljYOI55n7QnQdFQtz9ydXQTQt0ZXoH6v2Tg2WaC
         Yx57dOpdkd1wb73J2zRIVoKJXpVZai1o8IzfojLyIzrKiq6tXyRRaCD1ZsYVzbqRtP/0
         AgxA==
X-Gm-Message-State: AOJu0Yxb4frNFqMyv3jIJAubUipUZ8f0Ddh4QCXNkmwNTQTuOeGGjBxq
        wZ9w8lxwIqY7/supXPuH92TkjA==
X-Google-Smtp-Source: AGHT+IGqxsyB9NGlYxwJsRZgtFvY5zsY1NppQgidovpARDU2fWnZUcd25uoPUkOvkwUfGey/nbMgqg==
X-Received: by 2002:a05:6e02:1b84:b0:34a:a306:ae7c with SMTP id h4-20020a056e021b8400b0034aa306ae7cmr4567188ili.28.1693432413967;
        Wed, 30 Aug 2023 14:53:33 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id v9-20020a92c809000000b0034ce78e2450sm45948iln.39.2023.08.30.14.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:53:33 -0700 (PDT)
Date:   Wed, 30 Aug 2023 21:53:30 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: target: Replace strlcpy with strscpy
Message-ID: <20230830215330.6gyhpq3ohkbbtsam@google.com>
References: <20230830210724.4156575-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830210724.4156575-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 09:07:24PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
>
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
> v2:
>  * Replace all instances of strlcpy in this file instead of just 1.
>
> v1:
>  * https://lore.kernel.org/all/20230830200717.4129442-1-azeemshaikh38@gmail.com/
>
>  drivers/target/target_core_configfs.c |   27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> index 936e5ff1b209..10a22a428267 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -1392,16 +1392,15 @@ static ssize_t target_wwn_vendor_id_store(struct config_item *item,
>  	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
>  	unsigned char buf[INQUIRY_VENDOR_LEN + 2];
>  	char *stripped = NULL;
> -	size_t len;
> +	ssize_t len;
>  	ssize_t ret;
>
> -	len = strlcpy(buf, page, sizeof(buf));
> -	if (len < sizeof(buf)) {
> +	len = strscpy(buf, page, sizeof(buf));
> +	if (len > 0) {
>  		/* Strip any newline added from userspace. */
>  		stripped = strstrip(buf);
> -		len = strlen(stripped);
>  	}
> -	if (len > INQUIRY_VENDOR_LEN) {
> +	if (len < 0 || strlen(stripped) > INQUIRY_VENDOR_LEN) {
>  		pr_err("Emulated T10 Vendor Identification exceeds"
>  			" INQUIRY_VENDOR_LEN: " __stringify(INQUIRY_VENDOR_LEN)
>  			"\n");

Should we be explicitly checking for `len == -E2BIG` instead of the more
generic `len < 0`? Perhaps this is a nitpick but I prefer the former.

...

> @@ -1448,16 +1447,15 @@ static ssize_t target_wwn_product_id_store(struct config_item *item,
>  	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
>  	unsigned char buf[INQUIRY_MODEL_LEN + 2];
>  	char *stripped = NULL;
> -	size_t len;
> +	ssize_t len;
>  	ssize_t ret;
>
> -	len = strlcpy(buf, page, sizeof(buf));
> -	if (len < sizeof(buf)) {
> +	len = strscpy(buf, page, sizeof(buf));
> +	if (len > 0) {
>  		/* Strip any newline added from userspace. */
>  		stripped = strstrip(buf);
> -		len = strlen(stripped);
>  	}
> -	if (len > INQUIRY_MODEL_LEN) {
> +	if (len < 0 || strlen(stripped) > INQUIRY_MODEL_LEN) {
>  		pr_err("Emulated T10 Vendor exceeds INQUIRY_MODEL_LEN: "
>  			 __stringify(INQUIRY_MODEL_LEN)
>  			"\n");

... and here


> @@ -1504,16 +1502,15 @@ static ssize_t target_wwn_revision_store(struct config_item *item,
>  	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
>  	unsigned char buf[INQUIRY_REVISION_LEN + 2];
>  	char *stripped = NULL;
> -	size_t len;
> +	ssize_t len;
>  	ssize_t ret;
>
> -	len = strlcpy(buf, page, sizeof(buf));
> -	if (len < sizeof(buf)) {
> +	len = strscpy(buf, page, sizeof(buf));
> +	if (len > 0) {
>  		/* Strip any newline added from userspace. */
>  		stripped = strstrip(buf);
> -		len = strlen(stripped);
>  	}
> -	if (len > INQUIRY_REVISION_LEN) {
> +	if (len < 0 || strlen(stripped) > INQUIRY_REVISION_LEN) {
>  		pr_err("Emulated T10 Revision exceeds INQUIRY_REVISION_LEN: "
>  			 __stringify(INQUIRY_REVISION_LEN)
>  			"\n");

... and here

> --
> 2.42.0.283.g2d96d420d3-goog
>
>

At any rate, this is a worthwhile change for the reasons you mentioned.

Reviewed-by: Justin Stitt <justinstitt@google.com>
