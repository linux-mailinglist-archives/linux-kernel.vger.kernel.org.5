Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6733F7F3A55
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjKUXhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKUXht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:37:49 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48026199;
        Tue, 21 Nov 2023 15:37:46 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso5378678b3a.1;
        Tue, 21 Nov 2023 15:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700609866; x=1701214666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBsM6IhveS+o7/r4qHHc1TgZJQzdQDusijV9f+awe9A=;
        b=i+baoT7CVpQHwoxnw3QeUKOY2/8JslhpDRrWf+YUyqQQqIdtPC6mTWiD0Xat1R3Nzi
         +JiBdsQLAVupy3IbFm5+41itKPn/RW3vl94xGYJd67DbjDMI2w/f3+UzPVL9eu8/gRl9
         vH0cJ29LFSl85U5IQLE/O9jVXq3Pmk6lLrqR29ExLlXCKDduP27TXWJO91dNLM7kNDfY
         BV9aDbBOb/P0CzA3IC20Phvq9GJGO9Sijtjxk9hSdiJnlzse4PDnUgCxXBJYXU8X81uC
         alSE7MCeD2dz4XSMVavABUwFXkYBaIyNd+RxHaR65uiwMpXQdbkePz3knlM1LoAulCTG
         2m4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700609866; x=1701214666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBsM6IhveS+o7/r4qHHc1TgZJQzdQDusijV9f+awe9A=;
        b=N2A0fYrasSrh+HpS5NQVlMcw7NR56sW/ybQll/urQOMC7fUqxNLiNEmpGZFZPPjny1
         BZ0c6TiAO43fNKB+5nRgprykHsoNKrtNozoVV8qa/DbkV5E/IbHJHWhCjZ/efj1nVmOq
         Ond0mlTQhP6BA9UmOxS8zxvUVefbQ/vJDeUUzHGZ8zpw62c7VT+gIiR5YV7qOQFP73yX
         HkDW/QSg+4up0QIBBPr9ddlrw1v157ZoP95BrO81VGsm9jSsDghCj6HIuv++v9Lib4wd
         dLQSIBUDDN1eCHqt5KWITZOBnrE+IESnysZ/I4he2PQSa/UPy4UbFkJBbNvomA+OTlBR
         x0mw==
X-Gm-Message-State: AOJu0YwBlnt0Er2v6WZLJXJ7wmTDtX69EtswdypIiXJBf9AanJI8DmAi
        1YJBKe109ir0I/mY4DaOxaU=
X-Google-Smtp-Source: AGHT+IHylfg1T9X6BkuN5KOiJNcmxEeJ+UQfaRy0xEGLUcLwjosLbiBRBajuiM8h90cVFePNrmnm0g==
X-Received: by 2002:a05:6a20:3944:b0:189:c852:562e with SMTP id r4-20020a056a20394400b00189c852562emr636458pzg.38.1700609865663;
        Tue, 21 Nov 2023 15:37:45 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a19c500b0028098225450sm98849pjj.1.2023.11.21.15.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 15:37:45 -0800 (PST)
Message-ID: <a9abc5ec-f3cd-4a1a-81b9-a6900124d38b@gmail.com>
Date:   Wed, 22 Nov 2023 06:37:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: xfs: consolidate XFS docs into its own
 subdirectory
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Workflows <workflows@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Charles Han <hanchunchao@inspur.com>
References: <20231121095658.28254-1-bagasdotme@gmail.com>
 <202311220333.acL7LwXY-lkp@intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <202311220333.acL7LwXY-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 03:04, kernel test robot wrote:
> Hi Bagas,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 98b1cc82c4affc16f5598d4fa14b1858671b2263]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Bagas-Sanjaya/Documentation-xfs-consolidate-XFS-docs-into-its-own-subdirectory/20231121-180057
> base:   98b1cc82c4affc16f5598d4fa14b1858671b2263
> patch link:    https://lore.kernel.org/r/20231121095658.28254-1-bagasdotme%40gmail.com
> patch subject: [PATCH] Documentation: xfs: consolidate XFS docs into its own subdirectory
> reproduce: (https://download.01.org/0day-ci/archive/20231122/202311220333.acL7LwXY-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311220333.acL7LwXY-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> Warning: Documentation/filesystems/xfs/xfs-online-fsck-design.rst references a file that doesn't exist: Documentation/filesystems/xfs-self-describing-metadata.rst
>>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/filesystems/xfs-maintainer-entry-profile.rst
>>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/filesystems/xfs-*
>>> MAINTAINERS:53207: WARNING: unknown document: ../filesystems/xfs-maintainer-entry-profile
> 

Oh dear, I didn't catch them when building locally. Will fix anyway.

-- 
An old man doll... just what I always wanted! - Clara

