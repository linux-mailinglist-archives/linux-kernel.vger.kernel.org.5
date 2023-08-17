Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50C77FC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351992AbjHQQxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351734AbjHQQx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:53:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C26E1FF3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:53:28 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-565439b6b3fso26812a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692291207; x=1692896007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wd2eEJ8bKVLE4jt9D8MWLfi2bLdIG89C4XSDUA4XuM4=;
        b=mEGHcVfvJ1Ie/DKOGJ3cn4M75JEBivLZpO+OsJ8xCiLQ1GJQQMl36SlQjVy5cWWoaq
         QCelzu3Ao/JQ4pT9CBZGSIUuqXTpzHjc5tspYcUQlnZQeOLtgEczpE44hcHTy8fe+Cmp
         Ys7Fq1A1PBZe8vZ8xA4v38u9i5nGqrAggwr6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692291207; x=1692896007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wd2eEJ8bKVLE4jt9D8MWLfi2bLdIG89C4XSDUA4XuM4=;
        b=gvd7Wv+FFm563Z1m7YFa8KpgebG45f6RKP26CAdxux9rNaO6jBE+OA4dQfi4GBRuIm
         hMcIaPzu+uC3kXuY9ijSaRVqiy9sHm6IXdDQgluQ1JtMXo13LvGvRCQmlVgka2gl4V9t
         lBoIkRW+ygbGCG9hDoXdK5vAu/xtDrpV44D1vha3q75cSdvQjZS2BU970xIwJd7lZ9sl
         SWFhKKxff4A3tzSPTy8mvzncc+LS08kfbf3Anpwf7wf4qBHLDq3yGAup7sQ0WVUY/yzR
         lUl8yd9aWRHLikEydcbeWum0e3Xc8uRsJsaJm5sL3B9OZOwX63Dox/aCvnktohnSK8vc
         wDUQ==
X-Gm-Message-State: AOJu0YwpXi0o39KkHhGWAT5i9363Ojz+qobj3e/xbWtLRVKFnhKlPAG8
        eFg/G4pTyz/6a6P09v1kI6tMTQ==
X-Google-Smtp-Source: AGHT+IEBtVDJzAH7jjK/Tzl/XqL8sfAWLGYo2+wPKkU1O+/+nEh6rMeDF/flz5bgJyCIwogSa+XEHQ==
X-Received: by 2002:a05:6a20:3a83:b0:13e:b7e9:1a71 with SMTP id d3-20020a056a203a8300b0013eb7e91a71mr263073pzh.14.1692291207506;
        Thu, 17 Aug 2023 09:53:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u8-20020aa78488000000b00687227dd8f1sm13085118pfn.122.2023.08.17.09.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 09:53:26 -0700 (PDT)
Date:   Thu, 17 Aug 2023 09:53:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill do_each_thread()
Message-ID: <202308170953.ECBAA9A@keescook>
References: <20230817163708.GA8248@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817163708.GA8248@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 06:37:08PM +0200, Oleg Nesterov wrote:
> Eric has pointed out that we still have 3 users of do_each_thread().
> Change them to use for_each_process_thread() and kill this helper.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
