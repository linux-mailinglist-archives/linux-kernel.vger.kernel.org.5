Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDC67CD913
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjJRKWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjJRKWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:22:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE9BB0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:22:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3296b49c546so5218728f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697624531; x=1698229331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+YPVxhrij/9yyiFDCmXjbqG79WA01Bk0XowWcY3BL1k=;
        b=u8MnSC4Akx15maRa8AfHyPDBL6WFX+JbB1iqRyNbXnfBJla+Dknx/hpbkzMShQg0ix
         JGDJEHj4OHD9ZKVKdIwrPSta8stYmw0R9hESjC/bV1nATMtp5JEu1Q8J6K5yZ8Gan7hG
         ghS+SCFJNIE1b1WaFj1wBTQ/98kXh3OW+J1ev3vn3QfKi28lFpTgxnLtYxxytAhmpuHy
         wx0rlDssLQvm7FE6FGxUelIavCrdPTIdC8YeqvvTGelFZlVvTzsT7dXRCzo0FHKQxCRB
         MWHWYQ0h3SEnCK9GoGOgseNoYDM/giAw/c4MOYBktLBsnWAGRMcO/1biX66Z3s45+QIA
         TsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697624531; x=1698229331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YPVxhrij/9yyiFDCmXjbqG79WA01Bk0XowWcY3BL1k=;
        b=u5OxA9gKwdmRQB9OkFX0F8ExrzjckXhWcm1sPu5LbAcXMS1XXxEbBSJOeeNATW5oe3
         ZiBfMooNGF+HQyO2n8kXKhmk5yK0SihPkk/ag2+z9FKosgraZEQPPgsXY7DyBFW/8vLj
         4AyeGbHvJQgL2bKChrI736SmIhfwMH0lYeaVmZ25kQEEmqMmP38dudlfLg0NFoXaXYn1
         pi+fHetgvVygJFNga5i3VKVaHHYaQW0njUAVdroUFaTaiAJP7ql9R+hElMLOHaIWcckc
         /z6evPfz555+AngVyACHOCpOxeAovS2GAzaDvtCj9O4r9y9lVQwf6VRyg3bx7+wsPEcB
         gY0A==
X-Gm-Message-State: AOJu0YyKcYeyBhY0jd2Ns/hTH5eOjK2pfAUWDJp83se4oM+i+SfEaS1R
        vMcFzfkNgGtA/SLAgewXecQUnQ==
X-Google-Smtp-Source: AGHT+IFblBhRhzmDzaS+pqwHqudeZroQ2KZlSAXVw5pwCj/0sJY/9y88i/ThbUt7ShHZ/AFjgg/51g==
X-Received: by 2002:a5d:4e90:0:b0:32d:a4c4:f700 with SMTP id e16-20020a5d4e90000000b0032da4c4f700mr3953978wru.38.1697624531035;
        Wed, 18 Oct 2023 03:22:11 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c5-20020adfef45000000b0032da4c98ab2sm1796413wrp.35.2023.10.18.03.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:22:10 -0700 (PDT)
Date:   Wed, 18 Oct 2023 13:22:06 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     gustavo@embeddedor.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH V2] staging: vme_user: replace strcpy with strscpy
Message-ID: <8a1d6d6f-b650-4aad-9b31-07a0a8acf45c@kadam.mountain>
References: <ZS+c7NtfEw5ne2Oj@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS+c7NtfEw5ne2Oj@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:53:00AM +0300, Calvince Otieno wrote:
> Checkpatch suggests using strscpy() instead of strcpy().
> 
> The advantages of strscpy() are that it always adds a NUL terminator
> and prevents read overflows if the source string is not properly
> terminated.

strcpy() also always adds a NUL terminator.

With strcpy() both read overflows and write overflows are an issue but
write overflows are sooooooo much more serious that we don't worry about
read overflow.

> One potential disadvantage is that it doesn't zero pad the
> string like strcpy() does.

strcpy() does not zero pad anything.  You're resending patches too
quickly.  You should wait a day between resends.


> 
> In this specific context, both strscpy and strcpy performs the same
> operation without any functional difference.
> 
> The reason for this equivalence is that the driver_name string "vme_fake"
> is shorter than the size of the fake_bridge->name array which is defined
> as 16 characters (struct vme_bridge {char name[VMENAMSIZ];...}). Thus,
> there is no risk of buffer overflow in either case. VMENAMSIZ variable
> holds a constant value of 16 (#define VMENAMSIZ 16)

This paragraph is good and sufficient.

> 
> The null-terminated "vme_fake" string
> (static const char driver_name[] = "vme_fake";) can be safely copied into
> fake_bridge->name using either strscpy or strcpy.
> 
> While using strscpy() does not address any bugs, it is considered a better
> practice and aligns with checkpatch recommendations.
> 
> Signed-off-by: Calvince Otieno <calvncce@gmail.com>


Okay.  Good.  Re-write the commit message and resend it tomorrow.

regards,
dan carpenter


