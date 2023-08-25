Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191E1787E19
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjHYC4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbjHYCzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:55:45 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DC0E7A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:55:39 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7927f24140eso12524839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692932139; x=1693536939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+bzcizTeL9qFuQdDsAhAqqZhe0DCOQOHLGs+p18EceI=;
        b=tpF2VKjfwyKSG8Hqt9xqjhRXKYIoACT0VJ9CnXuRLLohyGD5QOGqWhEXgcqK8UQLtZ
         e5UHrt1LEZboTIFFg3YckjL2wONPAjH6+sBomEbo8szTqsgzeHCYNb/njFYpnET/3n2t
         r/H3PiXpfeqc8m58uX+pinN/NW1EPIix6FjOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692932139; x=1693536939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bzcizTeL9qFuQdDsAhAqqZhe0DCOQOHLGs+p18EceI=;
        b=M8pGVWfEB2WPf6zSKGrrL40w7DyG088hiPvhwQQIt+rIsf6rJX3WqQdBY3mZjOlii9
         3lL7ZanaPKJtmD++VWBdDO9194I7XLJAeYI9G1jSvDz1u4HEPLX30sWnaqslgKa9Eb/C
         T/l0aO9ttgKqZ/QPqz8MgtT3jVEiGCsuCx7hiU/BeMKC7Nk5g2BXVCQg3lBmIUYpgKhg
         tbW0nW0agAO+0ZMhp4Kvg/3MLgdUwuuPON4c6vdCC6MZ5BnfkC75Hv4HQMwcEhX6N+vk
         1ERaOoCXwSvZKgqSkkZLDEiDzmuyqIiep8iTIc66cbZX/yOZ0KYZtAnROP7wrHEgaGtS
         KdXA==
X-Gm-Message-State: AOJu0Yz9JmhxaFWZ/jszJRWAX8CGWSViTF29CpGr63zCn0hSYshvVBPY
        4+efJkXBJ4UkIjNZo5JYyNl0IJrQUMqfZCgHFd0=
X-Google-Smtp-Source: AGHT+IG9l3ghffEmYX1qaa3yg2PijOUFAak7ccGKAPahce4ViUcuvLYC0k9cofKLnwBwwpKxvvWljg==
X-Received: by 2002:a6b:dd16:0:b0:786:7100:72de with SMTP id f22-20020a6bdd16000000b00786710072demr8297660ioc.16.1692932139244;
        Thu, 24 Aug 2023 19:55:39 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id v15-20020a5ec10f000000b0076373f90e46sm194535iol.33.2023.08.24.19.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:55:38 -0700 (PDT)
Date:   Fri, 25 Aug 2023 02:55:38 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Replace schedule_timeout*() 1 jiffie waits
 with HZ/20
Message-ID: <20230825025538.GF4008060@google.com>
References: <20230816204913.450457-1-joel@joelfernandes.org>
 <530be59f-96a9-4b2b-8be3-af837d7cbe3a@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <530be59f-96a9-4b2b-8be3-af837d7cbe3a@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 02:07:55PM -0700, Paul E. McKenney wrote:
> On Wed, Aug 16, 2023 at 08:49:12PM +0000, Joel Fernandes (Google) wrote:
> > In the past, we see that spinning on schedule_timeout* with a wait of 1
> > jiffie can hang the kernel. See d52d3a2bf408 ("torture: Fix hang during
> > kthread shutdown phase").
> > 
> > Recently again it showed up in torture's stutter code as well. The behavior is
> > the the function may instantly return and never go to sleep preempting whatever
> > was running under it.
> > 
> > To prevent future issues, apply the same fix mentioned in the above
> > commit d52d3a2bf408 to more places.
> > 
> > I took care to only apply it to places where I thought it made sense.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Hearing no objections, I applied this for further review and testing.
> 
> In the future, should some of these become hrtimers?

Yes they certainly could be but we don't need these ones to be high
resolution AFAICS and the jiffie granularity should be good.

thanks,

 - Joel

