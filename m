Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0BA76FC07
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjHDI3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjHDI32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:29:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5546046AB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:29:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686ba97e4feso1671542b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691137742; x=1691742542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Lzp3ZkP17GT5v8YT6Q8PsfBgtBwszbchO+h+FYy3w4=;
        b=gz/zjWqM3uu/9WJf25raD3sRvhSeY7TJLSIXkLtJ5Q9CbU2Fg9UlZPPg31KTkF5Say
         h+zm8lyW0sWyiNhFbYjYNzovIj483N3sguC+1cDwqAfMGZm5likBeIBTtFQiZx7wjjw/
         6I+iYb810hAMUm38IIs4yM3G1df4qSUj79J1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137742; x=1691742542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Lzp3ZkP17GT5v8YT6Q8PsfBgtBwszbchO+h+FYy3w4=;
        b=GLO7LAzbS8ux+0N9jU+iQn4f7Yfn7dVNhi1txWk6YhudwrzcfVtvLYf/cIL2ecoiK1
         oQX+YWFP3Tfrp/xJ3TGiKqMxQ9wH5+Dc5JOuNuNl27AShREpQuuAiSi2+80Bqci4Q4/Z
         0H2xEp0KwNrGRXILgKUUre8iRMUHrGCESFYE/kMyFXyTlyt89w1/PMBLhZfbERiWb28E
         84wQW3m8vU9gDrTAtR36VOTDkaDz4FpwcmK0kSuL43tYJT6xaRLMUCkdJJFgC9CcQO51
         R3Tg/ApVLjMbirlmmxtUOTzL4WTTVT6N6Hunk0T+L0f8uMQeSYVf9r433agx25UjOnpq
         /c0g==
X-Gm-Message-State: AOJu0Yy4vP6GOB/YsK7AC41OC9hnvYEckRudLCCTYXtTJLspknRB1VFX
        houxp4WmwMAGNjLsGUeQ4/kp6w==
X-Google-Smtp-Source: AGHT+IEb8NJZukwkOLv+8X4gGyv5xuEMYnojzUqQ9CiQkM6If6hOvgmAM+Cd3GLl5BacdLQgN3RxVw==
X-Received: by 2002:a05:6a20:244f:b0:138:64d4:b040 with SMTP id t15-20020a056a20244f00b0013864d4b040mr1274551pzc.54.1691137742585;
        Fri, 04 Aug 2023 01:29:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v19-20020a62a513000000b006870721fcc5sm1101722pfm.175.2023.08.04.01.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:29:02 -0700 (PDT)
Date:   Fri, 4 Aug 2023 01:29:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] virtchnl: fix fake 1-elem arrays in
 structures allocated as `nents + 1`
Message-ID: <202308040128.667940394B@keescook>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-3-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728155207.10042-3-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 05:52:06PM +0200, Alexander Lobakin wrote:
> There are five virtchnl structures, which are allocated and checked in
> the code as `nents + 1`, meaning that they always have memory for one
> excessive element regardless of their actual number. This comes from
> that their sizeof() includes space for 1 element and then they get
> allocated via struct_size() or its open-coded equivalents, passing
> the actual number of elements.
> Expand virtchnl_struct_size() to handle such structures and replace
> those 1-elem arrays with proper flex ones. Also fix several places
> which open-code %IAVF_VIRTCHNL_VF_RESOURCE_SIZE. Finally, let the
> virtchnl_ether_addr_list size be computed automatically when there's
> no enough space for the whole list, otherwise we have to open-code
> reverse struct_size() logics.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

I remain a fan of _Generic uses. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
