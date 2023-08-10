Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF017778107
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbjHJTHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjHJTHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:07:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB152D47
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:07:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc83a96067so9677125ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691694460; x=1692299260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nmOwYu+wAsqoAkxbWGneNadnCgLM0c5R8LClfgUNH9I=;
        b=QkOkm0aFedzWAtuNszKzcm0KrHyY4YEWT0ltIriL5dNGRCGtKtfbjQGZDoRu8PHTGL
         2q19rGzd320iFiPEMeYLLVjDrO+n8xsOaMVVVB1p6UAnbmbd6CBz92szKDrxxgg9pRQn
         Rn8S9Iw75DpdEDSpYWSO36hoPOuxO4htgB28E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694460; x=1692299260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmOwYu+wAsqoAkxbWGneNadnCgLM0c5R8LClfgUNH9I=;
        b=WandqTp9dWFHRPScvoPmkWYLl5P4F26sRlhLmmjYH+LwCP1di6Lm6pUsycYT5axTD1
         FtRqEsUUINETPsQes8RjOWVdLq6yROMRAafe3gCOEOck53PyCPn64V/kYgtetO4NuZS9
         FQsqw1vx+cBBTC+8YpB1aDo2QLsrwt4c4bpLXDUKLog1fH1/D/mxk+P0iFTjYUdDX5dN
         ET6/UtuJlVXFrZatU2KIDgwbPhgJmKO/sEXNBVd4QsHP5gWU73D4ALbB+YdOiMg2udKR
         o6sHcFP2qlrqLQSU7DZ4+KG/vMGpI8c8SMA7+naZ+Ewuz4dZo7FcX74CpPt8+O6FvwQx
         mV9Q==
X-Gm-Message-State: AOJu0Yzjt38RTHCYbIYXwo6lsdnClMO5R0TMSFhXe4Y/u5kF0/ZH3eUD
        SNLOxKThmN4XygN5JKK1zlwypQ==
X-Google-Smtp-Source: AGHT+IEmgnGLrUOSbaCk2ycL3uzAZ+J06bwEXpv2ztZy56vch26GG8o6dUtXoEcAdUqVf+nIc0tC+A==
X-Received: by 2002:a17:902:d4c3:b0:1bb:bc6d:457 with SMTP id o3-20020a170902d4c300b001bbbc6d0457mr3391924plg.36.1691694460449;
        Thu, 10 Aug 2023 12:07:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001bbbbda70ccsm2134447pls.158.2023.08.10.12.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:07:39 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:07:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Justin Stitt <justinstitt@google.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-hardening@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] netfilter: ipset: refactor deprecated strncpy
Message-ID: <202308101206.35C628E5@keescook>
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
 <20230809-net-netfilter-v2-1-5847d707ec0a@google.com>
 <20230809201926.GA3325@breakpoint.cc>
 <CAFhGd8oNsGEAmSYs4H3ppm1t2DrD8Br5wwg+VuNtwfoOA_-64A@mail.gmail.com>
 <q49499n7-54p3-1soo-8s83-7p84724o08p7@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q49499n7-54p3-1soo-8s83-7p84724o08p7@vanv.qr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 11:54:48PM +0200, Jan Engelhardt wrote:
> 
> On Wednesday 2023-08-09 23:40, Justin Stitt wrote:
> >On Wed, Aug 9, 2023 at 1:19 PM Florian Westphal <fw@strlen.de> wrote:
> >>
> >> Justin Stitt <justinstitt@google.com> wrote:
> >> > Use `strscpy_pad` instead of `strncpy`.
> >>
> >> I don't think that any of these need zero-padding.
> >It's a more consistent change with the rest of the series and I don't
> >believe it has much different behavior to `strncpy` (other than
> >NUL-termination) as that will continue to pad to `n` as well.
> >
> >Do you think the `_pad` for 1/7, 6/7 and 7/7 should be changed back to
> >`strscpy` in a v3? I really am shooting in the dark as it is quite
> >hard to tell whether or not a buffer is expected to be NUL-padded or
> >not.
> 
> I don't recall either NF userspace or kernelspace code doing memcmp
> with name-like fields, so padding should not be strictly needed.

My only concern with padding is just to make sure any buffers copied to
userspace have been zeroed. I would need to take a close look at how
buffers are passed around here to know for sure...

-- 
Kees Cook
