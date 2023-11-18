Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327947EFD6E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjKRDeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjKRDd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:33:59 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3928E0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:33:55 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc5b705769so23683975ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700278435; x=1700883235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dF27M13Q5uIXKU9SuRFjuyiZuatrs8pB1vllLX+2P7M=;
        b=FOaCSrb8llwD112mZusnkMkAgqb83MPZihaaO3g6rzb+kSoU8PpZxvEoWVw7q1OTU6
         /g6WJJ5L7cb12/gacJfSb9lN49TnLWuJWnfzGHIKGYS/wRZH4oziKeEEYXciz4kiveDV
         UdvwtQAVLQpz6jTn50ujtowZiKtuwbG0g8YRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278435; x=1700883235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF27M13Q5uIXKU9SuRFjuyiZuatrs8pB1vllLX+2P7M=;
        b=sf265wu8buCt915TYmcJyfezTw5nnT22XROAllRvh3h+NwaoctasneflZmtSVh/7Oj
         Z3CYHJVXb8WDyZRQ2nmHnIujH9dFuJVCZSlR6Fu57kxm150Tak8LXTzDWEhgz9Qu42D3
         ZdOjRVBmMWIcMWuyk7uM5uoWHZpQqzT0BmAPmZRHMoEtbz3eoNDMMq05S3SbUOACnBYh
         IoXWwB43KstM1WaGzP77jIWbqnan9IuP3NLSMdzYeNYB1MpX8BTl++yY2DkMpuJTcyPA
         LgPlgLkUT40tuw4c9OTlV7UsqRhrRx5X5GiVKV4viaHuLjseWUAJwfP1A11I7ufRHxOS
         yngQ==
X-Gm-Message-State: AOJu0Yyu4PZoX4GUq5eg/NO58EdL0U+tj2Z5+ZaTqI5aoL+dk5xinWXj
        QBNH3rxo1omrmQVm3M6hV5tKqQ==
X-Google-Smtp-Source: AGHT+IFiVXVkJA1L9nXFiQfIL0/MD9bacMDG55+9sSwrswN9Mzf/813jB6DUKoAwLgRaC0LvRmDoEQ==
X-Received: by 2002:a17:902:cec8:b0:1ce:5b21:5c2e with SMTP id d8-20020a170902cec800b001ce5b215c2emr1703535plg.17.1700278435110;
        Fri, 17 Nov 2023 19:33:55 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b001c8836a3795sm2052356plw.271.2023.11.17.19.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 19:33:54 -0800 (PST)
Date:   Fri, 17 Nov 2023 19:33:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        cgroups@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/3] kernfs: Convert kernfs_path_from_node_locked() from
 strlcpy() to strscpy()
Message-ID: <202311171933.5792E9FFFE@keescook>
References: <20231116191718.work.246-kees@kernel.org>
 <20231116192127.1558276-3-keescook@chromium.org>
 <20231117084757.150724ed@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117084757.150724ed@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 08:47:57AM -0500, Steven Rostedt wrote:
> >  kernel/trace/trace_uprobe.c |  2 +-
> 
> trace_uprobe.c seems out of scope for this patch.

Oops. Yes, that's in the wrong patch. I will respin the series...

-- 
Kees Cook
