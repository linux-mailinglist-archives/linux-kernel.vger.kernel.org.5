Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FDF77802C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjHJSXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjHJSXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:23:50 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041312690
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:23:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc7e65ea44so8921785ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691691828; x=1692296628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v19mqXZMVEjkYcitM51ee25xYsPURi4wJGVMBga9gK8=;
        b=GFZ1xaUnRfjSYeHWCjh3NhIcVzjbMHuqnLhoFdzfETeXoOYTs2BwF5sicdbGj7cQBP
         FdRm1WPpZKA2Hvr3Psk9lC1cn8iGUtU/Xk1JC8ExbvRORW2d29L8jyjORA0s7QYbvmDc
         1Ewed91ibDi3OArcbobobjE8+Zf+mrutFSTaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691691828; x=1692296628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v19mqXZMVEjkYcitM51ee25xYsPURi4wJGVMBga9gK8=;
        b=ZDC3CfK0FZNgYZoy2OMYSqZpNXC1a6qnIKKGkCLun+lt3zt/y0bfa9l/wJn48RfvXa
         p7dK0MvC1eGQQCpk7nOkdHVlyZ42iK17D4bV4EAXwXzXyBkVOcnAPgiwH4tfE5/QOL+W
         XzadyS2kEn88geUA3x0HoW+Z4OoZDabbYHaWXKul4ehFOrAB4UFZbNG0SBR9o0IUCnFS
         1v8AdgH7qhOV6M8KAmQgrP6Bgid/k43qOWLPSQmYly47wnb1IuhH7l6q6Vf4PYrDeLYn
         dZnIsn7tDi1zsz2SjUXklwnkKUq+VOsSVDwC7dLf+CpML0Af8unckma1YUhywQtH5u32
         iRKw==
X-Gm-Message-State: AOJu0YztTiDH54iRoar/yR3MSMsDoJG0wR/gAcEGgZ10MLWqhRQnfjNZ
        r6VO4d6RCVSZwR+fLlrjn9zw6g==
X-Google-Smtp-Source: AGHT+IEwTTVq7ZdESNwJOlnT1RSm4fL++7TopJKhsJTxrPKQ/5MqvLawEF7KqSII2I4SZyBOSkcNqg==
X-Received: by 2002:a17:902:d488:b0:1b6:a37a:65b7 with SMTP id c8-20020a170902d48800b001b6a37a65b7mr3917339plg.23.1691691828422;
        Thu, 10 Aug 2023 11:23:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r12-20020a1709028bcc00b001b8052d58a0sm2095111plo.305.2023.08.10.11.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:23:47 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:23:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jijie Shao <shaojijie@huawei.com>,
        Leon Romanovsky <leon@kernel.org>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, chenhao418@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net] net: hns3: fix strscpy causing content truncation
 issue
Message-ID: <202308101103.D0827667B@keescook>
References: <20230809020902.1941471-1-shaojijie@huawei.com>
 <20230809070302.GR94631@unreal>
 <7c44c161-9c86-8c60-f031-6d77d6c28c20@huawei.com>
 <20230810102247.699ddc14@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810102247.699ddc14@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:22:47AM -0700, Jakub Kicinski wrote:
> On Thu, 10 Aug 2023 15:45:50 +0800 Jijie Shao wrote:
> > on 2023/8/9 15:03, Leon Romanovsky wrote:
> > > On Wed, Aug 09, 2023 at 10:09:02AM +0800, Jijie Shao wrote:  
> > >> From: Hao Chen <chenhao418@huawei.com>
> > >>
> > >> hns3_dbg_fill_content()/hclge_dbg_fill_content() is aim to integrate some
> > >> items to a string for content, and we add '\n' and '\0' in the last
> > >> two bytes of content.
> > >>
> > >> strscpy() will add '\0' in the last byte of destination buffer(one of
> > >> items), it result in finishing content print ahead of schedule and some
> > >> dump content truncation.
> > >>
> > >> One Error log shows as below:
> > >> cat mac_list/uc
> > >> UC MAC_LIST:
> > >>
> > >> Expected:
> > >> UC MAC_LIST:
> > >> FUNC_ID  MAC_ADDR            STATE
> > >> pf       00:2b:19:05:03:00   ACTIVE
> > >>
> > >> The destination buffer is length-bounded and not required to be
> > >> NUL-terminated, so just change strscpy() to memcpy() to fix it.  
> > > I think that you should change to strtomem() and not use plain memcpy().
> > >
> > > Thanks  
> > 
> > Hi:
> > 
> > We tried to replace memcpy with strtomem, but errors was reported during 
> > compilation:
> > /kernel/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c: In 
> > function ‘hclge_dbg_fill_content.part.0’:
> > /kernel/include/linux/compiler_types.h:397:38: error: call to 
> > ‘__compiletime_assert_519’ declared with attribute error: BUILD_BUG_ON 
> > failed: !__builtin_constant_p(_dest_len) || _dest_len == (size_t)-1
> >    397 |  _compiletime_assert(condition, msg, __compiletime_assert_, 
> > __COUNTER__)
> >        |                                      ^
> > /kernel/include/linux/compiler_types.h:378:4: note: in definition of 
> > macro ‘__compiletime_assert’
> >    378 |    prefix ## suffix();    \
> >        |    ^~~~~~
> > /kernel/include/linux/compiler_types.h:397:2: note: in expansion of 
> > macro ‘_compiletime_assert’
> >    397 |  _compiletime_assert(condition, msg, __compiletime_assert_, 
> > __COUNTER__)
> >        |  ^~~~~~~~~~~~~~~~~~~
> > /kernel/include/linux/build_bug.h:39:37: note: in expansion of macro 
> > ‘compiletime_assert’
> >     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), 
> > msg)
> >        |                                     ^~~~~~~~~~~~~~~~~~
> > /kernel/include/linux/build_bug.h:50:2: note: in expansion of macro 
> > ‘BUILD_BUG_ON_MSG’
> >     50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> >        |  ^~~~~~~~~~~~~~~~
> > /kernel/include/linux/string.h:302:2: note: in expansion of macro 
> > ‘BUILD_BUG_ON’
> >    302 |  BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||  \
> >        |  ^~~~~~~~~~~~
> > /kernel/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:115:4: 
> > note: in expansion of macro ‘strtomem’
> >    115 |    strtomem(pos, result[i]);
> >        |    ^~~~~~~~
> > 
> > In the strtomem macro, __builtin_object_size is used to calculate the 
> > _dest_len.
> > We tried to print the _dest_len directly, and the result was -1.
> > How can we solve this?
> 
> Let's add Kees in case he has a immediate recommendation on use of
> strtomem() vs memcpy() for this case..

tldr: use memcpy() instead of strscpy().


Okay, I went to go read up on the history here. For my own notes, here's
the original code, prior to 1cf3d5567f27 ("net: hns3: fix strncpy()
not using dest-buf length as length issue"):

static void hns3_dbg_fill_content(char *content, u16 len,
				  const struct hns3_dbg_item *items,
				  const char **result, u16 size)
{
	char *pos = content;
	u16 i;

	memset(content, ' ', len);
	for (i = 0; i < size; i++) {
		if (result)
			strncpy(pos, result[i], strlen(result[i]));
		else
			strncpy(pos, items[i].name, strlen(items[i].name));

		pos += strlen(items[i].name) + items[i].interval;
	}

	*pos++ = '\n';
	*pos++ = '\0';
}

The warning to be fixed was:

hclge_debugfs.c:90:25: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]

There are a few extra checks added in 1cf3d5567f27, but I'm more curious
about this original code's intent. It seems very confusing to me.

Firstly, why is "pos" updated based on "strlen(items[i].name)" even when
"result[i]" is used? Secondly, why is "interval" used? (These concerns
are mostly addressed in 1cf3d5567f27.)

I guess I'd just like to take a step back and ask, "What is this
function trying to do?" It seems to be building a series of strings in a
" "-padding buffer, and it intends that the buffer be newline and %NUL
terminated.

It looks very much like it wants to _avoid_ adding %NUL termination when
doing copies, which is why it's using strncpy with a length argument of
the source string length: it's _forcing_ the copy to not be terminated.
This is just memcpy.

strtomem() is designed for buffer sizes that can be known at compile
time, so it's not useful here (as was found), since a string is being
built up and uses a moving pointer.

I think the correct fix is to use memcpy() instead of strscpy(). No
%NUL-truncation is desired, the sizes are already determined and bounds
checked. (And the latter is what likely silenced the compiler warning.)

-Kees

-- 
Kees Cook
