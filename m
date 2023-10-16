Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826D67CA6D6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjJPLkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJPLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:40:10 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA0FE1;
        Mon, 16 Oct 2023 04:40:09 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3af5b5d7f16so2690949b6e.0;
        Mon, 16 Oct 2023 04:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697456408; x=1698061208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tE3/kt7VPkaFdquQYklg8hmYnVUnseOhnUoih4hEER0=;
        b=niR7CETXWTyqnpbNTQM9R9+3O+nRq6tX0tsjHqc2tVbuAFnQi+cOo9rrR2OLF/pQ46
         TJUuRlGdyNA3XTF2M+IVi/VGLj6Z8YO3sMCaUpiI0zTW1YoYj9z/BcsICKblFfN05X5H
         AjpJiWb3Iv28bNQk/wS3Zs6x/YqEsLfNFHiBWDW6fTxG07ddinrh5kSnCJU7V0X40/w0
         21MhQkYkmnudyJMsAI6TsTnQYr10QelHYtWE/JgQvgy9inaCzwK5sY+Twlhyoc8b5A+1
         VYyzDlZRSiWT/7auq/hyn/i66KxiIQkIXa1ypWBVyW4z0cu3tDC4mRFShE3q8yoxmSts
         4lpw==
X-Gm-Message-State: AOJu0YwFc7pb36RIyBJcIwaA9nspD8RUVxMQ/xYZJISiuLanKn8GDcW0
        ZpS+FgQ38Q3QDMheovVEjbU=
X-Google-Smtp-Source: AGHT+IHxDYPzvNS3lWU1QsDc586Js06uUe+5oigcPknJIMbnR2FqVnBRnij03C711FQbvHhcLy3Xug==
X-Received: by 2002:a05:6808:1582:b0:3af:7db8:21ad with SMTP id t2-20020a056808158200b003af7db821admr43196719oiw.33.1697456408615;
        Mon, 16 Oct 2023 04:40:08 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id f18-20020aa79d92000000b006bc3e8f58besm3726935pfq.56.2023.10.16.04.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:40:08 -0700 (PDT)
Date:   Mon, 16 Oct 2023 08:40:00 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1697456403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tE3/kt7VPkaFdquQYklg8hmYnVUnseOhnUoih4hEER0=;
        b=Tly0eZsWl0PYDKWvqPHKOAbv1/wJr0yDXEHYhkZ22t59XEtf39mUTX2rsE3I8NMi/l8Imm
        DxJB6uyPhef6JqSNZkl2HldM1Pc0VLw9mdmCFqUjI7PLcHw9RmuN6szKNdpLAlHzbK+SlR
        k6fNy9Q1OOmMHt13hU4tozESfZFEfYt1SuaivIwbZ8IRu68vUvoDVxB3FaEqZVNy1vhEJk
        OjWnBbKUsoyps9G66fCr+VsusMr4lBdsvuOSVBA4nZMjKzCrzd4jwosP9ZCYr8y/wFctcG
        OWKN6CpEfRsmrYu6+0uzOpVfIEXeeTQmzVpYx5BEth+yddX/k7RiYRU+0Xe+Pw==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/131] 6.1.59-rc1 review
Message-ID: <pocozopagkwaphxqyupnpuntzxsb47ws6s7nzmawhnqa5brzph@ku2y2aucxs3l>
References: <20231016084000.050926073@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/16 10:39AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.59 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:40 +0000.
> Anything received after that time might be too late.

No regressions on my system:

08:35:39 rbmarliere@debian ~
$ dmesg -lerr
08:35:42 rbmarliere@debian ~
$ uname -a
Linux debian 6.1.59-rc1+ #1 SMP PREEMPT_DYNAMIC Mon Oct 16 07:46:20 -03 2023 x86_64 GNU/Linux

1 build warning:
vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !ENDBR: kexec_mark_crashkres+0xe7


Tested-by: Ricardo B. Marliere <ricardo@marliere.net>
