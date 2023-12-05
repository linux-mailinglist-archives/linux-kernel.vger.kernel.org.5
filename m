Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E48805BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbjLEQpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjLEQpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:45:42 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F2D19F;
        Tue,  5 Dec 2023 08:45:48 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58dc434442dso3308967eaf.0;
        Tue, 05 Dec 2023 08:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701794748; x=1702399548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CG6BJUWe8kC1FHX30s9/aNRkViYtrDmsP1HwdN1t68E=;
        b=G+h2wJCKzcz45DGEkHy/5egyboCgLkCC4GPv4iVggblc69qToEjflvdDa6v1ZMgaRx
         CIN6uGv1/NmbCoJbG6zVsxk+NcoBCDmciH4+bfWASIU7MdIzkzco+4TeJmRSpFYLr9Et
         AzsVqnhdHQayxgnR6tIJyyBYv/lprKr334jVGXgr2MYToRtrO5N7rO2qMxwtGB6ymxBS
         gj7vZUmpBXBQazx3YABKBJvRs/Ieng7HlxSW2/yoGHPqzrhtV+O2LHMNIkK1JU2LqsXH
         iNOnTt09oilou+852N7nZzMqc3eKQKyzCYm+FIUtktCLwA8/TMq6tdEZXPhDVLWixzHC
         5TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701794748; x=1702399548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CG6BJUWe8kC1FHX30s9/aNRkViYtrDmsP1HwdN1t68E=;
        b=XFtTEORNnOYJ4N/tfA4MKW2n0EO6LZzdjfHYY+q13MpXrwX7d+xe/fDYJ7zs7G5M90
         UOykHpnKmsMfBjnSwqeoERuGA1ZyJqPTzxqL3PZdZaD7Qhr4gizZiJBQuk/PjbbgEWL1
         9O1lO3pZMtWvvTQILHYMu2GDf0lE2TXy+t1G+dUWIEW3yMm38FV/MChugiC5EOqP5jjE
         7DwPNwWFDc33GO+iPfgfNK6uvPT6XrU1yadw38ObEBmWXRQFND1cSJL2a+BxRGo39Ug8
         SStLeI+YdV9IeXWHz9s3KiJu82JUja2HcX0/DqjaFBOx2fkyFQK/EDwelCfZQ00mpNYl
         Is9w==
X-Gm-Message-State: AOJu0Yy4Vq6chiJgktSYoWt2v/hBWBhvxjQ6mueQYZiFFqlV9vZch4TL
        sUq77hOTnWhf7wmZW6st4co=
X-Google-Smtp-Source: AGHT+IHkZOxOZeK4LMXia/JEeUnAt9yE31khEXWi3y/sW8j3h2RRoWkcat/YYyZSpTercanDVIueLw==
X-Received: by 2002:a05:6870:1707:b0:1fb:75a:677c with SMTP id h7-20020a056870170700b001fb075a677cmr830776oae.35.1701794747950;
        Tue, 05 Dec 2023 08:45:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id qx2-20020a056871600200b001fac77ee907sm3051603oab.33.2023.12.05.08.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:45:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 5 Dec 2023 08:45:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.4 00/93] 5.4.263-rc2 review
Message-ID: <830134bd-9bdd-418e-8791-2890f1677f0f@roeck-us.net>
References: <20231205043618.860613563@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205043618.860613563@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:37:00PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.263 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 04:35:52 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 462 pass: 462 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
