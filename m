Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633CD78E228
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbjH3WM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245367AbjH3WMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:12:55 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54B4E4F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:12:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso5054241fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693433472; x=1694038272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQcM6QzSDrdw05zBYqyUQ1YoaP9zqQVZwczUVAgTjDI=;
        b=mUvEr/d8ejHfAlS5FKLWClyFkRSMowYdsR7o2jgl3Wl1vFOQmBBh6tUyLZG4Z1s/dF
         BY71ehH4OIVUhmLrf6uvNHX7/oMCL9o4F7TmS4G5JH8k5u5RGKM6zrifz88APE5UhTxt
         aZt4dHfM+Oob41x9xCAxV4l9ZsPI1dlk32AFWszHbdzdyOnxd18i01NyUNBA9dm+uQk2
         SOfxRlNQ3619fH44Tg9xXJ9dfzqQ2dWF2uqqun4xMPoR3xiuqygseNsAX2ZaWm7iEP5K
         WNga2mJw8JkCstmaFOhgAUooe0yOmyiCFmHfCKMyOwSqz9ahqYhJmygBvmFmd9fYapmY
         +8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693433472; x=1694038272;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQcM6QzSDrdw05zBYqyUQ1YoaP9zqQVZwczUVAgTjDI=;
        b=N2TVl9kBF0iTxaypEVQ4qA6f6xk3QSZdraEhIWqGi5XPW2xdIZ3BjTlMU7dBNHdZ7H
         1MqkpTG1VkpLB7TO2nS4BiQWLKIpCumvfc51F4lnRiuDfoSPSxgcAnqGvXpSTEENuR8a
         AkNOl84VZh8MRPvppncvM5g0iZlpGc1SbsikYhAy2P3UNMbJgnmgaBYr6kHTxN5v3Ttt
         16dth2zFENCTHrCReYaiu2ZF9zLh7DMbiXpIrjk565pLzbw7CS1ERRPYGGZtO/vIUcE0
         dOVhoucW52PnGtAYO6xlto4KgKcwpas1b9t2LnBtVF7Gv37MSyapQiSLJDt4GJRyg+tk
         +YMQ==
X-Gm-Message-State: AOJu0YyMA9vyvOnSsxDhtp1ykQ/LFjSYgwdawPZesO4kZQcAjkY4Ikrs
        7gA+CgYu/upoZci5OdCQmuaRwewrmk4=
X-Google-Smtp-Source: AGHT+IEKTx5QIs7BavwcZ95zC6a1N2eVgZo+TpMoQFooW8DueLhLak8FN677a7iQrMuiBcy49cc70g==
X-Received: by 2002:a19:2d45:0:b0:500:96fc:129d with SMTP id t5-20020a192d45000000b0050096fc129dmr2048436lft.14.1693424874737;
        Wed, 30 Aug 2023 12:47:54 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b8a0:2d00:e558:bad6:b660:31e3? (dynamic-2a01-0c23-b8a0-2d00-e558-bad6-b660-31e3.c23.pool.telefonica.de. [2a01:c23:b8a0:2d00:e558:bad6:b660:31e3])
        by smtp.googlemail.com with ESMTPSA id e1-20020a1709062c0100b0099df2ddfc37sm7454502ejh.165.2023.08.30.12.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 12:47:54 -0700 (PDT)
Message-ID: <af18507c-8d22-f33d-a5b2-c59f6cf5058b@gmail.com>
Date:   Wed, 30 Aug 2023 21:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To:     imre.deak@intel.com, Tejun Heo <tj@kernel.org>
Cc:     intel-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <f7e21caa-e98d-e5b5-932a-fe12d27fde9b@gmail.com>
 <ZO-BkaGuVCgdr3wc@slm.duckdns.org> <ZO+Q0Oaw/1GkDx6T@ideak-desk.fi.intel.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Intel-gfx] WQ_UNBOUND warning since recent workqueue refactoring
In-Reply-To: <ZO+Q0Oaw/1GkDx6T@ideak-desk.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2023 20:56, Imre Deak wrote:
> On Wed, Aug 30, 2023 at 07:51:13AM -1000, Tejun Heo wrote:
> Hi,
> 
>> Hello,
>>
>> (cc'ing i915 folks)
>>
>> On Wed, Aug 30, 2023 at 04:57:42PM +0200, Heiner Kallweit wrote:
>>> Recently I started to see the following warning on linux-next and presumably
>>> this may be related to the refactoring of the workqueue core code.
>>>
>>> [   56.900223] workqueue: output_poll_execute [drm_kms_helper] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
>>> [   56.923226] workqueue: i915_hpd_poll_init_work [i915] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
>>> [   97.860430] workqueue: output_poll_execute [drm_kms_helper] hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
>>> [   97.884453] workqueue: i915_hpd_poll_init_work [i915] hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
>>>
>>> Adding WQ_UNBOUND to these queues didn't change the behavior.
>>
>> That should have made them go away as the code path isn't active at all for
>> WQ_UNBOUND workqueues. Can you please double check?
>>

I tried the patch given below and double-checked. No change in behavior.

>>> Maybe relevant: I run the affected system headless.
>>
>> i915 folks, workqueue recently added debug warnings which trigger when a
>> per-cpu work item hogs the CPU for too long - 10ms in this case. This is
>> problematic because such work item can stall other per-cpu work items.
>>
>> * Is it expected for the above two work functions to occupy the CPU for over
>>   10ms repeatedly?
> 
> No, this shouldn't happen.
> 
> I assume it happens in
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> 
> after cfd48ad8c4a9 ("drm/i915: Fix HPD polling, reenabling the output poll work as needed")
> 
> which could result in the above problem.
> 
> Could you give a try to
> https://lore.kernel.org/all/20230809104307.1218058-1-imre.deak@intel.com/
> 
Didn't help

> and if that doesn't help provide more information/logs, by opening a
> ticket at:
> https://gitlab.freedesktop.org/drm/intel/-/issues/new
> 
> Thanks,
> Imre
> 
>> * If so, can we make them use an unbound workqueue instead?
>>
>> Thanks.
>>
>> -- 
>> tejun



diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 3f479483d..ac28b8d0f 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -279,7 +279,7 @@ static void reschedule_output_poll_work(struct drm_device *dev)
 		 */
 		delay = HZ;
 
-	schedule_delayed_work(&dev->mode_config.output_poll_work, delay);
+	queue_delayed_work(system_unbound_wq, &dev->mode_config.output_poll_work, delay);
 }
 
 /**
@@ -614,7 +614,7 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 		 */
 		dev->mode_config.delayed_event = true;
 		if (dev->mode_config.poll_enabled)
-			mod_delayed_work(system_wq,
+			mod_delayed_work(system_unbound_wq,
 					 &dev->mode_config.output_poll_work,
 					 0);
 	}
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index ec4d26b3c..c0592b77b 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -138,7 +138,7 @@ static int i915_workqueues_init(struct drm_i915_private *dev_priv)
 	 * to be scheduled on the system_wq before moving to a driver
 	 * instance due deprecation of flush_scheduled_work().
 	 */
-	dev_priv->unordered_wq = alloc_workqueue("i915-unordered", 0, 0);
+	dev_priv->unordered_wq = alloc_workqueue("i915-unordered", WQ_UNBOUND, 0);
 	if (dev_priv->unordered_wq == NULL)
 		goto out_free_dp_wq;
 
-- 
2.42.0


