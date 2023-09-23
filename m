Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB1A7AC3F2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjIWRay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIWRax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:30:53 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06DFAF;
        Sat, 23 Sep 2023 10:30:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-578b407045bso3024738a12.0;
        Sat, 23 Sep 2023 10:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695490246; x=1696095046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hqVcpoe1kOppgOo9sz7e5PA+cHdVczMYuQbWhKjq+0w=;
        b=UqTXJ/hD5JX35OKfdYk+kbE4ktlQmr/Xr34AdQGNHyI+7yhgQrq7sB4xL/kp2rVXWB
         CVgEdXIRIq1aYMIt0FQQcLmssmbWFugMK6NtSLjH8gw4noH4SaU6f6J47N8cazrXK6Aw
         5I29qcPis0IdZdTnxKeJieUTZczqvafJ3H5vbszsLx6/BqmTug83lXSBn7GEVVwZG0Xj
         Kn5Q6KQCEVx14HqMJSAaoD1gl/A7pAfcpGPkw2fSsRkoWVIj9mOEg19dGY36TbtFEMab
         7rRHCgtU7OIrcnhUL4Hm756UAQD11s04OYYpozDEKd+dTbwuipIqC1CGf/zPqquSAMiN
         7bRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695490246; x=1696095046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqVcpoe1kOppgOo9sz7e5PA+cHdVczMYuQbWhKjq+0w=;
        b=sLGsfueqKGcaSiPb8FBCthwpMKZVUaZ0gGSbdyJIdljwgTqVNAzuXqhW58UxiGhHSH
         A+WnzBF5aqis+2kb4cqMwfysRIsUSLKe7KfCm0WkOWVZJki4NEDWngkBzBtbaS5zrhYv
         XBNJpf21ICtAVZQpubTvdSuCes+RMCcD2nbGTcj63M/BbLt7gdSWgFL8zJ00c1MeQkxR
         T+H7NsjzrS5VeQUmCaLeuGbKHTMuJPlfzPSIrY99hzGMXlNqb+1Zb2T0cHLKDjAX9bzG
         MMnVJvz4Fnc+GgDj2Ra+MEfJ12HvQy5OWrbP55+61K5cv24pC1zhLO1tKAozZfa66Lcm
         Hbqg==
X-Gm-Message-State: AOJu0YxgtHA/xslIv8iSGw+aS0ZoYCOYV9djjVzsMUAqCc1Ssyvk7jjJ
        72QjP17cV9m6jS63A9yCzY8=
X-Google-Smtp-Source: AGHT+IHPdAb9M4jmm7oPBQjTAdl+QuO4EQ9Bp6jQsdh2Qe+b4XyW/HGfpl9cadv6/1o1cEmZV/rE8w==
X-Received: by 2002:a05:6a20:4290:b0:14d:16c:2d20 with SMTP id o16-20020a056a20429000b0014d016c2d20mr3333712pzj.44.1695490246251;
        Sat, 23 Sep 2023 10:30:46 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:52e1:3075:4405:fdad:b3f9])
        by smtp.gmail.com with ESMTPSA id fk22-20020a056a003a9600b0068a30f6cf32sm5294269pfb.143.2023.09.23.10.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 10:30:45 -0700 (PDT)
Date:   Sat, 23 Sep 2023 23:00:40 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Subject: Re: [PATCH v1] samples: kprobes: Fixes a typo
Message-ID: <20230923173040.GA159038@atom0118>
References: <20230817170819.77857-1-atulpant.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817170819.77857-1-atulpant.linux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 10:38:19PM +0530, Atul Kumar Pant wrote:
> Fixes typo in a function name.
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  samples/kprobes/kretprobe_example.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
> index cbf16542d84e..ed79fd3d48fb 100644
> --- a/samples/kprobes/kretprobe_example.c
> +++ b/samples/kprobes/kretprobe_example.c
> @@ -35,7 +35,7 @@ struct my_data {
>  	ktime_t entry_stamp;
>  };
>  
> -/* Here we use the entry_hanlder to timestamp function entry */
> +/* Here we use the entry_handler to timestamp function entry */
>  static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
>  {
>  	struct my_data *data;
> -- 
> 2.25.1
> 

	Hi all, can someone provide comments on this change.
