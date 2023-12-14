Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62665812C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443565AbjLNKG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443529AbjLNKGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:06:22 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72656125;
        Thu, 14 Dec 2023 02:06:28 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50be24167efso9159240e87.3;
        Thu, 14 Dec 2023 02:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702548386; x=1703153186; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5V4Zfz6XRU9uCFd234VmP4ICcrU9hXjNDlJGMb8vpTg=;
        b=h3oJWEYOy6NBVWCdapTuL9EqUm4WzZ0HQI034vzVXUSVYdGCyxhR91WvTGLpjiShdK
         8r0zottbvLHNuW3duz31ZFvFuMPMIeSh7+4qWBa10pjNMSNuCed7zBkGOb3ZaU/7aR+x
         zTeEU/LRzsDm+pop+I11xCDhOgLfSH20iQ/DZDZPghpAIAqPjJv4kbb1WqENmWW6W2tv
         280sOAf0UnBnoN6SfD9Nb1zVYnQdjNFB47rc9jAAk/9Imx29HCKhmykIYAHTX8qZywzR
         2p7MWmIR+v5VHoQ7AShwFrhrGxienh1liYERkxN0cIWsVoDusR+jCsd+4Scf6vpiZFb0
         mE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548386; x=1703153186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5V4Zfz6XRU9uCFd234VmP4ICcrU9hXjNDlJGMb8vpTg=;
        b=nEfjPsI0ocl+e+AxQZTCsx4dKK8FYiS4F+Vkm4skrKHOOm97z3dUUVhqHYQpnXaqMf
         AiAaXpKQKWyaE4GUS5ZrL3tBPqPLEgbNMl0hYKoLMZMadJcwpfZOqHCM2u32yghluhRT
         LFIQ7NaYW223F15EWeVe0zx/Dl7C57AmKgwXGqXI9+5It3q5SPWJnzOEQg7AbgKuTxoh
         lx5QLj8hc7G9/PiG3tYAG7pfp3oi2kgnm7jR6RTLkHDm64ZvmQQ29LCQ9WT7JfyTQzl0
         OG0y30vzhZoeCUboGVmw92GoXos68pQPRsWkZ+GfZsjMRxcC4YjFEKGFf/VqJuwRRN93
         ZSGQ==
X-Gm-Message-State: AOJu0YzbSxS8OWbqrePLSj1JYtkpV2ql56BMVrLpMQUWjxnWFKp8OjNq
        6zX9POBAMWu73b1rLzbFMIg=
X-Google-Smtp-Source: AGHT+IGopw4QyFfgA+rRb4sowL1hUkxX9gnIMDNKEAqTFmIs/F3tmFpZSM60D3lFcsprsv7XAhb4WQ==
X-Received: by 2002:ac2:559a:0:b0:50b:e73c:ff55 with SMTP id v26-20020ac2559a000000b0050be73cff55mr1967278lfg.250.1702548386238;
        Thu, 14 Dec 2023 02:06:26 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id j4-20020a056512028400b0050e1b5304b2sm14508lfp.170.2023.12.14.02.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:06:25 -0800 (PST)
Date:   Thu, 14 Dec 2023 13:06:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     xiongxin <xiongxin@kylinos.cn>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, stable@vger.kernel.org,
        Riwen Lu <luriwen@kylinos.cn>, hoan@os.amperecomputing.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq: Resolve that mask_irq/unmask_irq may not be called
 in pairs
Message-ID: <f5vtfoqylht5ijj6tdvxee3f3u6ywps2it7kv3fhmfsx75od2y@ftjlt4t4z4dk>
References: <20231207014003.12919-1-xiongxin@kylinos.cn>
 <87ttosssxd.ffs@tglx>
 <e125491c-4cdb-4870-924a-baeb7453bf78@kylinos.cn>
 <874jgnqwlo.ffs@tglx>
 <bf4004bf-4868-4953-8d8e-0c0e03be673e@kylinos.cn>
 <875y12p2r0.ffs@tglx>
 <1844c927-2dd4-49b4-a6c4-c4c176b1f75d@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1844c927-2dd4-49b4-a6c4-c4c176b1f75d@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, Xiong

On Thu, Dec 14, 2023 at 09:54:06AM +0800, xiongxin wrote:
> 在 2023/12/13 22:59, Thomas Gleixner 写道:
> > On Wed, Dec 13 2023 at 10:29, xiongxin wrote:
> > > 在 2023/12/12 23:17, Thomas Gleixner 写道:
> > > Sorry, the previous reply may not have clarified the BUG process. I
> > > re-debugged and confirmed it yesterday. The current BUG execution
> > > sequence is described as follows:
> > 
> > It's the sequence how this works and it works correctly.
> > 
> > Just because it does not work on your machine it does not mean that this
> > is incorrect and a BUG.
> > 
> > You are trying to fix a symptom and thereby violating guarantees of the
> > core code.
> > 
> > > That is, there is a time between the 1:handle_level_irq() and
> > > 3:irq_thread_fn() calls for the 2:disable_irq() call to acquire the lock
> > > and then implement the irq_state_set_disabled() operation. When finally
> > > call irq_thread_fn()->irq_finalize_oneshot(), it cannot enter the
> > > unmask_thread_irq() process.
> > 
> > Correct, because the interrupt has been DISABLED in the mean time.
> > 
> > > In this case, the gpio irq_chip irq_mask()/irq_unmask() callback pairs
> > > are not called in pairs, so I think this is a BUG, but not necessarily
> > > fixed from the irq core code layer.
> > 
> > No. It is _NOT_ a BUG. unmask() is not allowed to be invoked when the
> > interrupt is DISABLED. That's the last time I'm going to tell you that.
> > Only enable_irq() can undo the effect of disable_irq(), period.
> > 
> > > Next, when the gpio controller driver calls the suspend/resume process,
> > > it is as follows:
> > > 
> > > suspend process:
> > > dwapb_gpio_suspend()
> > >       ctx->int_mask   = dwapb_read(gpio, GPIO_INTMASK);
> > > 
> > > resume process:
> > > dwapb_gpio_resume()
> > >       dwapb_write(gpio, GPIO_INTMASK, ctx->int_mask);
> > 
> > Did you actually look at the sequence I gave you?
> > 
> >     Suspend:
> > 
> > 	  i2c_hid_core_suspend()
> > 	     disable_irq();       <- Marks it disabled and eventually
> > 				     masks it.
> > 
> > 	  gpio_irq_suspend()
> > 	     save_registers();    <- Saves masked interrupt
> > 
> >     Resume:
> > 
> > 	  gpio_irq_resume()
> > 	     restore_registers(); <- Restores masked interrupt
> > 
> > 	  i2c_hid_core_resume()
> > 	     enable_irq();        <- Unmasks interrupt and removes the
> > 				     disabled marker
> > 
> > 
> > Have you verified that this order of invocations is what happens on
> > your machine?
> > 
> > Thanks,
> > 
> >          tglx
> 
> As described earlier, in the current situation, the irq_mask() callback of
> gpio irq_chip is called in mask_irq(), followed by the disable_irq() in
> i2c_hid_core_suspend(), unmask_irq() will not be executed.
> 
> Then call enable_irq() in i2c_hid_core_resume(). Since gpio irq_chip does
> not implement the irq_startup() callback, it ends up calling irq_enable().
> 
> The irq_enable() function is then implemented as follows:
> 
> irq_state_clr_disabled(desc);
> if (desc->irq_data.chip->irq_enable) {
> 	desc->irq_data.chip->irq_enable(&desc->irq_data);
> 	irq_state_clr_masked(desc);
> } else {
> 	unmask_irq(desc);
> }
> 
> Because gpio irq_chip implements irq_enable(), unmask_irq() is not executed,
> and gpio irq_chip's irq_unmask() callback is not called. Instead,
> irq_state_clr_masked() was called to clear the masked flag.
> 
> The irq masked behavior is actually controlled by the
> irq_mask()/irq_unmask() callback function pairs in gpio irq_chip. When the
> whole situation occurs, there is one more irq_mask() operation, or one less
> irq_unmask() operation. This ends the i2c hid resume and the gpio
> corresponding i2c hid interrupt is also masked.
> 
> Please help confirm whether the current situation is a BUG, or suggest other
> solutions to fix it.
> 

I has just been Cc'ed to this thread from the very start of the thread
so not sure whether I fully understand the problem. But a while ago an
IRQ disable/undisable-mask/unmask-unpairing problem was reported for
DW APB GPIO driver implementation, but in a another context though:
https://lore.kernel.org/linux-gpio/1606728979-44259-1-git-send-email-luojiaxing@huawei.com/
We didn't come to a final conclusion back then, so the patch got lost
in the emails archive. Xiong, is it related to the problem in your
case?

-Serge(y)
