Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00CF78FB7D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbjIAJx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjIAJx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:53:28 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DB3E8;
        Fri,  1 Sep 2023 02:53:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68a520dba33so1546606b3a.0;
        Fri, 01 Sep 2023 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693562004; x=1694166804; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVmIC/TSva2BQpG1ymilUgrZHBLPn2XzYNzkcuE+VkA=;
        b=mMGle+qlVzMJSxkG+ZPghNkFqLCTUrU22cC2w0+V58sv1j0G6/Xjf4FzSYhl+zVMVo
         WEKkiGim5sdn6xk2K26PlTOcveZmC2N4Ao5edPzqCUW3aIahbIZJxlTfho+X7pAp0e6G
         U3KwyfC/VBvkWIPEg7wCA/Z2eMNvb9T+6xlvBcl3YY/JIEU7c7Nd8lHBRIFwag5OFJFd
         j4Co6jB7pzq4RNnK6qfQfOIWIqbQULRmG8ry4nCmSvqsau3jqkXGG7yKUuz7uA/1Q11S
         fXL4TtqnsHsKqQ5UdCiPZrXc7m5Fdi3hn57VHZ2yTgR7qWX6II8RRou4inwzDHo+xxOm
         8wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693562004; x=1694166804;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yVmIC/TSva2BQpG1ymilUgrZHBLPn2XzYNzkcuE+VkA=;
        b=M6JeUs6uSCeBJbCEePhpbf1Vr10FDN6bkKEO/2mUndozAbw9NaDwUi1qSD5DIT7QKq
         hbblLyVhNpaXSPIvBygp/IlqwKhdfh14sSxGAXmae9ETTCubHN37kiD5/n8WvYk/eYrp
         9EUA6CzDF0F8vdF/hkZY7O85ENl464Bbr3813REfw1YnLnpz8rHql+dvp1HlxXrDHykU
         8j/ruIRS1f/gMwm/A59h8014mSNw40/eAYu/VIkcxq4fMuoV2V8AstFEfnfAUrWQk3Nl
         7pabu3GBm5zSk90cl5X2/JijGM3o3MYfpUG/RykDU6j4xIsicnwYfRXwdmjiud9T2qz1
         SvNg==
X-Gm-Message-State: AOJu0Yzk7bxtUj/rFB4SA4onEvS59/TiaqHVNrMUNDlLTYKC5Y8SbzgM
        aavzNymw2JE4RzZeZXeULY4=
X-Google-Smtp-Source: AGHT+IH04Xqgdy+iVpdudRptAkZMoVyRlGpsdKljBL/aNZUf6YH08brsR289r+m531UrzzXYgojxug==
X-Received: by 2002:a05:6a21:788e:b0:132:2f7d:29ca with SMTP id bf14-20020a056a21788e00b001322f7d29camr2634863pzc.24.1693562003644;
        Fri, 01 Sep 2023 02:53:23 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b0068c6e666066sm2613068pfm.111.2023.09.01.02.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 02:53:23 -0700 (PDT)
Message-ID: <705ce5be-93a7-d41c-a557-47090535f089@gmail.com>
Date:   Fri, 1 Sep 2023 16:53:17 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Ruiwen Zhao <ruiwen@google.com>
Cc:     Linux unionfs/overlayfs <linux-unionfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: overlayfs: cannot rename symlink if lower filesystem is FUSE/NFS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Hi, 
> 
> We recently found a regression on linux kernel: rename(2) on a symlink through an overlayfs fails with ENXIO, when the lowerdir is FUSE.
> 
> *What happened*
> 
> When running `mv` command on a symlink file through overlayfs, and the overlayfs's lowdir on FUSE or NFS, the command fails with "No such device or address". This issue happens on kernel 5.15 and 6.1, but not on 5.10. 
> 
> *How to reproduce*
> Environment: Debian bookworm (kernel 6.1.0)
> 
> 1. To prepare the FUSE fs, create a file and a symlink under the VM's root dir:
> 
> ```
> ruiwen@instance-1:/tmp$ ls / -l | grep foo
> -rw-r--r--   1 root root     0 Aug 30 23:10 foo
> lrwxrwxrwx   1 root root     3 Aug 30 23:12 foolink -> foo
> ```
> and then run libfuse's passthrough (https://github.com/libfuse/libfuse/blob/master/example/passthrough.c), which mounts a FUSE filesystem by mirroring the root dir:
> 
> ```
> ruiwen@instance-1:~/fuse-3.16.1/build/example$ ./passthrough -o allow_other /tmp/fusemount
> ruiwen@instance-1:~/fuse-3.16.1/build/example$ ls /tmp/fusemount/ -l | grep foo
> -rw-r--r--   1 root root     0 Aug 30 23:10 foo
> lrwxrwxrwx   1 root root     3 Aug 30 23:12 foolink -> foo
> ```
> 
> 2. Create an overlayfs mount, with lower dir being the the mount point of FUSE filesystem.
> ```
> ruiwen@instance-1:/tmp$ mkdir -p fusemount upper work merged
> ruiwen@instance-1:/tmp$ sudo mount -t overlay overlay -o lowerdir=fusemount,upperdir=upper,workdir=work merged
> ruiwen@instance-1:/tmp$ ls -l merged/ | grep foo
> -rw-r--r--   1 root root     0 Aug 30 23:10 foo
> lrwxrwxrwx   1 root root     3 Aug 30 23:12 foolink -> foo
> ```
> 
> 3. Try to move the symlink and see the failure:
> ```
> ruiwen@instance-1:/tmp$ mv merged/foolink merged/foolink2
> mv: cannot move 'merged/foolink' to 'merged/foolink2': No such device or address
> ```
> 
> 
> *Some observations*
> 
> 1. Same bug has been reported at Debian Bug, where overlayfs is used with NFS: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1049885. This makes me think that the bug is more on overlayfs, but not on FUSE or NFS.
> 
> 2. This issue can be reproduced on kernel 5.15, 6.10, but CANNOT be reproduced on kernel 5.10. There is a noticeable change on 5.15 that is related to overlayfs: (https://github.com/torvalds/linux/commit/72db82115d2bdfbfba8b15a92d91872cfe1b40c6), which introduces copyup fileattr.
> 
> 3. When reproducing this bug, we found that the error ENXIO was actually from getting lower fileattr. In dmesg we see: "failed to retrieve lower fileattr (/link, err=-6)". So it seems that overlayfs for some reason fails to get the file attributes of the source file from the underlying filesystem.

See Bugzilla for the full thread.

Anyway, I'm adding it to regzbot:

#regzbot introduced: v5.10..v6.1 https://bugzilla.kernel.org/show_bug.cgi?id=217850
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=217850

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217850

-- 
An old man doll... just what I always wanted! - Clara
