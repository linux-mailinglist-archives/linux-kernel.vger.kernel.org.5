Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402FB766B06
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbjG1KuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjG1KuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:50:09 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F148C30C2;
        Fri, 28 Jul 2023 03:50:07 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so6788209a12.0;
        Fri, 28 Jul 2023 03:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690541406; x=1691146206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5kOE1jJSxvY6+Q1SNUpmeazrAStqxbxkO2plfSrMpg=;
        b=M75UwF2w0yzizm2X+rrPCYLfapbH0VQ+lALHr9ddJLkem3pAR1XcbJGiAAJWB+refj
         xaNU/eXCnL4Fyu8LzIzp2OLV7GP/kfxNyW1fe/uqJeEHoEnA3R7L/9AviRSymVpGZhYc
         HtlZYhskXgP76FEMd1hUrrQeFFjaI5qkViJ1BrLCwjPRzk9S6nm6NbRz7ISyYLoklr11
         JvtLU2E+dxeQ+F2b51W92jhtMiNIBLlw3LBMaMU2v2aa4NvORBCMAZd1PBmWCIx/OGTP
         3J/hhrqCxiPOiMI5Dj6S4sSL2dHjXeQJ8lDOCbVMTVJ5tkg26ayeJEvwqwyP8AXIRisN
         XZFg==
X-Gm-Message-State: ABy/qLbG01OXnVYU6tyDhQq6uV8yzv5CTEZDf3STtt1AbFy0jvu8kVzS
        AyUTQdcwKzlmQhk2wsEAi2I=
X-Google-Smtp-Source: APBJJlG4MZBRxi/a/TTyiOrebK6UlaBOJhrWe85gOMPtysD+7qhDkUeR1mKyMzVgUBD0C/LQSBfgLg==
X-Received: by 2002:a17:906:cc4e:b0:997:e836:6bb with SMTP id mm14-20020a170906cc4e00b00997e83606bbmr2397724ejb.14.1690541406267;
        Fri, 28 Jul 2023 03:50:06 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709060dc900b0099bc038eb2bsm1896528eji.58.2023.07.28.03.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:50:05 -0700 (PDT)
Date:   Fri, 28 Jul 2023 03:50:04 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, leit@meta.com,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] netconsole: Enable compile time configuration
Message-ID: <ZMOdXBwo2e7vFUpe@gmail.com>
References: <20230727163132.745099-1-leitao@debian.org>
 <c1f6344f-1b5d-15cc-f692-b5d036d8ad20@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1f6344f-1b5d-15cc-f692-b5d036d8ad20@infradead.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 03:51:41PM -0700, Randy Dunlap wrote:
> 
> 
> On 7/27/23 09:31, Breno Leitao wrote:
> > +config NETCONSOLE_APPEND_RELEASE
> > +	bool "Enable kernel release version in the message"
> > +	depends on NETCONSOLE_EXTENDED_LOG
> > +	default n
> > +	help
> > +	  Enable kernel release to be prepended to each netcons message. The
> > +	  kernel version is prepended to the first message, so, the peer knows what
> > +	  kernel version is send the messages.
> 
> 	                 is sending
> or
> 	                 sends

Thanks. I will fix on v2.
