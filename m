Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16AD78F461
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347493AbjHaVId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244408AbjHaVIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:08:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC837B5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:08:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so1097222b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693516109; x=1694120909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdS6aEw25mYoGsnnq+Zex8meOo2Y1HUCQC1ip4dfp1s=;
        b=kwVIlVcTfzt+KWLG+1QxfliQ0vfeuWKZs+EVHZi04zykGTKKvMn0FdK2p+8CO13npp
         zqXju9sqeWMu24HuE1+TisbyGNK4tfwHmW4kcoBDytClrdh8Zk0AZ3WfwCYWmmjmVZ7A
         Qo45c4AxUImEljx0m1GQCU2d10Om+PQmPUBG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693516109; x=1694120909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdS6aEw25mYoGsnnq+Zex8meOo2Y1HUCQC1ip4dfp1s=;
        b=VTEZfOt9WdxZDlMnG6KCIpFFLECyuflRbLrApWzA/7QQjYgzs77+5xGlGI1OLZQ4mr
         CGAafetdEN2BstRYt8Ja04hl01B+y3Onj7b3LoL0L7fInAptf8bbaHH/R20cNaxMcDDF
         5eTPNc2FQsUer4tbAiACt5Ve1z/3fvTuYjmtt2SWm08KJ9JN4J63r+QFpe2Gayedjtf0
         /06ANressyEjdY9mY5YsE1X2iPyCRYbTDgDFKJoRdFi88bJ4HfpsU8mecI27wmVFKdn1
         4bUnEXkOc9KarA52C8G53LX/C9pg3SjNsLFgd6H2yiCI1hPEhquadUimWcIWOwcPg9bb
         yixg==
X-Gm-Message-State: AOJu0YzHEIDEEBrZIGRnMOyMSzw0s53l1WxddMXULnUpm7lR4NSnQeM8
        udO+yBlaMnYNjdHo4izmIsWGvw==
X-Google-Smtp-Source: AGHT+IG3xkW1wQZbnGgPAEUzCt2GSCDdKOHcgxWVXIAe2RZ1/F3iEGAIqwPDUkiNDC9TTJhgLxQd/w==
X-Received: by 2002:a05:6a20:978b:b0:131:c760:2a0b with SMTP id hx11-20020a056a20978b00b00131c7602a0bmr835978pzc.52.1693516109106;
        Thu, 31 Aug 2023 14:08:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j22-20020aa78016000000b00682868714fdsm1746918pfi.95.2023.08.31.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:08:28 -0700 (PDT)
Date:   Thu, 31 Aug 2023 14:08:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] trace/events/task.h: Replace strlcpy with strscpy
Message-ID: <202308311408.A73103C41@keescook>
References: <20230831194212.1529941-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831194212.1529941-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 07:42:12PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
