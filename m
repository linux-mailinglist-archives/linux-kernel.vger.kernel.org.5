Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EEF8095D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjLGWyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjLGWyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:54:09 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C33210E6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:54:15 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35d6b381341so5261405ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 14:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701989655; x=1702594455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8z/n7oVJrLI7AapO66ABR3Mg7MdK3FEalI7JxmyKlx0=;
        b=edEE4eU8+O6QlvYuz3i3d26dDugmn+vDFrfAdV+kG+NLXC013awhcjppZZHt2ekSCo
         TlXtUgBhLONARN3Lczn34VGbHYmPy4reGk3vVcQSiR3K1f2xsFEBfdobHp1bGY1bpP5z
         wrRdtpbqb7kocSsScMTBi3cSoB6SCiupAuRIpjTABz/mKUK881z5CJMUY7P0OrnDXKqj
         zGLP7NQbWp3iX280Nr5PH/CkfpD2RlIqEnsd9T5zlSUlYGWOIy3eC5K8tFJOn3vvThAZ
         ark1z6lwXyBcBorxonk11VAyASTgL2CuqsOT96vvZkLyJWx14/YTFPSvamYZXTZYQodn
         hTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701989655; x=1702594455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z/n7oVJrLI7AapO66ABR3Mg7MdK3FEalI7JxmyKlx0=;
        b=h9KLy/EdOV0PXLWUgw8/6UjO0bHURt+9FAkHNUXMW+jv5tLNUVCGt4EYEOAA1rWoxr
         DXqCKmjsRmK/VK03vdj1mzhQpH6jgLIoiekTqxg1v7o5tIS3WLHa8p+zrkdcfF0h17Fm
         sWDLWNfpCGR5xa0TqGZxAq/PG2n4cxJi4XzqTJE8x4R2D4yvQp9liGwGEDVgjHDXFAdL
         MCBuSR3Nd9Lb3H01hSXZMK/nViaVfdAiRi7CFGVE9hMrVnSeufy/jwhtAUET3s8/MKDB
         0VHaoHacSDIXP2hFJAGEKMBrbbBKzk95tVK8m+1H9xeWT5+vvnwHx7xtfXCnilhXu6Yp
         aduQ==
X-Gm-Message-State: AOJu0Yy3soNrF8XtZoESuMhib+e4BxB0u5uHZEx3v41ushnZ8J/NCQ8L
        1JzuZRJtivfi2O07fIDuq1rfTg==
X-Google-Smtp-Source: AGHT+IG+tMLAPQMs0kJxW/IS3KFdRdsft6Gda4jPxtMmDl2cn6omxOmWAnKPtSQSHnM2EVZDhqe2JQ==
X-Received: by 2002:a05:6e02:12ec:b0:35d:59a2:331d with SMTP id l12-20020a056e0212ec00b0035d59a2331dmr4773035iln.33.1701989654689;
        Thu, 07 Dec 2023 14:54:14 -0800 (PST)
Received: from google.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id h6-20020a92c086000000b0035d5935e19bsm168963ile.65.2023.12.07.14.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:54:14 -0800 (PST)
Date:   Thu, 7 Dec 2023 22:54:11 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Jialu Xu <xujialu@vimux.org>
Cc:     nathan@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        masahiroy@kernel.org, morbo@google.com, ndesaulniers@google.com
Subject: Re: [PATCH v4] gen_compile_commands.py: fix path resolve with
 symlinks in it
Message-ID: <20231207225411.his46ofov6kswkmi@google.com>
References: <20231205165648.GA391810@dev-arch.thelio-3990X>
 <20231206012441.840082-1-xujialu@vimux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206012441.840082-1-xujialu@vimux.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 06, 2023 at 09:24:42AM +0800, Jialu Xu wrote:
> When a path contains relative symbolic links, os.path.abspath() might
> not follow the symlinks and instead return the absolute path with just
> the relative paths resolved, resulting in an incorrect path.
>
> 1. Say "drivers/hdf/" has some symlinks:
>
>     # ls -l drivers/hdf/
>     total 364
>     drwxrwxr-x 2 ...   4096 ... evdev
>     lrwxrwxrwx 1 ...     44 ... framework -> ../../../../../../drivers/hdf_core/framework
>     -rw-rw-r-- 1 ... 359010 ... hdf_macro_test.h
>     lrwxrwxrwx 1 ...     55 ... inner_api -> ../../../../../../drivers/hdf_core/interfaces/inner_api
>     lrwxrwxrwx 1 ...     53 ... khdf -> ../../../../../../drivers/hdf_core/adapter/khdf/linux
>     -rw-r--r-- 1 ...     74 ... Makefile
>     drwxrwxr-x 3 ...   4096 ... wifi
>
> 2. One .cmd file records that:
>
>     # head -1 ./framework/core/manager/src/.devmgr_service.o.cmd
>     cmd_drivers/hdf/khdf/manager/../../../../framework/core/manager/src/devmgr_service.o := ... \
>     /path/to/out/drivers/hdf/khdf/manager/../../../../framework/core/manager/src/devmgr_service.c
>
> 3. os.path.abspath returns "/path/to/out/framework/core/manager/src/devmgr_service.c", not correct:
>
>     # ./scripts/clang-tools/gen_compile_commands.py
>     INFO: Could not add line from ./framework/core/manager/src/.devmgr_service.o.cmd: File \
>         /path/to/out/framework/core/manager/src/devmgr_service.c not found
>
> Use pathlib.Path.resolve(), which resolves the symlinks and normalizes
> the paths correctly.
>
>     # cat compile_commands.json
>     ...
>     {
>       "command": ...
>       "directory": ...
>       "file": "/path/to/blabla/drivers/hdf_core/framework/core/manager/src/devmgr_service.c"
>     },
>     ...
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jialu Xu <xujialu@vimux.org>
> ---

This looks good to me. I prefer using pathlib over anything in os
module, even if the behavior was the same. In this case, the pathlib
behavior is better -- which is a bonus.

Reviewed-by: Justin Stitt <justinstitt@google.com>
>  scripts/clang-tools/gen_compile_commands.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index 180952fb91c1b..99e28b7152c19 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -11,6 +11,7 @@ import argparse
>  import json
>  import logging
>  import os
> +from pathlib import Path
>  import re
>  import subprocess
>  import sys
> @@ -172,8 +173,9 @@ def process_line(root_directory, command_prefix, file_path):
>      # by Make, so this code replaces the escaped version with '#'.
>      prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
>
> -    # Use os.path.abspath() to normalize the path resolving '.' and '..' .
> -    abs_path = os.path.abspath(os.path.join(root_directory, file_path))
> +    # Make the path absolute, resolving all symlinks on the way and also normalizing it.
> +    # Convert Path object to a string because 'PosixPath' is not JSON serializable.
> +    abs_path = str(Path(root_directory, file_path).resolve())
>      if not os.path.exists(abs_path):
>          raise ValueError('File %s not found' % abs_path)
>      return {
> --
> 2.39.2
>
