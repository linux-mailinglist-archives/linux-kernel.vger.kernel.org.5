Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DA678B65C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjH1RYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjH1RYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:24:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283A1E1;
        Mon, 28 Aug 2023 10:24:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26b5e737191so1588081a91.2;
        Mon, 28 Aug 2023 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693243469; x=1693848269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DH5Pw+Nwtjtpn2RlWDLRV4PLv534RmiJ+ccVLunffaM=;
        b=pNg4eGBNuZU4MjoKe5+HwtXKrM2X1biBf0V+NuWovRIv6ZESWJ52o8VHP4ry2WYXQm
         51cOOFQ/Dcj2nlLA/xapoR38GfIo6MnlQqAq13QCLKIKtwNNNwHk87/7V46n7z/yexcS
         WrcO+xy9sbXGnnaLfvf254Q8LDCbHecvWbR3aeyGgCJnkvy8j8oX/vERrDHHNuzgtxfA
         gg/AGZIvsTMBHR6kIdzwc1jL9tHn6RMdxaDnIvfUzhHMSq/C+QLSqG8jMrilJzyF7MsT
         Bk0mLGiE8fhQLqLvMyFWCVSiyky3CN4+YQXGC58jQFKWSpUbln6KGyNSydCy83qmVViY
         4SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693243469; x=1693848269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH5Pw+Nwtjtpn2RlWDLRV4PLv534RmiJ+ccVLunffaM=;
        b=T8BefpeWXzggHe89nO4u19+K7lFe+O/WJcMcLk1w/FLbtDDAYzmxlLH9H/8PPyS2Hn
         Dy/jDAY7xyxb+58FZV+fA/8VdKoPcWl4kixXGZEXQXQGcm3AtDSgS8Vh5jkohRtv7HWQ
         LzExuTiSFnRURbuYBeX6yq64HzvPRbOSZD89y0bNIecZ/tRV54dFsbS9/ug06VxHz0Fi
         efO73MP99uNzsaNXHfCTyjY2LfGinJrcR8L0wDTOL7FYpVaPs8D4j7yEMfHCUqTBIogh
         Mx/ebrc7oACLqNcA9mXm4kNuJz6RH+KoBdaq+4VEwA39MUlkS8o84USwJw3Q6pBVrGfW
         PMcg==
X-Gm-Message-State: AOJu0YzNtEAAa5M4yrgPEKgpxSvrZVIHwWlwIuM/JfsmN+bBvMnqxo3V
        EiGojAGoSs5mE9hRCpl7evk=
X-Google-Smtp-Source: AGHT+IGaAIVkKliPxSEirGIzxTAM3xU/hfjAL4uB3WLrRpgkso8PKdU5F/PUUFmn6v+c3BpaIplIlg==
X-Received: by 2002:a17:90a:748b:b0:26f:a34c:90e3 with SMTP id p11-20020a17090a748b00b0026fa34c90e3mr14857713pjk.31.1693243469388;
        Mon, 28 Aug 2023 10:24:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a1a4700b00263f446d432sm9864248pjl.43.2023.08.28.10.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 10:24:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 28 Aug 2023 10:24:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/84] 5.10.193-rc1 review
Message-ID: <a47b63cc-174f-4de7-987b-16a6264ce42d@roeck-us.net>
References: <20230828101149.146126827@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
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

On Mon, Aug 28, 2023 at 12:13:17PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.193 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 

v5.10.y also needs commit 4ea6fa2cb921 ("mhi: pci_generic: Fix implicit
conversion warning") to avoid

drivers/bus/mhi/host/pci_generic.c:276:25: warning: implicit conversion from 'unsigned long long' to 'dma_addr_t'
	(aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]

which is seen since v5.10.192 when building images with clang.

Thanks,
Guenter
