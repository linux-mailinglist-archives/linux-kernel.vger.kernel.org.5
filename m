Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D80D7F4C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjKVQXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKVQXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:23:51 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA7DBC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:23:46 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cb66f23eddso3137634b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700670226; x=1701275026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTDy5+k0dtJZNnwO+x4unCXNoTp268UlGDuFwlqBl7s=;
        b=eG0Rr4SD4TLiXFbaPXSZHwHBteQWSGTSvAShjUNiio/KZjxyx5dwrcgbetVEbuV1t4
         U3XWaXvb4/FkDFmO95R5HhcgFNEP4r8GDqM8REhUqT0k6L5Rz1Ot4sb9niHh+17YrYGc
         gIsf0W+X13XxqXjIJbB2aW5xmywBqc+9KU6QbxtVZlCUBjx3siT7v4DVnXvVKX8Qcm7V
         YFEE/SunFYxkBhFH8/KKiaWz8no5hxjN4S7Su23GQnwgQBC5+su3TFTnaPS3kPw2KjeW
         qR6rIeCG5wv/RAz4EB7AX0ZNIj5t13/8pt5NRsG7DlO5mV42PsJsBMqD+mtp+0BItuXS
         Vqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700670226; x=1701275026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTDy5+k0dtJZNnwO+x4unCXNoTp268UlGDuFwlqBl7s=;
        b=pafzqC3Xr9dJibrRHwe7ANG9ppJ44AAbQwTZ5TBQq7fxFumHXKIE+qbWr9mwyhIBpb
         nyyIigWyg+z12Q6KFvgA16uS/nmKKLU9T7JfB2LXV/6le0qAeI7MKqlOLC5Cq/x5Wy68
         hK2+tstqSGpMKQ1JGnmO/E3sL2Vkooabf3WwhXAhpe5qcT+muQOx7NceL1WyP9oeK4JG
         k+mRIswOh5aIeTr9jbrpzOAs70sYKekwIay89pQYIXxI2gvUJAFY4kv17jz73Nvsue7O
         oS366Q5zOO801e9O/Xk8EUeevV8rIY3ol82kRCQ07xp+JXkc9Xzoj8qPbAe30f9i+fuv
         z7zw==
X-Gm-Message-State: AOJu0Yz8h7c23qknHWN6QOGmrctauYtuoiN3SZ74HBFNnGa73sq+SgVb
        vrAlYVaNhkFqTcCYHA1kz24=
X-Google-Smtp-Source: AGHT+IFsiiOfKWQ9mjl6t3iZBmG4omqAercKcsoChp8QcOhyiLMxzcZGmSPdEefRz6Wjc8T9cw6nPQ==
X-Received: by 2002:a05:6a00:2d99:b0:6cb:a8dc:26ed with SMTP id fb25-20020a056a002d9900b006cba8dc26edmr3353572pfb.16.1700670225893;
        Wed, 22 Nov 2023 08:23:45 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id 17-20020a630d51000000b005894450b404sm9669478pgn.63.2023.11.22.08.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 08:23:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 22 Nov 2023 06:23:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     zhuangel570 <zhuangel570@gmail.com>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Make sure that wq_unbound_cpumask is never
 empty
Message-ID: <ZV4rEDd-5E83wJrJ@slm.duckdns.org>
References: <20231120121623.119780-1-alexyonghe@tencent.com>
 <ZVuudtAtDqHqYJr8@slm.duckdns.org>
 <CANZk6aTS9BODJiqtDSHxwhz2dV3RmaxRautR8WZfH5aYYhcQJw@mail.gmail.com>
 <ZV0jmGSismObVncD@slm.duckdns.org>
 <8f469287-e29a-4473-a181-9013292ef62c@redhat.com>
 <ZV4mPoOvIgX9Um0z@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV4mPoOvIgX9Um0z@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 06:03:10AM -1000, Tejun Heo wrote:
> It's a workqueue fix patch, so what I'm gonna do is land this in
> wq/for-6.6-fixes and just resolve it in cgroup/for-next.
           ^
	   7

So, I applied the fix to wq/for-6.7-fixes and merged it into cgroup/for-6.8
for conflict resolution.

Thanks.

-- 
tejun
