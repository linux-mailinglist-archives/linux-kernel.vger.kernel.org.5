Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09EE7AC30B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjIWPDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjIWPDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:03:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F867180
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:03:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so9119701a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695481385; x=1696086185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mf35qT3wdmI9FAWcSv+LLoKLH4mSf1lcVMZuMPVU6oU=;
        b=EWjlmNDZYx/kNEwF1cjYZ2g6UWuiRnbDyDYvbnSsrs+NrkfXKJy3Zc+BwSjBT6cTMa
         D0MZCnkpMAYKhgeVAv2haIFTPUoEUpBnmtaBCQvJClPFc83Wki7PcPuvXHWIXAD23p2z
         WYK6hndDZxx/fLurZTvpmGB8FubVFpLwXuVC3tCWs8XpicNkH1dAWSc3CFtg6M5N9bhW
         Gj9SJaSIkbdVO94bCosSn0Dy89AXIlJPCl8ZA0vvPXHXmK2aCIbrcy2bGStaAlhrctkJ
         9bSUzmni3rs0cfMQdMo6pIYcSE1PQF7RM5ajTIm3Tb3/dtrIhNV2wvjv1mWtXVaXNqkg
         59VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695481385; x=1696086185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mf35qT3wdmI9FAWcSv+LLoKLH4mSf1lcVMZuMPVU6oU=;
        b=RLpuFGiDJFtaqaQ68gzZbFFxuQ1DWLxCS/oAYlQuKq2Sxl7Y2BtJfv9cBE0rwC7SXt
         LatKEaQq77gbrABtF7P6TlKZi+S8D3iL/h0+7Pr+1IAg/24qoNwWxIi7+BRQpu2SvJyf
         jXXqJvyFri50voBaL0l58ruJkwQKPEmhVK2t2euiSwTRi+cfI0MjgwSWs9WilMgbnJ/F
         DqocBm4+CnBnx+cT82ViYh/0WTT+Sp/s5KkjUneV8LUTjrQ7Ut0u6KC0zhNhz3RqBYHM
         tsZLq+/n/hIwIhPj5CNGEpVWZX4ysG/dw4r2T1sKGBUag2rJd8o1ttDGAvepoECavnum
         4HMQ==
X-Gm-Message-State: AOJu0YyCqpowiUlPlwzr1cQ5koNdd0yDeIG2PfnPgwZIDYA5mgkglVce
        4YYaWd25sUYpc0t2jeBHAtR4Gwc8OlHazx8swwQ=
X-Google-Smtp-Source: AGHT+IFTXCZmW7UzyuZf1BuVac1rOqZQiIlUVcsQFdbBPX4v4s9HlTCZMWamY4v7PtF6t8H1zObaw34V4PtUnHSsCTU=
X-Received: by 2002:a05:6402:270d:b0:530:bfb6:66cd with SMTP id
 y13-20020a056402270d00b00530bfb666cdmr7966668edd.7.1695481379778; Sat, 23 Sep
 2023 08:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <ZO8oNb2hpegB6BbE@debian>
In-Reply-To: <ZO8oNb2hpegB6BbE@debian>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 23 Sep 2023 16:02:23 +0100
Message-ID: <CADVatmNY=KB-KCpMAGU_krpoX-eKxha3BSHT0u9XfcPuEoOMPQ@mail.gmail.com>
Subject: Re: mainline build failure due to ace6d1448138 ("mfd: cs42l43: Add
 support for cs42l43 core driver")
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On Wed, 30 Aug 2023 at 12:29, Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> The latest mainline kernel branch fails to build alpha, csky and s390
> allmodconfig with the error:
>
> drivers/mfd/cs42l43.c:1138:12: error: 'cs42l43_runtime_resume' defined but not used [-Werror=unused-function]
>  1138 | static int cs42l43_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> drivers/mfd/cs42l43.c:1124:12: error: 'cs42l43_runtime_suspend' defined but not used [-Werror=unused-function]
>  1124 | static int cs42l43_runtime_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/mfd/cs42l43.c:1106:12: error: 'cs42l43_resume' defined but not used [-Werror=unused-function]
>  1106 | static int cs42l43_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~
> drivers/mfd/cs42l43.c:1076:12: error: 'cs42l43_suspend' defined but not used [-Werror=unused-function]
>  1076 | static int cs42l43_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~
>
> git bisect pointed to ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")

Since its almost time for v6.6-rc3, so just a quick reminder that this
build failure is still not fixed.


-- 
Regards
Sudip
