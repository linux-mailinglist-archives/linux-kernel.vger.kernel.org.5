Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2647785C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjHKDFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHKDFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:05:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB26E76
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:05:42 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc7e65ea44so11300535ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691723142; x=1692327942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhB12dk8ZdnZdwj11biZ9b+hnnLzEWY6lozUSH8CqWk=;
        b=BYW+L6arNt/PBqcqYDViI0eMlBwWvh53Xb26ArI91EMF0L2dF4Xt7yB3d+66lh8NHD
         wvrSBponRKouOz5+6sHbVbjehaXoNPbRAIXtkkYT+p3Twr4s2pP3ovRyRJAYbZ6osRuL
         /wiafGdfBND3CA997sbiNNt/8/KjDV7TaFGuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691723142; x=1692327942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhB12dk8ZdnZdwj11biZ9b+hnnLzEWY6lozUSH8CqWk=;
        b=cTEbIMQ4fzr/ZWf9foogycQqFWSUmJmSrnSz5/1Wb6+GLc32A8IQQma4nEZd05OSau
         oXOvghzM97bnqkfzZZtix990rVtxwB76I0La2zJ+7NC6jBSSCgFWMR47zLFw3SCS6kDY
         WaJqWEgpP0No41nnHrj1nBtL53XWKfZ8TsD/OOKxiCETHDmQYGUEdoLAwHCTvE5R7Qaz
         E1uriaqFhNxRFAre3kg1uIrdLtnszKnLg+JceOmFO9wDSMoigTtWtPj0U614cb0fNSeE
         WEZjqPZ8SGygy+bbjk6GKsAHdEpgy5MYjjDxMoJoG6uSIe6fhYqLjN89qKqCNhuS8NKr
         8Z0A==
X-Gm-Message-State: AOJu0Ywnhz9uD47Z3FVQdD4y86B+PTKBprxgl8WgtSGkrGuKJOXFEmOc
        jYs4mA59cNcC26CfXi87NumOYw==
X-Google-Smtp-Source: AGHT+IGwQIWEJ3qdOsjFt2/KoAMrkWhW9OasV6Odz77Ts8cINDpajWa1E4N02/PSWT590vS26lp6rA==
X-Received: by 2002:a17:903:11d1:b0:1bb:d586:d29a with SMTP id q17-20020a17090311d100b001bbd586d29amr4754223plh.34.1691723141955;
        Thu, 10 Aug 2023 20:05:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902744900b001b7e63cfa19sm2542835plt.234.2023.08.10.20.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 20:05:41 -0700 (PDT)
Date:   Thu, 10 Aug 2023 20:05:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: pstore/ram: printk: NULL characters in pstore ramoops area
Message-ID: <202308102001.55158F519@keescook>
References: <f28990eb-03bc-2259-54d0-9f2254abfe62@linux.microsoft.com>
 <202308040053.7F38C6D@keescook>
 <0220f601-14f8-1dda-f057-73a608fbe62b@linux.microsoft.com>
 <202308101649.337F4D8@keescook>
 <0dace822-ce13-906e-46bd-e1cb9274cafe@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dace822-ce13-906e-46bd-e1cb9274cafe@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 05:48:17PM -0700, Vijay Balakrishna wrote:
> On 8/10/23 16:50, Kees Cook wrote:
> > Can you share the .config you're building with? And what are you using
> > to trigger an Oops? I will see if I can reproduce this...
> 
> Config: https://paste.ubuntu.com/p/Vrcsf8Ry9g/

Thanks! I'll see how close I can get to this for my local testing...

> 
> Just ran plain "sudo reboot" and inspected /var/lib/systemd/pstore/dmesg-ramoops-0 after reboot.

If you have a "dmesg-ramoops-0" there, something Oopsed. On a clean
shutdown, only "console-ramoops-0" will be recorded. Can you double
check by deleting everything in /var/lib/systemd/pstore/ and rebooting?

If you still get a dmesg-ramoops-0 file, can you upload that somewhere
so I can look at it?

Also, can you send the contents of /proc/iomem ?

-- 
Kees Cook
