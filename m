Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211BB751495
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjGLXkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjGLXkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:40:53 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C289E5C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:40:51 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b078b34df5so60054fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1689205250; x=1691797250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gX10h/u2AgEKQyI33m5MeDdClug4BRazkNImVUptCuk=;
        b=fwTU2bLGr7Sk+sKJD1ewW671eMhXay4oAa1T3Er6P0BwrI6gCXNWhwwv9QOMBVCLFI
         TFlkISyQzRlJU9ur4/mXxQ38KDlNXjPb0G+/1cD2zdTUAYP5FNtGeGzmRG7SJXzbaEt+
         pVJAKZ6IHsRtL0ndsNj2ASJ1X47/D8wGeTiDYhxBUQt9Z9ooyIlIkGYN0AipJodyxsP/
         48TElYA+FrnP9A3Bikz32B9SxHqfIQb4MvooCpNfdqgZGOIv3H4ySmZjCqEJGfqyPAi/
         mgaPYbQLsFBE79LUdZcsIQH4c5uDSDf9J6+MJ4ghjyhEP+zXlpRp6qMjiZ0aj10mvUUh
         Q9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205250; x=1691797250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX10h/u2AgEKQyI33m5MeDdClug4BRazkNImVUptCuk=;
        b=W4O81h/K7bJk6PF2BVptDXJzdiZMrYGEoKs9j3Too2qViab9O07J/qtwURY4Omvc+m
         +GL+J1hNdCiwpOnFYW3i0R2LBzmLwFpTpUOsGRV4cGvpUW//5nNE5Dto4CZnyP8RGo8R
         WRiSAj7h+9Fxx07X4CA1eXtmuQZc7cYEMt5N1Isn+iEuxvV+PF9mlHffCmoJvYe5IImk
         x3KMZrVOc6WDoYYndpPktuBaqGZwx+4k84iqYsSiYQpTD9Q5O1fyT9CS14rSCOChHpoP
         ADU60P+ahnDrYjHmic7JWcQJ1+vRuNusV16doy0RSOG+qnYDJq4Yl8qwfz85r3TxfOKe
         oQvQ==
X-Gm-Message-State: ABy/qLZIQeTZqPkTrB00AjHaIAO0CATEPmdCI+cqElLQz0HIs80/7BCn
        Yck+31eVm/UvWVWUxn9uQjuntw==
X-Google-Smtp-Source: APBJJlEPB6IkUH0IphZLgS++VMmg/0wihL5I3IzhQWj/WdLcmXqOlQ68mI8W/UKLavpRhWSGy69Hbw==
X-Received: by 2002:a05:6871:20f:b0:1b0:5fc0:e2b5 with SMTP id t15-20020a056871020f00b001b05fc0e2b5mr170509oad.53.1689205250432;
        Wed, 12 Jul 2023 16:40:50 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id t5-20020a17090a3b4500b0023fcece8067sm4559014pjf.2.2023.07.12.16.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:40:50 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:40:47 -0700
From:   Mohamed Khalfella <mkhalfella@purestorage.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing/histograms: Add histograms to hist_vars if they
 have referenced variables
Message-ID: <20230712234047.GA3521501@medusa>
References: <20230712223021.636335-1-mkhalfella@purestorage.com>
 <20230712190723.26ebadea@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712190723.26ebadea@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-12 19:07:23 -0400, Steven Rostedt wrote:
> And Of course you send this to me right after I send a pull request with
> fixes to Linus :-p
> 
> Thanks for the patch. I just did a quick test, and sure enough I can
> reproduce the bug, and your patch makes the bug go away.
> 
> I run this through my full test suite, and then send Linus another pull
> request.
Thanks for the quick response!
> 
> Thanks!
> 
> -- Steve
