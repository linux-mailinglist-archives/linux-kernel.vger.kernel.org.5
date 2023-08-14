Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EAC77BFB4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjHNSXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHNSWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:22:51 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABED310D5;
        Mon, 14 Aug 2023 11:22:50 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso180538639f.3;
        Mon, 14 Aug 2023 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692037370; x=1692642170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYcETzBFWwAKvPAbWEGprtuAskWB+Cr6l4b2K8yGJWs=;
        b=noXwODNlHTQMN+1eT9ySBSF43lbvo6cMVNWQ5Q0O4PmHTB44YYI04fjoBfABRjAB3d
         zKvHIWr6eUYC/L0vJndlht0YazrZZBJe023XUFe1doIoIMPKtANPpsqT9XfEG1QQ8R10
         vscN+6lG5Ju8ULdPyeu1X4RZ+4UnbZix55mJZLf3jAeo8RL4HABSpJgUq/N3eiWLFoDn
         fTUo3TpOB3hM9J+GWTavHlCr7WdP1cHmiF/+TV69foQZluwnQJCyEKyLNUmTqWdo+Cot
         DeG4/B7qcfbTQqP97ztkh0NB+L1XhkvwAv0JCd7kt5ZdJsZmCVly8ePEKIvnKwOhh5c7
         xyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692037370; x=1692642170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYcETzBFWwAKvPAbWEGprtuAskWB+Cr6l4b2K8yGJWs=;
        b=B/GsBFY+yjnA5XDao77ouphzVe+fgHbDOx2DwhVcLdyzz0Axvy+JkGqEsnHDdAZSTl
         KUIQfLJ1mH/RvPNyl/JMzw5nkzlUvfwIA+jSQIW9b+S5zcqd5wm/V6w9owYJYnYaYwUk
         Kn5jRktaLSHetuFcIRHQOH2mnRMP0ADZ6FzlcKGmIXHvBJbMW5VO915Axeie8TEfjM2G
         8Q7ikNbQcAeECRHul6bT/6c4fCnKl4IzfcLoJFhPEAj2MfS0M5prcnHAdy0Jx+WWSGJg
         WL5qoqKQPlRrEwHpQLdAcMO4sEtE1xeWjqgSRNgQziakMPvkmpeSitnQknQIYvkIJzzX
         tB9w==
X-Gm-Message-State: AOJu0YxB1GADtNiDPorkSA5lTnbea2KEQekSdey6BsINZHTjInQAMwBS
        3DEI/i+5O8Lz+nzvLqw5DCc=
X-Google-Smtp-Source: AGHT+IGC12MWuXC/Nk5U7L1u1QwDYxq+TbxG19bYwKIQWuZpGlLKtoWADsKq5FsB+Npfj4fMPoYJjw==
X-Received: by 2002:a05:6e02:1b08:b0:347:70ae:542d with SMTP id i8-20020a056e021b0800b0034770ae542dmr15205901ilv.7.1692037370010;
        Mon, 14 Aug 2023 11:22:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o14-20020a92d38e000000b00345aaa564a6sm3340898ilo.44.2023.08.14.11.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:22:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Aug 2023 11:22:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.14 00/26] 4.14.323-rc1 review
Message-ID: <8d9b70fa-25af-4481-822a-aa52d42f2554@roeck-us.net>
References: <20230813211702.980427106@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813211702.980427106@linuxfoundation.org>
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

On Sun, Aug 13, 2023 at 11:18:53PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.323 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 431 pass: 431 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
