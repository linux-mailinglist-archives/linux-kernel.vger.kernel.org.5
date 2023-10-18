Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1B97CD8FA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjJRKRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:17:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DCEB0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:17:31 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507be298d2aso2472584e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697624250; x=1698229050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMF9+XVbotmwlZkgFVQV7OtJV2XJqMd/UdMT31C9cZA=;
        b=x3K17i3/yuAxq4zKxvz9TLDR6x/1vjyPGdYLvFmKiVNii/N8xAAQEs3FP0SCXfz/4B
         krxMceRVw535nVRJOcN1h//chRvvJYj7jVcjmZmUpI2SdVhcTqwmo3LmZs71Qf3WG4Kx
         yBZIjmKTr3Ze+3RYVDWZeab6tCrZ7b0tccQHO9CNFYvfV3qNd6HySDb8HG1reT4vhQiu
         Q4vazcA5uQP+PaP/bI1t3G/TOJswodddeOBXeQUyxMl22D1bWQW+DanGPWN5j/2E0yhs
         yQb+nZ7QYKzxxqLnTUKUSgiNBUUNyX1jFkzL6YxwHNM5vWdm40mt/9QBiA8Ps0YN/aNf
         F3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697624250; x=1698229050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMF9+XVbotmwlZkgFVQV7OtJV2XJqMd/UdMT31C9cZA=;
        b=uvi+nQivv51sO0ojJn4JSk0jWNYkIjn1JaCPTEixedDt5o+kmP9by4SPc4gRDWDeVx
         r+CNtiTF4kze9RSBCWYFXjvYrwNeHkaKB17ZaumVHCHIp+rLRn0vOOP5MyIGqUUE2kCC
         pyD5L+SScpjQbNQ8v61nWwLNN7gi7yGyIf9EI7XLajOrmKLPYr1+S+PbxXQOm8vJ6pd9
         ScmZpDkNY+gYYI5HkusJavf9t9KECgJvODzF1CX9XADWA4pBnEuaHOPTkeXZ2BecFOXh
         3yDTuxwTExUF2MsxNaoQszeSpcvF5VglIWuZH8e/hQBk8hv/vF3elgoeZX+nott/dhGq
         LJ9w==
X-Gm-Message-State: AOJu0YyW29DFwnDGj94jojnxK1bWglZHhJGNLyq1UPB2Qsld2utpMCTN
        RavVWvRB6TeJu5VXL0RBZGCkbA==
X-Google-Smtp-Source: AGHT+IHuHf/vAVlD/nYzbbKTFIUa4gHdOV6nXgpEc3kC6Vu1Tngn0aHuloTkDC1Ihtka7WkYH8MafA==
X-Received: by 2002:a05:6512:3b89:b0:507:96fd:d3ee with SMTP id g9-20020a0565123b8900b0050796fdd3eemr4498644lfv.32.1697624249706;
        Wed, 18 Oct 2023 03:17:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4806000000b0032da75af3easm1786409wrq.80.2023.10.18.03.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:17:28 -0700 (PDT)
Date:   Wed, 18 Oct 2023 13:17:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     gustavo@embeddedor.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: replace strcpy with strscpy
Message-ID: <e6c2d522-8770-4e94-81cd-5dedf91f5f32@kadam.mountain>
References: <ZS+Jb2rQWbOIIQ42@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS+Jb2rQWbOIIQ42@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:29:51AM +0300, Calvince Otieno wrote:
> Checkpatch suggests using strscpy() instead of strncpy().
> 
> The advantages of strscpy() are that it always adds a NUL terminator
> and prevents read overflows if the source string is not properly
> terminated. One potential disadvantage is that it doesn't zero pad the
> string like strncpy() does.

You're not replacing strncpy(), you're replacing strcpy().  There is
never a downside to replacing strcpy() with strspy() beyond that the
secure function is probably slightly slower.

> 
> In this code, strscpy() and strncpy() are equivalent and do not affect
> runtime behavior. strscpy() simply copies the known string value of the
> variable driver_name into the fake_bridge->name variable, which also
> has a fixed size.
> 
> While using strscpy() does not address any bugs, it is considered a better
> practice and aligns with checkpatch recommendations.

This analysis does not say where driver_name is set, or how big it is,
or what the size of the fake_bridge->name buffer is.  I would like to
see that sort of analysis in the commit message.

regards,
dan carpenter

