Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F9979A010
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 23:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjIJVRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 17:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjIJVRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 17:17:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED32A188
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 14:17:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31f71b25a99so3468541f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694380632; x=1694985432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cAWjpfrn7lv6+qtMd2gXILZDalvU84LJUkzZQm+59KA=;
        b=m6/H10+3EusXNttroh/jdv1z+QUf5Uc3eGkt7TNigNtysjc2a0MNWnq120p21R/rhh
         zyAEJfQd5XJeFljwcLV2pgIXQk7gdejSSs/IUD9UC9KyB8mU3b4EbYeBmSehQwItEobH
         DK2T1TO1e/cUixV6mjSEXFypBmoOyrV4pwGCe2OS8KzNql5cqHoU1eeEtissMseLaX+u
         0byIxqLhUzHXqSQsL5qCX2erQKuu2ACLyoiLD1kMBmopoImo70p5zB23AKyG9VQVnuQw
         hKAh6OvCfqAXfkrCc2iHn3DQflL1KcepTCqDvZTvisKqcu6KRrdqnAGhz2K+HkHicVeO
         KVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694380632; x=1694985432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAWjpfrn7lv6+qtMd2gXILZDalvU84LJUkzZQm+59KA=;
        b=jLOZIfizSc4guh44uba5/pwkS+X1GmjCYusMILVEJdWRFP1OT49T68SYdsxQoUBSwP
         GtrKltTVO8ousgD82TqpAD+rjVYeEvgZrrJGtYLnjNss5iNSqb8FFSH5H48d+UGjdLrC
         Zk93AKFpPUAYfPvgD8C8seCAOTVXiBqF/5f7r/tKU6TUfLKINbwT+DohnWgPeiCUsVvg
         rOGteGykY050kU+XXXD+9I+ArOP+1pk/Synz/3OaLgg/QQVnMzxHGFfULxVUlZFxlgYT
         bgLx/MLhLyxD/seKs3SaOCYSMPOBv60F1OUCFVpHST8f/0UTYaNfR5PLyGC2Eid/8MRM
         l4KA==
X-Gm-Message-State: AOJu0Yyf7U+EXlhexzoO60pLFRm/EVOa72nK5lRyvcF+PdoQ52wzx+Pb
        Jd056NGnBnL/2uzPsn5t3ByW0A==
X-Google-Smtp-Source: AGHT+IEHA/TpwIBqPVhNBIDRS0aLQwyea5La+7Kdbk43ym+TKMpLoyHnDqkZWYw7xCxZpmCbC2UlfQ==
X-Received: by 2002:a5d:4008:0:b0:315:ad00:e628 with SMTP id n8-20020a5d4008000000b00315ad00e628mr5754672wrp.47.1694380632063;
        Sun, 10 Sep 2023 14:17:12 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600001c300b0031f07d1edbcsm8225077wrx.77.2023.09.10.14.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 14:17:11 -0700 (PDT)
Date:   Sun, 10 Sep 2023 22:17:10 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230910211710.a367up7rstm2l7zr@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230907130805.GE10955@noisy.programming.kicks-ass.net>
 <20230908001725.mtqbse3xwhzvo5qp@airbuntu>
 <20230908102511.GA24372@noisy.programming.kicks-ass.net>
 <20230908133336.uge4hcnx4cum3lg5@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908133336.uge4hcnx4cum3lg5@airbuntu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/23 14:33, Qais Yousef wrote:
> On 09/08/23 12:25, Peter Zijlstra wrote:
> > On Fri, Sep 08, 2023 at 01:17:25AM +0100, Qais Yousef wrote:
> > 
> > > Just to be clear, my main issue here with the current hardcoded values of the
> > > 'margins'. And the fact they go too fast is my main problem.
> > 
> > So I stripped the whole margin thing from my reply because I didn't want
> > to comment on that yet, but yes, I can see how those might be a problem,
> > and you're changing them into something dynamic, not just removing them.
> 
> The main difficulty is that if you try to apply those patches on their own, I'm
> sure you'll notice a difference. So if we were to take this alone and put them
> on linux-next; I expect a few regression reports for those who run with
> schedutil. Any ST oriented workload will not be happy. But if we compensate to
> reduce the regression, my problem will re-appear, just for a different reason.
> So whack-a-mole.

Sorry I just realized that the dynamic thing was about the margin, not the new
knob.

My answer above still holds to some extent. But yes, I meant to write that I'm
removing magic hardcoded numbers from the margins.


Cheers

--
Qais Yousef
