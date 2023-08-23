Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3078594D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbjHWN3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbjHWN25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:28:57 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE92170F;
        Wed, 23 Aug 2023 06:28:36 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34ca63f6a27so11312825ab.1;
        Wed, 23 Aug 2023 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692797287; x=1693402087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1k7Fnb+QkSpaEkMrTKWq52o4HXWXKwP+S+nMyf/GHw=;
        b=gzAKzbTbV8dOIOXlhh8uGXW9cIpX8TpD6AB4yVvOahUMcyAkJS7hiOePSaKyUcAAcs
         mio8ENCnFmO/GgAUK5iq/MdVKNHQby/yLBw3LNIYnbRLrsluxFIMew+MLhOgNqc/VyuW
         CMv7svmImwWGB/1NJZV28kxHac+fEJvVyUhVAEyIwrThD8UXluu4tL4aLTAIk2yObS8v
         +7bZPEIR39G8yF+cIUXylMTFZJ8qc0AikgEt0iAg1lh5OxYmOWhF3tVeVo5K5Rw9vOlM
         Ha3Pgfa1sKKmQItyYY9dESAxUziPEgrjvhr8GhgSOujL0marCWH9FknF5HEl+PK+3yLt
         i0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797287; x=1693402087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1k7Fnb+QkSpaEkMrTKWq52o4HXWXKwP+S+nMyf/GHw=;
        b=UZymoAP+KJ4GnrDYy+jGYiTaxX7NturdEANQB/dM5c2RqqEPEHiACxbrGLslzAcxDu
         UDBA622kA5zf+3k+B5nuBmEf35V3BBqNFZJma/SO2xuNib5obVm/qYw9kh2vn7Hh8VnK
         0hHs3Nhvyp6hdBBW2zOoTXx1Vnn9Q8qJuKGvpDp9E9eNjZ7EKh+7WJtc+Im5fQcPu+EC
         9aJyidj15ulSD1yWmiZdMCl1MlZ5n2pHm1IgH/qB+7y9Q1uB/Sz+m3uZLM/en2oEZt3u
         X6N2LaZBNejaQowxhdiANnv+qypnsbH/gN5UkOgrYMBjuGy9ltYu1D4HAIDnFkZ4ApVd
         0cWg==
X-Gm-Message-State: AOJu0Yy3AmjV2Ac6+c+8528olh1WoR7LQ7mMuixnVi7EBdhWu8pm3nzy
        S9yDZgIkynXU0sIRYRCcPpfZu9aqjaA=
X-Google-Smtp-Source: AGHT+IG0ENLXwnyM65ixhgaL9IR4YqAghb/lD07OIOdsWY7rDdauhYn3KJbcJB5ldSNReZWiQQ433g==
X-Received: by 2002:a05:6e02:1a0b:b0:348:d78d:a1a2 with SMTP id s11-20020a056e021a0b00b00348d78da1a2mr3192080ild.21.1692797286832;
        Wed, 23 Aug 2023 06:28:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i25-20020a633c59000000b00564aee22f33sm9690768pgn.14.2023.08.23.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Aug 2023 06:28:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <a47e9615-aabf-4cc4-a479-430c309c3c8a@roeck-us.net>
References: <20230821194122.695845670@linuxfoundation.org>
 <991b93d2-9fde-4233-97d5-1133a9360d02@roeck-us.net>
 <2023082309-veggie-unwoven-a7df@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082309-veggie-unwoven-a7df@gregkh>
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

On Wed, Aug 23, 2023 at 09:03:49AM +0200, Greg Kroah-Hartman wrote:
> 
> > For x86 I get the same runtime warning as everyone else.
> 
> Yeah, this is troubling...
> 
> Is it clang only?  I'll dig into this today...
> 

No, I build with gcc. More specifically, gcc 11.4.0 and binutils 2.40.

Guenter
