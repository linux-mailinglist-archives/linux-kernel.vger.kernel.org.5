Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C91A7BE413
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376482AbjJIPNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376519AbjJIPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AFBCF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696864331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4qfZPKhe4D8OCEELO/RpTfN5G0X8gflsKKhK6pkYfv0=;
        b=Z9MLekZpagAdcwMvDz/QySI9qxZaTVjE8jzBDB8SWae9rRvxwa6CYPo+7qs6fuPMWALhWJ
        fSBZpCeiD8Likw9xtf91vPI22z/3XDJRSohT2HeCawPqOP9V7bbdeTkbCmxAQoz14ugWwi
        htKcRVAxiOjpVsXwggGSGykhUvfNa6s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-Bi75ZB-bP126ZD6wtQpOLg-1; Mon, 09 Oct 2023 11:12:10 -0400
X-MC-Unique: Bi75ZB-bP126ZD6wtQpOLg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-65af7b636easo61194276d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864330; x=1697469130;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4qfZPKhe4D8OCEELO/RpTfN5G0X8gflsKKhK6pkYfv0=;
        b=N5LEH3Y7tFkfd13WRIimlTtBPkLr+70hUwGYeQS2AAGtW9gcrMNpPb2P2VMO21j5nR
         dh24yzMVB1evRLRpkf8jSiSSAuleqBn85G3GYyDTDZrAShIUyJHk6+LWSU0vy6NB0kPx
         TeXfBmmqLY14ErRcR7032cI7KVwiRWwWZ6L6h8q9RvtzkVDSEtGr9WszH04dBYNXgmGp
         W4LLm5RNwN2Tu4hUQXCp7U0sow4u8pIQdBa3J5O150YczX2leRsG00+9BgBo36Ak08zT
         XKsh9sGpQqfQySCddXvUBRt1yNGkVhRblWaNA3KH5GE/l0PhcBjTV8Xn9paPM+SsFL4y
         4OaQ==
X-Gm-Message-State: AOJu0YyyPBDpiN75rrhFowaFvWIeDUjTfdLSfXqrPrU6UzxysQ4F+TAp
        fL8oNUDts5dN3z9FksrwxgYOsi5QzOOM6NkGogdLpbjTROzLYuwdFRwpmgcEmYaX+kWwlQt7PXC
        p0OO7xTOzr0wROR7irWd2Z2oV
X-Received: by 2002:a0c:f2d4:0:b0:668:dd6b:6cbd with SMTP id c20-20020a0cf2d4000000b00668dd6b6cbdmr15849814qvm.46.1696864329855;
        Mon, 09 Oct 2023 08:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiRw3UpxKj8WXRyOtwVOg38QyfJskKdQC95sLHfqSeo421hVHmQH13cUXqSbWHJLqUbR9Jhg==
X-Received: by 2002:a0c:f2d4:0:b0:668:dd6b:6cbd with SMTP id c20-20020a0cf2d4000000b00668dd6b6cbdmr15849799qvm.46.1696864329649;
        Mon, 09 Oct 2023 08:12:09 -0700 (PDT)
Received: from vschneid.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id fh16-20020a0562141a1000b0065aff6b49afsm3912638qvb.110.2023.10.09.08.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:12:09 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/3] sched/nohz: Use consistent variable names in
 find_new_ilb() and kick_ilb()
In-Reply-To: <20231006102518.2452758-3-mingo@kernel.org>
References: <20231006102518.2452758-1-mingo@kernel.org>
 <20231006102518.2452758-3-mingo@kernel.org>
Date:   Mon, 09 Oct 2023 17:12:06 +0200
Message-ID: <xhsmhedi3omnt.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/23 12:25, Ingo Molnar wrote:
> Use 'ilb_cpu' consistently in both functions.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

