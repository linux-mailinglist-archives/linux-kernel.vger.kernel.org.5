Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DFC7D26E3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 00:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjJVWxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 18:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVWxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 18:53:24 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FA3E4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 15:53:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b709048d8eso1952836b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 15:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698015201; x=1698620001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oRYglAKPkAepx6qheWxbJfkWRfk28WNVjjfLpReBOUk=;
        b=hrcb1QlTURXDpNZ+jY1eA481caltABBqY9kb3Eod7uU7r1wdLpUQuwLGJbh5RbXF8L
         vAc9n8Gg/Zcl2gRIuyEMLGIboEeLlVT+wSD069vZvMJYNhRVNn5bXinsrbalRiTHoJsy
         pw48keadrlj4dBAw3lvrLcK68ZsJiSk8S8LVRJxCZTGrZgIYKDUiXQAfTIKZoTv7yAVo
         icM5ln9aQlTSrivggJ9oQITRIDFlx4ReTc0Ke1+NH433RMrDttE4pv7mk+uEHW3Vf8F0
         ReZj2ZH8GO9j959baiwM443gCPXhlSaNO0UoeXlqR8lbh0tJxpz2EeqelTZU+2JZwxxs
         m4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698015201; x=1698620001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRYglAKPkAepx6qheWxbJfkWRfk28WNVjjfLpReBOUk=;
        b=XURfNopH260GBQ/HkfpaZIbB6xT8lhDJsSFbS873Q7h48OTyR5SM6wcvle33yvq2LM
         w77njnGN5b3iP802j6yKCbibGY6kpAcMzfD3eLB+2YbWS9Df8GMezrPaN9N/11fmQ4Vj
         HXXwEiQvPqYIiHj326gDvBInRyI0FY0vVjjI24L8T0pRYGUCJNwTymPAbhC33Mgurwo3
         7+9+QV0rrl78sK47Cdr26Wy9tkbd3/IVM12fUOenrQkS3jQ32Aj+PuAfMzK6oYwvN8qs
         Fqi0bvjxfWwW6jw69BuqwSbn9L6Ft9vbyU0/6CuyH3+pDwNf1erbzT1yXN9u47L/Eaau
         d+7w==
X-Gm-Message-State: AOJu0YzW+cUz6QPvOHbStWhnsYhJ8oH5zH3+nKEhOvT5ejz6AkM+X+1H
        LNJfMNB/9CMERX4JSvlrMtQbCuR9r9nbaQrv1mA=
X-Google-Smtp-Source: AGHT+IHwrBNhRCFQtpnzt/uIlF/fMD3afTTUcvPkMAGKpgkIKsDEfkiim78m3y1jcY1kFXpDO4/Jzw==
X-Received: by 2002:a05:6a00:15c4:b0:6be:2991:d878 with SMTP id o4-20020a056a0015c400b006be2991d878mr6482900pfu.15.1698015200772;
        Sun, 22 Oct 2023 15:53:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id e12-20020aa7980c000000b006889348ba6esm4914612pfl.127.2023.10.22.15.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 15:53:20 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1quhJt-002ctP-2Z;
        Mon, 23 Oct 2023 09:53:17 +1100
Date:   Mon, 23 Oct 2023 09:53:17 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     David Wang <00107082@163.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PERFORMANCE]fs: sendfile suffer performance degradation when
 buffer size have performance impact on underling IO
Message-ID: <ZTWn3QtTggmMHWxS@dread.disaster.area>
References: <28de01eb.208.18b4f9a0051.Coremail.00107082@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28de01eb.208.18b4f9a0051.Coremail.00107082@163.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 08:19:34AM +0800, David Wang wrote:
> Hi, 
> 
> I was trying to confirm the performance improvement via replacing read/write sequences with sendfile, 
> But I got quite a surprising result:
> 
> $ gcc -DUSE_SENDFILE cp.cpp
> $ time ./a.out 
> 
> real	0m56.121s
> user	0m0.000s
> sys	0m4.844s
> 
> $ gcc  cp.cpp
> $ time ./a.out 
> 
> real	0m27.363s
> user	0m0.014s
> sys	0m4.443s
> 
> The result show that, in my test scenario,  the read/write sequences only use half of the time by sendfile.
> My guess is that sendfile using a default pipe with buffer size 1<<16 (16 pages), which is not tuned for the underling IO, 
> hence a read/write sequences with buffer size 1<<17 is much faster than sendfile.

Nope, it's just that you are forcing sendfile to do synchronous IO
on each internal loop. i.e:

> But the problem with sendfile is that there is no parameter to tune the buffer size from userspace...Any chance to fix this?
> 
> The test code is as following:
> 
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <sys/sendfile.h>
> #include <fcntl.h>
> 
> char buf[1<<17];   // much better than 1<<16
> int main() {
> 	int i, fin, fout, n, m;
> 	for (i=0; i<128; i++) {
> 		// dd if=/dev/urandom of=./bigfile bs=131072 count=256
> 		fin  = open("./bigfile", O_RDONLY);
> 		fout = open("./target", O_WRONLY | O_CREAT | O_DSYNC, S_IWUSR);

O_DSYNC is the problem here.

This forces an IO to disk for every write IO submission from
sendfile to the filesystem. For synchronous IO (as in "waiting for
completion before sending the next IO), a larger IO size will
*always* move data faster to storage.

FWIW, you'll get the same behaviour if you use O_DIRECT for either
source or destination file with sendfile - synchronous 64kB IOs are
a massive performance limitation even without O_DSYNC.

IOWs, don't use sendfile like this. Use buffered IO and
sendfile(fd); fdatasync(fd); if you need data integrity guarantees
and you won't see any perf problems resulting from the size of the
internal sendfile buffer....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
