Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C019679A0DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 02:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjIKAw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 20:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjIKAwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 20:52:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8A8180;
        Sun, 10 Sep 2023 17:52:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-271c700efb2so2401728a91.0;
        Sun, 10 Sep 2023 17:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694393571; x=1694998371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynfsq0qHci/n+Vfsk2tkPb4KpZxDVJsE8HaxdBBDCG4=;
        b=Y+WmWu70ohSwBVB5+xY8ji6c98FJBExYIQFp0GWcfS+GmBJno+xScTgyAn2xY/OBBz
         wloYXtAnw0GAIaU9PH+u68jniHDnPmP+Ndv1XFwZ7MkmN8KfY/93trqU1bJUxZN48S14
         8cFRNlxk5ql/h+RawXzMVAO/8JLHtiBIS3QlJIY76t+0K+0hANxrpMTk1mGuM9rDJen1
         NTb4MIdkX8Xpl1fCo67atAF0gkKLwatU7hRyNMBJwQpWFuodQHDUp4izdh0BN1w45Zf/
         oGeFrn2xlBp5xDw/wwqY9mamncCXxailXI7DR04JlwKB0pEi+DkvAJCE0a0CdZgWJGKk
         Sjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694393571; x=1694998371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynfsq0qHci/n+Vfsk2tkPb4KpZxDVJsE8HaxdBBDCG4=;
        b=Vhf4cGZ800MSh8azpjp88otMF9ECVOrYCfnkRdANyyJJEzr92fSCvRf/dkxYMgyXhP
         kh1d39aYI9j8SDwoa4+rtaACA37oH1/EMXzYRgeWDWFv65a8Wg3wE8P45xVNp+aN7GkH
         PtPVtyoOC6RgmJyMmdKlxzfhfgqSNjFgBe8bCHIO/upWNQBAlbVUsc8ciJmWfQNfFEhI
         T4EpnclwMLjc264HH4Z+tLi+5JFSU7tRhtPk3JaBZq4I6lL4p4QG5UEHs/Ho2qg1P3x5
         cUORZEXTlzwuFynXmR2FD3eswMDsU+qi1YAvPPypQOqprVcwUYvBdMcx0cBc+RK7E71F
         /iUw==
X-Gm-Message-State: AOJu0YyY6uzmy34j4n7eS4tL7vIs2i9ztoCUQKC9MZVDOguhe/bpU+u2
        xtM/G4nctpTStTLbS8OGDRs=
X-Google-Smtp-Source: AGHT+IHhKe8y0upfZSaQ++ZMut2duWEiftnQ+jRUX/YjKWd12i0lvNvL+iCX6I8QucAYagUoeW/Shg==
X-Received: by 2002:a17:90a:a10d:b0:274:96a:5007 with SMTP id s13-20020a17090aa10d00b00274096a5007mr1056466pjp.1.1694393571187;
        Sun, 10 Sep 2023 17:52:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ga24-20020a17090b039800b0026b41363887sm6259695pjb.27.2023.09.10.17.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 17:52:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 10 Sep 2023 17:52:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] hwmon: (sch5627) Use regmap for pwm map register
 caching
Message-ID: <3b05ef1a-296a-4cf9-a376-ee966729165f@roeck-us.net>
References: <20230907052639.16491-1-W_Armin@gmx.de>
 <20230907052639.16491-4-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907052639.16491-4-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 07:26:37AM +0200, Armin Wolf wrote:
> Accessing virtual registers is very inefficient, so pwm map values
> should be cached when possible, else userspace could effectively do
> a DOS attack by reading pwm map values in a while loop.
> Use the regmap cache to cache those values.
> 
> Tested on a Fujitsu Esprimo P720.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter
